Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WJXx1r2YzF24d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 21:55:13 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id f189so5905402pfa.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 04:55:13 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 04/11] KVM: PPC: fix incorrect element_size for stxsiwx in
 analyse_instr
Date: Wed, 25 Apr 2018 19:54:37 +0800
Message-Id: <1524657284-16706-5-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

stwsiwx will place contents of word element 1 of VSR into word
storage of EA. So the element size of stwsiwx should be 4.

This patch correct the size from 8 to 4.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/lib/sstep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 34d68f1..151d484 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -2178,7 +2178,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		case 140:	/* stxsiwx */
 			op->reg = rd | ((instr & 1) << 5);
 			op->type = MKOP(STORE_VSX, 0, 4);
-			op->element_size = 8;
+			op->element_size = 4;
 			break;
 
 		case 268:	/* lxvx */
-- 
1.8.3.1
