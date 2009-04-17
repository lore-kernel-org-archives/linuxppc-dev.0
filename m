Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93BB3DE25C
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 03:06:48 +1000 (EST)
Subject: Re: issues w/init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B6C2A84E-7481-47D3-A85A-C2D8218354A4@kernel.crashing.org>
References: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
	<88F07543-B7F6-4F27-B5FB-4780AD069D7E@kernel.crashing.org>
	<49E78620.7070303@freescale.com>
	<C17084D8-19F7-48D2-8E7E-2DE561108A90@kernel.crashing.org>
	<1239953907.7443.45.camel@pasglop>
	<18920.21593.737132.732053@cargo.ozlabs.ibm.com>
	<1239964860.7443.65.camel@pasglop>
	<B6C2A84E-7481-47D3-A85A-C2D8218354A4@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 19:04:39 +0200
Message-Id: <1239987879.7210.16.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> On ppc32 personality is clearly set to 0.  On ppc64 the  
> elf_read_implies_exec does work around the issue (ie I implemented  
> elf_read_implies_exec as (exec_stk != EXSTACK_DISABLE_X) on ppc32).   
> However I think its just masking it.

How so ? IE, it checks for PT_GNU_STACK, if not present, it then
sets read to imply exec. Things compiled with a fixed toolchain
have that no ?

Ben.

> Hear are the PHDRs for the version of init I'm running:
> 
> Program Headers:
>    Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg  
> Align
>    PHDR           0x000034 0x10000034 0x10000034 0x000e0 0x000e0 R E 0x4
>    INTERP         0x000114 0x10000114 0x10000114 0x0000d 0x0000d R   0x1
>        [Requesting program interpreter: /lib/ld.so.1]
>    LOAD           0x000000 0x10000000 0x10000000 0x072a0 0x072a0 R E  
> 0x10000
>    LOAD           0x0072a0 0x100172a0 0x100172a0 0x00358 0x00988 RW   
> 0x10000
>    DYNAMIC        0x0074bc 0x100174bc 0x100174bc 0x000c8 0x000c8 RW  0x4
>    NOTE           0x000130 0x10000130 0x10000130 0x00020 0x00020 R    
> 0x10
> 
> I don't think elf_read_implies_exec() is the right solution on ppc32.   
> As I asked before, can VM_MAYEXEC be of any use to us?
> 
> - k
