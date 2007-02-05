Return-Path: <darwish.07@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 9B4D4DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Feb 2007 03:59:25 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1191873ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 05 Feb 2007 08:59:23 -0800 (PST)
Date: Mon, 5 Feb 2007 18:59:16 +0200
To: ebs@ebshome.net
Subject: [PATCH 2.6.20] ibm_emac: Use ARRAY_SIZE macro when appropriate
Message-ID: <20070205165916.GK3896@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070205165429.GD3896@Ahmed>
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

A patch to use ARRAY_SIZE macro already defined in kernel.h.

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---
Patch isn't compile-tested cause I don't have the needed hardware.

diff --git a/drivers/net/ibm_emac/ibm_emac_debug.c b/drivers/net/ibm_emac/ibm_emac_debug.c
index 92f970d..1f70906 100644
--- a/drivers/net/ibm_emac/ibm_emac_debug.c
+++ b/drivers/net/ibm_emac/ibm_emac_debug.c
@@ -132,7 +132,7 @@ void emac_dbg_register(int idx, struct ocp_enet_private *dev)
 {
 	unsigned long flags;
 
-	if (idx >= sizeof(__emacs) / sizeof(__emacs[0])) {
+	if (idx >= ARRAY_SIZE(__emacs)) {
 		printk(KERN_WARNING
 		       "invalid index %d when registering EMAC for debugging\n",
 		       idx);
@@ -148,7 +148,7 @@ void mal_dbg_register(int idx, struct ibm_ocp_mal *mal)
 {
 	unsigned long flags;
 
-	if (idx >= sizeof(__mals) / sizeof(__mals[0])) {
+	if (idx >= ARRAY_SIZE(__mals)) {
 		printk(KERN_WARNING
 		       "invalid index %d when registering MAL for debugging\n",
 		       idx);
@@ -167,11 +167,11 @@ void emac_dbg_dump_all(void)
 
 	local_irq_save(flags);
 
-	for (i = 0; i < sizeof(__mals) / sizeof(__mals[0]); ++i)
+	for (i = 0; i < ARRAY_SIZE(__mals); ++i)
 		if (__mals[i])
 			emac_mal_dump(__mals[i]);
 
-	for (i = 0; i < sizeof(__emacs) / sizeof(__emacs[0]); ++i)
+	for (i = 0; i < ARRAY_SIZE(__emacs); ++i)
 		if (__emacs[i])
 			emac_mac_dump(i, __emacs[i]);
 

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
