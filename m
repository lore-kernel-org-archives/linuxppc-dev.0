Return-Path: <SRS0=ugyh=4N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85E4C35E04
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 18:46:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E2C2084E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 18:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpqRPQiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E2C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Rnvw1zc8zDqG1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 05:46:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kpqRPQiN; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RmSF3qV8zDqN8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2020 04:41:01 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id r77so3833632pgr.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2020 09:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HLXz3WhEAb/lJbjyK0HMiOjtM7V5fMmFjUQlNHv4uYg=;
 b=kpqRPQiN4R2NAd5xPS7HK9dHRVPV6OuIF5Xonzqd+Nlg66p6gueWqZ46qm3Xy7xHtp
 Zt2tYCzfhlx49aZVCn7v9DpUup748WgRH5CgIwJxHbHshK2eQceVPhvGqkiNXPVS1JSn
 eAfgeK2akUUG9y1zujbefT+TwSXeBWNoudQLNnQl2e7IRCUyYBcqP0hjoHAQXyy3kvK2
 TJFmHEACgaS1da4w6iGVL1GmaVXIOaLto+PenwDOemVEiXr2BysSDAIR0Jx+AGaU3l9+
 NCy2bIRll6J24eGJg9Ky1VWvBo4gQQvzKJ447BbcRVWl74x+njBRmP8p21hpvwnfh3NN
 iLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HLXz3WhEAb/lJbjyK0HMiOjtM7V5fMmFjUQlNHv4uYg=;
 b=sKWrB+pZyOvHkA5oZ7kyJin6iC4ZnlWkoN1YhvMQn9/mb1MI7uvNZcwT3Ts1vxerew
 KRtzf0ampUrK6QkFm8NIZzM9WDpfc70ZMyRwFigyDKm+6bU3+KEwOMQ8zlWl7AS5+rNG
 PUgGt2MG/YslEJGvenjpAEOLlaTUQUKwdREt1t9gsrDoxXlU+6G5ZcYA6ZmVKjq22hqj
 +eN1bQh5pD4NWj7UNgWJOZSHbYBweKpn94REEsdoNJug6HSpYD6sLnfFZxQ42R9w4NRh
 hOCtzhnTgGuPFfcNtiGR6bMRTuwsYeFQtnWYhKXPtTsQ89OvB7nY6IRL+v7yz3qxSa2i
 Dlnw==
X-Gm-Message-State: APjAAAV8laI8G6YlcsY9Ec4LyGlJigPIMwtuLnF0CBYFzn3hB3iJPPNj
 0ToHhKNftKvRXV3EvBwlr9WHqF8s
X-Google-Smtp-Source: APXvYqzvCRUpSM4ECV1mKGAVHjzxksBJwKhetdoTb2yqHxPTHeI1JN2J0WDz+tzrzRQpytcjNiqGiw==
X-Received: by 2002:aa7:99c6:: with SMTP id v6mr34560267pfi.187.1582652452467; 
 Tue, 25 Feb 2020 09:40:52 -0800 (PST)
Received: from bobo.ibm.com ([61.68.187.74])
 by smtp.gmail.com with ESMTPSA id z63sm14791480pgd.12.2020.02.25.09.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 09:40:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 24/32] powerpc/64: sstep ifdef the deprecated fast endian
 switch syscall
Date: Wed, 26 Feb 2020 03:35:33 +1000
Message-Id: <20200225173541.1549955-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200225173541.1549955-1-npiggin@gmail.com>
References: <20200225173541.1549955-1-npiggin@gmail.com>
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
Cc: Michal Suchanek <msuchanek@suse.de>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/lib/sstep.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index c077acb983a1..5f3a7bd9d90d 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -3179,8 +3179,9 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 		 * entry code works.  If that is changed, this will
 		 * need to be changed also.
 		 */
-		if (regs->gpr[0] == 0x1ebe &&
-		    cpu_has_feature(CPU_FTR_REAL_LE)) {
+		if (IS_ENABLED(CONFIG_PPC_FAST_ENDIAN_SWITCH) &&
+				cpu_has_feature(CPU_FTR_REAL_LE) &&
+				regs->gpr[0] == 0x1ebe) {
 			regs->msr ^= MSR_LE;
 			goto instr_done;
 		}
-- 
2.23.0

