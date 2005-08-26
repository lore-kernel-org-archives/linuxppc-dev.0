Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C65E767F88
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2005 23:39:57 +1000 (EST)
Date: Fri, 26 Aug 2005 15:39:48 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Message-ID: <20050826133948.GA29431@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: alsa tumbler audio-gpio-active-state handling broken after
	2.6.12-rc2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Ben,

this patch 03a53d4895d274ee8562ddc99723b98d8d0ef04c breaks tumbler
[PATCH] pmac: sound support for latest laptops

audio-gpio-active-state is zero. active_state was forced to 1 in this
case, now it is 0. As a result, no sound is played on my G4/466 and
600Mhz ibook.


This patch fixes it for me.


 sound/ppc/tumbler.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.13-rc7-tumbler/sound/ppc/tumbler.c
===================================================================
--- linux-2.6.13-rc7-tumbler.orig/sound/ppc/tumbler.c
+++ linux-2.6.13-rc7-tumbler/sound/ppc/tumbler.c
@@ -1073,7 +1073,7 @@ static long tumbler_find_device(const ch
 		gp->inactive_val = (*base) ? 0x4 : 0x5;
 	} else {
 		u32 *prop = NULL;
-		gp->active_state = 0;
+		gp->active_state = 1;
 		gp->active_val = 0x4;
 		gp->inactive_val = 0x5;
 		/* Here are some crude hacks to extract the GPIO polarity and
