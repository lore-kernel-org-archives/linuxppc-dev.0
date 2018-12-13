Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80762C67839
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 07:36:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0577520873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 07:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0577520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Flqg0ryNzDqVx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 18:36:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FlnG57TBzDqSd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 18:34:42 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43FlnB0sWjz9v0cY;
 Thu, 13 Dec 2018 08:34:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dTDX-_0vTrpm; Thu, 13 Dec 2018 08:34:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43FlnB0Cz4z9v0cX;
 Thu, 13 Dec 2018 08:34:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DF45E8B85F;
 Thu, 13 Dec 2018 08:34:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id wzwVVr6mT-K3; Thu, 13 Dec 2018 08:34:38 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E9488B754;
 Thu, 13 Dec 2018 08:34:38 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id C9D78716EC; Thu, 13 Dec 2018 07:34:37 +0000 (UTC)
Message-Id: <7f27d91e7e78d8aac28e8b6c600fd874b7d5be9f.1544686398.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Date: Thu, 13 Dec 2018 07:34:37 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[    2.364486] WARNING: CPU: 0 PID: 60 at ./arch/powerpc/include/asm/io.h:837 dma_nommu_map_page+0x44/0xd4
[    2.373579] CPU: 0 PID: 60 Comm: cryptomgr_test Tainted: G        W         4.20.0-rc5-00560-g6bfb52e23a00-dirty #531
[    2.384740] NIP:  c000c540 LR: c000c584 CTR: 00000000
[    2.389743] REGS: c95abab0 TRAP: 0700   Tainted: G        W          (4.20.0-rc5-00560-g6bfb52e23a00-dirty)
[    2.400042] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24042204  XER: 00000000
[    2.406669]
[    2.406669] GPR00: c02f2244 c95abb60 c6262990 c95abd80 0000256a 00000001 00000001 00000001
[    2.406669] GPR08: 00000000 00002000 00000010 00000010 24042202 00000000 00000100 c95abd88
[    2.406669] GPR16: 00000000 c05569d4 00000001 00000010 c95abc88 c0615664 00000004 00000000
[    2.406669] GPR24: 00000010 c95abc88 c95abc88 00000000 c61ae210 c7ff6d40 c61ae210 00003d68
[    2.441559] NIP [c000c540] dma_nommu_map_page+0x44/0xd4
[    2.446720] LR [c000c584] dma_nommu_map_page+0x88/0xd4
[    2.451762] Call Trace:
[    2.454195] [c95abb60] [82000808] 0x82000808 (unreliable)
[    2.459572] [c95abb80] [c02f2244] talitos_edesc_alloc+0xbc/0x3c8
[    2.465493] [c95abbb0] [c02f2600] ablkcipher_edesc_alloc+0x4c/0x5c
[    2.471606] [c95abbd0] [c02f4ed0] ablkcipher_encrypt+0x20/0x64
[    2.477389] [c95abbe0] [c02023b0] __test_skcipher+0x4bc/0xa08
[    2.483049] [c95abe00] [c0204b60] test_skcipher+0x2c/0xcc
[    2.488385] [c95abe20] [c0204c48] alg_test_skcipher+0x48/0xbc
[    2.494064] [c95abe40] [c0205cec] alg_test+0x164/0x2e8
[    2.499142] [c95abf00] [c0200dec] cryptomgr_test+0x48/0x50
[    2.504558] [c95abf10] [c0039ff4] kthread+0xe4/0x110
[    2.509471] [c95abf40] [c000e1d0] ret_from_kernel_thread+0x14/0x1c
[    2.515532] Instruction dump:
[    2.518468] 7c7e1b78 7c9d2378 7cbf2b78 41820054 3d20c076 8089c200 3d20c076 7c84e850
[    2.526127] 8129c204 7c842e70 7f844840 419c0008 <0fe00000> 2f9e0000 54847022 7c84fa14
[    2.533960] ---[ end trace bf78d94af73fe3b8 ]---
[    2.539123] talitos ff020000.crypto: master data transfer error
[    2.544775] talitos ff020000.crypto: TEA error: ISR 0x20000000_00000040
[    2.551625] alg: skcipher: encryption failed on test 1 for ecb-aes-talitos: ret=22

IV cannot be on stack when CONFIG_VMAP_STACK is selected because the stack
cannot be DMA mapped anymore.

This patch copies the IV from areq->info into the request context.

Fixes: 4de9d0b547b9 ("crypto: talitos - Add ablkcipher algorithms")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Using per-request context.

 drivers/crypto/talitos.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 6988012deca4..df289758755c 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1664,12 +1664,16 @@ static int common_nonsnoop(struct talitos_edesc *edesc,
 static struct talitos_edesc *ablkcipher_edesc_alloc(struct ablkcipher_request *
 						    areq, bool encrypt)
 {
+	void *req_ctx = ablkcipher_request_ctx(areq);
 	struct crypto_ablkcipher *cipher = crypto_ablkcipher_reqtfm(areq);
 	struct talitos_ctx *ctx = crypto_ablkcipher_ctx(cipher);
 	unsigned int ivsize = crypto_ablkcipher_ivsize(cipher);
 
+	if (ivsize)
+		memcpy(req_ctx, areq->info, ivsize);
+
 	return talitos_edesc_alloc(ctx->dev, areq->src, areq->dst,
-				   areq->info, 0, areq->nbytes, 0, ivsize, 0,
+				   req_ctx, 0, areq->nbytes, 0, ivsize, 0,
 				   areq->base.flags, encrypt);
 }
 
@@ -3066,6 +3070,13 @@ static int talitos_cra_init_ahash(struct crypto_tfm *tfm)
 	return 0;
 }
 
+static int talitos_cra_init_ablkcipher(struct crypto_tfm *tfm)
+{
+	tfm->crt_ablkcipher.reqsize = TALITOS_MAX_IV_LENGTH;
+
+	return talitos_cra_init(tfm);
+}
+
 static void talitos_cra_exit(struct crypto_tfm *tfm)
 {
 	struct talitos_ctx *ctx = crypto_tfm_ctx(tfm);
@@ -3149,7 +3160,7 @@ static struct talitos_crypto_alg *talitos_alg_alloc(struct device *dev,
 	switch (t_alg->algt.type) {
 	case CRYPTO_ALG_TYPE_ABLKCIPHER:
 		alg = &t_alg->algt.alg.crypto;
-		alg->cra_init = talitos_cra_init;
+		alg->cra_init = talitos_cra_init_ablkcipher;
 		alg->cra_exit = talitos_cra_exit;
 		alg->cra_type = &crypto_ablkcipher_type;
 		alg->cra_ablkcipher.setkey = ablkcipher_setkey;
-- 
2.13.3

