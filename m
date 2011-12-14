Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4C79EB70B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 10:58:32 +1100 (EST)
Message-ID: <1323907106.21839.27.camel@pasglop>
Subject: [PATCH 1/2] offb: Fix bug in calculating requested vram size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-fbdev@vger.kernel.org
Date: Thu, 15 Dec 2011 10:58:26 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 448820776363da565f221c020f4ccb3c610faec3 Mon Sep 17 00:00:00 2001
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 14 Dec 2011 16:52:02 +1100
Subject: 

We used to try to request 8 times more vram than needed, which would
fail if the card has a too small BAR (observed with qemu).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/video/offb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

(I'm happy to carry that in the powerpc tree)

diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index cb163a5..915acae 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -381,7 +381,7 @@ static void __init offb_init_fb(const char *name, const char *full_name,
 				int pitch, unsigned long address,
 				int foreign_endian, struct device_node *dp)
 {
-	unsigned long res_size = pitch * height * (depth + 7) / 8;
+	unsigned long res_size = pitch * height;
 	struct offb_par *par = &default_par;
 	unsigned long res_start = address;
 	struct fb_fix_screeninfo *fix;
