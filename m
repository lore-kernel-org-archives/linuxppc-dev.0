Return-Path: <linuxppc-dev+bounces-26640-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82E7C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 04:52:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdZS831nJz2ywn;
	Mon, 07 Sep 2026 14:52:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788756744;
	cv=none; b=TB0OQte5xE9MCBv/Gpn0PNxvPuJs0C/Waq57hRxIT2rr3WeUkw/+cv8pdbQe1X8QphGC5ISjqv5aDvlr8OBIgE62CNOfLAXK5TAR044I0/cA8EyQgrVpzZDWx8/UBd+jRJZVWqxlxmYJ/18oBqgdRma0cHFlvffyAkInvt5imCnsCGo4AKksvYgNwfEr+RVZNUQ/P0UjhZkfr2Q66sjPCj+UqC/sr3x3HE+oRT3teunLkwvdtFEfu6sSiIsmwSjIvkeBBoVIF5T6bMGdM0gnw/SONlJqu4Z2xQ2sq16suul08Urhv4EiJS4m/9P5dAcPWFDThNeRjgf15lx1LZj+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788756744; c=relaxed/relaxed;
	bh=dj5/gWxeDk47uSELqCVU9KzfoSY5+X/l8m45uFaTtlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIAzuz6/mwJ2fFSAwkSo+PUYbMMiakWLDyPKoBSZmED+ZIyXjJpdfDftdvmd0Zz09lNXv0z2SyxOHhcKLGCvr89nLQJJJ+GrtixtMtgk/y62UGsiyqrXEYgcVUWwy45xuGVc6C/ogVugoqreuw69rKHQ9acDGaxsHQ+N0HdsNFeknYyfO9jdcxnKxhHvJtv7FgOjBa7/WppBrJgU4k9BL2XxnHOKPi0RDLY4ZVyuLuHp8Sr1rdPT6loMhB7SVSQSN88C1QqTMSU8I8yE3q2Jt+CR55abjVj8nbzJ4X0rYK2hnb79KbDQgNW+dm1MgBFmcmPDrz7DD32zg78fCtrtDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BzdLX/qB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BzdLX/qB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdZS63JqRz2ywh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 14:52:22 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-39b35105ba4so2618618a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756740; x=1789361540; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dj5/gWxeDk47uSELqCVU9KzfoSY5+X/l8m45uFaTtlw=;
        b=BzdLX/qBjfK2/gxOAdr8GGl2gZmeE+5t5Tj0HRga3E9UnLkWtu/H9BPLI+d7yX4Cza
         a6IYPpxDT0M/o+N+Rfvn88LtkKvkd/H0/ppj77FwKcfgL51H8GvfbVG4sTSVecDYTbHc
         Lo9HsXovD6m1mXyzEBrRnoNGTWcClxkWPnDfSu1mY3PJ0VeET1XMx7/i0j9J0KtqL5zG
         ywYFqfilKyCdJ92aGWBfqRRUVlTTiv6u68blti42TotKhAyGIJp3vTNhGUr5fVXUAd/o
         oasDh8aLcrkObzhA+aYMes1Y0H+WcWGIDHKHL2KaxPMN0ZvmuKTrl4jH9KLKgabvPBtL
         CaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756740; x=1789361540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dj5/gWxeDk47uSELqCVU9KzfoSY5+X/l8m45uFaTtlw=;
        b=Xs8raWNjxUgg4Wdcw7NZOJZKB7NjNBCMWJD3DWUvWcszDS7b7FLyogiG32QlmGRPiM
         6DXGp/xMe5sTMvSyCOQNjYI3hMW+X1TxC9ZcGGj0xAnphYAoZDjIbcmFvRpbUVVrje8h
         QZH8/7H/uvXSbI9hDvrmEFJrRTkeTt0xLnmZGSxDWJCx2KkR45p3Lzt05ufccDH9Itxw
         gbMHltztWdKsLjGLkKgu/n5w3XMat5dZ4EcAgCIqqG1q2+eU71MXtJT+zau6yMfUPGsu
         gXLCIlnc1ciA+WujSkPr3DzpvzYUj1GB/k5OEEvqenxVj3ywmDSuJiy9xp3KUsBfCLva
         RmiQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5AnvoQNJB2ruuC+19sWxOGPXbxYgJXJ6BQqoE1QFqARtT61tt5P03sY5Q2RPB/aDm9DukyzMJiYcw2pQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k8MFhOgrwlczP/HmGdGPWJlUSSkqQanBhQLl1l9/M3hLg6vyP1
	8etRGg92BXmHOovZx/gnIuF8Y/cccuGeErMmvCg+zfWH82Lts78O/D/V
X-Gm-Gg: AYBFou2dJBizXx3HliKbRlUqCV+pJ6OneU02R5lphiqfGEP11mCAGP/Bwkllgtvg4Tj
	S8YXYOJjnnT6V4iL4MTwCyhM6dulf9ZG7KCJAd8K2iMG8j8zte1mPuMyybvKaUxbKKKtnR/Cqep
	XNgxCSBTHlXOzPvwTl2B+OpQtdChpUwV39L57rja90ttkWTnavKPjTz54Dcic2nqFOXwntTY6EF
	EeqeUDvZnZjGO+28W//GEAc9ARQMkZVKGttjGxWADYDCMu76iBiHMAUQ/GBuhDxCaPVeuiv2f4K
	gVM/2pu/fncgoSgVluT1jmkt/YlWNq3KN5YaWsZYg7u5GqhhTKs8+I69RaiWFrCbBfM/tdU8ZRO
	T0BmAmQ1Mpej+wVlRaIE09Dpaf4q1O2s7nBctuFp+zcF0QTacqGTJYEA4K0Pv/2M9XGzT/IPZ3M
	OC0ydfK/5/kw4xCPx8RSxRabwbhuLUYigAndqCcCHsm52/6blaBGxi4R7mA0VpwKDLPczHyr464
	XvWFc3gQepNYg==
X-Received: by 2002:a17:90b:1b44:b0:398:ba96:1afd with SMTP id 98e67ed59e1d1-39b2613249fmr28234165a91.8.1788756740085;
        Sun, 06 Sep 2026 21:52:20 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:52:19 -0700 (PDT)
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
Subject: [PATCH v2 4/7] selftests/bpf: fix typos in comments
Date: Mon,  7 Sep 2026 10:21:32 +0530
Message-ID: <20260907045135.13317-5-hemanth.selam@gmail.com>
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

The subject prefix changed since v1, from "selftests: bpf:" to
"selftests/bpf:", to match the rest of the history in this directory.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h     | 2 +-
 tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c | 2 +-
 tools/testing/selftests/bpf/progs/verifier_var_off.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c b/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
index 1b25d5c5f8fb..8b96fb861368 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
@@ -13,7 +13,7 @@
  * IPv6 header with a Segment Routing Header, with segments :
  *	fd00::1 -> fd00::2 -> fd00::3 -> fd00::4
  *
- * 3 fd00::/16 IPv6 addresses are binded to seg6local End.BPF actions :
+ * 3 fd00::/16 IPv6 addresses are bound to seg6local End.BPF actions :
  * - fd00::1 : add a TLV, change the flags and apply a End.X action to fc42::1
  * - fd00::2 : remove the TLV, change the flags, add a tag
  * - fd00::3 : apply an End.T action to fd00::4, through routing table 117
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 8ae4fb2027f7..9f2971fc7cd5 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -243,7 +243,7 @@ static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
 		}
 
 		/*
-		 * TLD_DEFINE_KEY() is given memory upto a page while at most
+		 * TLD_DEFINE_KEY() is given memory up to a page while at most
 		 * TLD_DYN_DATA_SIZE is allocated for tld_create_key()
 		 */
 		if (dyn_data) {
diff --git a/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c b/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
index 624078abf3de..d7e30ee576c9 100644
--- a/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
+++ b/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
@@ -7,7 +7,7 @@
 
 SEC("freplace/btf_unreliable_kprobe")
 /* context type is what BPF verifier expects for kprobe context, but target
- * program has `stuct whatever *ctx` argument, so freplace operation will be
+ * program has `struct whatever *ctx` argument, so freplace operation will be
  * rejected with the following message:
  *
  * arg0 replace_btf_unreliable_kprobe(struct pt_regs *) doesn't match btf_unreliable_kprobe(struct whatever *)
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index a63e33675091..227dea0da3a0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -225,7 +225,7 @@ __naked void stack_write_priv_vs_unpriv(void)
 }
 
 /* Similar to the previous test, but this time also perform a read from the
- * address written to with a variable offet. The read is allowed, showing that,
+ * address written to with a variable offset. The read is allowed, showing that,
  * after a variable-offset write, a privileged program can read the slots that
  * were in the range of that write (even if the verifier doesn't actually know if
  * the slot being read was really written to or not.

