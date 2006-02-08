Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C80B468A90
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 18:10:59 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] fix iomem annotations in dart_iommu
Message-Id: <E1F6jTc-0002bA-1c@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:10:56 +0000
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Date: 1138796882 -0500

it's int __iomem *, not int * __iomem...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/powerpc/sysdev/dart_iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

6fa2ffe901c77cdd8db9616db66894e96c12143d
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 977de9d..6298264 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -59,7 +59,7 @@ static unsigned long dart_tablesize;
 static u32 *dart_vbase;
 
 /* Mapped base address for the dart */
-static unsigned int *__iomem dart;
+static unsigned int __iomem *dart;
 
 /* Dummy val that entries are set to when unused */
 static unsigned int dart_emptyval;
-- 
0.99.9.GIT
