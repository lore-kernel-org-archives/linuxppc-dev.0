Return-Path: <paulus@ozlabs.org>
Date: Tue, 29 Oct 2013 16:21:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: boot: Don't change link address for OF-based
 platforms
Message-ID: <20131029052125.GA17290@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit c55aef0e5bc6 ("powerpc/boot: Change the load address for the
wrapper to fit the kernel") adjusts the wrapper address unnecessarily
for platforms that use arch/powerpc/boot/of.c, since the code there
allocates space for the kernel wherever it can find it and doesn't
necessarily load the kernel at address 0.  Changing the link address
is actually harmful since it can cause the zImage to overlap with
Open Firmware and thus fail to boot.

To fix this, we set make_space to n for all of the platforms that
use of.o.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/boot/wrapper | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index cd7af84..ac16e99 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -150,18 +150,22 @@ case "$platform" in
 pseries)
     platformo="$object/of.o $object/epapr.o"
     link_address='0x4000000'
+    make_space=n
     ;;
 maple)
     platformo="$object/of.o $object/epapr.o"
     link_address='0x400000'
+    make_space=n
     ;;
 pmac|chrp)
     platformo="$object/of.o $object/epapr.o"
+    make_space=n
     ;;
 coff)
     platformo="$object/crt0.o $object/of.o $object/epapr.o"
     lds=$object/zImage.coff.lds
     link_address='0x500000'
+    make_space=n
     pie=
     ;;
 miboot|uboot*)
-- 
1.8.4.rc3
