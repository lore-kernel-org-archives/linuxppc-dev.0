Return-Path: <mware@internode.on.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2605DB7153
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 13:01:21 +1000 (EST)
Received: from ipmail01.adl6.internode.on.net (ipmail01.adl6.internode.on.net
	[203.16.214.146]) by ozlabs.org (Postfix) with ESMTP id 66B39DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 13:01:20 +1000 (EST)
MIME-Version: 1.0
Message-ID: <38410.1244689279@internode.on.net>
To: <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="utf-8"
Date: Thu, 11 Jun 2009 12:31:19 +0930
Subject: [PATCH] powerpc/fsl_lbc: Increase the number of possible lbc banks
From: mware@internode.on.net
Reply-To: mware@internode.on.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the fsl,*lbc devices support 8 banks (ie OR and BR registers).
This is adequate for most pq2 and pq3 processors, but not the MPC8280 which
has 12 banks.

Signed-Off-By: Mark Ware <mware@elphinstone.net>
---
 arch/powerpc/include/asm/fsl_lbc.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/=
fsl_lbc.h
index 63a4f77..1b5a210 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -95,8 +95,8 @@ struct fsl_lbc_bank {
 };

 struct fsl_lbc_regs {
-       struct fsl_lbc_bank bank[8];
-       u8 res0[0x28];
+       struct fsl_lbc_bank bank[12];
+       u8 res0[0x8];
        __be32 mar;             /**< UPM Address Register */
        u8 res1[0x4];
        __be32 mamr;            /**< UPMA Mode Register */
--
1.5.6.5
