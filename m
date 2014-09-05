Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC9461A00FD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 15:28:47 +1000 (EST)
Message-ID: <1409894927.11359.26.camel@ale.ozlabs.ibm.com>
Subject: deb-pkg: Add support for powerpc little endian
From: Michael Neuling <mikey@neuling.org>
To: Michal Marek <mmarek@suse.cz>, Ben Hutchings <ben@decadent.org.uk>
Date: Fri, 05 Sep 2014 15:28:47 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Leann Ogasawara <leann.ogasawara@canonical.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>,
 linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Debian powerpc little endian architecture is called ppc64le.  This
is the default architecture used by Ubuntu for powerpc.

The below checks the kernel config to see if we are compiling little
endian and sets the Debian arch appropriately.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 35d5a58..6f4a1af 100644
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -37,7 +37,7 @@ create_package() {
 	s390*)
 		debarch=3Ds390$(grep -q CONFIG_64BIT=3Dy $KCONFIG_CONFIG && echo x || tr=
ue) ;;
 	ppc*)
-		debarch=3Dpowerpc ;;
+		debarch=3D$(grep -q CPU_LITTLE_ENDIAN=3Dy $KCONFIG_CONFIG && echo ppc64e=
l || echo powerpc) ;;
 	parisc*)
 		debarch=3Dhppa ;;
 	mips*)
