Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD70606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I39/wiAb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNqK36qZDz3bWX;
	Tue, 10 Nov 2026 12:47:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794275239;
	cv=none; b=cTpv06eBQX0Un3Vqd5751G+MDsaceEVO2wrVgZ4m9vANB7HYSSykt4UwNCFptwY94xLID7A+3cy7m5r2KRKDvrZ9JxLnRpbzc/fDHBGpGpFQztyyYDfGho58Intycu9RAsXifNuS7r0d9hnmepTeX2zgG5fbEnuDzwcMnffuEvnrUfqDWvXFWlHHjtrrx44oUuG0v8z6Ife0ZcKvgq0FERdtQbEQxWj9X0U1Pq1S9RYl3DhK4a6/X0LSSkQe4A4O5fnWJfJPW8A0I9HP934El0a80XyA9GHefo4zWQViVY+KHpa6jlnDv8+U/JZ5/KBGBq9aoH3wa0wFqoCYVkhL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794275239; c=relaxed/relaxed;
	bh=mq8Ar0lLi/5kEOpfFLpnVCrLP0dRhJFYGmauCZHGg0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWIeaI4njC3QYYw9AIg+1L8hw9KzwF3782QJ4zI2PLMSOK4VlieIYN6kYt0pEGQZrCx8CUylwq67CpjqjMr/kR0PfInsWE9j5xbXc1/t0UrL2PZalYUXL6kqXa/tYQEs8xnlpYCgj2REGEoS+ClB7WwW0Pwfn4aY1IsRVej8RO2td1xzKG7aT611IEjKqp2b38wHvf+YLfBlVmx3zByaXTXQ4ExH6aWoEhZaDA8xYrT4oSLJVuzheg67pp5t2PS9CSyAQ8BL7r9od5OuUFaklGJrplqZS5tb6db6TPNTzB6ltAMXCghK7K2HNSDEFMGrCYOdlE/Ua7h2gHfHY3AKsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I39/wiAb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I39/wiAb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNqK31tFKz3bf4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 12:47:19 +1100 (AEDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-8b300713befso12544137b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275237; x=1794880037; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mq8Ar0lLi/5kEOpfFLpnVCrLP0dRhJFYGmauCZHGg0E=;
        b=I39/wiAbXDl/17Lw+QY//dh62hKYiyDBv6q7m47qf1V6w3IKvp1lIJ5o4Sy8Hif7W2
         rzEQwdzMo8Df2rDTHL4uSrxth6WN2XEZENSS0NKGCcJ4otdRMVBIKV+X6kDftIecw3Wd
         zP9a+RDSRtF+I0afd8aBbqKUx8Wkh0HR1xCC659MIBwAaV2z7R7M5k9S3Trx1lXvSXW+
         T9AHBdxWdlkKflXRhsJr1Ar2p1HWiGN94VdersN0SsETpps4JqPu268Xp0WTdFt2Ae9a
         NImPKLmjg1J/77HVRwG6jmehRzifH+y40IQow4sXNyJOdemhfD5JonCh52BV2vKw28qN
         FIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275237; x=1794880037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mq8Ar0lLi/5kEOpfFLpnVCrLP0dRhJFYGmauCZHGg0E=;
        b=ZeiYZtKiKbPXxWQ5G93AZuT/hKBmdaijF3BPBucwEa8JVsURm8EO5SyQithwulFgdM
         g8MU7+qxPJB6I0T0xDm4zBttwoeHmuF1kXurf0verJ6yZMp4OblqUhDCY3fRXm3Cf+pw
         Bq4GZwhvC64gGcGSQTqP+nRL8v4WE3JkIs/C/tT5wGdGv2JkzQkHs99beUBS7l5ZkE0d
         hHGiubjJzgm2G7jWGuHt3n+mRGMU+hRXXpDqJctw4dMrqIz/Y4ry/39EjzRNCNZR/8kB
         GKfg/4pVne+ywFAvSZXGpXRhda7pXKO2YOeFNkyXh8uUAvKPuGezXgpYmk6hUcBNUt7G
         lHpg==
X-Gm-Message-State: APuU4Z/HbHkUqnE7qBEGscfvkas5drtpyWhBwKZdsk0U+5wBYCj6bFW5
	ZE8URSo94YBFvjVbc/TyMi33FGAHvmxXVCIG2J8xKWkAIS807AxF5Vj5oSBYUGy3
X-Gm-Gg: AYBFou3GJWmFSMeGVVWNHhbaDWmjBPoT1eW3tvuT7i8occ0ncHLDVxZ9A1ZqJeneaNQ
	lZ5uZ8+NVKXY/ziZ694YTgq425rL0DiF8YsfkccJmEQJy3pRKCPsjW16xT7ehXRDXp5Ln8f1F4v
	Cuj+kO2Y4ZhzS07EdpELNT0cJ6h+VrefLXcZCGEgatY6MChzU2HKJQaAbVObt5Yb7lf8jXgOamM
	CpzjR1cBVonDpV4CCAw8eE+XUenJy3ANSxcddF4R4pi2J6Jk+Wm1mvh3YH4MYBSXQx0nBPnH6MF
	C5w53OtLztqmb/p/I0qIaHIr/yvDvsncQFCN30hfYiydvXl2Z94vsflRzDUSnUEmJ0VOXUUBqqn
	6kXuNcu2hoGYFNhjfe0ltSc60ORQ9sToXw02tFEe0CNunlp4fmzpS3VXmzfC6zdC8DEs+tZoWi0
	WGPxjs5uFeA2jKDS/7YvbBxkaiqO46mxxGQz/PWDTfmxr6qSDNVsQNXIrI94eeqsGb+w/bTv3Zw
	VHX+i7gUhxxSsVfDAXMbgfFyKUv+txdMyIRkCWgC8S3V+CutrgYD+0j9eQ9cnHX0wJSFei6wrt0
	l0C1UtGhGf4SEo2wxvKoR5GxrjvbW43fD/o4l1HoWOI6hemhlPxFT1NXaohw8XW5NfnB2Fd2pqa
	4FWN6lsyQRg==
X-Received: by 2002:a05:690c:ec3:b0:8b0:cc41:a124 with SMTP id 00721157ae682-8b392b705f7mr8737777b3.49.1794275236620;
        Mon, 09 Nov 2026 17:47:16 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933a1cf3sm8399777b3.15.2026.11.09.17.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:47:15 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 09 Nov 2026 20:47:06 -0500
Subject: [PATCH 7/8] powerpc/perf: Use SIAR for sample addresses on 32-bit
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
Message-Id: <20261109-ppc32-perf-v1-7-a6e8a55b3b48@gmail.com>
References: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
In-Reply-To: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4209; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=IV87DZUvmybjN6JB+MieMd8HoMSlN7JVQzsooFUy8EA=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI+lU85dW3Djx/3Lh7g9o7pbNXUr42b9zf47lJtEae6n
 b9U+6/KdnxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1k88xMhzn31w8Qc
 Vls5z7ep8S302hNn5W9t6/DjmyPfRf8WEOQwPDf5fUlTodM3e+YdapYeI9vTPQ9mNg06qeGUVXq
 vy2Bl/l5gcA
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
(MPC7450UM Rev. 5, section 11.3.7).  The exception can be generated
with MSR[EE] = 0 and is taken once EE is set again (section 11.2), so
when interrupts are disabled the interrupted PC is wherever they are
re-enabled, while SIAR still points into the disabled region.

On a 7448, sampling cycles system-wide with --intr-regs=nip during dd,
perf bench sched pipe and find, 46% of the kernel samples have SIAR and
the interrupted PC in different functions.  13270 samples have their PC
on the instruction after the mtmsr that restores interrupts in
ata_scsi_queuecmd(), and 11661 of those have SIAR in udelay().

With interrupts enabled SIAR helps less.  Sampling a 32-instruction
loop with one store and one branch with -c 10007, 99.8% of the samples
land at:

  event             interrupted PC   SIAR
  r122 (branches)   br + 13          br + 9
  r014 (stores)     stw + 21         stw + 17

siar_valid() already returns true on 32-bit.  Use SIAR for PMU
exceptions, and take the user/kernel flags from it too.  Move
regs_use_siar() above the 32-bit block so that perf_get_misc_flags()
can call it.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/core-book3s.c | 55 +++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 10ded865583c..e4c8ecddccbd 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -75,6 +75,20 @@ static struct power_pmu *ppmu;
  */
 static unsigned int freeze_events_kernel = MMCR0_FCS;
 
+static bool regs_use_siar(struct pt_regs *regs)
+{
+	/*
+	 * When we take a performance monitor exception the regs are setup
+	 * using perf_read_regs() which overloads some fields, in particular
+	 * regs->result to tell us whether to use SIAR.
+	 *
+	 * However if the regs are from another exception, eg. a syscall, then
+	 * they have not been setup using perf_read_regs() and so regs->result
+	 * is something random.
+	 */
+	return ((TRAP(regs) == INTERRUPT_PERFMON) && regs->result);
+}
+
 /*
  * 32-bit doesn't have MMCRA but does have an MMCR2,
  * and a few other names are different.
@@ -108,13 +122,30 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
 	return 0;
 }
 static inline void perf_get_data_addr(struct perf_event *event, struct pt_regs *regs, u64 *addrp) { }
-static inline u32 perf_get_misc_flags(struct pt_regs *regs)
-{
-	return 0;
-}
+
+/*
+ * The MPC7450 family's SIAR holds the address of the last instruction to
+ * complete before the performance monitor exception was generated, so for
+ * a PMU exception it is closer to the event than the interrupted PC.
+ */
 static inline void perf_read_regs(struct pt_regs *regs)
 {
-	regs->result = 0;
+	regs->result = 1;
+}
+
+static inline u32 perf_get_misc_flags(struct pt_regs *regs)
+{
+	unsigned long siar;
+
+	if (!regs_use_siar(regs))
+		return 0;
+
+	siar = mfspr(SPRN_SIAR);
+	if (!siar)
+		return 0;
+
+	return is_kernel_addr(siar) ? PERF_RECORD_MISC_KERNEL :
+				      PERF_RECORD_MISC_USER;
 }
 
 static inline int siar_valid(struct pt_regs *regs)
@@ -163,20 +194,6 @@ unsigned long get_pmcs_ext_regs(int idx)
 	return cpuhw->pmcs[idx];
 }
 
-static bool regs_use_siar(struct pt_regs *regs)
-{
-	/*
-	 * When we take a performance monitor exception the regs are setup
-	 * using perf_read_regs() which overloads some fields, in particular
-	 * regs->result to tell us whether to use SIAR.
-	 *
-	 * However if the regs are from another exception, eg. a syscall, then
-	 * they have not been setup using perf_read_regs() and so regs->result
-	 * is something random.
-	 */
-	return ((TRAP(regs) == INTERRUPT_PERFMON) && regs->result);
-}
-
 /*
  * Things that are specific to 64-bit implementations.
  */

-- 
2.55.0


