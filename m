Date: Tue, 27 Nov 2001 23:32:24 -0500
From: Joseph Manojlovich <manojlov@cse.psu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: 'make rpm' Failing due to i386 bug
Message-ID: <20011127233224.C23109@cardassian.cse.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all. I was using the latest stable branch from source.mvista.com,
and noticed that 'make rpm' wasn't working. Looking closer, I noticed
that a supporting script, scripts/mkspec, is quite 386 specific. It
makes an rpm spec file that assumes the kernel image is compressed,
which with ppc it isn't (for me at least).

Here's a quick patch which fixes this for the ppc platform, but would
not work on platforms that use compressed kernel images, like x86. I'm
not looking forward to fixing the make system for the kernel, so if
anyone wants to permanently fix this, it would be appreciated.

--- linuxppc-old/scripts/mkspec	Sun Nov 18 03:45:21 2001
+++ linuxppc/scripts/mkspec	Tue Nov 27 22:02:17 2001
@@ -28,12 +28,12 @@
 echo "%setup -q"
 echo ""
 echo "%build"
-echo "make oldconfig dep clean bzImage modules"
+echo "make oldconfig dep clean vmlinux modules"
 echo ""
 echo "%install"
 echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
 echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
-echo 'cp arch/i386/boot/bzImage $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo 'cp vmlinux $RPM_BUILD_ROOT'"/boot/vmlinux-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 echo ""
 echo "%clean"

(end of patch)

--
Joe Manojlovich
manojlov@cse.psu.edu
"And a thermostat on a home furnace... is that supposed to go to
 5000 degrees, do you think?"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
