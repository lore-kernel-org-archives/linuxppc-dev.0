Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7360606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MqG2vvRH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV6F53NhPz2xSl;
	Thu, 19 Nov 2026 03:17:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795018633;
	cv=none; b=bxVw4bbi4Uh+VaKt7E49P5b0K5NTLULfRxs+t77wQbiU7zdk5JZekOS+JBiaHdN8Ri/ejLN1lN7SiK6RV2i6YMIRd18eKa/uoh93OjJGKXWx7b/gRub2G43ZPf0WgdU7jpebCYJlEWTe22AVarfbD6NGwJbB/nTl8M+bkz49GVgrqZEVO5GsxXp4ZEZDCl3u6hdStHmKck93jd5Mz8INaR0OZOT1ft4cuNS9oehnhpaYsSpYOXEKML7zMQ6GXdQSRX0AeWGuSvlxPbVXE3WGFIVOmj25UfMqQLePnuCIRrZSjNg6WDAPlPdAXRO6PAMAknWD9M14rHiGOfceh3/l1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795018633; c=relaxed/relaxed;
	bh=KH7bb4VaZEOEZgLtTJYQPM7/j5RYK5pPIJZczw0vLME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abx6M6sEmH1OGKHzysILIiqXznzPJseYxJlx7t4s0DG7loFdTVbE36TgqbXohbBxiev+6DTE8sNxzxSU++cWJxWhM/B/WltGJUIcQQ0i0FntdS2nLBd4GZsbNLphipMa4z674dSFq/hTvjXrkFYVY2CfnQi2mwW5/gJuRYHt/UhICeDJYEhf2CFdalbtjM/5UbnbfoIL3TqqZt1m1tBiq6DMDnkvlkDsULlYEY58oPPmQHNlVJQ/7sWMAnSObqzvyBIKaQtR8yOzqAKuoHnvKnJmKdinPtROKs9cOI7irW+nf0h5pbQrrhGc1nt4aADZd8pwH5q1X3124dhS22Z4Cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MqG2vvRH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MqG2vvRH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV6F41gsvz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 03:17:11 +1100 (AEDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-8b4d07494b0so27826737b3.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795018628; x=1795623428; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KH7bb4VaZEOEZgLtTJYQPM7/j5RYK5pPIJZczw0vLME=;
        b=MqG2vvRHy/e0IG2mzerWOme6xCL4dTF6ZgzHAPywjibhnN5cLsqzrpIFRTyLr6f7WY
         ceDCmDTfjUq8rataifS9CPozhblTw0bnXAWMdwz48rUC8EPoTpldWRGXWdoIjl6fqrvg
         bfKAExv5g6YkLjoRrYqnqIriKXY13Wk6ktW1O0kKUTiEiJvqfLeOKo5itBVPdIavdoyx
         EOA8Xene0lGVh7pVvrh8Y2gZkMCKEaw8wPjFGcHu4biwxCFmTpHLrh0bkjpT5rQjG73G
         ru7ywX3hExCLDL1x/rkERHZ4NIxYCNUE9qxt26MBuaOsrGkRaYJ/7cWlxpoKviFUbMJV
         t0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018628; x=1795623428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KH7bb4VaZEOEZgLtTJYQPM7/j5RYK5pPIJZczw0vLME=;
        b=ycNYYnR5XMFhwXVsFlCl+0EtkPU50Txf1j1Wbo9SRqSFBKPwAUrK1KgfmFvOPfMYcB
         Js4iBmjK3dfYRtlJL9LNG3gJNcJRG7D4Bl5esEDl1V2vNgm8NXN+dpsUjetJj9ouKCG7
         sypuksRz/clpYolOjNHmAhN5ZvJ1RiRhWWLHK9LWlZOcTwLLNoN/ksfeKvxwpsg2RgJJ
         PJ7uNOUi+TB/rPaLad5FF6l4tzzhHjiAFkoa4Kt6OU5DcWyU56vFyTANzESPzulH1rJ3
         SCbuuRcYvWffKHD7tKGFZeHzcVdOmMJgmc+D4xgmAng1K/9q90AcOSgkbAgJepnY0yzx
         c/fw==
X-Forwarded-Encrypted: i=1; AL+hErHsVJN3VVRFrhSKevNpCNv/InWmWCei7N7E8ZmTIFqB6Eu/r17hm6rvMI+JgV5QhEK7ZFHKGyIE/dQNu+k=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/9W5ujPPMK4FwWcVEL6A+Nq9yOQAli91skl01axJRZRrycX/2B
	nGKSnlafELRrYNgZwDpQfINw6sJL+gfm2x6yVpPp/WwJ0fH6Um/TivyS
X-Gm-Gg: AZFdTZfrmlxLNlT5Rx0RKKDYkOJsivCpB77YHQM5k6YXF8g5gTwkgVox9mk4xDNWXOL
	00ViqNoaVQjCVga68JTzOtfcY/88oZz+JwXB2LkDFMns3MuGVq1TuYoM6P50Iye/Bd8qbZlTmEt
	H6UEMv35KiTh22CfBImts89/9qljyxMaJfH37g27Pl7cqIIlsQWsFLCFTNa6JexXpiRvL350yxl
	41kF899FDpnNyqiqePR5J2PazasSRTk5bAVj3vcT7Tc3Eq9iQKIF3fC3cgbcUJe6/MDUqasaiHU
	/Hh+Tvvjr3jg5H/nn8j79e4msjHZiIyiVQRXaJzZJUBCmTDc1sMIXHtq96E8u7iqfB8w89ZISGH
	81keBe7W9k4qraPw1XpcqnlFdLnSSMhrywEOgFJ65cbWN2uzJJNanfldAAPzd5hs085mQ1OaFbD
	37Qcq5GVzk+VGIUlpQTcSAyQ1L3AgQq08v8vEAnkc55bl9maCNIaUWoDxm72TLsILGWgfrRW6Pm
	MzEMm7+lLJhOwjRWiMClEm1XhzmNf+Qm2tUu3K5NUz9/CKsWIHLaxkCG4nc0g08C7DAqe9C2qIq
	7SaHMMpkDfHLlGh5bo/zrT9D/nW7W8oSkNtpNtVKMPHwAyzEh77+mFGOMzjVgcTIHFtX3HwHzh0
	WMy3q/GwVm0LBtFfashrSjRmJIguWg6Bhujc+2I19pMrwh4LZSCLsOV/jV95o/BIuEYN7xI4Qhd
	Ee58w2VRQGiPO6MSMBGQ==
X-Received: by 2002:a05:690e:810:20b0:67d:bcce:d615 with SMTP id 956f58d0204a3-67dc786a8dfmr2191044d50.10.1795018628172;
        Wed, 18 Nov 2026 08:17:08 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dd58cad32sm1901629d50.22.2026.11.18.08.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:17:07 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Paul Mackerras <paulus@ozlabs.org>
Cc: Tanushree Shah <tshah@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] powerpc/perf: Use SIAR for kernel sample addresses on 32-bit
Date: Wed, 18 Nov 2026 11:17:06 -0500
Message-ID: <20261118161706.2454031-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117-ppc32-perf-v2-7-2072e9b90009@gmail.com>
References: <20261117-ppc32-perf-v2-7-2072e9b90009@gmail.com>
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

On 32-bit, perf_read_regs() sets regs->result to 0, so regs_use_siar()
is always false and every sample is attributed to the interrupted PC.

The MPC7450 family's SIAR holds the address of the last instruction to
complete before the performance monitor exception is generated
(MPC7450UM Rev. 5, section 11.3.7). The exception can be generated
with MSR[EE] = 0 and is taken once EE is set again (section 11.2), so
when interrupts are disabled the interrupted PC is wherever they are
re-enabled, while SIAR still points into the disabled region.

On a 7448, sampling cycles system-wide with --intr-regs=nip during dd,
perf bench sched pipe and find, 46% of the kernel samples have SIAR and
the interrupted PC in different functions. 13270 samples have their PC
on the instruction after the mtmsr that restores interrupts in
ata_scsi_queuecmd(), and 11661 of those have SIAR in udelay().

With interrupts enabled SIAR helps less. Sampling a 32-instruction
loop with one store and one branch with -c 10007, 99.8% of the samples
land at:

  event             interrupted PC   SIAR
  r122 (branches)   br + 13          br + 9
  r014 (stores)     stw + 21         stw + 17

Because the exception is held off, it can also be taken on the other
side of a user/kernel transition from the instruction in SIAR, e.g.
just after the rfi at the end of a system call. Recording a loop that
alternates user work with getppid() with perf record -g -c 1000000,
3022 of 16953 samples had SIAR in a different mode from the
interrupted PC. The callchain is walked from regs, so taking its first
entry from SIAR there starts a user callchain with a kernel address.

SIAR also holds a real address while translation is off, and a real
address looks like a user address. The hash_page() fast path on
CONFIG_PPC_BOOK3S_604 runs with translation off and EE clear and
returns straight to user space, so an exception generated there is
taken at a user PC with SIAR holding a kernel real address. Reading
one word from each of 2048 pages after an mprotect() round trip has
flushed their hash PTEs, with -c 10007, 1674 of 2659 user samples land
on the real addresses of DataAccess, hash_page() and
fast_hash_page_return when SIAR is used whenever its address matches
the mode of the interrupted context.

A user SIAR cannot be told apart from a kernel real address, and the
table above shows user samples gain little from SIAR. Use SIAR for PMU
exceptions only when the interrupted context is the kernel and SIAR is
a kernel address, and the interrupted PC otherwise. With that, neither
test has user samples at kernel addresses or callchains with mixed
modes, and 99.9% of the kernel samples in the mprotect() test still
take their address from SIAR.

Suggested-by: Tanushree Shah <tshah@linux.ibm.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v3:
- Use SIAR only for kernel samples, and only when it is a kernel
  address. A real-mode SIAR from the hash_page() fast path looks like a
  user address and was used for user samples taken after its rfi
  (Tanushree Shah).
- Retitled from "Use SIAR for sample addresses on 32-bit".
- Link to v2: https://patch.msgid.link/20261117-ppc32-perf-v2-7-2072e9b90009@gmail.com

 arch/powerpc/perf/core-book3s.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 10ded865583c..aab18f4dda94 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -112,9 +112,28 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
 	return 0;
 }
+
+/*
+ * The MPC7450 family's SIAR holds the address of the last instruction to
+ * complete before the performance monitor exception was generated, so for
+ * a PMU exception it is closer to the event than the interrupted PC. The
+ * exception is held off while MSR[EE] is clear, so with interrupts
+ * disabled the interrupted PC is wherever they are re-enabled.
+ *
+ * Because it is held off, the exception can also be taken on the other
+ * side of a user/kernel transition from the instruction in SIAR, e.g.
+ * just after the rfi at the end of a system call. SIAR also holds a real
+ * address for code running with translation off, and a real address
+ * looks like a user address. The hash_page() fast path runs with
+ * translation off and returns straight to user space, so a user SIAR
+ * cannot be trusted. Use SIAR only for kernel samples, and only when it
+ * is a kernel address.
+ */
 static inline void perf_read_regs(struct pt_regs *regs)
 {
-	regs->result = 0;
+	unsigned long siar = mfspr(SPRN_SIAR);
+
+	regs->result = siar && !user_mode(regs) && is_kernel_addr(siar);
 }
 
 static inline int siar_valid(struct pt_regs *regs)
-- 
2.56.1


