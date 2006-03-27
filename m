Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD4D0679F0
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 07:23:36 +1100 (EST)
In-Reply-To: <17443.49609.63829.380622@cargo.ozlabs.ibm.com>
References: <17443.49609.63829.380622@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0ED6B216-1F6E-40E7-9EB8-399F4066E273@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Unify the 32 and 64 bit idle loops
Date: Mon, 27 Mar 2006 14:23:31 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm now seeing the following kernel panic on an 83xx system (603  
core) w/preempt on (2.6.16 is ok on this system):

Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:e0:db:00:04:fe
eth0: Running with NAPI disabled
eth0: 64/64 RX/TX BD ring size
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
Marvell 88E1101: Registered new driver
i2c /dev entries driver
NET: Registered protocol family 2
Non-recoverable exception at PC=c0009498 MSR=8000
Oops: nonrecoverable exception, sig: 9 [#1]
Modules linked in:
NIP: C0009498 LR: C0007E78 CTR: C00093D8
REGS: c022bef0 TRAP: 0900   Not tainted  (2.6.16-g9618edab)
MSR: 00008000 <EE>  CR: 24024048  XER: 20000000
TASK = c01f5da8[0] 'swapper' THREAD: c022a000
GPR00: 00000000 C022BFA0 C01F5DA8 00800000 8090C000 00E00000 00000001  
00048000
GPR08: 00000000 C00093D8 22024022 00000010 000009D3 9D410001 0FFFF000  
007FFFFA
GPR16: 00000001 FFFFFFFF 00000000 0FFFA0E4 00000000 007FFF00 0FFA7758  
00000002
GPR24: 00000000 00800000 40000000 C0249370 C0249370 00000010 C022A024  
C022A000
NIP [C0009498] ppc6xx_idle+0xc0/0xcc
LR [C0007E78] cpu_idle+0x9c/0xf0
Call Trace:
[C022BFA0] [00800000] 0x800000 (unreliable)
[C022BFC0] [C00037A4] rest_init+0x28/0x38
[C022BFD0] [C022C6A0] start_kernel+0x1b8/0x1f8
[C022BFF0] [00003378] 0x3378
Instruction dump:
64a50080 7c842878 7c841b78 64840010 7c90fba6 60000000 60000000 60e78000
64e70004 7c0004ac 4c00012c 7ce00124 <4c00012c> 7c0004ac 4e800020  
7d70faa6
<0>Kernel panic - not syncing: Attempted to kill the idle task!
<0>Rebooting in 180 seconds..



On Mar 24, 2006, at 3:54 AM, Paul Mackerras wrote:

> This unifies the 32-bit (ARCH=ppc and ARCH=powerpc) and 64-bit idle
> loops.  It brings over the concept of having a ppc_md.power_save
> function from 32-bit to ARCH=powerpc, which lets us get rid of
> native_idle().  With that, we can also reduce the amount of special
> code for pSeries and cell because the special code has only to do what
> needs to be done when there is no work to do, rather than being a
> complete idle loop.
>
> iSeries still has its own idle loops because it wants to test
> hvlpevents_pending() as well as need_resched() etc.  I don't know if
> that is essential but I have left it as-is for now.
>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
