Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix error when cross building TAGS & cscope
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Thu, 21 Nov 2013 14:59:07 +1100
Message-ID: <15464.1385006347@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, Ian Munsie <ianmunsi@au1.ibm.com>,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently if I cross build TAGS or cscope from x86 I get this:
  % make ARCH=3Dpowerpc TAGS
  gcc-4.8.real: error: unrecognized command line option =E2=80=98-mbig-endi=
an=E2=80=99
  GEN     TAGS
  %=20

I'm not setting CROSS_COMPILE=3D as logically I shouldn't need to and I
haven't needed to in the past when building TAGS or cscope.  Also, the
above completess correct as the error is not fatal to the build.

This was caused by:
    commit d72b08017161ab385d4ae080ea415c9eb7ceef83
    Author: Ian Munsie <imunsie@au1.ibm.com>
    powerpc: Add ability to build little endian kernels

The below fixes this by testing for the -mbig-endian option before
adding it.

I've not done the same thing in the little endian case as if
-mlittle-endian doesn't exist, we probably want to fail quickly as you
probably have an old big endian compiler.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8a24636..273ace7 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -75,8 +75,10 @@ LDEMULATION	:=3D lppc
 GNUTARGET	:=3D powerpcle
 MULTIPLEWORD	:=3D -mno-multiple
 else
+ifeq ($(call cc-option-yn,-mbig-endian),y)
 override CC	+=3D -mbig-endian
 override AS	+=3D -mbig-endian
+endif
 override LD	+=3D -EB
 LDEMULATION	:=3D ppc
 GNUTARGET	:=3D powerpc
