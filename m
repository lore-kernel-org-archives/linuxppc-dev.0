Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 5/5] of/address: restrict 'no-ranges' kludge to powerpc
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 08 Jun 2010 08:10:18 -0600
Message-ID: <20100608141018.25879.44413.stgit@angua>
In-Reply-To: <20100608140917.25879.67745.stgit@angua>
References: <20100608140917.25879.67745.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Certain Apple machines don't use the ranges property correctly, but the
workaround should not be applied on other architectures.  This patch
disables the workaround for non-powerpc architectures.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
CC: devicetree-discuss@lists.ozlabs.org
---
 drivers/of/address.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 0b04137..5c220c3 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -346,12 +346,21 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	 * a 1:1 translation at that level. It's up to the caller not to try
 	 * to translate addresses that aren't supposed to be translated in
 	 * the first place. --BenH.
+	 *
+	 * As far as we know, this damage only exists on Apple machines, so
+	 * This code is only enabled on powerpc. --gcl
 	 */
 	ranges = of_get_property(parent, rprop, &rlen);
+#if !defined(CONFIG_PPC)
+	if (ranges == NULL) {
+		pr_err("OF: no ranges; cannot translate\n");
+		return 1;
+	}
+#endif /* !defined(CONFIG_PPC) */
 	if (ranges == NULL || rlen == 0) {
 		offset = of_read_number(addr, na);
 		memset(addr, 0, pna * 4);
-		pr_debug("OF: no ranges, 1:1 translation\n");
+		pr_debug("OF: empty ranges; 1:1 translation\n");
 		goto finish;
 	}
 
