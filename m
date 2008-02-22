Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it (unknown [82.190.130.254])
	by ozlabs.org (Postfix) with ESMTP id 36BEFDDD01
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Feb 2008 01:18:08 +1100 (EST)
Message-ID: <47BED3A2.9020307@coritel.it>
Date: Fri, 22 Feb 2008 14:52:34 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8641D PCI-Express error
References: <47BC51B5.50204@coritel.it>	<BA5ADBDE-BDE5-4126-B012-DA6C5A8F8EF3@kernel.crashing.org>	<47BD3001.2020004@coritel.it>	<47BD96F8.4090406@freescale.com>	<47BD9815.9020002@freescale.com>
	<47BD9ACE.1090003@coritel.it> <47BD9FA9.1000904@freescale.com>
In-Reply-To: <47BD9FA9.1000904@freescale.com>
Content-Type: text/plain; charset=us-ascii
Cc: s.balamurugan@gdatech.co.in
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jon Loeliger ha scritto:
> Marco Stornelli wrote:
>> When I try to read some register from my FPGA (virtex5) I have this bus
>> error:
> 
> 
> Hmmm....  OK, so if we've eliminated PCI-E as a source
> for this issue, it really must be in the Virtex support
> somewhere then.  Unfortunately, I know nothing about those,
> and am not going to be much direct help there.
> 
> Sorry.
> 
> jdl
> 
> 
>> Machine check in kernel mode.
>> Caused by (from SRR1=149030): Transfer error ack signal
>> Oops: Machine check, sig: 7 [#1]
>> PREEMPT SMP NR_CPUS=2
>> Modules linked in: virtex5
>> LTT NESTING LEVEL : 0
>> NIP: F108019C LR: F1080198 CTR: 00000001
>> REGS: c044dd60 TRAP: 0200   Not tainted      (2.6.18-mpc8641d_hpcn)
>> MSR: 00149030 <EE,ME,IR,DR>  CR: 22000222  XER: 00000000
>> TASK = c20e9990[568] 'insmod' THREAD: c044c000 CPU: 0
>> GPR00: F1080198 C044DE10 C20E9990 0000002E 80000000 FFFFFFFF 00008000
>> 00002EA3
>> GPR08: C20E9990 00000000 C04C0220 C044C000 22000222 1001956C 00000000
>> 00000000
>> GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 00000000
>> GPR24: 3000EAA0 7FD6FDC0 00000000 C045FCC0 F107E594 F10A0000 00000000
>> C2036000
>> NIP [F108019C] virtex5_probe+0x130/0x1c4 [virtex5]
>> LR [F1080198] virtex5_probe+0x12c/0x1c4 [virtex5]
>> Call Trace:
>> [C044DE10] [F1080198] virtex5_probe+0x12c/0x1c4 [virtex5] (unreliable)
>> [C044DE30] [C01D2A58] pci_device_probe+0x84/0xbc
>> [C044DE50] [C0213754] driver_probe_device+0x60/0x118
>> [C044DE70] [C0213890] __driver_attach+0x84/0x88
>> [C044DE90] [C02130F4] bus_for_each_dev+0x58/0x94
>> [C044DEC0] [C02135D4] driver_attach+0x24/0x34
>> [C044DED0] [C0212AC8] bus_add_driver+0x88/0x164
>> [C044DEF0] [C021397C] driver_register+0x70/0xb8
>> [C044DF00] [C01D284C] __pci_register_driver+0x64/0x98
>> [C044DF10] [F1080030] init_module+0x30/0x6c [virtex5]
>> [C044DF20] [C004CBFC] sys_init_module+0xc8/0x25c
>> [C044DF40] [C0011358] ret_from_syscall+0x0/0x38
>> --- Exception: c00 at 0xff6de0c
>>     LR = 0x10000de4
>> Instruction dump:
>> 40820060 3c60f108 3863cea0 48000311 807f0238 3c800001 48000395 7c7d1b78
>> 3c60f108 3863ced4 480002f5 809d0000 <3c60f108> 3863cf04 480002e5 3c60f108
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

I tried to use 2.6.24 but I have the same error. It looks like this
problem happens when I try to read something in my ML555 board (Virtex5
evaluation board), but if try to write everything works fine. I tried to
change the settings about inbound/outbound PCI-E windows but I have the
same problem. Have you got any suggestions?

Thanks.

Marco
