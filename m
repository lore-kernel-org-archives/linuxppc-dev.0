Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Gorelik, Jacob (335F)" <jacob.gorelik@jpl.nasa.gov>
Subject: Re: powerpc: Hardware breakpoints rewrite to handle non DABR
 breakpoint registers
In-reply-to: <3F431E22-B7A9-4FCF-B34F-DC171A643E05@jpl.nasa.gov>
References: <3F431E22-B7A9-4FCF-B34F-DC171A643E05@jpl.nasa.gov>
Date: Fri, 17 May 2013 14:27:14 +1000
Message-ID: <30348.1368764834@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> I assume you are the right person to ask this question. 

Yep I am but adding linuxppc-dev mailing list to CC anyway.

> We are running the Linux kernel version 3.8.13 on a PPC750FX 32-bit
> based board without any problems; however, when I tried to boot
> version 3.9.2 on the same board, I get the following error:
> 
> Mount-cache hash table entries: 512
> Oops: Exception in kernel mode, sig: 4 [#1]
> BRE750FX
> Modules linked in:
> NIP: c0007210 LR: c00072ac CTR: c00403c0
> REGS: c039be90 TRAP: 0700   Not tainted  (3.9.0-svn1447)
> MSR: 00081032 <ME,IR,DR,RI>  CR: 22000082  XER: 00000000
> TASK = c03833a8[0] 'swapper' THREAD: c039a000
> GPR00: c029466c c039bf40 c03833a8 00000000 00000000 00000001 00000000 00000000 
> GPR08: c0383fe4 00000000 00000000 00000000 42000022 1001a6e4 00000000 100ce000 
> GPR16: 00000000 00000001 00000000 00000024 00000001 c02a0000 c03a0000 c02a0000 
> GPR24: c0386864 00000004 c038796c c039a000 cf4303d0 c0386490 c0386490 c03833a8 
> NIP [c0007210] set_breakpoint+0x48/0x54
> LR [c00072ac] __switch_to+0x90/0x98
> Call Trace:
> [c039bf40] [c00404e4] pick_next_task_fair+0x124/0x1c0 (unreliable)
> [c039bf60] [c029466c] __schedule+0x17c/0x358
> [c039bfa0] [c0294ad0] schedule_preempt_disabled+0x10/0x20
> [c039bfb0] [c0004090] rest_init+0x60/0x70
> [c039bfc0] [c035ed60] start_kernel+0x2c4/0x2d8
> [c039bff0] [00003438] 0x3438
> Instruction dump:
> 2f890000 81630004 80e30000 5483077e 5484ef7e 91480000 91680004 7c633b78 
> 419e000c 7d2903a6 4e800420 7c75fba6 <7c97fba6> 38600000 4e800020 9421ffe0 

Last two instruction here are:

	7c 75 fb a6 	mtspr   1013,r3
	7c 97 fb a6 	mtspr   1015,r4 ****

The SPR 1015 is the dabrx.

Looking at the 970FX docs, it has the DABR but not DABRX.  I didn't
realise that this config ever existed so I'm going to have to code
something up to fix it.

Meanwhile the below should get you going.  Let me know if it works.

This patch is not for upstream.

Not-at-all-signed-off-by: Michael Neuling <mikey@neuling.org> :-)

Mikey

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a902723..df9eb8e 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -399,7 +399,6 @@ static inline int __set_dabr(unsigned long dabr, unsigned lo
 static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
 {
        mtspr(SPRN_DABR, dabr);
-       mtspr(SPRN_DABRX, dabrx);
        return 0;
 }
 #else
