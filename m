Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36702C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 06:15:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F399214DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 06:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F399214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44130X6147zDqZR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 17:15:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4412yl4yD3zDqZG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 17:14:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4412yl36xSz9s5c; Fri, 15 Feb 2019 17:14:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4412yl2ZpXz9s7T; Fri, 15 Feb 2019 17:14:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning
Date: Fri, 15 Feb 2019 17:14:00 +1100
Message-Id: <20190215061400.20302-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: malat@debian.org, mroos@linux.ee
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

GCC 8 warns about the logic in vr_get/set(), which with -Werror breaks
the build:

  In function ‘user_regset_copyin’,
      inlined from ‘vr_set’ at arch/powerpc/kernel/ptrace.c:628:9:
  include/linux/regset.h:295:4: error: ‘memcpy’ offset [-527, -529] is
  out of the bounds [0, 16] of object ‘vrsave’ with type ‘union
  <anonymous>’ [-Werror=array-bounds]
  arch/powerpc/kernel/ptrace.c: In function ‘vr_set’:
  arch/powerpc/kernel/ptrace.c:623:5: note: ‘vrsave’ declared here
     } vrsave;

This has been identified as a regression in GCC, see GCC bug 88273.

However we can avoid the warning and also simplify the logic and make
it more robust.

Currently we pass -1 as end_pos to user_regset_copyout(). This says
"copy up to the end of the regset".

The definition of the regset is:
	[REGSET_VMX] = {
		.core_note_type = NT_PPC_VMX, .n = 34,
		.size = sizeof(vector128), .align = sizeof(vector128),
		.active = vr_active, .get = vr_get, .set = vr_set
	},

The end is calculated as (n * size), ie. 34 * sizeof(vector128).

In vr_get/set() we pass start_pos as 33 * sizeof(vector128), meaning
we can copy up to sizeof(vector128) into/out-of vrsave.

The on-stack vrsave is defined as:
  union {
	  elf_vrreg_t reg;
	  u32 word;
  } vrsave;

And elf_vrreg_t is:
  typedef __vector128 elf_vrreg_t;

So there is no bug, but we rely on all those sizes lining up,
otherwise we would have a kernel stack exposure/overwrite on our
hands.

Rather than relying on that we can pass an explict end_pos based on
the sizeof(vrsave). The result should be exactly the same but it's
more obviously not over-reading/writing the stack and it avoids the
compiler warning.

Reported-by: Meelis Roos <mroos@linux.ee>
Reported-by: Mathieu Malaterre <malat@debian.org>
Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ptrace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 7535f89e08cd..d9ac7d94656e 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -567,6 +567,7 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
 		/*
 		 * Copy out only the low-order word of vrsave.
 		 */
+		int start, end;
 		union {
 			elf_vrreg_t reg;
 			u32 word;
@@ -575,8 +576,10 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
 
 		vrsave.word = target->thread.vrsave;
 
+		start = 33 * sizeof(vector128);
+		end = start + sizeof(vrsave);
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
-					  33 * sizeof(vector128), -1);
+					  start, end);
 	}
 
 	return ret;
@@ -614,6 +617,7 @@ static int vr_set(struct task_struct *target, const struct user_regset *regset,
 		/*
 		 * We use only the first word of vrsave.
 		 */
+		int start, end;
 		union {
 			elf_vrreg_t reg;
 			u32 word;
@@ -622,8 +626,10 @@ static int vr_set(struct task_struct *target, const struct user_regset *regset,
 
 		vrsave.word = target->thread.vrsave;
 
+		start = 33 * sizeof(vector128);
+		end = start + sizeof(vrsave);
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &vrsave,
-					 33 * sizeof(vector128), -1);
+					 start, end);
 		if (!ret)
 			target->thread.vrsave = vrsave.word;
 	}
-- 
2.20.1

