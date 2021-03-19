Return-Path: <SRS0=qtcn=IR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA241C433E9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 11:07:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F118964F53
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 11:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F118964F53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F21MD3TvMz3c80
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 22:07:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F21LW4PYxz304R
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2021 22:06:56 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F21LN3qsZz9tx8w;
 Fri, 19 Mar 2021 12:06:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Dq8PeRF8qLwU; Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F21LN2vnRz9tx8s;
 Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 099188B976;
 Fri, 19 Mar 2021 12:06:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id rRIrLIL4Vubt; Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D5D78B975;
 Fri, 19 Mar 2021 12:06:52 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id B0CA1675FB; Fri, 19 Mar 2021 11:06:51 +0000 (UTC)
Message-Id: <308e65d9237a14e8c0e3b22919fcf0b5e5592608.1616151715.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616151715.git.christophe.leroy@csgroup.eu>
References: <cover.1616151715.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 02/10] powerpc/uaccess: Also perform 64 bits copies in
 unsafe_copy_from_user() on ppc32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 cmr@codefail.de
Date: Fri, 19 Mar 2021 11:06:51 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Similarly to commit 5cf773fc8f37 ("powerpc/uaccess: Also perform
64 bits copies in unsafe_copy_to_user() on ppc32")

ppc32 has an efficiant 64 bits unsafe_get_user(), so also use it in
order to unroll loops more.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 77d837b16e4d..a4e791bcd3fe 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -432,9 +432,9 @@ do {											\
 	size_t _len = (l);								\
 	int _i;										\
 											\
-	for (_i = 0; _i < (_len & ~(sizeof(long) - 1)); _i += sizeof(long))		\
-		unsafe_get_user(*(long *)(_dst + _i), (long __user *)(_src + _i), e);	\
-	if (IS_ENABLED(CONFIG_PPC64) && (_len & 4)) {					\
+	for (_i = 0; _i < (_len & ~(sizeof(u64) - 1)); _i += sizeof(u64))		\
+		unsafe_get_user(*(u64 *)(_dst + _i), (u64 __user *)(_src + _i), e);	\
+	if (_len & 4) {									\
 		unsafe_get_user(*(u32 *)(_dst + _i), (u32 __user *)(_src + _i), e);	\
 		_i += 4;								\
 	}										\
-- 
2.25.0

