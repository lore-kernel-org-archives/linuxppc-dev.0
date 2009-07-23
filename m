Return-Path: <elendil@planet.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E9F7AB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 04:57:23 +1000 (EST)
Received: from CPSMTPM-EML104.kpnxchange.com (cpsmtpm-eml104.kpnxchange.com
	[195.121.3.8]) by ozlabs.org (Postfix) with ESMTP id 3D7AADDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 04:57:22 +1000 (EST)
From: Frans Pop <elendil@planet.nl>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: minor Makefile simplification through use of
	cc-ifversion
Date: Thu, 23 Jul 2009 20:57:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200907232057.19942.elendil@planet.nl>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Frans Pop <elendil@planet.nl>
---

Change was suggested by Sam Ravnborg; see http://lkml.org/lkml/2009/7/18/15.
Untested.

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index bc35f4e..952a396 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -77,7 +77,7 @@ CPP		= $(CC) -E $(KBUILD_CFLAGS)
 CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
 
 ifeq ($(CONFIG_PPC64),y)
-GCC_BROKEN_VEC	:= $(shell if [ $(call cc-version) -lt 0400 ] ; then echo "y"; fi)
+GCC_BROKEN_VEC	:= $(call cc-ifversion, -lt, 0400, y)
 
 ifeq ($(CONFIG_POWER4_ONLY),y)
 ifeq ($(CONFIG_ALTIVEC),y)
