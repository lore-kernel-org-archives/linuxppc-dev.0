Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 474FA1007D1
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2011 23:36:19 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <bounces@nabble.com>) id 1QGtIN-0006BM-0j
	for linuxppc-dev@ozlabs.org; Mon, 02 May 2011 06:36:15 -0700
Message-ID: <31523658.post@talk.nabble.com>
Date: Mon, 2 May 2011 06:36:15 -0700 (PDT)
From: linuxppc-dev <eftakhar.chowdhury@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Read/write BCSR registers of PPC460EX
In-Reply-To: <201105021453.32775.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <31522823.post@talk.nabble.com>
	<20110502124039.GB3269@zod.rchland.ibm.com>
	<201105021453.32775.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Dear Stefan,

I have changed CPLD/BCSR address with 0x4E1000000.

static unsigned long mem_addr =  0x4E1000000;

But still I get the Machine check error When I load my module. I have posted
the error Message below.




Error Message
-------------

<4>minimod: module license 'unspecified' taints kernel.
<4>Disabling lock debugging due to kernel taint
<4>ioremap: Virtual Address e8f20000
<4>Machine check in kernel mode.
<4>Data Read PLB Error
<4>Oops: Machine check, sig: 7 [#1]
<4>PowerPC 44x Platform
<4>Modules linked in: minimod(P+)
<4>NIP: e4ff60ec LR: e4ff60d8 CTR: c0167174
<4>REGS: dfff7f10 TRAP: 0214   Tainted: P            (2.6.30.3)
<4>MSR: 00029000 <EE,ME,CE>  CR: 24000028  XER: 20000007
<4>TASK = de518000[956] 'insmod' THREAD: da282000
<6>GPR00: e4ff60d8 da283e90 de518000 00000025 00000000 ffffffff c01646c8
0000321d 
<6>GPR08: 00000000 e8f20000 0000321d 00004000 44000022 101c0dac 100ab618
10095434 
<6>GPR16: 100f0000 100f0000 bfee5eec 00000002 bfee5ef0 00000000 101ebf80
bfd0c274 
<6>GPR24: 10130a48 00000000 c0350000 c0326008 c0326014 e4ff0000 da282000
e4ff6524 
<4>NIP [e4ff60ec] io_driver_init+0x9c/0x150 [minimod]
<4>LR [e4ff60d8] io_driver_init+0x88/0x150 [minimod]
<4>Call Trace:
<4>[da283e90] [e4ff60d8] io_driver_init+0x88/0x150 [minimod] (unreliable)
<4>[da283eb0] [c00013d8] do_one_initcall+0x34/0x1a0
<4>[da283f20] [c004dc14] sys_init_module+0xb0/0x1b8
<4>[da283f40] [c000de8c] ret_from_syscall+0x0/0x3c
<4>Instruction dump:
<4>7c601b78 3c60e4ff 3fa0e4ff 386361ec 7c040378 901d6658 4800007d 813d6658 
<4>2f890000 419e004c 7c0004ac 80890000 <0c040000> 4c00012c 3c60e4ff 3863621c 
<4>---[ end trace 0af1ade6d5d6a053 ]---

Thanks,
Efti



Stefan Roese wrote:
> 
> On Monday 02 May 2011 14:40:39 Josh Boyer wrote:
>> >static unsigned long mem_addr = 0xC0000000;// IP base address
>> 
>> Is this the correct address for the BCSR?  On the 460EX Canyonlands
>> board, the CPLD/BCSR is at 0xE1000000.
> 
> To be precise: It's 0x4.e100.0000 as 36bit physical address.
>  
> Cheers,
> Stefan
> 
> --
> DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://old.nabble.com/Read-write-BCSR-registers-of-PPC460EX-tp31522823p31523658.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
