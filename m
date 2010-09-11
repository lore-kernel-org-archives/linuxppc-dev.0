Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 561CBB70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Sep 2010 21:16:46 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH] sound/ppc/powermac: remove undefined operations
Date: Sat, 11 Sep 2010 13:16:41 +0200
Message-ID: <m2iq2cfs2u.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modifying an object twice without an intervening sequence point is
undefined.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 sound/ppc/tumbler.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 20afdf9..961d982 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -785,7 +785,7 @@ static int snapper_set_capture_source(struct pmac_tumbler *mix)
 	if (! mix->i2c.client)
 		return -ENODEV;
 	if (mix->capture_source)
-		mix->acs = mix->acs |= 2;
+		mix->acs |= 2;
 	else
 		mix->acs &= ~2;
 	return i2c_smbus_write_byte_data(mix->i2c.client, TAS_REG_ACS, mix->acs);
-- 
1.7.2.3

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
