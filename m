Return-Path: <haishan.bai@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 22905B6F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Jul 2011 23:33:50 +1000 (EST)
Received: by iyn35 with SMTP id 35so2371350iyn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Jul 2011 06:33:48 -0700 (PDT)
Message-ID: <4E22E4AC.7040600@gmail.com>
Date: Sun, 17 Jul 2011 21:33:32 +0800
From: Shan Hai <haishan.bai@gmail.com>
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 1/1] Fixup write permission of TLB on powerpc e500 core
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>	
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>	
	<1310725418.2586.309.camel@twins> <4E21A526.8010904@gmail.com>	
	<1310860194.25044.17.camel@pasglop>
	<1310900561.13765.22.camel@twins>
In-Reply-To: <1310900561.13765.22.camel@twins>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
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

On 07/17/2011 07:02 PM, Peter Zijlstra wrote:
> On Sun, 2011-07-17 at 09:49 +1000, Benjamin Herrenschmidt wrote:
>> In the meantime, other than rewriting the futex code to not require
>> those in-atomic accesses (can't it just access the pages via the linear
>> mapping and/or kmap after the gup ?),
> That'll wreck performance on things like ARM and SPARC that have to deal
> with cache aliasing.
>
>>   all I see would be a way to force
>> dirty and young after gup, with appropriate locks, or a variant of gup
>> (via a flag ?) to require it to do so.
> Again, _WHY_ isn't gup(.write=1) a complete write fault? Its supposed to
> be, it needs to break COW, do dirty page tracking and call page_mkwrite.
> I'm still thinking this e500 stuff is smoking crack.
>
> ARM has no hardware dirty bit either, and yet it works for them. I can't
> exactly tell how because I got lost in there, but it does, again,
> suggest e500 is on crack.

Ok, the following feature of the architecture causes failure of
gup(.write=1) on dirtying pages,
- allows pages to be protected from supervisor-mode writes

On ARM you could not protect pages from supervisor-mode writes,
isn't it?  That means, all writable user pages are writable for
supervisor too, but its not hold for at least x86 and powerpc,
x86 and powerpc can be configured to protect pages from
supervisor-mode writes.

Think about the following situation,
a page fault occurs on the kernel trying to write to a writable shared
user page which is read only to the kernel, the following conditions hold,
- the page is *present*, because its a shared page
- the page is *writable*, because demand paging sets up the pte for
     the current process to so

The follow_page() called in the __get_user_page() returns non NULL
to its caller on the above mentioned *present* and *writable* page,
so the gup(.write=1) has no chance to set pte dirty by calling 
handle_mm_fault,
the follow_page() has no knowledge of supervisor-mode write protected pages,
that's the culprit in the bug discussed here.

Thanks
Shan Hai
