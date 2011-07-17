Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
	[IPv6:2001:4978:20e::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84500B6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Jul 2011 19:39:30 +1000 (EST)
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QiNos-0001Zk-5F
	for linuxppc-dev@lists.ozlabs.org; Sun, 17 Jul 2011 09:39:26 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219]
	helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1QiNor-0006Yz-Cx
	for linuxppc-dev@lists.ozlabs.org; Sun, 17 Jul 2011 09:39:25 +0000
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
	<1310725418.2586.309.camel@twins> <4E21A526.8010904@gmail.com>
	<1310860194.25044.17.camel@pasglop>
In-Reply-To: <1310860194.25044.17.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/1] Fixup write permission of TLB on powerpc e500 core
From: Peter Zijlstra <peterz@infradead.org>
Date: Sun, 17 Jul 2011 11:38:11 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Shan Hai <haishan.bai@gmail.com>
Message-ID: <4b337921-d430-4b63-bc36-ad31753cf800@email.android.com>
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>On Sat, 2011-07-16 at 10:50 -0400, Shan Hai wrote:
>> 
>> That's right the gup(.write=1) want to do the same thing as the
>> above code snippet, but it failed for the following reason:
>> because the get_user_pages() would not dirty pte for the reason
>> the follow_page() returns not NULL on *present* and *writable*
>> page, the page which holds the lock is present because its a shared
>> page,
>> writable because demand paging set that up so for shared
>> writable page, so the handle_mm_fault() in the __get_user_page()
>> could not be called.
>> 
>> Why the above code could do the same task, because by calling
>> handle_mm_fault() will set pte dirty by
>> [do_annonymous_page(), memory.c]
>> if (vma->vm_flags & VM_WRITE)
>>                  entry = pte_mkwrite(pte_mkdirty(entry));
>> 
>
>Right. gup won't set page_dirty, it expects the caller to do so (in
>case
>it doesn't dirty all the gup'ed pages a suppose).
>
>You could probably fix the problem here by setting dirty after gup in
>the futex code if you know you're going to write. You must do that with
>the PTE lock held though and -not- at interrupt time.
>
>Note however that the exact same problem exist with normal "read"
>accesses and page_young (_PAGE_ACCESSED on powerpc). The page will not
>be accessible until that bit is set and it's set by SW.
>
>As I wrote earlier, fixing that by making "atomic" page faults perform
>the dirty/accessed tracking is not right, since such faults can happen
>at interrupt time and the PTE lock cannot be taken at interrupt time.
>
>IE. The implementation of those "SW" TLB archs heavily relies on the
>PTE
>lock to serialize write access to the PTE and writing it outside of
>that
>lock would do really bad things.
>
>So there's a deeper problem here. The whole user access "in atomic"
>concept is by itself a violation of some of the basic access rules of
>user memory that have existed from day 1 of the kernel. That we allow
>it
>for semi-harmless (and allowed to fail) things like snapshot of
>backtraces for perf is one thing, but relying on it for the futex case
>like that is not going to fly very well. I sincerely hope that this
>kind
>of usage is not going to become a habit.
>
>In the meantime, other than rewriting the futex code to not require
>those in-atomic accesses (can't it just access the pages via the linear
>mapping and/or kmap after the gup ?), all I see would be a way to force
>dirty and young after gup, with appropriate locks, or a variant of gup
>(via a flag ?) to require it to do so.
>
>Cheers,
>Ben.

Whats this talk about interrup context? There is non of that involved.

Furthermore, I still dont see the problem. The futex code is optimistically trying to poke at user memory while holding spinlocks.

We fully expect that to fail, hence the error path that drops all locks and does the gup(.write=1) to fix up the mapping after which we try again.

This has worked for years, its by no means new code. Nor do I see how its broken.
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
