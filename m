Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3EB5679E6
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 04:32:47 +1000 (EST)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 6D31AEF03
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Apr 2006 20:32:42 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] snd_pmac_toonie_init should to be __init
Date: Sun, 23 Apr 2006 20:32:41 +0200
Message-ID: <jeodys87na.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

snd_pmac_toonie_init is only called by __init code and calls __init code
itself.

Signed-off-by: Andreas Schwab <schwab@suse.de>

---
 sound/ppc/toonie.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17-rc2/sound/ppc/toonie.c
===================================================================
--- linux-2.6.17-rc2.orig/sound/ppc/toonie.c	2006-04-19 21:46:39.000000000 +0200
+++ linux-2.6.17-rc2/sound/ppc/toonie.c	2006-04-19 22:56:30.000000000 +0200
@@ -335,7 +335,7 @@ static void toonie_cleanup(struct snd_pm
 	chip->mixer_data = NULL;
 }
 
-int snd_pmac_toonie_init(struct snd_pmac *chip)
+int __init snd_pmac_toonie_init(struct snd_pmac *chip)
 {
 	struct pmac_toonie *mix;
 

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
