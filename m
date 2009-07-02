Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E817DB70FB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 03:57:25 +1000 (EST)
Received: from mail-px0-f182.google.com (mail-px0-f182.google.com
	[209.85.216.182]) by ozlabs.org (Postfix) with ESMTP id 320D8DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 03:57:24 +1000 (EST)
Received: by pxi12 with SMTP id 12so1758140pxi.17
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Jul 2009 10:57:22 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] ASoC: Fix mpc5200-psc-ac97 to ensure the data ready bit
	is cleared
To: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
Date: Thu, 02 Jul 2009 11:57:19 -0600
Message-ID: <20090702175719.15773.58956.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

When doing register reads, it is possible for there to be a stale
data ready bit set which will cause subsequent reads to return
prematurely with incorrect data.  This patch fixes the issues by
ensuring stale data is cleared before starting another transaction.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/mpc5200_psc_ac97.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 794a247..9b8503f 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -41,6 +41,10 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 		pr_err("timeout on ac97 bus (rdy)\n");
 		return -ENODEV;
 	}
+
+	/* Force clear the data valid bit */
+	in_be32(&psc_dma->psc_regs->ac97_data);
+
 	/* Send the read */
 	out_be32(&psc_dma->psc_regs->ac97_cmd, (1<<31) | ((reg & 0x7f) << 24));
 
