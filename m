Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 7C622B6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 00:18:15 +1000 (EST)
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Dave Airlie <airlied@gmail.com>
Subject: [PATCH] agp/uninorth: Fix lockups with radeon KMS and >1x.
Date: Thu, 19 May 2011 16:08:39 +0200
Message-Id: <1305814119-32288-1-git-send-email-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michel Dänzer <daenzer@vmware.com>

This was based on a description by Ben Herrenschmidt:

> I've removed that SBA reset from the normal TLB invalidation path and
> left it only once after turning AGP on.

About six months ago, he said:

> I did it a bit differently, but yeah, you get the idea. I'm doing a
> patch series so don't bother pushing things too hard yet.

But I haven't seen anything from him about this since then, and people are
regularly hitting these lockups, so here we are...

Signed-off-by: Michel Dänzer <daenzer@vmware.com>
---
 drivers/char/agp/uninorth-agp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 47c2218..55af723 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -80,7 +80,7 @@ static void uninorth_tlbflush(struct agp_memory *mem)
 			       ctrl | UNI_N_CFG_GART_INVAL);
 	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL, ctrl);
 
-	if (uninorth_rev <= 0x30) {
+	if (!mem && uninorth_rev <= 0x30) {
 		pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
 				       ctrl | UNI_N_CFG_GART_2xRESET);
 		pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
-- 
1.7.5.1
