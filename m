Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 62A992C0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 14:10:03 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id rA639tE0030806
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Nov 2013 21:09:57 -0600
Message-ID: <1383707393.4776.118.camel@pasglop>
Subject: [PATCH] powerpc/boot: Properly handle the base "of" boot wrapper
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 06 Nov 2013 14:09:53 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The wrapper script needs an explicit rule for the "of" boot
wrapper (generic wrapper, similar to pseries). Before
0c9fa29149d3726e14262aeb0c8461a948cc9d56 it was hanlded
implicitly by the statement:

platformo=$object/"$platform".o

But now that epapr.o needs to be added, that doesn't work
and an explicit rule must be added.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/boot/wrapper | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index ac16e99..2e1af74 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -147,6 +147,10 @@ link_address='0x400000'
 make_space=y
 
 case "$platform" in
+of)
+    platformo="$object/of.o $object/epapr.o"
+    make_space=n
+    ;;
 pseries)
     platformo="$object/of.o $object/epapr.o"
     link_address='0x4000000'
