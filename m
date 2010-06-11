Return-Path: <dbaryshkov@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id 368131007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 21:52:39 +1000 (EST)
Received: by bwz8 with SMTP id 8so338668bwz.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 04:52:38 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] mpc52xx: fix oops during going to standby
Date: Fri, 11 Jun 2010 15:52:35 +0400
Message-Id: <1276257155-7297-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1276257155-7297-1-git-send-email-dbaryshkov@gmail.com>
References: <1276257155-7297-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When going to standby mode mpc code maps the whole soc5200 node
to access warious MBAR registers. However as of_iomap uses 'reg'
property of device node, only small part of MBAR is getting mapped.
Thus pm code gets oops when trying to access high parts of MBAR.
As a way to overcome this, make mpc52xx_pm_prepare() explicitly
map whole MBAR (0xc0000).

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/52xx/mpc52xx_pm.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
index a55b0b6..7672253 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -64,10 +64,19 @@ int mpc52xx_pm_prepare(void)
 		{ .type = "builtin", .compatible = "mpc5200", }, /* efika */
 		{}
 	};
+	struct resource res;
 
 	/* map the whole register space */
 	np = of_find_matching_node(NULL, immr_ids);
-	mbar = of_iomap(np, 0);
+
+	if (of_address_to_resource(np, 0, &res)) {
+		pr_err("mpc52xx_pm_prepare(): could not get IMMR address\n");
+		of_node_put(np);
+		return -ENOSYS;
+	}
+
+	mbar = ioremap(res.start, 0xc000); /* we should map whole region including SRAM */
+
 	of_node_put(np);
 	if (!mbar) {
 		pr_err("mpc52xx_pm_prepare(): could not map registers\n");
-- 
1.7.1
