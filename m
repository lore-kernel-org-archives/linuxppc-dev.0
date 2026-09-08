Return-Path: <linuxppc-dev+bounces-26720-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38497C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:49:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfCgy37qxz2yqT;
	Tue, 08 Sep 2026 15:49:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788846590;
	cv=none; b=KV5QJG7WPVxK9aTqgQ9FpWdLsmA12rpyO8AysPRs3Yz3nf++cbdGY1p5Ut9Al2kIBOSs9zdxMIBMWxAy0d78hO9Nv330B+Oyn9r/kg+4UD+Yvi7YJ1wdXvZeXuyJFviSMATGA9GxTmPe2e52YcSOS8gPwAkXI2aRA7DiDFMyZz09HJSS5/GoPzqtjhHJwTHC+9fFDyZTTy7nv0emEI2zmiUEwhV5reJLeeRYvN/CkDccc1d9iZfZUnvap19b5asoyk+M6qdOt0dlJfv7Y5XPNAPGecsXMG0xLGeB7jdrZcIhTV84GBHlTMXitRZhCACbxVNF+bIsaDkoP+0HNV7TSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788846590; c=relaxed/relaxed;
	bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYGU2hQouVQgY5ivjCNpfor3KA8mtwP71jSO9RHSJDRvTR0JDxiQrIXd7WYSnSz01frlWYkkZzqbH/suaPTPf4bxVlKE8rMQEw65McyBSHCw/RRYuQDUocyHU+0ASrciT7d0Lxkne48GxxXIPhu1MgKo2VZsbH2XXy5gyAVbOQp1ELm6QnBvOc+9pwi8cBcBQaTkN9kN5bqFbAEErakCyvu2Ug2/gzLjNsqGXTLiSZM5k8R0gOwUGsRaYO4x+y5r7LM+0sxZC6NO53f7Ngs5Ug7hZY9Qmn88jO27D6Gcl2lJ60BZHIGFgLuudEfQV/mgtmvwlsZQVUY+Dv0GnAgMew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VGqeuaPE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VGqeuaPE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfCgx5TMXz2yqL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 15:49:49 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cc439aa0078so3419690a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846587; x=1789451387; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
        b=VGqeuaPEW6g8bbj7k/X3r+y2a2BZbfbmaM6yoMabQ0ocMaB4aQaoXg/5QtPVnuwKNU
         F6AFFzXn12ynyxnA1MhneAtF5BPIiIEpSnn3fnPfbltabH05orDsLDF1BfHkhnpQHMPN
         K9dyUroynvk95c0ZacCrg/9Rlh9NgPafwNTwRE7bnFEhK1c8XY1jtQ5Y5IllBXqnla+0
         EsTIXiulCGkOSN5ZU2Ux0RnFNQje/pNQnIH9MzCb1A7O4s2SZzyiUPmWid+dxrX6yPKG
         Vl8b3yOzqHsYvhP2Pe+VjuRebVDhViwMI087jHogYwjAO6leSz4iKaSTuPG7iS/w2jNM
         aJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846587; x=1789451387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
        b=BVgHgtZzw3Ii4DGkpfWW6ky6dLPzk+Qq7Uz0JNEK/3y+uqQNbxaA0f7K4msWaYR2KG
         gMhsXdZ/hRn/4vybXx2iQcvbtY/pKaxT10G4OJc3F95z2nX47kvry+DqVbjiUdL0/fHC
         lHmTGDGBI+jfsy1EDlE0lCNFscPrDC5vSZxuJ6Aq4k1GEuDWRnuV/gqeBbpthUj3dhza
         qJ61KeIe5zMZ/eywJVnuIAZFMacEtNY68txWcVhF1Z34SySEuW3PgsQiIQKNRM/JI8Bi
         YSGffxQa9OCrpjKDX47EB6zq+JPg+RMCrVFpaQxWiV2MRnFFITwihRCTyfLTqmPQwbQG
         fllA==
X-Forwarded-Encrypted: i=1; AKwUvByVNkG4wNvF5o/Zd0cwdVVtGeZSjVC2jOisfHmn+FSvmEwz4L0DJ9/CWllPFA100kitNPcJvFOWP1XmJpc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k6ZqBwgnl53Hp7KBWZv0hnhu5cXO6sAW1lAHM5RyUnhe0uG2c6
	HH2hXeCTbahSkmWo4BxaBX0Etr2OSifoeV+ObLzNtiElZqOYAEmaroup
X-Gm-Gg: AYBFou3UDXH/W6LzpUFPJMTwtuN8+Y95/BOCuH8qdBin8djo0IkZeAsQbzcNq48EIyI
	kKq9YOA/cIiCAZEndmXJKb8LhaiHt1DqZhJO3aRvm0yu0jNXmf96rTKk+3BCyVbm75mMwt+2AWr
	2bxEoQNH1y7RAifSmbhkgH5Emkb4QL7Dmw7oZHPnYJ4JZgPugemAErBy3xd9RtVXfVBt3rI0V+q
	ZNTsTiVSknXmf3ECJGdiit0CYT6G+W5+8/JU0+t9HSGc0iSVJvTstB8KlI5JzVwlmrIgi2ttzXq
	cq5rG0Ol7/XgHePJg0fp2rkzzP2yPA+dVye2kepnkAWGEHxJ5Oa6O5XO+FYeplyA8gxh3HCTliE
	f6xTZSugV6H5K3+7earMhNcxcyXD8dQKroTTPQe3He1Y4mIfMvn17W9eZPyW7iHssugBDFTY/dQ
	vUI+MT4LJIlX3izKsBp+qBjzMBeZwz4wf2hqPU9hDm+jTa4/fzzfPJ2kZlaLUq8/1KmaFem7OtL
	A3OF/eYwLZXvg==
X-Received: by 2002:a05:6a21:9204:b0:3d1:60d3:99f8 with SMTP id adf61e73a8af0-3da39b7183emr44883342637.5.1788846587447;
        Mon, 07 Sep 2026 22:49:47 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:47 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH bpf-next v4 5/7] sparc: net: fix typo "evalute" in comment
Date: Tue,  8 Sep 2026 11:18:51 +0530
Message-ID: <20260908054853.13820-6-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908054853.13820-1-hemanth.selam@gmail.com>
References: <20260908054853.13820-1-hemanth.selam@gmail.com>
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
Content-Transfer-Encoding: 8bit

Correct "evalute" to "evaluate", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/sparc/net/bpf_jit_asm_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/net/bpf_jit_asm_32.S b/arch/sparc/net/bpf_jit_asm_32.S
index a2e28e0464a3..81430f065ac9 100644
--- a/arch/sparc/net/bpf_jit_asm_32.S
+++ b/arch/sparc/net/bpf_jit_asm_32.S
@@ -195,7 +195,7 @@ bpf_error:
 	/* Make the JIT program return zero.  The JIT epilogue
 	 * stores away the original %o7 into r_saved_O7.  The
 	 * normal leaf function return is to use "retl" which
-	 * would evalute to "jmpl %o7 + 8, %g0" but we want to
+	 * would evaluate to "jmpl %o7 + 8, %g0" but we want to
 	 * use the saved value thus the sequence you see here.
 	 */
 	jmpl	r_saved_O7 + 8, %g0
-- 
2.48.1


