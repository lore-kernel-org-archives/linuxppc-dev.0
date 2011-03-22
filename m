Return-Path: <jeremy@goop.org>
Received: from claw.goop.org (claw.goop.org [74.207.240.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 633ECB6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Mar 2011 12:23:39 +1100 (EST)
Message-ID: <4D88A560.8080405@goop.org>
Date: Tue, 22 Mar 2011 13:34:24 +0000
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mmotm threatens ppc preemption again
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>	
	<1300665188.2402.64.camel@pasglop> <4D873571.702@goop.org>
	<1300747942.2402.262.camel@pasglop>
In-Reply-To: <1300747942.2402.262.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/21/2011 10:52 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2011-03-21 at 11:24 +0000, Jeremy Fitzhardinge wrote:
>> I'm very sorry about that, I didn't realize power was also using that
>> interface.  Unfortunately, the "no preemption" definition was an error,
>> and had to be changed to match the pre-existing locking rules.
>>
>> Could you implement a similar "flush batched pte updates on context
>> switch" as x86? 
> Well, we already do that for -rt & co.
>
> However, we have another issue which is the reason we used those
> lazy_mmu hooks to do our flushing.
>
> Our PTEs eventually get faulted into a hash table which is what the real
> MMU uses. We must never (ever) allow that hash table to contain a
> duplicate entry for a given virtual address.
>
> When we do a batch, we remove things from the linux PTE, and keep a
> reference in our batch structure, and only update the hash table at the
> end of the batch.

Wouldn't implicitly ending a batch on context switch get the same effect?

> That means that we must not allow a hash fault to populate the hash with
> a "new" PTE value prior to the old one having been flushed out (which is
> possible if they different in protection attributes for example). For
> that to happen, we must basically not allow a page fault to re-populate
> a PTE invalidated by a batch before that batch has completed.

Kernel ptes are not generally populated on fault though, unless there's
something in power?  On x86 it can happen when syncing a process's
kernel pmd with the init_mm one, but that shouldn't happen in the middle
of an update since you'd deadlock anyway.  If a particular kernel
subsystem has its own locks to manage the ptes for a kernel mapping,
then that should prevent any nested updates within a batch shouldn't it?

> That translates to batches must only happen within a PTE lock section.

Well, in that case, I guess your best bet is to disable batching for
kernel pagetable updates.  These apply_to_page_range() changes are the
first time any attempt to batch kernel pagetable updates has been made
(otherwise you would have seen this problem earlier), so not batching
them will not be a regression for you.

But I'm not sure what the proper fix to get batching in your case will
be.  But the assumption that there's a pte lock for kernel ptes is not
valid.

    J
