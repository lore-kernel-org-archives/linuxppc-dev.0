Return-Path: <haishan.bai@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3B006B6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 18:36:43 +1000 (EST)
Received: by qwf7 with SMTP id 7so534470qwf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 01:36:41 -0700 (PDT)
Message-ID: <4E1FFC7B.4000209@gmail.com>
Date: Fri, 15 Jul 2011 16:38:19 +0800
From: MailingLists <haishan.bai@gmail.com>
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 0/1] Fixup write permission of TLB on powerpc e500 core
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310718056.2586.275.camel@twins>
In-Reply-To: <1310718056.2586.275.camel@twins>
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

On 07/15/2011 04:20 PM, Peter Zijlstra wrote:
> On Fri, 2011-07-15 at 16:07 +0800, Shan Hai wrote:
>> The following test case could reveal a bug in the futex_lock_pi()
>>
>> BUG: On FUTEX_LOCK_PI, there is a infinite loop in the futex_lock_pi()
>>          on Powerpc e500 core.
>> Cause: The linux kernel on the e500 core has no write permission on
>>          the COW page, refer the head comment of the following test code.
>>
>> ftrace on test case:
>> [000]   353.990181: futex_lock_pi_atomic<-futex_lock_pi
>> [000]   353.990185: cmpxchg_futex_value_locked<-futex_lock_pi_atomic
>> [snip]
>> [000]   353.990191: do_page_fault<-handle_page_fault
>> [000]   353.990192: bad_page_fault<-handle_page_fault
>> [000]   353.990193: search_exception_tables<-bad_page_fault
>> [snip]
>> [000]   353.990199: get_user_pages<-fault_in_user_writeable
>> [snip]
>> [000]   353.990208: mark_page_accessed<-follow_page
>> [000]   353.990222: futex_lock_pi_atomic<-futex_lock_pi
>> [snip]
>> [000]   353.990230: cmpxchg_futex_value_locked<-futex_lock_pi_atomic
>> [ a loop occures here ]
>>
>
> But but but but, that get_user_pages(.write=1, .force=0) should result
> in a COW break, getting our own writable page.
>
> What is this e500 thing smoking that this doesn't work?

A page could be set to read only by the kernel (supervisor in the powerpc
literature) on the e500, and that's what the kernel do. Set SW(supervisor
write) bit in the TLB entry to grant write permission to the kernel on a
page.

And further the SW bit is set according to the DIRTY flag of the PTE,
PTE.DIRTY is set in the do_page_fault(), the futex_lock_pi() disabled
page fault, the PTE.DIRTY never can be set, so do the SW bit, unbreakable
COW occurred, infinite loop followed.

Thanks
Shan Hai
