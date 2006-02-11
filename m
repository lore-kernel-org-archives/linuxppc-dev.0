Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 97FCE67B37
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Feb 2006 03:10:38 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PPC,SOUND] Fix audio gpio state detection
Date: Sat, 11 Feb 2006 17:10:29 +0100
Message-ID: <jehd7527wq.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When booting with line out or headphone plugged, you won't hear anything.
The problem is that after reset all channels are muted, but the actual
value of the gpio port doesn't exactly match the active_val settings as
expected by check_audio_gpio.  For example, the line_mute port is set to
7, but check_audio_gpio would expect 0xd or 0xf, thus its return value
indicates that it is not active, even though it is.  AFAICS only looking
at the low bit is enough to determine whether the port is active.

Signed-off-by: Andreas Schwab <schwab@suse.de>

Index: linux-2.6.16-rc2/sound/ppc/tumbler.c
===================================================================
--- linux-2.6.16-rc2.orig/sound/ppc/tumbler.c	2006-02-03 19:43:50.000000000 +0100
+++ linux-2.6.16-rc2/sound/ppc/tumbler.c	2006-02-11 03:46:30.000000000 +0100
@@ -207,7 +207,7 @@ static int check_audio_gpio(struct pmac_
 
 	ret = do_gpio_read(gp);
 
-	return (ret & 0xd) == (gp->active_val & 0xd);
+	return (ret & 0x1) == (gp->active_val & 0x1);
 }
 
 static int read_audio_gpio(struct pmac_gpio *gp)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
