Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [RFC,PATCH] scripts/package: add powerpc images to tarball
Message-Id: <1216887460.306306.238738123378.1.gpush@pingu>
To: <linux-kernel@vger.kernel.org>, <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 24 Jul 2008 18:17:40 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, tarball builds for powerpc kernels don't have any boot
images (other than vmlinux) present.

Add support for powerpc builds in the buildtar script, to include
a few default images.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
RFC: any requests for more/less boot images?

---
 scripts/package/buildtar |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index 28574ae..85e5563 100644
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -72,6 +72,16 @@ case "${ARCH}" in
 	x86|i386|x86_64)
 		[ -f "${objtree}/arch/x86/boot/bzImage" ] && cp -v -- "${objtree}/arch/x86/boot/bzImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
 		;;
+	powerpc)
+		for img in zImage zImage.pseries zImage.iseries \
+				dtbImage dtbImage.ps3
+		do
+			imgpath=arch/powerpc/boot/${img}
+			[ -f "${objtree}/${imgpath}" ] || continue
+			cp -v -- "${objtree}/${imgpath}" \
+				"${tmpdir}/boot/${img}-${KERNELRELEASE}"
+		done
+		;;
 	alpha)
 		[ -f "${objtree}/arch/alpha/boot/vmlinux.gz" ] && cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
 		;;
