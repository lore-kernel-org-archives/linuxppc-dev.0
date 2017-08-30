Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhmYr3T7hzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 10:28:00 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id a2so3275098pfj.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 17:28:00 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 1/2] powerpc/xmon: hdec is now 64bits
Date: Wed, 30 Aug 2017 10:27:44 +1000
Message-Id: <20170830002745.29526-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ISA 300 defines hypervisor decrementer to be 64 bits in length.
This patch extends the print format for all archs to be 64 bits

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9e68f1d..1b26d53 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1749,7 +1749,7 @@ static void dump_206_sprs(void)
 
 	printf("sdr1   = %.16lx  hdar  = %.16lx hdsisr = %.8x\n",
 		mfspr(SPRN_SDR1), mfspr(SPRN_HDAR), mfspr(SPRN_HDSISR));
-	printf("hsrr0  = %.16lx hsrr1  = %.16lx hdec = %.8x\n",
+	printf("hsrr0  = %.16lx hsrr1  = %.16lx hdec = %.16lx\n",
 		mfspr(SPRN_HSRR0), mfspr(SPRN_HSRR1), mfspr(SPRN_HDEC));
 	printf("lpcr   = %.16lx  pcr   = %.16lx lpidr = %.8x\n",
 		mfspr(SPRN_LPCR), mfspr(SPRN_PCR), mfspr(SPRN_LPID));
-- 
2.9.4
