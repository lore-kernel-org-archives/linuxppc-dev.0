Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6D9C867B16
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2005 08:05:59 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1112594783.26086.22.camel@gaston>
	<1112616384.19004.60.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 08 Apr 2005 00:05:49 +0200
In-Reply-To: <1112616384.19004.60.camel@gaston> (Benjamin Herrenschmidt's
	message of "Mon, 04 Apr 2005 22:06:24 +1000")
Message-ID: <jezmwa6y4i.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: iBook G3 owners
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> http://gate.crashing.org/~benh/ppc32-pmac-sleep-fix.diff

This patch does not work on the 750fx, I'm getting random crashes on
wakeup.  When I replace it with this one-liner, all is well again:

--- linux-2.6.12-rc2.orig/arch/ppc/platforms/pmac_cache.S	2005-04-04 23:05:41.000000000 +0200
+++ linux-2.6.12-rc2/arch/ppc/platforms/pmac_cache.S	2005-04-07 23:22:04.000000000 +0200
@@ -73,7 +73,7 @@
 
 	/* disable / invalidate / enable L1 data */
 	mfspr	r3,SPRN_HID0
-	rlwinm	r0,r0,0,~HID0_DCE
+	rlwinm	r3,r3,0,~(HID0_DCE | HID0_ICE)
 	mtspr	SPRN_HID0,r3
 	sync
 	isync

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
