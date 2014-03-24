Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 752D514008C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 22:33:41 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 24 Mar 2014 10:22:53 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 004602190069
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 10:22:47 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2OAMenQ66781392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 10:22:40 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2OAMpWk001852
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 04:22:51 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/boot: fix global entry point for pseries
Date: Mon, 24 Mar 2014 11:22:41 +0100
Message-Id: <1395656561-29261-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1395651884.30488.10.camel@pasglop>
References: <1395651884.30488.10.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch 15/18 "powerpc/boot: add a global entry point for pseries"
introduced a pseries-head.S file to fix the endian order when
entering the boot wrapper. This patch is a fix for some platforms
which also generate the zImage.pseries boot wrapper.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
Ben,

You can probably merge that one with patch 15. I can also
resend the whole patchset and merge the three last patches
as you did. As you wish.

Cheers,


 arch/powerpc/boot/Makefile |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 35189540b699..0d65b83e4af3 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -106,6 +106,10 @@ src-plat-$(CONFIG_AMIGAONE) += cuboot-amigaone.c
 src-plat-$(CONFIG_PPC_PS3) += ps3-head.S ps3-hvcall.S ps3.c
 src-plat-$(CONFIG_EPAPR_BOOT) += epapr.c epapr-wrapper.c
 src-plat-$(CONFIG_PPC_PSERIES) += pseries-head.S
+src-plat-$(CONFIG_PPC_POWERNV) += pseries-head.S
+src-plat-$(CONFIG_PPC_IBM_CELL_BLADE) += pseries-head.S
+src-plat-$(CONFIG_PPC_CELLEB) += pseries-head.S
+src-plat-$(CONFIG_PPC_CELL_QPACE) += pseries-head.S
 
 
 src-wlib := $(sort $(src-wlib-y))
-- 
1.7.10.4
