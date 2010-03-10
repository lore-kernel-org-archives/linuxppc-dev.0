Return-Path: <julia@diku.dk>
Received: from mgw1.diku.dk (mgw1.diku.dk [130.225.96.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw1.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 421C8B7D11
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 08:41:22 +1100 (EST)
Date: Wed, 10 Mar 2010 22:15:01 +0100 (CET)
From: Julia Lawall <julia@diku.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/6] arch/powerpc/platforms/pseries: Use kasprintf
Message-ID: <Pine.LNX.4.64.1003102214430.1672@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

kasprintf combines kmalloc and sprintf, and takes care of the size
calculation itself.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression a,flag;
expression list args;
statement S;
@@

  a =
-  \(kmalloc\|kzalloc\)(...,flag)
+  kasprintf(flag,args)
  <... when != a
  if (a == NULL || ...) S
  ...>
- sprintf(a,args);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/powerpc/platforms/pseries/dlpar.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff -u -p a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -78,13 +78,12 @@ static struct device_node *dlpar_parse_c
 	 * prepend this to the full_name.
 	 */
 	name = (char *)ccwa + ccwa->name_offset;
-	dn->full_name = kmalloc(strlen(name) + 2, GFP_KERNEL);
+	dn->full_name = kasprintf(GFP_KERNEL, "/%s", name);
 	if (!dn->full_name) {
 		kfree(dn);
 		return NULL;
 	}
 
-	sprintf(dn->full_name, "/%s", name);
 	return dn;
 }
 
@@ -409,15 +408,13 @@ static ssize_t dlpar_cpu_probe(const cha
 	 * directory of the device tree.  CPUs actually live in the
 	 * cpus directory so we need to fixup the full_name.
 	 */
-	cpu_name = kzalloc(strlen(dn->full_name) + strlen("/cpus") + 1,
-			   GFP_KERNEL);
+	cpu_name = kasprintf(GFP_KERNEL, "/cpus%s", dn->full_name);
 	if (!cpu_name) {
 		dlpar_free_cc_nodes(dn);
 		rc = -ENOMEM;
 		goto out;
 	}
 
-	sprintf(cpu_name, "/cpus%s", dn->full_name);
 	kfree(dn->full_name);
 	dn->full_name = cpu_name;
 
