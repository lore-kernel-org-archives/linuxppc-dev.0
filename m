Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DFA7BDDF4D
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jul 2007 07:19:09 +1000 (EST)
Date: Sun, 1 Jul 2007 23:19:09 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] power-management elements for 603e/fsl (version 2)
In-Reply-To: <Pine.LNX.4.60.0705212225470.7562@poirot.grange>
Message-ID: <Pine.LNX.4.60.0707012253420.4652@poirot.grange>
References: <Pine.LNX.4.60.0705192013010.10162@poirot.grange>
	<20070521155712.GA16235@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.60.0705212225470.7562@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 May 2007, Guennadi Liakhovetski wrote:

> On Mon, 21 May 2007, Scott Wood wrote:
> 
> > IRQs really shouldn't be enabled here without something like the "Handle
> > HID0_SLEEP in the TLF_NAPPING hack" patch I posted recently.
> 
> Ok, I'd be happy to rely on those your patches... as long as they make it 
> into the kernel. Paulus, what's the plan? I'll try to apply them locally 
> for now and adjust my code accordingly. A recent powerpc.git should be 
> fine, I guess - the arch_suspend_{disable,enable}_irqs hooks are already 
> there, or are there any further dependencies?

Took some time, but now I did rebase my linkstation standby code on your 
patches, and also used your mpc83xx_enter_sleep / ret_from_sleep functions 
(former with a single modification - removed the first mtmsr to set EE and 
POW in MSR with one insn) - all worked. So, we could put them into 
something like arch/powerpc/sysdev/fsl_pm.S and name accordingly. That 
could be an incremental patch after the present versions make it into some 
tree.

Of course, I needed other your patches to, e.g., bypass calling the ISR on 
resume too.

Thanks
Guennadi
---
Guennadi Liakhovetski
