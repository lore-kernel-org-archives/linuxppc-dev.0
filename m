Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9470BDE347
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 05:20:09 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH] Add null pointer check to of_find_property
Date: Wed,  7 May 2008 14:19:59 -0500
Message-Id: <1210187999-20274-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update function of_find_property() to return NULL if the device_node passed
to it is also NULL.  Otherwise, passing NULL will cause a null pointer
dereference.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch allows callers to do this:

np = of_find_compatible_node(...);
prop = of_get_property(np);
if (!prop)
     goto error;

Today, we need a np==NULL check between the two of_ calls.  Some callers may
not care whether the node is missing or the property is missing.

 drivers/of/base.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9bd7c4a..23ffb7c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -65,6 +65,9 @@ struct property *of_find_property(const struct device_node *np,
 {
 	struct property *pp;
 
+	if (!np)
+		return NULL;
+
 	read_lock(&devtree_lock);
 	for (pp = np->properties; pp != 0; pp = pp->next) {
 		if (of_prop_cmp(pp->name, name) == 0) {
-- 
1.5.5
