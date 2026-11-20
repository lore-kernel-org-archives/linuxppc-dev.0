Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2B6606A33C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TjwWCpwu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1ss18l0z30Tm;
	Fri, 20 Nov 2026 15:03:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147425;
	cv=none; b=JCMA7ZWVetbcay5RQZU7ZK5L9TE7bfpybGFFsaE9f+o55CouIBPg4C2i9wixrQLPj2WMZGu1JHpv6dpfradiH55RUhxWNSsvvV82u+FL5rtvoy5yh3qrl1SLGL3d9NCsJskumY3zHHJls8Uu6olPzZVRFJjrsZ0f1XZ45a/pAEgJtgfOK8bfzMz1KC4cqfIllz2PmsF9nUua1c5rLyStcNFLkxrpTpvgz5HpBK4exqEzV5LcC95eOozUgWM9mnCWCf4+7mkko8HqpP3OcXM1oJlGInptvL+PtQQqy1afLXi31BOZVw8mwq4hZBZ140ndr6QMs4lf+a7A+PYls5TPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147425; c=relaxed/relaxed;
	bh=F0IcenKlGXfs/ekHbNQmyvDTyrNd0+ZA/lq2CB7f/tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LR5KEabBqh801NfZrcl4cakzNKb1l4zN9r7s6LYuRZaV1nlad0StdKTxpT3rd8yO4LQxLxHHtBIhb/XC3YdipmtNShL0QsDBKRsE7CLhSKZ9i0cdcXwOBOVU1PwcXDYIppz3+znuq5qFoBR2U6mU4Jv8L8Yb7ewC3abOBivPWHp/FQ5ZDwC4+MNHNDPWb0PSaqYcac4Jd4oKetcxety32S4qxao2cjkCaKM9mR9yDv9K3pngdh4Pkv+1eeqH0DUCr4rNZom7Y60Xp7ElET5+Zx4WlKmPqgRV4kmJKcHknlfQhROD4NT1NizwiBEtixwAhVu3x0ahKcAwmJMWis1UXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TjwWCpwu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TjwWCpwu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1sr443gz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:03:44 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-38318d69173so953041eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147423; x=1795752223; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0IcenKlGXfs/ekHbNQmyvDTyrNd0+ZA/lq2CB7f/tA=;
        b=TjwWCpwuQT3xI/6IOJ3U281xNdITWt3PRDUMtNT6S0GoJGy862yRYFvvZCL/C+oiJn
         wVAfh4sOHXmT2OZsbEaUHU5OtrYEuYCoe+ISnTTbZX4PaN8/NojjKZVRQ8C74LEpuIeT
         SuaXEsi3cSdzdnJOvmtssxzcwon4fTdmbZD31xI69Yf/+9bMO1Fg5vxhiOAe11E6E46S
         bCR+YLvKNNuHqlvGCZ7AVVpRkFGMsVWG6nwf67MYQZPSpyyQwaQz/PHAyE7XuF/IRYXz
         Q5uZW/UyLzUZG8T0JHnVhuXlefk29wMA/+fHqnrSPLFz6lRrpRAQ65gVUl3FKrQOYDlo
         kBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147423; x=1795752223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0IcenKlGXfs/ekHbNQmyvDTyrNd0+ZA/lq2CB7f/tA=;
        b=m4nD6G4LxEzgF6smEYhBOS8EGI03nY8Kmy+dIUzsKRXGO+54TbCO53dM9xEJm7mKy+
         l8aU//6JjiB2GbXALurn2prpjvjrcyWsDJ14qN0do9CWIrHEM+V0Bgr3dZdx+4BBa9L4
         0vvx8q/PzMhW3G3ElnjP6Q3ZcXFh25B8+OYq3s8nD7GQHGSRklMRYHvR8JcOOxp8QsqI
         xr19WUTOuO3ooGc7b4uEGcgTijekDmkh0pUKZsT6aM0iqhc+wvi7T7b4iWhe+vQMNACA
         A/T3R49fYXOTPicLlwmVx9uLxoAUnQ87v2/hvYvIH2FDvRUzE+RfKA+L5Y+QRNBn+bjt
         43JQ==
X-Gm-Message-State: APuU4Z9um+xfB3gJz1rC6D1T9Tq0VoJbo9sELwDMTn8ev5fyDnDsepgx
	CpyiOe4lgw3sR/bvEZt0EVk3N3OORIzEvnLrFgXvGXTeyvckc6d991cjWvV9Tg==
X-Gm-Gg: AZFdTZer/1vH9wg1A3DA00ao4cLdTcFtgAs/T63GshpqfpNtAJJXeTlRqg9xWIguNfR
	p+Ekr9oZU6HCHS7LfdO7scxdH45GmbNRTmKY2PZU2YvwknKI/Q/7pms5Wi/Qnug1COTR7OWYDKl
	wDujlqP/z22e5vUXAaPf8bagqx510h8//ud5SQd8bmty9skwtU2s0jneMoEYEQUks/X3EAif8vB
	vDa+X3iOD6C+FOum+RwZ8R/1gdaEFsgkbDwaA20ccMWFkMhrSl/IwHbpKFNqJWmWt8M23w3jNuu
	ppU6qqMHfzLbAqOb5L6AfSIpRR5HA/C6MYea5EjUg4RwjZJNWx8eIIKpyyisf7IQAPZKiXSnvgx
	4iu4OJdPU5jfZSBf/yR0PmOWbLkubpue6YymG9WfX4SSwOABp65XC3w+LaZRxSTCTrTVNtcJe7Q
	k3HA67Q1y97OWMcY+C56EmBb6RWz0Ctu87fYVLiX6/4vFTBhLr+jCmoKJen9OqnkClRh6YwGs+z
	F6VjGkUfyA+/i5BA9dc1p8DLwWyWlH7JxAyXofT3SgpjKkyQFHSZRF5PvgxV8cR+4Z32DIct+rL
	1fp0hFI9QBXHKuKY3M+NRaGp7JBqTA8yxw==
X-Received: by 2002:a05:7300:108:b0:375:50d9:474e with SMTP id 5a478bee46e88-3856c0d0bb4mr1846178eec.4.1795147422638;
        Thu, 19 Nov 2026 20:03:42 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:03:41 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 03/19] powerpc/64s/hash: Reference all arguments in the 4K pte_iterate_hashed_subpages()
Date: Fri, 20 Nov 2026 09:33:02 +0530
Message-Id: <3557ef0c4ad63a904f57ca2108757c0cb72eb911.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795147055.git.ritesh.list@gmail.com>
References: <cover.1795147055.git.ritesh.list@gmail.com>
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

With 4K pages there is exactly one HPTE per PTE, so
pte_iterate_hashed_subpages() only sets index and shift and does not
look at rpte at all, whereas 64K version reads all three.

Reference all variables in pte_iterate_hashed_subpages() even for the
4K version, to avoid -Wunused-but-set-variable warning.

No functional change.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 8e5bd9902bed..179181870e71 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -89,10 +89,14 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
 	return pte_val(__rpte_to_pte(rpte)) >> H_PAGE_F_GIX_SHIFT;
 }
 
+/* references all variables to avoid -Wunused-but-set-variable warning */
 #define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
 	do {							         \
 		index = 0;					         \
 		shift = mmu_psize_defs[psize].shift;		         \
+		(void)(rpte);					         \
+		(void)(index);					         \
+		(void)(shift);					         \
 
 #define pte_iterate_hashed_end() } while(0)
 
-- 
2.39.5


