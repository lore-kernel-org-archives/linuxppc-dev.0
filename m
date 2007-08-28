Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B6D56DDF63
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 21:43:47 +1000 (EST)
Message-ID: <46D40510.3060805@scram.de>
Date: Tue, 28 Aug 2007 13:20:48 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32/8xx: Fix r3 trashing due to 8MB TLB page instantiation
Content-Type: multipart/mixed; boundary="------------000709070107090300080001"
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000709070107090300080001
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Instantiation of 8MB pages on the TLB cache for the kernel static
mapping trashes r3 register on !CONFIG_8xx_CPU6 configurations.
This ensures r3 gets saved and restored.

This has been posted to linuxppc-embedded by Marcelo Tosatti
<marcelo@kvack.org>, but only an incomplete version of the patch
has been applied in c51e078f82096a7d35ac8ec2416272e843a0e1c4.
This patch adds the rest of the fix.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/ppc/kernel/head_8xx.S |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

This can be pulled from git://git.bocc.de/dbox2.git ppc-fixes

--------------000709070107090300080001
Content-Type: text/x-patch;
 name="d14ebb1e9d133983252a14f2ef037f76969ab3c6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="d14ebb1e9d133983252a14f2ef037f76969ab3c6.diff"

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 944c35c..eb8d26f 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -495,9 +495,7 @@ LoadLargeDTLB:
 	lwz	r11, 4(r0)
 
 	lwz	r12, 16(r0)
-#ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)
-#endif
 	rfi
 
 /* This is the data TLB error on the MPC8xx.  This could be due to


--------------000709070107090300080001--
