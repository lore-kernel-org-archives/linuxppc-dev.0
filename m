Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC056683A8
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Oct 2005 08:15:07 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc <marvin24@gmx.de>
In-Reply-To: <200510040814.07188.marvin24@gmx.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
	<200510040814.07188.marvin24@gmx.de>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 08:14:54 +1000
Message-Id: <1128464094.6417.31.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: clock skew on B/W G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-10-04 at 08:14 +0200, Marc wrote:
> Hi,
> 
> given that this option causes problems on non i386 systems, may I propose to 
> mark CONFIG_HZ as broken on these architectures and/or use a default value of 
> 1000 ? I guess this issue can't be fixed in a sane way until 2.6.14 is out.

The problem is indeed in via_calibrate_decr(). This routine works on
HZ/100 so it will not do any good with HZ not beeing a multiple of 100.

Can you test this patch ?

Index: linux-work/arch/ppc/platforms/pmac_time.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_time.c	2005-09-22 14:06:18.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_time.c	2005-10-05 08:14:17.000000000 +1000
@@ -195,7 +195,7 @@
 		;
 	dend = get_dec();
 
-	tb_ticks_per_jiffy = (dstart - dend) / (6 * (HZ/100));
+	tb_ticks_per_jiffy = (dstart - dend) / ((6 * HZ)/100);
 	tb_to_us = mulhwu_scale_factor(dstart - dend, 60000);
 
 	printk(KERN_INFO "via_calibrate_decr: ticks per jiffy = %u (%u ticks)\n",
