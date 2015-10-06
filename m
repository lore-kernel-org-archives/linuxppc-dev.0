Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0140.outbound.protection.outlook.com [207.46.100.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B4901A0017
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 09:56:09 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: Simon Horman <horms@verge.net.au>
CC: <kexec@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Scott Wood <scottwood@freescale.com>, "Samuel
 Mendoza-Jonas" <sam.mj@au1.ibm.com>
Subject: [PATCH v2 2/3] ppc64: Avoid rfid if no need to clear MSR_LE
Date: Tue, 6 Oct 2015 17:55:49 -0500
Message-ID: <1444172150-29493-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit a304e2d82a8c3 ("ppc64: purgatory: Reset primary cpu endian to
big-endian) changed bctr to rfid.  rfid is book3s-only and will cause a
fatal exception on book3e.

Purgatory is an isolated environment which makes importing information
about the subarch awkward, so instead rely on the fact that MSR_LE
should never be set on book3e, and the rfid is only needed if MSR_LE is
set (and thus needs to be cleared).  In theory that MSR bit is reserved
on book3e, rather than zero, but in practice I have not seen it set.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
---
v2: new patch

 purgatory/arch/ppc64/v2wrap.S | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
index 179ade9..3534080 100644
--- a/purgatory/arch/ppc64/v2wrap.S
+++ b/purgatory/arch/ppc64/v2wrap.S
@@ -116,9 +116,17 @@ master:
 	stw	7,0x5c(4)	# and patch it into the kernel
 	mr      3,16            # restore dt address
 
+	mfmsr	5
+	andi.	10,5,1		# test MSR_LE
+	bne	little_endian
+
+	li	5,0		# r5 will be 0 for kernel
+	mtctr	4		# prepare branch to
+	bctr			# start kernel
+	
+little_endian:			# book3s-only
 	mtsrr0	4		# prepare branch to
 
-	mfmsr	5
 	clrrdi	5,5,1		# clear MSR_LE
 	mtsrr1	5
 
-- 
2.1.4
