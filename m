Return-Path: <linuxppc-dev+bounces-25810-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F11C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 08:17:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLJB13gPdz2yNj;
	Thu, 13 Aug 2026 18:17:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786609033;
	cv=none; b=CDVYFrBQNKHV7L8sPH4KJfMAgD5ic4kjI6VDsfP3iGIDW+raQ+9d0iZ8sS/AsR2PnlwaU5aG+QIxoPlYQy9d+br1gn7DOgiSyhdhqK1U7/BfLzjltmXr9422t7YqQ+VzkJsOSDC48baVVlbnJJSY6glSddOA6aKI8hipSIKibAatJNlcujBrpAAApszyqhZfq3Ltu3glB6Za1Zh6qfJ8PyvqiYCDFOuTw1T3hxdU2awLl5pCh4Hd8UW0wBz0vc0h26qURQXFSuOfuZzqNb72UKZ/zF8LbiSMOTVfGfO1MvCOi4stPRi8sF0iOQ/5kA3XZuE663b1dPzSZ21KGcKswg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786609033; c=relaxed/relaxed;
	bh=OBCEUWqwGxw/pU1xAkmBvx00nyMvNlJlQThBjZtx7/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1oISrGjP3yN6GiK0IB/pYA/17T0WPlNzFczX9nrq84+FVNeNy0k3i9F+XtsMfp7qN4nIdJNoXOKd8LsVNL9EWvcC4N9t8SSmXqPjxSx2tjlXgJEkIVgtir3tfADYJDXF/WRDqBgdXym2GL1dM7TF6aIm++aDlkqDGj44zdcP6pWTjxAdeXImunOx8tPQcfSzJ649J8EGijbrJLKxZIO5fC6SaL2NPCvEptg5Drr5ha7hS34rhaSKRhSC1rcMdej1lW6nVtp7968i8XNAQQvpJYyvls9HSihQ/QlLn0XvHrWQdCmuVFkMPb9TYf4pKzfsTnyqr5UwpcN0JIvlT6jXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOsXmEDQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOsXmEDQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLJB03FJwz2yfp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 18:17:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 60B23600AD;
	Thu, 13 Aug 2026 08:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0569E1F000E9;
	Thu, 13 Aug 2026 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786609029;
	bh=OBCEUWqwGxw/pU1xAkmBvx00nyMvNlJlQThBjZtx7/c=;
	h=From:To:Cc:Subject:Date;
	b=hOsXmEDQeXsxkBgDCazffc87Oi+RAGpdxNPkxAbJ5J88njdP3zLs0G+ohSUCHH1ak
	 iZtVevb7a0+NRAHk84V8KFdRZoqHdULNIqbYJCpi5gY1piDmJCxja8m3VEgXCz843q
	 BTZnonzeR4OJ5DNVfrkdt47hwSl0pmqicrU12FQyxdCBx0NP/0XLgoAWd7Gtf9Zl6v
	 PbfcCA9M4Fct9UMqDmEsmZNG92iWfYIwhmO924j4hei4TzVmJzdiBzCiahbWSBCl2C
	 oYVKurEUIUseJJmUk/TikLA40YDwHN/7MHVfEqAuJ/IlelETC1J43GDzkwQMh8WUpT
	 /i9vroy3bfRgQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc: Silence sparse warnings caused by type casting in (cmp)xchg
Date: Thu, 13 Aug 2026 10:16:46 +0200
Message-ID: <289a7ffac9cb5b6d26a57fdc26605bf725285302.1786608980.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2850; i=chleroy@kernel.org; h=from:subject:message-id; bh=4mvMrpIZAkAXcVPWdMLSSPRhuOvefDeo4UeeoCigqWM=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTV1hZeDi8Q1L/ufP95imiNYN2l9Q98bzzm3av03tO18 VaR/LPAjlIWBjEuBlkxRZbj/7l3zej6kpo/dZc+zBxWJpAhDFycAjCRM1sYGW6dWnDg2kfH9yZR XodCF+bwpnt9VT6uMV1ij8Cx+jRJphyG//5edavr1Wd84vS12h5yrudDkp/k40tOHX9CbJyjNp0 I5AcA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Powerpc arch_cmpxchg() wrapper macros cast arguments to
'unsigned long' before calling the functions implementing the
operation. Some type annotations (e.g. __bitwise) generate
sparse warnings like:

  block/blk-crypto-fallback.c:164:17: warning: cast from restricted blk_status_t
  block/blk-crypto-fallback.c:164:17: warning: cast to restricted blk_status_t

Force casting in the macros to avoid the warnings:

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606012339.rZAl6Xq8-lkp@intel.com/
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/include/asm/cmpxchg.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index dbb50c06f0bf..7264e33ef877 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -700,8 +700,9 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
      __typeof__(*(ptr)) _n_ = (n);					 \
-     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
-				    (unsigned long)_n_, sizeof(*(ptr))); \
+     (__force __typeof__(*(ptr)))					 \
+	__cmpxchg((ptr), (__force unsigned long)_o_,			 \
+		  (__force unsigned long)_n_, sizeof(*(ptr)));		 \
   })
 
 
@@ -709,26 +710,27 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
      __typeof__(*(ptr)) _n_ = (n);					 \
-     (__typeof__(*(ptr))) __cmpxchg_local((ptr), (unsigned long)_o_,	 \
-				    (unsigned long)_n_, sizeof(*(ptr))); \
+     (__force __typeof__(*(ptr)))					 \
+	__cmpxchg_local((ptr), (__force unsigned long)_o_,		 \
+			(__force unsigned long)_n_, sizeof(*(ptr)));	 \
   })
 
 #define arch_cmpxchg_relaxed(ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),			\
-			(unsigned long)_o_, (unsigned long)_n_,		\
-			sizeof(*(ptr)));				\
+	(__force __typeof__(*(ptr)))					\
+	  __cmpxchg_relaxed((ptr), (__force unsigned long)_o_,		\
+			    (__force unsigned long)_n_, sizeof(*(ptr)));\
 })
 
 #define arch_cmpxchg_acquire(ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_acquire((ptr),			\
-			(unsigned long)_o_, (unsigned long)_n_,		\
-			sizeof(*(ptr)));				\
+	(__force __typeof__(*(ptr)))					\
+	  __cmpxchg_acquire((ptr), (__force unsigned long)_o_,		\
+			    (__force unsigned long)_n_, sizeof(*(ptr)));\
 })
 #ifdef CONFIG_PPC64
 #define arch_cmpxchg64(ptr, o, n)					\
-- 
2.54.0


