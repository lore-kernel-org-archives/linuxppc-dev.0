Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f201.google.com (mail-pz0-f201.google.com
	[209.85.222.201]) by ozlabs.org (Postfix) with ESMTP id 6C0AFB8528
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:04:46 +1100 (EST)
Received: by mail-pz0-f201.google.com with SMTP id 39so169281pzk.15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:04:46 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 10/37] drivers/video: use .dev.of_node instead of .node in
	struct of_device
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org,
	dwmw2@infradead.org, jeremy.kerr@canonical.com,
	James.Bottomley@suse.de, broonie@opensource.wolfsonmicro.com,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org
Date: Thu, 11 Mar 2010 11:04:43 -0700
Message-ID: <20100311180442.4824.14836.stgit@angua>
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
References: <20100311174830.4824.19820.stgit@angua>
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

.node is being removed

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/video/cg6.c |    2 +-
 drivers/video/ffb.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 0d47c60..978c15f 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -741,7 +741,7 @@ static void cg6_unmap_regs(struct of_device *op, struct fb_info *info,
 static int __devinit cg6_probe(struct of_device *op,
 				const struct of_device_id *match)
 {
-	struct device_node *dp = op->node;
+	struct device_node *dp = op->dev.of_node;
 	struct fb_info *info;
 	struct cg6_par *par;
 	int linebytes, err;
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 9dbb964..be0c982 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -897,7 +897,7 @@ static void ffb_init_fix(struct fb_info *info)
 static int __devinit ffb_probe(struct of_device *op,
 			       const struct of_device_id *match)
 {
-	struct device_node *dp = op->node;
+	struct device_node *dp = op->dev.of_node;
 	struct ffb_fbc __iomem *fbc;
 	struct ffb_dac __iomem *dac;
 	struct fb_info *info;
