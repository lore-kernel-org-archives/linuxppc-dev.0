Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29079606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J/eL05uh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTXCt5rWSz2y71;
	Wed, 18 Nov 2026 04:44:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1131"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794937450;
	cv=none; b=bn1GR5zqSGRd4lmvTtopqSGomJzBJAWGYtWauDCp/IV+Bzza5Gg+ijqLFC5aUYgVCRhB3qVqqWUbdLUi9ORxcdCDPEO/Zl6qtCzt2ycGl632Oyd+gii0KAHLNJjW9ChNp2S8ukvnMJPR62L4kGbSlnZ4D2317gxgedIx8P/RTdDJh/uqfgMIQrDA5ZX0GykfFmRkfAU6hhQ8d1UY/BZ+F4zr+rBrZuiS6+tIa8k97Qpj9nBOhTFkbNOsZjA1jYIUA0khy34upw659SVnvCrvbZl5TGasUn6RBpnNN1otGSVV7beI1+LskzoE4qG4pr8pDhi5wBH1LIQ/RV+57xHyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794937450; c=relaxed/relaxed;
	bh=EMofIhkXpaZ8+oSY685djaeZJDUF5sw2CncgWG8cpWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l2dbRJEs1cZn9ux/MGTbSrPyfBEXx5cu7Mw/vtvJOujS7MxKbSIH5ku/1ybtgmW0bsduyhjOpoi2PrYVmfSdgLvO1jTe9F2UZdPqIhRUZcTSlQsdGceynwwHb9I187w3qkuSz8QPW9KDC459e9Weu31Wi8BKtPxFf/5fqKtDfvGbk9EN0ESpCe54r9erpZT5A+UsiB7O5S/ODNEEgZrnwiRFbxSHGFgcbasPxAINJXdADroxwW5NRlo/Xjff36+S1RMoMaJZdks9uo53EGLhS7NHMTFfA42D57B6f55T5j5bfp8VGfet9g1afVtcGahRNtblC3rFGRuYTTnovuc5Iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J/eL05uh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J/eL05uh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTXCt0BBcz30V1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:44:09 +1100 (AEDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-8b4e2fcc300so23081487b3.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937447; x=1795542247; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EMofIhkXpaZ8+oSY685djaeZJDUF5sw2CncgWG8cpWg=;
        b=J/eL05uhsl3yXhy6Q6tEQHVRFqejrptP4ULpDMqKVILw45SXuwsBTgzjgtKt7UzW6o
         MKjbU371aW2AZUk9Y3CWHQ3domaLoJozsP71yqT+izDykmNn0J6QWW/V6RopXRBiF8+S
         cuA4Ijx09IRJuSDFBfS/WYl6XIBBwxyHAurnbnOP3w+TZE8A3btgR11qxPOFku9whOTL
         Ri265eIajta07WXqd7AFvosIMR+RsNcq2fipRnocTYCJ8Se8Fot/oyOWAdMF8hECjRmO
         rv+NMvn13840wYqs3nK22D+zAPC5ETZxjfejt1iCp5MI//wDfaYPg6SLaJdR3aYPrlMa
         8zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937447; x=1795542247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EMofIhkXpaZ8+oSY685djaeZJDUF5sw2CncgWG8cpWg=;
        b=drUFKW0ycL6sPjV/Z7z7XjR8FvPV7DPnyVvt320a7LcpLFOKaQSLyZ1gVZ0HPSNCOH
         uG6f5CCZPgMKI1a88eIN1XZZxZBpauN5Ks1Plp587u0xN4ziTzvtqDxDqPvI3m0gSycC
         s5ghBopJ6h+J4k5ghTUYa+NhuKkRDFsdFarJXklkrex37nlfO6dRQwFXFwHjKkL54Qsa
         TYN1fK5pdp+hgc1T/ZXSQOJ5UUOvpGXYV1jYY8EKTT6CcayIKWCGxYKpljCQscKAJVd/
         pv3ZbHuHPjrD7y0DIxADzFmkCQ9UkFZgfA6/Ab+xHIRd0gCuTvb/9BtagQIdSoch2ca3
         XfFw==
X-Gm-Message-State: APuU4Z98gW8wVCfOE++fn/9j5Bk9fzsZ8rlmTFIeYnFzb//li/9kfogz
	B/Z4BrzCDnV68h5nzkOoOjlBAQZ6TaXfPhEJpr0PxqIrSniNEeZK0ESv
X-Gm-Gg: AZFdTZd1HGR7vKSi01G8x6agMYizdw2G8tk8jJdCXbmcFqG28zgGLGPYgzZWmS16wOJ
	f9IqcXaMGfkqSNvbHPwsszqcvV2masgk8h90X5/f5/8jDq4xEk8fwn253pb54MrGC2dbp+3mDj/
	lkfT8btBLyMSuqzV/xcqKtVIVqXaDneirgs2B/uJ4gINgGEgcOI0NV2xXUgLDlsYEMu7iq8Z52l
	ClIwhkJOAkwD5ewPcip387gz94OCtqog47wR23BnJrUSzE5T+CLQt0HDGPwMYClJnkBEiG+TRka
	liWCdUR0comi5hhSJzhUbSGr1zVTCyIAdTbjwPokOpYZSyLhpcrxYM3JuyTo4Pm6pQhMJCfzf0c
	f7Y9NVc1tXBn1ytoc+ZrMKGGuxL9IoEqqIGW/V2kvvkdrPVzfvUqZ02t7Pz2XqQnjNVaz4Dvh05
	Pjd9m6k+PtN4LqSvZ68q0FpI5M6d3AWgFaHt7PUxIJqjMoY5Mm8lgdHj1iYTUFVy0QvKj4ZKfdq
	xtKVc8kfQdwHz6KtAHqrHNQdS6WzoZ0BMS1gq4I6UOJGiTwwFzjh1qLG3bjoVFfcGIgI+X6Q3MX
	uhQQqUHq8ipKhwSAPkw+0oNNgUd+uTsILjYXAC+W2vx/TjKDPUtVDh3hD9jMKxNMAwBYcFqaxQP
	wngK6brHJOZORpWOdI/vTZEJGRRqmoKPAsevKN36ux7wPJsOdRk0aBsxLV1mtLXBjWeIUvJ4psO
	RWpKbLZ9YqGcvq2Bcasw==
X-Received: by 2002:a05:690c:30a:b0:8b4:e3f7:9edb with SMTP id 00721157ae682-8b4e3f7a668mr28160497b3.97.1794937447362;
        Tue, 17 Nov 2026 09:44:07 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe07408esm2161937b3.22.2026.11.17.09.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:44:06 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 17 Nov 2026 12:43:58 -0500
Subject: [PATCH v2 7/8] powerpc/perf: Use SIAR for sample addresses on
 32-bit
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-ppc32-perf-v2-7-2072e9b90009@gmail.com>
References: <20261117-ppc32-perf-v2-0-2072e9b90009@gmail.com>
In-Reply-To: <20261117-ppc32-perf-v2-0-2072e9b90009@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3533; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=sQH/oeX/+nbUx0BbEEHc52r/vsgK7BzhKRKCWM0N8VA=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+TIo0NGUxEJC7tOo634SlwSv/KV89fO+6YNCBVxly+
 Wt7+Gy8Oz6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaaSEeG/zE930sb7r
 vyP2d/pfxslRGv58b6oycvLvTXOvbmkwiPTD3D/5CrHFGFs0QXmy2zyFE/+O5B6iem/ScONDO/4
 7rlIr/2BAMA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
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
just after the rfi at the end of a system call. SIAR also holds a real
address while translation is off, such as 0xc00 in the system call
vector. Recording a loop that alternates user work with getppid() with
perf record -g -c 1000000, 3022 of 16953 samples had SIAR in a
different mode from the interrupted PC. The callchain is walked from
regs, so taking its first entry from SIAR there starts a user
callchain with a kernel address, or reports a kernel sample as a user
sample at 0xc00.

siar_valid() already returns true on 32-bit. Use SIAR for PMU
exceptions when it is in the same mode as the interrupted context, and
the interrupted PC otherwise. With that, the same test has no samples
with mixed modes.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/core-book3s.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 10ded865583c..4c9c9ff1073e 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -112,9 +112,25 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
 	return 0;
 }
+
+/*
+ * The MPC7450 family's SIAR holds the address of the last instruction to
+ * complete before the performance monitor exception was generated, so for
+ * a PMU exception it is closer to the event than the interrupted PC.
+ *
+ * The exception is held off while MSR[EE] is clear, so it can be taken on
+ * the other side of a user/kernel transition from the instruction in SIAR,
+ * e.g. just after the rfi at the end of a system call. SIAR also holds a
+ * real address for code running with translation off, such as the start
+ * of an exception vector. Use SIAR only when it is in the same mode as
+ * the interrupted context, so the sample's mode and the callchain built
+ * from regs stay consistent with it.
+ */
 static inline void perf_read_regs(struct pt_regs *regs)
 {
-	regs->result = 0;
+	unsigned long siar = mfspr(SPRN_SIAR);
+
+	regs->result = siar && is_kernel_addr(siar) == !user_mode(regs);
 }
 
 static inline int siar_valid(struct pt_regs *regs)

-- 
2.56.1


