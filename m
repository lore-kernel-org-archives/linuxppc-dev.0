Return-Path: <patrickdepinguin@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCyw66mFWzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 20:47:18 +1100 (AEDT)
Received: by mail-qt0-x242.google.com with SMTP id n13so63313373qtc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 01:47:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAXf6LWL67Qvdv82yOREoB5Q5fVHNUU3m5a13-qSowk30Oj8AA@mail.gmail.com>
References: <CAAXf6LWL67Qvdv82yOREoB5Q5fVHNUU3m5a13-qSowk30Oj8AA@mail.gmail.com>
From: Thomas De Schampheleire <patrickdepinguin@gmail.com>
Date: Wed, 1 Feb 2017 10:46:55 +0100
Message-ID: <CAAXf6LVrPi+8dHu75Oy1UBgd8kRk=uEzWTVTJB5yN=X6kq5ixQ@mail.gmail.com>
Subject: Re: "Unable to handle kernel paging request for instruction fetch" on
 P4080
To: linuxppc-dev@lists.ozlabs.org
Cc: Ronny Meeus <Ronny.Meeus@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2017 at 10:46 AM, Thomas De Schampheleire
<patrickdepinguin@gmail.com> wrote:
> Hi,
>
> We are experiencing kernel panics of the type "Unable to handle kernel paging
> request for instruction fetch" but are stuck in our analysis. We would
> appreciate any help you can give.
>
> The problem occurs from time to time on different instances of a particular
> embedded systems. The kernel is very old, 2.6.36.4, and runs on an 8-core
> Freescale P4080 QorIQ processor (e500mc-based). Upgrading the kernel to a newer
> version is not an option at this point.
>
> Here is an example panic log: (Panic 1)
>
> <1>[2497591.165517] Unable to handle kernel paging request for instruction fetch
> <1>[2497591.248027] Faulting instruction address: 0x4837ad68
> <4>[2497591.309541] Oops: Kernel access of bad area, sig: 11 [#1]
> <4>[2497591.376218] PREEMPT SMP NR_CPUS=8 P4080 DS
> <0>[2497591.427290] last sysfs file:
> /sys/module/ndps_b_reboot_helper/parameters/panic_counter
> <4>[2497591.524180] Modules linked in: uio_generic_driver
> reborn_macfilter ndps_b_reboot_helper ramoops cpld_watchdog physmap_of
> sysfs_exports write_unlock ndps_a_cpld reborn_class generic_access
> <4>[2497591.726423] NIP: 4837ad68 LR: 4837ad69 CTR: c0009c30
> <4>[2497591.787899] REGS: e3619cc0 TRAP: 0400   Tainted: G        W
> (2.6.36.4)
> <4>[2497591.871243] MSR: 00029002 <EE,ME,CE>  CR: 24002844  XER: 00000000
> <4>[2497591.946313] TASK = ec2dc600[444] 'watchdog_monito' THREAD:
> e3618000 CPU: 0
> <4>[2497592.028624] GPR00: 4837ad69 e3619d70 ec2dc600 00000001
> 00260100 00000008 00000001 0000039d
> <4>[2497592.130812] GPR08: ffffffff 00000000 00029002 c3389040
> 00000000 100d624c 3b9ac9ff 00000201
> <4>[2497592.233007] GPR16: 000003fb 1009d604 1424120d e3638000
> 00000200 00000678 00000001 0000039d
> <4>[2497592.335209] GPR24: 1424120d ec1f3800 00000001 4800001c
> 4819b729 7fe5fb78 7c641b78 3c60c042
> <4>[2497592.439505] NIP [4837ad68] 0x4837ad68
> <4>[2497592.485353] LR [4837ad69] 0x4837ad69
> <4>[2497592.530159] Call Trace:
> <4>[2497592.561424] [e3619d70] [4837ad69] 0x4837ad69 (unreliable)
> <4>[2497592.628123] Instruction dump:
> <4>[2497592.665641] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> XXXXXXXX XXXXXXXX XXXXXXXX
> <4>[2497592.760511] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> XXXXXXXX XXXXXXXX XXXXXXXX
> <0>[2497592.855933] Kernel panic - not syncing: Fatal exception
> <4>[2497592.920568] Call Trace:
> <4>[2497592.951911] [e3619bf0] [c0006fe4] show_stack+0x78/0x18c (unreliable)
> <4>[2497593.030177] [e3619c30] [c0389c34] panic+0xc0/0x1e8
> <4>[2497593.089648] [e3619c80] [c000ba9c] die+0x1f0/0x1fc
> <4>[2497593.148080] [e3619ca0] [c001109c] bad_page_fault+0xb0/0xc8
> <4>[2497593.215872] [e3619cb0] [c000e3f8] handle_page_fault+0x7c/0x80
> <4>[2497593.286798] --- Exception: 400 at 0x4837ad68
> <4>[2497593.286803]     LR = 0x4837ad69
>
> Our analysis of the above panic log lead to the conclusion
> that there is a kernel stack corruption, such that when restoring the link
> register (LR) from the stack frame near the end of a function, an invalid value
> is restored, so that the fetching of that instruction upon return from that
> function causes an instruction fetch exception (0x400).
> This is based on the fact that registers R27-R31 contain values that are
> actually coming from the vmlinux image itself, in this case they are parts
> from the function smp_message_recv. In another case, we have seen opcodes from
> generic_smp_call_function_interrupt.
>
> In a typical function epilogue (e.g. from doorbell_message_pass) we see:
>
>    0xc0009de8 <+440>:   lwz     r0,52(r1)     # load value from memory
> from address (r1+52) and store into r0
>    0xc0009dec <+444>:   lwz     r25,20(r1)
>    0xc0009df0 <+448>:   lwz     r26,24(r1)
>    0xc0009df4 <+452>:   mtlr    r0            # store value of r0 into
> LR (link register)
>    0xc0009df8 <+456>:   lwz     r27,28(r1)    # load value from memory
> from address (r1+28) and store into r27
>    0xc0009dfc <+460>:   lwz     r28,32(r1)    # r28 <- (r1+32)
>    0xc0009e00 <+464>:   lwz     r29,36(r1)    # r29 <- (r1+36)
>    0xc0009e04 <+468>:   lwz     r30,40(r1)    # r30 <- (r1+40)
>    0xc0009e08 <+472>:   lwz     r31,44(r1)    # r31 <- (r1+44)
>    0xc0009e0c <+476>:   addi    r1,r1,48
>    0xc0009e10 <+480>:   blr                   # jump to value stored
> in link register
>
> So, when the values at r1 + 52 (and other offsets nearby) are corrupted, then
> after this code the registers r0, r25-31 contain bogus values. As r0 is used to
> provision the link register LR, an instruction fetch abort is unavoidable.
>
> Unfortunately, it is unclear what would cause the corruption of memory.
> Moreover, in some of the other kernel panics, we do _not_ see this pattern of
> r27-r31 containing values coming from the .text section of the kernel image
> itself. There may be different corruption mechanisms at play here.
>
> While the signature of the different panics varies in several ways, the
> recurring aspects are:
> - always reported on CPU 0 (even though this is an SMP system with 8 running
>   cores)
> - R0 always contains the same value as LR, confirming that LR is always restored
>   from a corrupted R0 value
> - the CTR register is always the same (0c0009c30) and points to the function
>   doorbell_message_pass
> - the current userspace task is always the same ('watchdog_monito...') which is
>   a simple shell script that reads from a fuse filesystem, but otherwise does
>   nothing funky. The shell interpreter is busybox ash.
>
> A developer also wondered whether there could be a problem with memory
> coherency between cores. There are several errata existing in this area.
> In particular, because some of the panic logs show references to functions in
> the inter-core communication area, like smp_message_recv, doorbell_message_pass
> and generic_smp_call_function_interrupt. If data written to memory by one core
> is read by another core, but there is an incoherency issue, then the other core
> may read bad data which can lead to other corruptions later.
>
> Does any of this ring a bell to you? Do you recall a problem that has been fixed
> that shows such symptoms? (I have searched in the commit logs on several
> keywords and file changes, but did not find any hits that reminded me of what we
> see).
> How should we interpret the fact that CTR is always pointing to
> doorbell_message_pass? Could it lead us to the problem?
> Do you have any suggestions on how to proceed?
>
> I include some other kernel panics below, in case it helps.


Any hint about this problem would be very appreciated.
What strikes me is the seeming relation to inter-core communication or
coherence.

Do you know of any previous problems in this area?

Thanks,
Thomas
