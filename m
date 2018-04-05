Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Gsr501nCzF1tF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 16:10:12 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id c21-v6so14122078plz.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 23:10:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64s/idle: POWER9 restore AMOR after deep sleep
Date: Thu,  5 Apr 2018 16:10:00 +1000
Message-Id: <20180405061000.30513-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER8 restores AMOR when waking from deep sleep, but POWER9 does not,
because it does not go through the subcore restore.

Have POWER9 restore it in core restore.

Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Do we need this guy after waking from deep sleep?

This code is a little messy at the moment, it can be a bit tricky to
see exactly what we've restored. I'm doing a bit of work to tidy it
up and make it clearer, but that's not going to make 4.17 or backports.

 arch/powerpc/kernel/idle_book3s.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index bc4e391d031e..e72e385a4973 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -857,6 +857,8 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_PTCR,r4
 	ld	r4,_RPR(r1)
 	mtspr	SPRN_RPR,r4
+	ld	r4,_AMOR(r1)
+	mtspr	SPRN_AMOR,r4
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 
 	ld	r4,_TSCR(r1)
-- 
2.16.3
