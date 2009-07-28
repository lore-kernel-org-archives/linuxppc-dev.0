Return-Path: <julia@diku.dk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 20D65B7B61
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jul 2009 02:02:10 +1000 (EST)
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AD3DADDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2009 02:02:09 +1000 (EST)
Date: Tue, 28 Jul 2009 17:56:00 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: avorontsov@ru.mvista.com, linuxppc-dev@ozlabs.org,
	sdhci-devel@lists.ossman.eu, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 8/9] drivers/mmc: correct error-handling code
Message-ID: <Pine.LNX.4.64.0907281755340.28189@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

sdhci_alloc_host returns an ERR_PTR value in an error case instead of NULL.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@match exists@
expression x, E;
statement S1, S2;
@@

x = sdhci_alloc_host(...)
... when != x = E
(
*  if (x == NULL || ...) S1 else S2
|
*  if (x == NULL && ...) S1 else S2
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/mmc/host/sdhci-of.c         |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index d79fa55..fb00bc5 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -226,7 +226,7 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 		return -ENODEV;
 
 	host = sdhci_alloc_host(&ofdev->dev, sizeof(*of_host));
-	if (!host)
+	if (IS_ERR(host))
 		return -ENOMEM;
 
 	of_host = sdhci_priv(host);
