Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C365DDE08
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:31:46 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1Vesj026745
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:31:40 -0700 (MST)
Date: Tue, 17 Jul 2007 20:31:37 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/61] Use strcasecmp() rather than strncasecmp() when
	determining device node compatibility.
Message-ID: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current code assumes "foo-bar" must always be compatible with a node
compatible with "foo", which breaks device trees where this is not so.

The "case" part is also wrong according to Open Firmware, but it's more
likely to have drivers and/or device trees depending on it, and thus
needs to be handled more carefully.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/prom.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 37ff99b..0b136a5 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -218,7 +218,7 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
 	if (cp == NULL)
 		return 0;
 	while (cplen > 0) {
-		if (strncasecmp(cp, compat, strlen(compat)) == 0)
+		if (strcasecmp(cp, compat) == 0)
 			return 1;
 		l = strlen(cp) + 1;
 		cp += l;
@@ -1099,7 +1099,7 @@ int of_device_is_compatible(const struct device_node *device,
 	if (cp == NULL)
 		return 0;
 	while (cplen > 0) {
-		if (strncasecmp(cp, compat, strlen(compat)) == 0)
+		if (strcasecmp(cp, compat) == 0)
 			return 1;
 		l = strlen(cp) + 1;
 		cp += l;
-- 
1.5.0.3
