Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C19606A32C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jgTiaFsi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJY8L0zg6z2xlw;
	Tue, 03 Nov 2026 13:54:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1231"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793674498;
	cv=none; b=DQBkJga7Q+RBDMUQ+e5BZY8bqeSZI5YUxxPQNq/vNS1bx5EOywmZSiYY4VAGagmm+HBO/joZvOLvty4PMKBuPu4IUPsmV/6CArcploge8z+8f+Er+XqHsqA4RPot7R45cz1g30ziAU8xhCFMyjy/FaLhWy8bkRNq7HIhfnskQw5LojNErCdV3D3W0h1jow7vNqTDPR5sSKvGSA7PqGUvZtDpwIg+ofpFuvt/4jh7kPX4aJEk9UslNCcRQvSnz4umW6zpypWynR3uHal5ct5diXr06ynarws7Afv5CHatUYQkB+a7TinEBcBtJYr1B9aTxEdawf5eWp1MJukFIOV7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793674498; c=relaxed/relaxed;
	bh=qjmg1SjTs3atT2nn9WnBytEIpIW9LchwdehIjStPp4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gai5NjAuNirvky3T+wzG8HucvvKjBgGdQmPQdyuMuM8InWmrJoqskCl5zOrxEG4IQCAU+ULqWhcJHW+XJwP0YO0oJTwl9ghSIR3CsXPZrqhyVgOkEBThITBotO72ypn7ZhANFpC5R0tl/eIbN8U6J9hHcvJBpZT5ns+Md6R2Wxr/Q+Zn0v93gijt5IpihW1D7u5QUqa+wkx/dLs11QbJrHZGdkvVyBLDlBtT2RUKqdV+jMBe/S/eQxzA3jklsifr1rfcra5bOrQgX7r7fyPyR38isaA/nuhvJWwgHeFCw7dtpABji2eG+8zAQHXnXmAkvGoCpfLZPjufV9nL0IXVcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jgTiaFsi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jgTiaFsi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com [IPv6:2607:f8b0:4864:20::1231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJY8J3CSdz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 13:54:55 +1100 (AEDT)
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so3687428c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 18:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674492; x=1794279292; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qjmg1SjTs3atT2nn9WnBytEIpIW9LchwdehIjStPp4Y=;
        b=jgTiaFsiIQKDh1W3HYDymaec1SY06qXFj5woKb09QeAUJqybump3mOounGNyZxrsWX
         6LW0QUJ0tL3zoiwjiTSiaFBjF9cX1Yldp9NR1Qwra32QAg0mEml8vqpyaRSQZ6CLR9K6
         o9DXfHyW9N5xWZNIYewk7kWw8ls4YW67+m+0dzyXUA60IW/F72TbjSQRMamuKa5Szwbv
         CcnaIBgUxSHEncfvNhjqNst8qiJSIYSeul07qeoFiWNWM/cU1bXhotObSbnmY0r55VaW
         U72xBQfSV/t4OTNF8qngGW3QEVKSodzIiWpFC6YJ7miqqhce5IomCRTUxlTXWiPncr3h
         /cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674493; x=1794279293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qjmg1SjTs3atT2nn9WnBytEIpIW9LchwdehIjStPp4Y=;
        b=zEKFlWkrNjUVE+OcHz2PNnA2o4mGkmsnXY7r0E3w+L9r246RT74fxBcmRcFQj5qgIS
         +zhPM545NsK4+wz8OWqaXZuJcPSNAttdaI/NLSmZG0i73aKPxJKcKeIWpfqgYwEmR6OG
         /S5m3pwPx3BLeoJg+TPk3ruyvN6NJ6yyUDDcz+w91a+6fLOv+YNzXj2U2UjeKZ936+p4
         ryE5FKWIkP4CZZ5Lfo3CyWV/kIzSSu+zBTrCMPPP2/E6MnccPJJ5hhk+UvFjXGcHQPy8
         NRqYiKux59HC0p1QoeH5FPxHrbaI0LkX6mp8UUJmJagJWBW6udjpRKLG7sQAFVId1sV+
         rkFw==
X-Gm-Message-State: AFq9FYJ6ZFHTiCQiVN07cS/jctH0ruCp7EnsTpLwIslXJDh/ccftCfP5
	ZEsQbX7HmlwfZo3Geb+roSQqQj4EmVR3zytXoHVbe8yprtYhm8pnN2FhDdKYng==
X-Gm-Gg: AYBFou2AOtODZhHBPvEKc/2mB51LIcUIEvouumZlCQNuDrIJ1lclrdcVD1nT07xR/UA
	q0p152UDz6tkas5FWM+H/iLqb8rHD293FiI07w567z+qOSCX2qqyxImdcy2RjcCwE6OUf+J9htl
	cLOKIGqVfuuej03Zz+mJvvSRo080S3sjfiLT6tRAHX6cM0FCqAEQfb9w77BQaoZfaGpChwoHWvA
	5r4NmowU/N1Eqee5Wrc58+3aWTzDFrChywnBQ7TNIFiy3vh0rua8FOaVzF0mgj/vcwdKCFExS69
	Ml0X7/f3XSRh1h5MfczpqaIhLi6trwrJUiltVPrbhkYeMQpnvJQU2mrf6Rh6QGbP8yO1tScEuPL
	EWEufF29VxjifzcX/7QNVc5iS2lQPLvtDYVgbIiTl6to2hfEQkE/wslS5sIzaSv9vxXjeqMfGR/
	KmZvkbOuwwqna3vuWtXr8+WmAx2vemYme8swmwhLHTBluDhCDljVrikdSOKLce7ww4i0H8XYguK
	U0T3BOSgU7MPhwVF9nQlYVltGLhZiEMAF/xNwyoH3pijD0hPSWu5y0UiZKOXYBPsGBb1ajznW4V
	eL25aHs8tejmn158aj+pjWI9pOerFYpOfg==
X-Received: by 2002:a05:7022:5f02:b0:19a:51da:f54f with SMTP id a92af1059eb24-1ac5d88c584mr16916727c88.14.1793674492234;
        Mon, 02 Nov 2026 18:54:52 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm49882356c88.6.2026.11.02.18.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:54:51 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org,
	Josef Schlehofer <pepe.schlehofer@gmail.com>
Subject: [PATCH] powerpc/code-patching: Flush the patch area TLB entry locally
Date: Tue,  3 Nov 2026 08:24:43 +0530
Message-Id: <b7916dadd8ef56d417d0cbf69fa9ef2a447a5a3e.1793674111.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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

patching functions like patch_mem() and patch_instructions(), maps the
target page at the per-cpu text_poke_area, write it, clear the PTE and
then flushes the tlb using flush_tlb_kernel_range(), with interrupts
disabled. flush_tlb_kernel_range() on SMP nohash (e500) does an IPI
based TLB invalidation i.e -

	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);

...which will wait for other CPUs but with interrupts off. This can be
caught by lockdep with the following warning:

  WARNING: kernel/smp.c:917 at smp_call_function_many_cond+0x430/0x818, CPU#1: swapper/0/1
  CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1-leds-v4 #1 PREEMPT
  Hardware name: Turris 1.1 e500v2 0x80211051 Freescale P2020
  Call Trace:
  [c1915bc0] [c001be04] flush_tlb_kernel_range+0x2c/0x74
  [c1915bd0] [c001ce2c] patch_instructions+0x1b0/0x318
  [c1915c20] [c003113c] bpf_arch_text_copy+0x5c/0xb4
  [c1915c40] [c01c3398] bpf_jit_binary_pack_finalize+0x28/0x8c
  [c1915c60] [c0031770] bpf_int_jit_compile+0x5dc/0x758
  ...
  [c1915dd0] [c102e114] ptp_classifier_init+0x30/0x4c
  [c1915df0] [c102d3a8] sock_init+0xc8/0xe4
  ...
  hardirqs last disabled at (3076): [<c001ceb4>] patch_instructions+0x238/0x318

Josef confirmed that this was causing a hang (deadlock):
    I think this is why the CZ.NIC Turris 1.1 hangs early in boot with
    CONFIG_JUMP_LABEL=y. On 6.18.44 it hung in 19 of 19 boots and booted
    fine 9 of 9 times with jump labels off. The hang comes while static
    keys are patched and modules are loaded, nothing is printed and the
    watchdog resets the board. OpenWrt keeps jump labels off on these
    boards for now.

...which is possible if both cpus are doing similar operations with interrupts
off and doing TLB invalidation using IPI.

Broadcast TLB invalidation is not needed here since text_poke_area is
a per-cpu area. It is mapped and unmapped with interrupts disabled by
it's own cpu. The only reason I think, if we would need a broadcast tlb
invalidate is, when we want to prevent a stray or malicious write to
this cpu text_poke_area by another CPU. This generally gets solved with
temporary-mm path like how Radix and even x86 implements. However, booke
doesn't implement that, so for now let's ensure we use local tlb
flushing for correctness.

Fixes: 49e3d8ea6248 ("powerpc/fsl_booke: Enable STRICT_KERNEL_RWX")
Cc: stable@vger.kernel.org
Reported-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Closes: https://lore.kernel.org/all/20261026195644.16384-1-pepe.schlehofer@gmail.com/
Tested-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/lib/code-patching.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 44ff9f684bef..6351342fa5c3 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -276,6 +276,23 @@ static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
 	return err;
 }

+/*
+ * The patch area is per-CPU and only used by its own CPU, with IRQs
+ * disabled, so only the local TLB can hold an entry for it.
+ *
+ * On nohash SMP, flush_tlb_kernel_range() IPIs the other CPUs and waits, which
+ * must not be done with IRQs disabled (see smp_call_function_many_cond()), so
+ * flush just the local kernel (PID 0) entry.
+ * Book3S keeps flush_tlb_kernel_range() which doesn't IPI here.
+ */
+static void flush_patch_area(unsigned long addr)
+{
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	else
+		local_flush_tlb_page(NULL, addr);
+}
+
 static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
 {
 	int err;
@@ -296,7 +313,7 @@ static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
 	err = __patch_mem(addr, val, patch_addr, is_dword);

 	pte_clear(&init_mm, text_poke_addr, pte);
-	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
+	flush_patch_area(text_poke_addr);

 	return err;
 }
@@ -488,7 +505,7 @@ static int __do_patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat
 	err = __patch_instructions(patch_addr, code, len, repeat_instr);

 	pte_clear(&init_mm, text_poke_addr, pte);
-	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
+	flush_patch_area(text_poke_addr);

 	return err;
 }
--
2.39.5


