Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 682F5B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Jun 2010 01:58:50 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] macio: don't dereference pointer before null check
References: <1275270628.1931.540.camel@pasglop>
	<1275271231.1931.547.camel@pasglop>
	<FAE73713-EE73-4FA6-B1C6-88D38E230F01@suse.de>
	<m3ljb0tn2l.fsf@hase.home>
	<4C03DB3D.7090007__38063.9078132392$1275321190$gmane$org@suse.de>
	<m2aargndy2.fsf@igel.home>
	<1275384716.1931.711.camel__10281.3212587082$1275384770$gmane$org@pasglop>
	<m3mxvfrt5n.fsf@hase.home>
	<1275385607.1931.712.camel__30394.2679115154$1275385651$gmane$org@pasglop>
Date: Tue, 01 Jun 2010 17:58:40 +0200
In-Reply-To: <1275385607.1931.712.camel__30394.2679115154$1275385651$gmane$org@pasglop>
	(Benjamin Herrenschmidt's message of "Tue, 01 Jun 2010 19:46:47
	+1000")
Message-ID: <m2sk56u4lr.fsf_-_@whitebox.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 drivers/macintosh/macio_asic.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 9714780..40390ac 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -492,8 +492,8 @@ static void macio_pci_add_devices(struct macio_chip *chip)
 	}
 
 	/* Add media bay devices if any */
-	pnode = mbdev->ofdev.dev.of_node;
-	if (mbdev)
+	if (mbdev) {
+		pnode = mbdev->ofdev.dev.of_node;
 		for (np = NULL; (np = of_get_next_child(pnode, np)) != NULL;) {
 			if (macio_skip_device(np))
 				continue;
@@ -502,10 +502,11 @@ static void macio_pci_add_devices(struct macio_chip *chip)
 						 mbdev,  root_res) == NULL)
 				of_node_put(np);
 		}
+	}
 
 	/* Add serial ports if any */
-	pnode = sdev->ofdev.dev.of_node;
 	if (sdev) {
+		pnode = sdev->ofdev.dev.of_node;
 		for (np = NULL; (np = of_get_next_child(pnode, np)) != NULL;) {
 			if (macio_skip_device(np))
 				continue;
-- 
1.7.1

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
