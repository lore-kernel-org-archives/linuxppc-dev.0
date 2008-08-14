Return-Path: <galak@kernel.crashing.org>
Date: Wed, 13 Aug 2008 22:52:26 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: devicetree-discuss@ozlabs.org
Subject: [PATCH] libfdt: Add support for using aliases in fdt_path_offset()
Message-ID: <Pine.LNX.4.64.0808132251340.29599@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the path doesn't start with '/' check to see if it matches some alias
under "/aliases" and substitute the matching alias value in the path
and retry the lookup.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 libfdt/fdt_ro.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/libfdt/fdt_ro.c b/libfdt/fdt_ro.c
index ebd1260..74b8153 100644
--- a/libfdt/fdt_ro.c
+++ b/libfdt/fdt_ro.c
@@ -139,8 +139,29 @@ int fdt_path_offset(const void *fdt, const char *path)

 	FDT_CHECK_HEADER(fdt);

-	if (*path != '/')
-		return -FDT_ERR_BADPATH;
+	/* see if we have an alias */
+	if (*path != '/') {
+		const char *q;
+		int aliasoffset = fdt_path_offset(fdt, "/aliases");
+
+		if (aliasoffset < 0)
+			return -FDT_ERR_BADPATH;
+
+		q = strchr(path, '/');
+		if (!q)
+			q = end;
+
+		p = fdt_getprop_namelen(fdt, aliasoffset, path, q - p, NULL);
+		if (!p)
+			return -FDT_ERR_BADPATH;
+
+		aliasoffset = fdt_path_offset(fdt, p);
+		if (*q == '\0')
+			return aliasoffset;
+
+		q++;
+		return fdt_subnode_offset(fdt, aliasoffset, q);
+	}

 	while (*p) {
 		const char *q;
-- 
1.5.5.1
