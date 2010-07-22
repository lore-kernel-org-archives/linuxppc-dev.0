Return-Path: <stuart.yoder@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id 8BD8E1007E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 09:50:29 +1000 (EST)
Received: from mail102-tx2 (localhost.localdomain [127.0.0.1])	by
	mail102-tx2-R.bigfish.com (Postfix) with ESMTP id 93F291E0495	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 23:35:03 +0000 (UTC)
Received: from TX2EHSMHS032.bigfish.com (unknown [10.9.14.251])	by
	mail102-tx2.bigfish.com (Postfix) with ESMTP id 6248E1208059	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 23:35:03 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6MNZ1J9004896	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Jul 2010 16:35:01 -0700 (MST)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] fix of_flat_dt_is_compatible to match the full compatible
	string
Date: Thu, 22 Jul 2010 18:28:50 -0500
Message-ID: <1279841330-28695-1-git-send-email-stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stuart Yoder <stuart.yoder@freescale.com>

With the previous string comparison, a device tree
compatible of "foo-bar" would match as compatible
with a driver looking for "foo".

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 drivers/of/fdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index dee4fb5..f5239c0 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -169,7 +169,7 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
 	if (cp == NULL)
 		return 0;
 	while (cplen > 0) {
-		if (strncasecmp(cp, compat, strlen(compat)) == 0)
+		if (!strcmp(cp, compat))
 			return 1;
 		l = strlen(cp) + 1;
 		cp += l;
-- 
1.6.2.5
