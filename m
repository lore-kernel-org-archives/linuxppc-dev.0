Return-Path: <grant.likely@secretlab.ca>
Date: Wed, 17 Oct 2007 20:22:48 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] bootwrapper: Allow wrapper script to execute verbosely
To: paulus@ozlabs.org, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
Message-id: <20071018022247.19403.36462.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Allow wrapper script to print verbose progress when the V is set in the
environment.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/wrapper |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 39b27e5..347639c 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -21,6 +21,11 @@
 #		(default ./arch/powerpc/boot)
 # -W dir	specify working directory for temporary files (default .)
 
+# Allow for verbose output
+if [ "$V" = 1 ]; then
+    set -x
+fi
+
 # defaults
 kernel=
 ofile=zImage
