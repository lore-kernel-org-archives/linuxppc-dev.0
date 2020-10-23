Return-Path: <SRS0=t5Sp=D6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1E5C4363A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2020 02:11:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD1020747
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2020 02:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="iXMjHkWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD1020747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CHSPt6RpqzDr43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2020 13:10:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CHSMG0nhszDr0p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2020 13:08:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=iXMjHkWA; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4CHSMF2LHzz9sTc; Fri, 23 Oct 2020 13:08:41 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CHSMD6KCJz9sTK; Fri, 23 Oct 2020 13:08:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1603418920;
 bh=Ng0fZOsQFBeLrflbA41ibay3UPia7+nt0IbLJd90iTg=;
 h=From:To:Subject:Date:From;
 b=iXMjHkWAEPG3UZQeTnkHquLbwkbhjWy8d8xdD3s5arMSZ/0v2aXb5xlyWjbBWVSd1
 O9buSG+oDQ9PTRAoqo/Dj+w+RsmqPMNWrRASXp/3TCPYNlSiyZzpKfZbAHaiPbAoxb
 L3O4QcjJmu2AnAdwsL6BVZ4qLwIenWz2Dl4CJp4BtVriuoMaFd8e6kfuqc30F55Kfj
 gRyevkBV6q1LiU3QkXXMghThQjTXRPw0QQi0ep0Q4VsSdU0LrEClhAideS7GhYIZEv
 yJdCG43PgPfHR7OyUvIsQlAQttmt6SFVrYzRprXUrPBw8mfzrRiA3h2L3pvz9Hen5a
 kUSZGhMuqHuNw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Fix declaration made after definition
Date: Fri, 23 Oct 2020 13:08:38 +1100
Message-Id: <20201023020838.3274226-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently the clang build of corenet64_smp_defconfig fails with:

  arch/powerpc/platforms/85xx/corenet_generic.c:210:1: error:
  attribute declaration must precede definition
  machine_arch_initcall(corenet_generic, corenet_gen_publish_devices);

Fix it by moving the initcall definition prior to the machine
definition, and directly below the function it calls, which is the
usual style anyway.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 6aa8defb5857..8d6029099848 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -106,6 +106,7 @@ int __init corenet_gen_publish_devices(void)
 {
 	return of_platform_bus_probe(NULL, of_device_ids, NULL);
 }
+machine_arch_initcall(corenet_generic, corenet_gen_publish_devices);
 
 static const char * const boards[] __initconst = {
 	"fsl,P2041RDB",
@@ -206,5 +207,3 @@ define_machine(corenet_generic) {
 	.power_save		= e500_idle,
 #endif
 };
-
-machine_arch_initcall(corenet_generic, corenet_gen_publish_devices);
-- 
2.25.1

