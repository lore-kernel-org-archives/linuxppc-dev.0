Return-Path: <ricardo.ribalda@gmail.com>
Received: from mail-bw0-f10.google.com (mail-bw0-f10.google.com
	[209.85.218.10]) by ozlabs.org (Postfix) with ESMTP id E66DCDDDEF
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 22:40:10 +1100 (EST)
Received: by bwz3 with SMTP id 3so23113240bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 08 Jan 2009 03:40:07 -0800 (PST)
Message-ID: <aa76a2be0901080338g5fb34d8fuc9b7a3523f1ee670@mail.gmail.com>
Date: Thu, 8 Jan 2009 12:38:42 +0100
From: Ricardo <ricardo.ribalda@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Kernel completely crashes after accessing an unmapped area.
In-Reply-To: <1227259073.7185.228.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <aa76a2be0811190459x461128a5m82eb5d8d8d6da5fe@mail.gmail.com>
	<1227259073.7185.228.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Benjamin

   Thank you very much for your help. You are completely right, once I
have fixed the cputable everything worked like a charm. I have
reviewed the last git version and it seems solved there, so I wont
publish the patch in git format ( to avoid confusions)

                   Best regards

--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1487,6 +1487,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
                .cpu_user_features      = COMMON_USER_BOOKE,
                .icache_bsize           = 32,
                .dcache_bsize           = 32,
+               .cpu_setup              = __setup_cpu_440spe,
+               .machine_check          = machine_check_440A,
                .platform               = "ppc440",
        },
        { /* 460EX */




root@Q5:~# md.l 0x80000000
[  191.806370] Machine check in kernel mode.
[  191.809078] Data Read PLB Error
[  191.812194] Oops: Machine check, sig: 7 [#2]
[  191.816419] PREEMPT Xilinx Virtex440
[  191.819962] Modules linked in: reg_user
[  191.823767] NIP: d106f16c LR: d106f128 CTR: c000f90c
[  191.828699] REGS: cfff9f10 TRAP: 0214   Tainted: G      D    (2.6.27)
[  191.835082] MSR: 00029000 <EE,ME>  CR: 84000422  XER: 00000000
[  191.840875] TASK = cf83d000[2969] 'md.l' THREAD: ce8a8000
[  191.846055] GPR00: a5a5a5a5 ce8a9e50 cf83d000 d1072000 d1072000
00000000 80000000 0000051b
[  191.854350] GPR08: 00000000 00000000 00000000 00000000 80000000
10018d78 fffda400 00000000
[  191.862644] GPR16: ffbbfffc 00000000 00000004 0000003f 000001ff
00000000 1008d23c 1008d254
[  191.870938] GPR24: 4800e454 bf820e00 00000002 40087100 40087100
c02e6bf0 40087100 bf820b70
[  191.879421] NIP [d106f16c] reg_user_ioctl+0x16c/0x1c8 [reg_user]
[  191.885375] LR [d106f128] reg_user_ioctl+0x128/0x1c8 [reg_user]
[  191.891242] Call Trace:
[  191.893670] [ce8a9e50] [d106f128] reg_user_ioctl+0x128/0x1c8
[reg_user] (unreliable)
[  191.901364] [ce8a9e80] [c00956dc] vfs_ioctl+0x9c/0xa8
[  191.906369] [ce8a9ea0] [c009576c] do_vfs_ioctl+0x84/0x68c
[  191.911725] [ce8a9f10] [c0095db4] sys_ioctl+0x40/0x74
[  191.916744] [ce8a9f40] [c000d3c4] ret_from_syscall+0x0/0x3c
[  191.922260] Instruction dump:
[  191.925200] 6fc04008 2f807100 419e0020 48000101 38600000 4bfffee8
3c60d107 3863f314
[  191.932887] 480000bd 4bffffb8 7c0004ac 80030000 <0c000000> 4c00012c
9001000c 80020214
[  191.940754] ---[ end trace af45d29b317f9126 ]---
Bus error
root@Q5:~# ls



On Fri, Nov 21, 2008 at 10:17, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2008-11-19 at 13:59 +0100, Ricardo wrote:
>> Hello All:
>>
>>   I am using the paulus tree popwerpc linux kernel for a ppc440 cpu
>> located in a Virtex5 FPGA.
>>
>>   While developing some drivers (a simple gpio device) I have notice
>> that if I try to access an unmapped area (an address without any
>> register/device attached), the system completely crashes... I remember
>> that doing the same with a ppc400 cpu the system showed a
>> "Instruction/Data bus error" and continue working.
>>
>>   My question: The ppc440 cannot recover from this types of errors or
>> is a kernel missing feature/bug?
>
> You may want to look at the patch I posted recently:
>
> powerpc: Fix 460EX/460GT machine check handling
>
> >From the look of your log, we aren't using the right type of machine
> check handler for your core and it may need a similar treatement as the
> above processors.
>
> There are two kind of 440 cores vs. machine checks. On the old kind,
> machine checks used to be critical interrupts (and thus used CSRR0 and
> CSRR1 to save the context) while on the new kind, machine checks are
> their own type of exception with a dedicated pair of context save
> registers MCSRR0 and MCSRR1.
>
> It -looks- like the problem might be that the kernel isn't using the
> right set for your core. It uses by default the old style unless
> you change the machine check IVOR to point to MachineCheckA
> which is done by calling __fixup_440A_mcheck() in your CPU init routine
> for example, as we do for other 440 cores.
>
> So you would have to hook up a setup_cpu routine in cputable for
> those guys (I can see the virtex cores seem to not have any at
> this stage) and also change their machine check pointer to
> use machine_check_440A instead of machine_check_4xx so the machine
> check details are properly decoded.
>
> Of course check your Virtex user manual to make sure that's indeed
> what is happening :-)
>
> Cheers,
> Ben.
>
>



-- 
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
