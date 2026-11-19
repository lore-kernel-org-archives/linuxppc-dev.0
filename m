Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFBE60A260D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k9Nra8wp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPNt3NbZz2yGT;
	Thu, 19 Nov 2026 14:39:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059598;
	cv=none; b=U0t6wfA4kbnZcuL+8RTgCFTL/6WPX1SE0g7J/blGifRu8Hm4n44aG15a9EkTqiRGSE/fi7rpCL3Wb2Eq6dzDDWybBbs3vNLMhpSOWXkumZXF8T9Veef95Yv8YIUvT8HAmG2D0wUKXblB2qgXVh9wpH8pUjRPteMNcQqaD0PaoJVBfz1UhotLGv3rplHc2lrlYgrFiHodUmgWfk0sy8qGSzCnSK291954I/JhVDZvRsf0UKEWpMw0q15MOsi5duPdWCOhGvq/o+yNR3fh+ldLCRcBa8nMePBzp+8Z0KyJF5KH2sLR+AgQFVOnMEVg1NLQeBRoWHcsGyrZf7T3nbuggA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059598; c=relaxed/relaxed;
	bh=ewTGQvK3tt2260QtNRrZ7p3X1lbZ3jh2OEzTu9yhDdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THoM8R+Chp5tx99lgp7QyMXJMGoR5t3LLZ7pFSuBoPaE5jccJHbk6UAu0xJTjtfzqA78gdxh1DweKPy4y711vwVqB3dvEqyDVkr0s/Wj65QpsVjThIo6eIRyyNTD9T13LuggMgibEajxW8jBDHtWuURPVSrziZzKQpN3rHjNMZDDc+c9bSHVbZXwaWOz0E3f4sgquwreIvwuSYn3G8tTQVbhkBUSvapqSi29S+7Ap2x/y4Jw5vWRBlfEDqARYxV2BvYV60h8c7YLPcj4eWncSCWt6rR9C3e4d0rQmkMfDcnWdgl4ndFjTfP5m+ftnrVglPGxkHrgc4U8TYmITbpO/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k9Nra8wp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k9Nra8wp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPNs4JYNz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:39:57 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-382f4710a17so2333841eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059595; x=1795664395; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ewTGQvK3tt2260QtNRrZ7p3X1lbZ3jh2OEzTu9yhDdE=;
        b=k9Nra8wpIEBYOFglSQ9zBWQLa00rHKGFD6LQ1MBg4NHG//PGd5FWA3ySbZC/Im7Vew
         GYT242TKT6p92iP/FfiShB+hGm37PxFNhH43OpPGfaGmG7Nzw0yf17MNII0n1BQcHPKv
         CpuDuk2KY6pvoFx1A05YcL8MSAGKo3bmK8ILENeGa/DhxVZNB4oxirbKxtvZWJwsaWDI
         /dYySd0NdP/aC3K9OG/YDuTYp02omJ59R7TLg93GLG5HPuXcqUqRdYFjkuo/9S0N2/eV
         YTRa6lOOVXsZi5txDMeH/4tIxQV1lFVbrtzry3J6RY5RuppxfgJiQ2U0d+AvloOumalM
         0XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059595; x=1795664395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ewTGQvK3tt2260QtNRrZ7p3X1lbZ3jh2OEzTu9yhDdE=;
        b=OLkjgCk4B6/4pHeyX63/ZbR3gBZhCprvLRD3rNXu8qsLIrFmSP5UKTypJzRWmtBvEQ
         tO3jSkGuXFvrEPrvTZCgQmngilVBdKwBAPt8o0Ru+AYYQ8DAaX3ZXBCdbrufAOAb0lmL
         9kWP1mC6BQBV0DjUIbukLRr6HESQN0f0s6FIgQh+sALjI5s4UgfP/NNv39sHEXhorJfm
         DvN1BTN5u8KQ/Q4NxMPSKbRfFXqqOaSj5A8fabojECYaKVNa4ghZRMRQIsIXe899EDYN
         SrwhuvQwBPL7jd/+3fcmhb8JVQ+2thaQBel7ywjXpL1w0qOV7LdUGjTQaWETzWI3QAGC
         bhHQ==
X-Gm-Message-State: APuU4Z8megBWFobns5R0m5wt46eWHKWKrvtEKFwiH7+ikkVqg6Jf+auJ
	Y8+RCrIvV0db2B3qazNrZIsCTzPAlvoO5WTlxAHJ15+0QVhzp9KOYshpvnGlyw==
X-Gm-Gg: AZFdTZdyWvqmMa53CMknpaDzbJFSOcfvMM62jGg8nhxC+IzcRKiJwtFxbBI8cCX+rJ4
	syy0QlkTpaXO2sLZuqWWTdyhK8fgkkV3r8LJmULEeRvQzSRrbWnz67IFLWThvPw0kDZtEhFYrO7
	YCpWuEj4k2PZcD2076+H1RS7Qr2gV18rnvYXQszg7ENPgtv7Z7RcqN7MuD8Md4wiLH/d/sHm1pg
	mZK7imnVlQ20iMj4LMC5y1Vu60wg+H5qdcWJKFIPonN+jdVhMtduht/l3Mfvc2ukXG2JuxsqJ65
	RdCmc/NBWeOlS4y+dRbrN9cOamHxnNQ96OJb91kyxHpJ28E7aKG25X74dqrGU73SCDuV33fGbWY
	dw/RlBYZyW0U3OehhvBnPQzE9OOIN6/Ryu4bVWP1NLzdLfBI0TC6spcaXIGI1l0FzhCv51K06PQ
	64FDlQxzi0KxTrZJNrnrWIFB8pCNca3XYJO30zoMzBGLcKANebLbTrgBXsdsieno6zST45AMc2A
	pXtbipbVMSiC9PV5O01cO/uY5S01MN4ZHsrhDQwJD4TT/WggaBoxmakUjePFjJHEgAhhxzyITWy
	m9g7Y2Ehr11RDqES9F17M3/nr0K4DT84Od0xa0HX+zoOlpLRFI5gAIc=
X-Received: by 2002:a05:7301:140c:b0:382:105f:e7e with SMTP id 5a478bee46e88-38281bf902fmr4198470eec.36.1795059595470;
        Wed, 18 Nov 2026 19:39:55 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:39:54 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 07/18] powerpc/pseries: Drop inline from hugepage invalidate
Date: Thu, 19 Nov 2026 09:09:02 +0530
Message-Id: <02c8ed0701924869f3caec29d9a5b049285bcc91.1795058683.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795058683.git.ritesh.list@gmail.com>
References: <cover.1795058683.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Leave __pSeries_lpar_hugepage_invalidate() static and let the
compiler decide whether to inline it.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 6a415febc53b..94cd30e9f6e1 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1225,7 +1225,7 @@ static void hugepage_bulk_invalidate(unsigned long *slot, unsigned long *vpn,
 	}
 }
 
-static inline void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
+static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 						      unsigned long *vpn,
 						      int count, int psize,
 						      int ssize)
-- 
2.39.5


