Return-Path: <SRS0=ASHh=5B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3313AC0044D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2020 15:43:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40F220663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2020 15:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="r4hF69xB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40F220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48h0vR4vCQzDqRj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2020 02:43:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48gwwr1SQczDqJg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2020 23:44:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=r4hF69xB; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48gwwn4rywz9sTL; Mon, 16 Mar 2020 23:44:25 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48gwwm5wNfz9sTM; Mon, 16 Mar 2020 23:44:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1584362664;
 bh=uK/Bpx/pGZKhUfLZM1qxP88ejTBgdz2aOq7L7q+QwUw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r4hF69xBF6MdsYo5a63dodGM5Wk3OXpa65A+Ecc0bhNqSKaEZjlNE2RBILfyE0FAg
 0KxgbVYWxKAWey9SqsgaZevsZLfhnr05710s95yDc5aVY+3j1S1eMS8F/zM1pyDcYt
 IziL2jcPwlRg3QiAYa0Z36KKUS/cwnn9SrNj2iRJU8iI+xrbf7yFCw4VbLvWaM7W7r
 N7rQRaNrSzvsOFynXcX8t1Bj6u3c66OgP0MasUYoFhTaNJr2MqN2MB2hMIXQRiX3NB
 wROv4DmDmA6V+HCLfDxwJ81JIchazr1A1LCnXT5LHEZXUf0PQK0nDewqAJjYc1SD4h
 XxZu85ArvJJQg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v5 2/2] powerpc/64: Prevent stack protection in early boot
Date: Mon, 16 Mar 2020 23:44:21 +1100
Message-Id: <20200316124421.99211-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316124421.99211-1-mpe@ellerman.id.au>
References: <20200316124421.99211-1-mpe@ellerman.id.au>
MIME-Version: 1.0
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
Cc: npiggin@gmail.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The previous commit reduced the amount of code that is run before we
setup a paca. However there are still a few remaining functions that
run with no paca, or worse, with an arbitrary value in r13 that will
be used as a paca pointer.

In particular the stack protector canary is stored in the paca, so if
stack protector is activated for any of these functions we will read
the stack canary from wherever r13 points. If r13 happens to point
outside of memory we will get a machine check / checkstop.

For example if we modify initialise_paca() to trigger stack
protection, and then boot in the mambo simulator with r13 poisoned in
skiboot before calling the kernel:

  DEBUG: 19952232: (19952232): INSTRUCTION: PC=0xC0000000191FC1E8: [0x3C4C006D]: addis   r2,r12,0x6D [fetch]
  DEBUG: 19952236: (19952236): INSTRUCTION: PC=0xC00000001807EAD8: [0x7D8802A6]: mflr    r12 [fetch]
  FATAL ERROR: 19952276: (19952276): Check Stop for 0:0: Machine Check with ME bit of MSR off
  DEBUG: 19952276: (19952276): INSTRUCTION: PC=0xC0000000191FCA7C: [0xE90D0CF8]: ld      r8,0xCF8(r13) [Instruction Failed]
  INFO: 19952276: (19952277): ** Execution stopped: Mambo Error, Machine Check Stop,  **
  systemsim % bt
  pc:                             0xC0000000191FCA7C      initialise_paca+0x54
  lr:                             0xC0000000191FC22C      early_setup+0x44
  stack:0x00000000198CBED0        0x0     +0x0
  stack:0x00000000198CBF00        0xC0000000191FC22C      early_setup+0x44
  stack:0x00000000198CBF90        0x1801C968      +0x1801C968

So annotate the relevant functions to ensure stack protection is never
enabled for them.

Fixes: 06ec27aea9fc ("powerpc/64: add stack protector support")
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/paca.c     | 4 ++--
 arch/powerpc/kernel/setup.h    | 2 ++
 arch/powerpc/kernel/setup_64.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

v5: New.

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 0ee6308541b1..3f91ccaa9c74 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -176,7 +176,7 @@ static struct slb_shadow * __init new_slb_shadow(int cpu, unsigned long limit)
 struct paca_struct **paca_ptrs __read_mostly;
 EXPORT_SYMBOL(paca_ptrs);
 
-void __init initialise_paca(struct paca_struct *new_paca, int cpu)
+void __init __nostackprotector initialise_paca(struct paca_struct *new_paca, int cpu)
 {
 #ifdef CONFIG_PPC_PSERIES
 	new_paca->lppaca_ptr = NULL;
@@ -205,7 +205,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 }
 
 /* Put the paca pointer into r13 and SPRG_PACA */
-void setup_paca(struct paca_struct *new_paca)
+void __nostackprotector setup_paca(struct paca_struct *new_paca)
 {
 	/* Setup r13 */
 	local_paca = new_paca;
diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index 2dd0d9cb5a20..d210671026e9 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -8,6 +8,8 @@
 #ifndef __ARCH_POWERPC_KERNEL_SETUP_H
 #define __ARCH_POWERPC_KERNEL_SETUP_H
 
+#define __nostackprotector __attribute__((__optimize__("no-stack-protector")))
+
 void initialize_cache_info(void);
 void irqstack_early_init(void);
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 17886d147dd0..438a9befce41 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -279,7 +279,7 @@ void __init record_spr_defaults(void)
  * device-tree is not accessible via normal means at this point.
  */
 
-void __init early_setup(unsigned long dt_ptr)
+void __init __nostackprotector early_setup(unsigned long dt_ptr)
 {
 	static __initdata struct paca_struct boot_paca;
 
-- 
2.24.1

