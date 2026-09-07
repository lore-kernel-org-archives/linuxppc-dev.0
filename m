Return-Path: <linuxppc-dev+bounces-26641-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1C6C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 04:52:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdZSH2SRKz2yx5;
	Mon, 07 Sep 2026 14:52:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788756751;
	cv=none; b=H+OLPv7+E7vk6gorg1uMxePvbaO4ZcIQb53PNCMo/ZSgRgXWxzpNr6B2/GqK8Gxhgi+BRWIKswmhQvOzf8ShsMDlGeb9RTT+/yMyK5urmB0PuT99HOISkCQ1i2bfz3g0Rl+vEkJC2YhnIiMHxG6YutTPGJzvkC518n4rvXamkpgmHzRhP2Fo3VnPyPscZy/u3v22UkVe1mAtKSgh8ZAHlr/WFkDPo2OXF4O/mo+VNV2hEKaR/DG6LDM33dL71RbfBRlumaeXWXTp55UG0y2Cndf4kRa+79GdO2MzrTGi2SsDGChMTn2m3AYjj6wpZYfcfl1+kDoQGy1o3PPWVEKUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788756751; c=relaxed/relaxed;
	bh=vm/cehq7ZbHazeTz6lyclFSjgW2pMvi5dQ4X+rlCVtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qv1SeQUQgY13X99SWAb091K9w2tKLO+C5wmcME8c8jLkQBQ6ddFrgcyzB4YWFYJxZ3024Eiy5xDxUS8PmuJDjrG9KMrNQkU5/9bli5eVPIdX1ETHHXcujsZdIKngHDB0tayR6YlZTVqE1d3u+bEa667jZ9LxIFkQfgnqbTyGWwsZBNft0cbvpkl4CjkeKnC/eKpxcxHo/iHAIm67dl/zoo3wkoqrA7Ip5vfW19M+4ce+Rev/9W7leuJVIb3OB9Y5Cp9QDXJh0avDVfpPR/PpaSnzpy5740ULtsUJmPJBNsM7pa73OQCvCb5MN3kFTOxsTBkbmf1F3q5RhNuMcbEc9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FBj3zGdx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FBj3zGdx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdZSG4gXkz2ywN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 14:52:30 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2d9db539a54so24155925ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 21:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756749; x=1789361549; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vm/cehq7ZbHazeTz6lyclFSjgW2pMvi5dQ4X+rlCVtE=;
        b=FBj3zGdxpfIfWLKW9VCXt2TawPV+puIi4vIUvs0yz8O6z+KYOUbErUvkDe6WNQkY36
         VbY4hgs2sdzkn8sHPWpdI79kHgKjHb+t0gk47xktEbckHnSxkzb5b1fIYTw39p846ADy
         XrCaAV/R5e1PqKOr1cBDYvYuKUC4OcfiMBxKaSuSfBveH53EyWAwigh+/GV30mRyopKa
         dIVRdL/N6hthXeFS5bKaZ0Q9/lm0cq7S8IdCFpKmRPUEHUG0tQk2WLOTnaKxRXxTN5vN
         QGTlex7Ry6nYXxKIBsJNRklOWFB6Wi73uC10mGaF74dPgvE7/fDVa5cuty4CMvsI6ZfX
         +Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756749; x=1789361549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vm/cehq7ZbHazeTz6lyclFSjgW2pMvi5dQ4X+rlCVtE=;
        b=Q044mlWkNPNoUy5Ds2dPnEiXKa4jErz7KdwlSGMenk2NlRlsrnhh+3LQ9lf06jfAXI
         EJDaNIUC0Pg2QOAa9LDGfauvg24cXUjR61R/1mJjT6q6g7Jyc6xO3V8r+oErqrxfceJt
         4f086LhhpaHBc+lqFARBcENt2lfvNDSMgzrncyfP77VHgvx6oi+oskI8hZB9RfGZBGXM
         Kj2vt6N+O9Ehjf/CDK142m4lxtppgEMMWy5BpC+Qa6s9PO8pJV1PLWRBQx9m+HNDiRsK
         JKZ5N7RLtKOnkVFiYKJJV5vfW1+bM+v1+D7W4JYWahYWgWi0TZQdD64nmPbKsIfs5QfG
         Gm9g==
X-Forwarded-Encrypted: i=1; AKwUvBx9lv+X/Ju3QGjgGVVKV1kTw8It9nP/FyIUCHjzgZPM+1in4GqKDkQktlKAj3JI5Bju7zkdMP2a2uKZLKU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kxF6mPGEf3D9J9C2yEmJYqvl9jbqV+AYSxc59+6Gld9geL/cvD
	Rds4LnxyY4ZRqdxSFZxWNfjc7TCCorSAMlT6eRxpVbPy3okAfVPCfrJZ
X-Gm-Gg: AYBFou2WmImQxoXmW1t1yL2r+gD60NGb+0pCEWTAj6iiiMc4KLzmQ58war9YJ/gxDLt
	IYkt5zfQWd8IB9TEML3Otjln1iXYZuySegw0NVa2wyWesqls6Hd1KqusHgJ0hsVCv7wN9V0K3p1
	SnLJ6r0H/butEFSIbsE3YRc3pS/HQw3W7bmqVZ4XIazoIbgllqaz9QOoXAzDSfFam182MWgm3HT
	jxaxrf57xml237wCFbdCNGTWrzdNJc5Lkr+YP3WlasExHgeMFpDQAVdLJ8UVih1cQWwwYC9+Z2f
	ZYm4ZH/eE9tjNQkFjU6jFR9IVp1CgzmPcJrCMwwEptjDZQpVlfdyb/kRqaUonIQBVCLQxpm8VeO
	8uFBYmsps+kbT73sdULH0nT4NfCvER9U73aiH9UX1mEjr1JPpHCQrN0yfFI4fgN0KbA2wZ+LY/w
	dI3tkKHELkCIgUjEULy+Jg/JW2DKUhMXmagYHXY+JcDZ5vXP2a/imX/z8tk/EFIu/98wdiXGb1S
	y9IPQI05ZJPiA==
X-Received: by 2002:a17:90b:4c4e:b0:399:1b64:e0d7 with SMTP id 98e67ed59e1d1-39b262aaf32mr32153720a91.19.1788756748582;
        Sun, 06 Sep 2026 21:52:28 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:52:28 -0700 (PDT)
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
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v2 5/7] sparc: net: fix typo "evalute" in comment
Date: Mon,  7 Sep 2026 10:21:33 +0530
Message-ID: <20260907045135.13317-6-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907045135.13317-1-hemanth.selam@gmail.com>
References: <20260907045135.13317-1-hemanth.selam@gmail.com>
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

