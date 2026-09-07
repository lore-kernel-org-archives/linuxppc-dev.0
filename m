Return-Path: <linuxppc-dev+bounces-26669-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC20FC79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:01:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdlzV1ZFLz2ywS;
	Mon, 07 Sep 2026 22:01:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788782502;
	cv=none; b=JJ8k6wP4lsc1dqBEUR6wMxqERUYB2TmjMxhjbo2DFDb0ZN/sQBs8uZZI4sRuOgIiMhyn4DlKM+ufRC2004czeLHz+WSKNTi/MHOQFs9Ws4Rk27+G/0DiD4qW6wlPB7889OY6FKMHsvPi/qh/wmMObEGWJoGgrMIILUMsEotHmvj8RQGIQeqESZznYoFk+NgASa003jB6/OcNPUcBBXHHhmESWw1CAgdsLyvbbJ4ixIAvnTK6MosMGUfgC5ifYEYnFjf84qB0yCoFAAgKlMwph7cPVLAYWZtIovhjHF766NNQqGUAoryKgF0iFNRWZYuHmG/U6zKAcXMePXj7Nvwb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788782502; c=relaxed/relaxed;
	bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBimUwZ5smE6sE9caGMLPN2sTTjOGUOgMqiyDlquQF4ucHrW8Kg3m2atxhN+wxhioWEl13LTcbtJcWdMGyCZQJ7gYt5Ct0iFFWqUOC/FOfWXC/mMsUbvjleOKHVtP6WgROHqI75EbUB224FBrZViwVvElI/eQ2yIcPSwZVFi/LKXn5Qtn5rpN6VqEj5d1W2IVMEKO5LtJhdTGBD7mM/KVeknfPSYmv1QHstNrZkJJ0+FlW0Ct6uPPzt12GbkUAd1oe8FnQUB+ubJLjhm71OkiemAFvNT9x9eclCLCL3CvrFD+cS+hvKtsOaKkgRlJ0bOFTWVw2zJOqSWHx+FydfaJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q0zSXxf9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q0zSXxf9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdlzT2rBKz2ywR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:01:41 +1000 (AEST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-6b8366e4755so1629248eaf.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782499; x=1789387299; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
        b=Q0zSXxf9TbBj2u1yAodVCYIJFrrIkvldEuS+EPI89Qa+YQEfNO77DmsK6Drt6F59Zs
         cytJ+gjCpegvfD0K+VXL6ilYZv1piGmEAl+b5YHDkf7daKjmBy+vkPM00kQLSoYQbU3V
         8wRLOfjrGVuFe3rTXD/sKtLtF3GTnB5RxT2Q6SZWgrXq1/0onomsv2i8CdWvE53eMGzH
         pAu9oQa0khp6wm+hkwr3ynZodBE61p4b4pk6kBk6f5Rc/a4WdyAd6wT0qC/Q6WJk2o2j
         9yTOHGHuspC5uXBnzvtnnEFIz50xQZsDdGp9gEtPi9r6FVIkDK1RTrn2BqM91AoibTDL
         ePkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782499; x=1789387299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
        b=NrlFf4nfAPf+3LQTQUW0i6tg7fBaH99k1PoiYTuw39YNdMikCccZzO+xVl+IgrzHyl
         V4mWnb8+0be7PObR37Mk3PnD6Ey1/SMDHCjrUKjG9tnWIRoAIn+vzWX0v5lcW5l5fPSG
         5uYYigYvhbWIsYadzNB20O4Y/XNXHyDlzaVuh2wFTBlDE34i8BwWAl8rl/5VSTmCB3sM
         RVQtclACG+U+hiEMly1LvQDLZ240AoC7llOVyYbcC/k1TJwU6vHswGwmgcpUASpftcuQ
         oGtbhoSc6GNdwjycH+LK8p7a3rq4oO7fQD0BuvbwU3neqzYL8M39lPfknM6I7FItCYnq
         bczA==
X-Forwarded-Encrypted: i=1; AKwUvBytLLeNyhMdb6pGisycOoy2Gucj/WBQCbo/ZLoQxxSLe8Lac6XMYLaOqu8V/sgrIRkabm3hxMBR8BWkv2g=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n96+uueMBgbOOiHJRyrxeOs1dV3csEcFKOpTTAh192DOc0FBTl
	KN1x9bo8igPpH7Nlv3lAB6UAfzisimH0wcUreRLTSMYykhjTDrn+6D3S
X-Gm-Gg: AYBFou0uSawUCrwxJ+bhoNXZfJpe8fwdKbtUeaenXXLgloMIVrYfVUtuXe08uJi0fBe
	WEvzo6UgQVrUA59biRc4cvGlbQCXH7mtugxgbE3E6RuThWR0pUw2ThrjTj3LS9g54kGUQpicJ5S
	orYJLL0dFyCi3TuCPxbafGMFuQBRHe7wETH696NPa2VioBZ15JuTIV6klZf90tgswR72aVMXiIy
	2ypHVr/nNTcKSJnax6/xye1Y29S+6W5SXgAAcKyXwfWXBMUc8aqtuCq0ROtAkp5D7z6Fe6uQPBw
	QcAQfWyjOk9tx/a9uJeif5f5ojX7042U7C4Z1UXmOe73/PMkto0ocfqBWZNiVO9taqnZiNUKDMN
	FwsH51S2/j7scXrBqpAVDGwZaOPqtNViJjNSkOPwrsF9Ay2namJYaH5DxIDlsunte2VwhkXFzGP
	SQ0lp3CfmrCllKV1+q+nRzKlxe8zrje843DZkch7lPfDdzjqrDdsIi8aRoHd0I8NDyyr9p31Zso
	m9nriGB1Im6mA==
X-Received: by 2002:a05:6820:c91:b0:6b1:535a:eb8 with SMTP id 006d021491bc7-6b6fa8e02aamr12552198eaf.2.1788782498996;
        Mon, 07 Sep 2026 05:01:38 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/7] sparc: net: fix typo "evalute" in comment
Date: Mon,  7 Sep 2026 17:30:41 +0530
Message-ID: <20260907120043.36894-6-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907120043.36894-1-hemanth.selam@gmail.com>
References: <20260907120043.36894-1-hemanth.selam@gmail.com>
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


