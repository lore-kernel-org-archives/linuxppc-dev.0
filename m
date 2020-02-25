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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC43C35E04
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 17:49:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D488A2082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 17:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3jQlYvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D488A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Rmdx6GbNzDqLN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 04:49:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e;
 helo=mail-pf1-x42e.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=b3jQlYvn; dkim-atps=neutral
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RmR019nSzDqN3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2020 04:39:56 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id s1so7553274pfh.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2020 09:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9zblclroSNaQ8iAYHiv9YE4d0hDAja3tdnbYU47UA7o=;
 b=b3jQlYvnbwbHvhyIdwxuRj88RCbcwKy2lcUIpvKlk5CoSUuYAiOFZHDl34TUfE10t3
 KxefqzNdIHIEMhf1worqdbNyYyPiqVbQT0sE6qsio0iutGev34AmQQ9BRfja7VyNVGq+
 23VVjtAvRe1vdvISQsQ59+2F4U2c/oP5Q3AXipW9WUGpCnZSO/RGWfs8Nh/ZYEKLx7ph
 GvY30H22CeF78JmF2kakJh5+7kwMo5xAa7QXoIrXV4KkTrm4sfHZVbQDpsqZZk2W5ogu
 NTJDTn6GDAtlaIUyydZoXKOltiuKixFUJEkQOnBs7tRdt1WN9ScJDBCDjJzxhZgNHPsG
 wNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9zblclroSNaQ8iAYHiv9YE4d0hDAja3tdnbYU47UA7o=;
 b=hBj23r5klGMzvGmU6Ey20YC7h3YKnHi3L8oQaXIE+70gRt87f/8jmtHn+/M3RuAoaJ
 uRMAQeAX13mJzc5VWd46kwDUbxf0hOOh01z4WcawmltEiPy0KtyB7NcyPORJbJSDU6+9
 0L9X1/hTJ3TxIL7tvJbguMx1dK9H1zXyFdvW4uZhsCP2/aR1r64axobWXOS+tohGQOF3
 ENNVh1kOiQXslIq78GvOW6NSY8GqqIHVZlHXPwpnL2bD1mYJT5vPEox3wvfmEDDwp/Hm
 fT7E8f/rm4t3dnFyMGj7eVO2etCNDMNgOIQgNROn/nSBy2dywqzl6U0r23glOvdmUt2j
 15MA==
X-Gm-Message-State: APjAAAX3X4yke8toa9QjDR5UUSxckZdW26PCBQz2koA794y9qLRvllkz
 1HC2G5u/Nw0mpXNtGt4qo48LSDmo
X-Google-Smtp-Source: APXvYqxB6gK2l90uiauKV2IL5Cj4HKL3AWcsKHyMD7udc+Z98I49hLGOhMJ1JekJqW5+FH6VsKFsmQ==
X-Received: by 2002:a63:f447:: with SMTP id p7mr34456644pgk.326.1582652393340; 
 Tue, 25 Feb 2020 09:39:53 -0800 (PST)
Received: from bobo.ibm.com ([61.68.187.74])
 by smtp.gmail.com with ESMTPSA id z63sm14791480pgd.12.2020.02.25.09.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 09:39:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 03/32] powerpc/64s/exception: Add GEN_KVM macro that uses
 INT_DEFINE parameters
Date: Wed, 26 Feb 2020 03:35:12 +1000
Message-Id: <20200225173541.1549955-4-npiggin@gmail.com>
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

No generated code change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f3f2ec88b3d8..da3c22eea72d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -204,6 +204,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define ISET_RI		.L_ISET_RI_\name\()
 #define IEARLY		.L_IEARLY_\name\()
 #define IMASK		.L_IMASK_\name\()
+#define IKVM_SKIP	.L_IKVM_SKIP_\name\()
 #define IKVM_REAL	.L_IKVM_REAL_\name\()
 #define IKVM_VIRT	.L_IKVM_VIRT_\name\()
 #define ISTACK		.L_ISTACK_\name\()
@@ -243,6 +244,9 @@ do_define_int n
 	.ifndef IMASK
 		IMASK=0
 	.endif
+	.ifndef IKVM_SKIP
+		IKVM_SKIP=0
+	.endif
 	.ifndef IKVM_REAL
 		IKVM_REAL=0
 	.endif
@@ -265,6 +269,10 @@ do_define_int n
 	KVM_HANDLER \vec, \hsrr, \area, \skip
 .endm
 
+.macro GEN_KVM name
+	KVM_HANDLER IVEC, IHSRR, IAREA, IKVM_SKIP
+.endm
+
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 /*
@@ -1226,6 +1234,7 @@ INT_DEFINE_BEGIN(data_access)
 	IVEC=0x300
 	IDAR=1
 	IDSISR=1
+	IKVM_SKIP=1
 	IKVM_REAL=1
 INT_DEFINE_END(data_access)
 
@@ -1235,7 +1244,8 @@ EXC_REAL_END(data_access, 0x300, 0x80)
 EXC_VIRT_BEGIN(data_access, 0x4300, 0x80)
 	GEN_INT_ENTRY data_access, virt=1
 EXC_VIRT_END(data_access, 0x4300, 0x80)
-INT_KVM_HANDLER data_access, 0x300, EXC_STD, PACA_EXGEN, 1
+TRAMP_KVM_BEGIN(data_access_kvm)
+	GEN_KVM data_access
 EXC_COMMON_BEGIN(data_access_common)
 	GEN_COMMON data_access
 	ld	r4,_DAR(r1)
-- 
2.23.0

