Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA260DDE3F
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 22:58:23 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JRR76-0003eJ-HX
	for linuxppc-dev@ozlabs.org; Tue, 19 Feb 2008 03:58:20 -0800
Message-ID: <15560565.post@talk.nabble.com>
Date: Tue, 19 Feb 2008 03:58:20 -0800 (PST)
From: EricDuj <eric.dujardin@sagem.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [BUG][PATCH] 2.6.25-rc2 build fails on mpc52xx_psc_spi
In-Reply-To: <15560559.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <15560559.post@talk.nabble.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hello again,

Here is a second patch as the link fails with the same configuration. The
error is the following:

Image Name:   Linux-2.6.25-rc2
Created:      Tue Feb 19 13:57:46 2008
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    1662959 Bytes = 1623.98 kB = 1.59 MB
Load Address: 0x00400000
Entry Point:  0x00400550
  Building modules, stage 2.
  MODPOST 24 modules
ERROR: "mpc52xx_set_psc_clkdiv" [drivers/spi/mpc52xx_psc_spi.ko] undefined!
make[1]: *** [__modpost] Erreur 1
make: *** [modules] Erreur 2

Here is the patch:

--- arch/powerpc/platforms/52xx/mpc52xx_common.c.orig	2008-02-19
14:14:52.000000000 +0100
+++ arch/powerpc/platforms/52xx/mpc52xx_common.c	2008-02-19
14:12:56.000000000 +0100
@@ -199,6 +199,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(mpc52xx_set_psc_clkdiv);
 
 /**
  * mpc52xx_restart: ppc_md->restart hook for mpc5200 using the watchdog
timer


Best,

Eric


EricDuj wrote:
> 
> Hi all,
> 
> I am trying to cross compile the vanilla 2.6.25-rc2 kernel with the Denx
> 4.1 toolchain (gcc-4.0.0 based).
> 
> 

-- 
View this message in context: http://www.nabble.com/-BUG--PATCH--2.6.25-rc2-build-fails-on-mpc52xx_psc_spi-tp15560559p15560565.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
