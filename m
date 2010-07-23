Return-Path: <stuart.yoder@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) by ozlabs.org (Postfix) with ESMTP id 41FC0B6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Jul 2010 04:49:21 +1000 (EST)
Received: from mail111-va3 (localhost.localdomain [127.0.0.1])	by
	mail111-va3-R.bigfish.com (Postfix) with ESMTP id 7EF78160019A	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jul 2010 18:49:03 +0000 (UTC)
Received: from VA3EHSMHS010.bigfish.com (unknown [10.7.14.242])	by
	mail111-va3.bigfish.com (Postfix) with ESMTP id 46772C5004B	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jul 2010 18:49:03 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6NImuGU001568	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 11:48:56 -0700 (MST)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH][v2] fix of_flat_dt_is_compatible to match the full compatible
	string
Date: Fri, 23 Jul 2010 13:42:44 -0500
Message-ID: <1279910564-17887-1-git-send-email-stuart.yoder@freescale.com>
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
index dee4fb5..28c0c2b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -169,7 +169,7 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
 	if (cp == NULL)
 		return 0;
 	while (cplen > 0) {
-		if (strncasecmp(cp, compat, strlen(compat)) == 0)
+		if (!strcasecmp(cp, compat))
 			return 1;
 		l = strlen(cp) + 1;
 		cp += l;
-- 
1.6.2.5
