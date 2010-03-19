Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [v2 PATCH] of/flattree: Fix unhandled OF_DT_NOP tag when unflattening
	the device tree
To: devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org,
	monstr@monstr.eu, linuxppc-dev@lists.ozlabs.org
Date: Fri, 19 Mar 2010 14:01:49 -0600
Message-ID: <20100319200049.5195.97171.stgit@angua>
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

From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

NOPs within the property section are skipped, but NOPs between
OF_DT_END_NODE and OF_DT_BEGIN_NODE were not. My firmware NOPs out
entire nodes depending on various environment parameters.

of_scan_flat_dt already handles NOP more generally.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
v2 - adapted to new location of unflatten_dt_node().

Jason, please test against 2.6.34-rc1

 drivers/of/fdt.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 406757a..dee4fb5 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -376,8 +376,11 @@ unsigned long __init unflatten_dt_node(unsigned long mem,
 		if (!np->type)
 			np->type = "<NULL>";
 	}
-	while (tag == OF_DT_BEGIN_NODE) {
-		mem = unflatten_dt_node(mem, p, np, allnextpp, fpsize);
+	while (tag == OF_DT_BEGIN_NODE || tag == OF_DT_NOP) {
+		if (tag == OF_DT_NOP)
+			*p += 4;
+		else
+			mem = unflatten_dt_node(mem, p, np, allnextpp, fpsize);
 		tag = be32_to_cpup((__be32 *)(*p));
 	}
 	if (tag != OF_DT_END_NODE) {
