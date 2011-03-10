Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F25D1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Mar 2011 05:07:01 +1100 (EST)
References: <1299630721-4337-1-git-send-email-wilsons@start.ca>
	<20110310160032.GA20504@alboin.amr.corp.intel.com>
	<20110310164022.GA6242@fibrous.localdomain>
In-Reply-To: <20110310164022.GA6242@fibrous.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----3X4K0B2TLOA62KIFLERUUQW17HJVJU"
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/5=5D_make_*=5Fgate=5Fvma_acc?=
	=?US-ASCII?Q?ept_mm=5Fstruct_instead_of=09task=5Fstruct?=
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Thu, 10 Mar 2011 09:15:56 -0800
To: Stephen Wilson <wilsons@start.ca>, Andi Kleen <ak@linux.intel.com>
Message-ID: <bba01c29-0f31-4e3b-9839-4048b47bbd17@email.android.com>
Cc: linux-s390@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org, x86@kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Michel Lespinasse <walken@google.com>, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------3X4K0B2TLOA62KIFLERUUQW17HJVJU
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit

TIF_IA32 is set during the execution of a 32-bit system call - so touched on each compat system call. Is this the actual flag you want? A 32-bit address space flag is different from TIF_IA32.
-- 
Sent from my mobile phone. Please pardon any lack of formatting.

Stephen Wilson <wilsons@start.ca> wrote:

On Thu, Mar 10, 2011 at 08:00:32AM -0800, Andi Kleen wrote: > On Tue, Mar 08, 2011 at 07:31:56PM -0500, Stephen Wilson wrote: > > > > Morally, the question of whether an address lies in a gate vma should be asked > > with respect to an mm, not a particular task. > > > > Practically, dropping the dependency on task_struct will help make current and > > future operations on mm's more flexible and convenient. In particular, it > > allows some code paths to avoid the need to hold task_lock. > > > > The only architecture this change impacts in any significant way is x86_64. > > The principle change on that architecture is to mirror TIF_IA32 via > > a new flag in mm_context_t. > > The problem is -- you're adding a likely cache miss on mm_struct for > every 32bit compat syscall now, even if they don't need mm_struct > currently (and a lot of them do not) Unless there's a very good > justification to make up for this performance issue elsewhere > (including numbers) this seems like !
 a bad
idea. I do not think this will result in cache misses on the scale you suggest. I am simply mirroring the *state* of the TIF_IA32 flag in mm_struct, not testing/accessing it in the same way. The only place where this flag is accessed (outside the exec() syscall path) is in x86/mm/init_64.c, get_gate_vma(), which in turn is needed by a few, relatively heavy weight, page locking/pinning routines on the mm side (get_user_pages, for example). Patches 3 and 4 in the series show the extent of the change. Or am I missing something? > > /proc/pid/mem. I will be posting the second series to lkml shortly. These > > Making every syscall slower for /proc/pid/mem doesn't seem like a good > tradeoff to me. Please solve this in some other way. > > -Andi -- steve 


------3X4K0B2TLOA62KIFLERUUQW17HJVJU
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body>TIF_IA32 is set during the execution of a 32-bit system call - so touched on each compat system call. Is this the actual flag you want? A 32-bit address space flag is different from TIF_IA32.<br>
-- <br>
Sent from my mobile phone.  Please pardon any lack of formatting.<br><br><div class="gmail_quote">Stephen Wilson &lt;wilsons@start.ca&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div style="white-space: pre-wrap; word-wrap:break-word; ">
On Thu, Mar 10, 2011 at 08:00:32AM -0800, Andi Kleen wrote:
&gt; On Tue, Mar 08, 2011 at 07:31:56PM -0500, Stephen Wilson wrote:
&gt; &gt; 
&gt; &gt; Morally, the question of whether an address lies in a gate vma should be asked
&gt; &gt; with respect to an mm, not a particular task.
&gt; &gt; 
&gt; &gt; Practically, dropping the dependency on task_struct will help make current and
&gt; &gt; future operations on mm's more flexible and convenient.  In particular, it
&gt; &gt; allows some code paths to avoid the need to hold task_lock.
&gt; &gt; 
&gt; &gt; The only architecture this change impacts in any significant way is x86_64.
&gt; &gt; The principle change on that architecture is to mirror TIF_IA32 via
&gt; &gt; a new flag in mm_context_t. 
&gt; 
&gt; The problem is -- you're adding a likely cache miss on mm_struct for
&gt; every 32bit compat syscall now, even if they don't need mm_struct
&gt; currently (and a lot of them do not) Unless there's a very good
&gt; justification to make up for this performance issue elsewhere
&gt; (including numbers) this seems like a bad idea.

I do not think this will result in cache misses on the scale you suggest.  I am simply mirroring the *state* of the TIF_IA32 flag in mm_struct, not testing/accessing it in the same way.

The only place where this flag is accessed (outside the exec() syscall path) is in x86/mm/init_64.c, get_gate_vma(),  which in turn is needed by a few, relatively heavy weight, page locking/pinning routines on the mm side (get_user_pages, for example).  Patches 3 and 4 in the series show the extent of the change.

Or am I missing something?


&gt; &gt; /proc/pid/mem.  I will be posting the second series to lkml shortly.  These
&gt; 
&gt; Making every syscall slower for /proc/pid/mem doesn't seem like a good
&gt; tradeoff to me. Please solve this in some other way.
&gt; 
&gt; -Andi

-- 
steve

</div></blockquote></div></body></html>
------3X4K0B2TLOA62KIFLERUUQW17HJVJU--
