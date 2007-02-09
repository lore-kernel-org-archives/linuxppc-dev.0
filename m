Return-Path: <mgreer@mvista.com>
Date: Fri, 9 Feb 2007 11:43:45 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Subject: Okay to change default zImage link/load address?
Message-ID: <20070209184345.GA28127@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The default link (and therefore load address if your fw talks ELF)
is @ 4MB.  This causes problems for at least 2 different platforms
I have (Maple and f101/prpmc280).  The problem is that a large enough
zImage overwrites memory--or stops downloading if it would overwrite
memory--used by the firmware and it ends up complaining about a corrupted
ELF image or just doesn't run properly.

The default in arch/ppc was configurable (CONFIG_BOOT_LOAD) with the
default being 8MB.  8MB worked fine for most if not all 32-bit platforms.

Does anyone know of a problem downloading to 8MB instead of 4MB in
arch/powerpc?  If not, would you object if it changed to 8MB?

The patch below is the change I'm talking about.

Thanks,

Mark
--

diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index 4be3c64..608de2f 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -2,7 +2,7 @@ OUTPUT_ARCH(powerpc:common)
 ENTRY(_zimage_start)
 SECTIONS
 {
-  . = (4*1024*1024);
+  . = (8*1024*1024);
   _start = .;
   .text      :
   {
