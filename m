Return-Path: <mgreer@mvista.com>
Date: Wed, 8 Nov 2006 17:50:44 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Remove dtb file created by wrapper script
Message-ID: <20061109005043.GA10072@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When the wrapper script is passed a dts file, it runs 'dtc' to create
a dtb file.  This patch deletes that dtb file once its no longer needed.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 wrapper |    3 +++
 1 file changed, 3 insertions(+)
---

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index b5fb1fe..024e4d4 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -184,6 +184,9 @@ fi
 
 if [ -n "$dtb" ]; then
     addsec $tmp "$dtb" .kernel:dtb
+    if [ -n "$dts" ]; then
+	rm $dtb
+    fi
 fi
 
 if [ "$platform" != "miboot" ]; then
