Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A28606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fRwCyAhZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD4CH2Pw7z2yPR;
	Tue, 27 Oct 2026 06:56:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793044619;
	cv=none; b=ZcvTpZ+eU+awUZBfwyn85OMNd34XSe5or+avxvLPtSkj/MxQQ8bLkNgVKojam49jwjhrCE1/LKPIQkpPBk46TZPtQ816VSzXnsmN1Ly7KHtaAZGetyjSkRa4gsQL+ZbjD44s6QvuguQJ78iTHQNHF0YkrGuEg48d3N+SeF5PnkednkE2+48kw+/HayrZSLNR7vt9pRZSGITH3QNunzCp+SL7hwuLlUKfyLIsWz57/tmWzdB7rVMa4vu4IYq33PYZm/0lQi6am0/yVf1JEy6qJUzr2cE2I4xfV+++4IjIb/gCWx+JZFSJNbFwSYs9khdYBB/uikqo/5/ZuaFRX3JGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793044619; c=relaxed/relaxed;
	bh=FqCIdqPFMWya49nS37tTwwL89MpF/df8fJ6+BamATMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hr5CUAjW77pudmZA56DACpO3qZp4E7AptR39xDscQ1zV9G5AOyUN61M+TmZ5O4KDU0weKyUc0oYMZWfZapHGMhimi2sFvqxK6QEY0wORjXBowQKEiQH4E1DjaUGrsOvonvCUhKxhi2m6U2PxE9xavf3WOAARzbADQJw9+i/n4ILJ4CaPHHW9+MfS7A4OXfgjWHGMTnDRzCI2KXPXw+723usxysZ7B1zVVTXTTCGJP8zJoHqaO3FVu/2wlLSFG6m9l2hR//uPkPrTsrv/+96to3LEV9sq7gPIHlw8hI1BHjoIa1nFV3SsiBIcRLar2oihP7PPE3QdZJjtXfbAtyM2MA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fRwCyAhZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fRwCyAhZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jD4CF6Q2Pz2yKn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 06:56:57 +1100 (AEDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1938407f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793044613; x=1793649413; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FqCIdqPFMWya49nS37tTwwL89MpF/df8fJ6+BamATMQ=;
        b=fRwCyAhZ089z9+INUkN8at3siCzLxA2OggjIQAYQozMbfKK/gdjp+FU6wz2DjHZRCj
         okHEHBIpvAKWWA9Y94Ro4amCxHlZkZVvU9ZSvWJ6NbMTDq5JqsPY/KPpSFLP4/thS3/R
         Z1/S2YNUgP9/y0M0UYvfJdc0N8EQI2GMKm+VDV5FAze27RbaHWVZjXVoEDXBHYR1XXMp
         Z0qSGpv8GIRwxsAprPOvXiDV1QQAUBVD4QZ9G71OAekM8QcnZV8EaZ7bu1fQ9RrsSrSN
         u8zOGVttO/AxcGO/8cZ3lJbRdBdJUT6/mwpeShlWLiDDjppeDF2Eq9HI9p/BFQanQZyk
         YdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793044613; x=1793649413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FqCIdqPFMWya49nS37tTwwL89MpF/df8fJ6+BamATMQ=;
        b=vLDQdJXFfvsHRfIMk9VIsuoTlwCf99NY5h40M3kxuADJNgl3D9qhxtDRSn/9XCQtdA
         fBASNB0a46dyK6dkPPTLDPAUOJOFyo9xoAMbzoIgBBaun3Zc67pc+//JKUB7HugGXerm
         ObX0dlifmGsdWsGOwbIhtDS/OWJte/xjNrKrgion1IBv3lWLKQH5y8QIbhWdSU+49A1T
         sYKPiv8IosrVi1sDigzVkp8gLsZwieraifdBXiGOmPGR/raHF0FKzxJ/DSV8BXYctZ4D
         2/A3aQVMu2UCIzYqT3b7Z/1GCdKWk93dnKJ2HcHD67GL5BNLZUyPwdh0r5p5UETNWxNi
         Za2A==
X-Gm-Message-State: AFq9FYLwAbJysd/0R3FoYIUUFZDoqhWIdKOLZcs/tquiUjnq64nzdunT
	ONFFGyUsi5JF/Go9pxYBCHFL3kzaV3S3FG2Ctz8f6FELj5pwKl3EEpKpvXRVccqb
X-Gm-Gg: AYBFou2rggxNYa4jgYbLaMqdbpJbPOyNgOXAxBj+6FaEW+BqkRnGvfvNIdCIdcKUwbE
	/4X5UWIfCocTCtouJIMx2fbJKNlw8Aqx/fA8xeytgGN3LGzQKr8dVGNxU7xpVbdQ11vEtrvOYBF
	9oCI/CzMyr2BDC74vgt+kt3N6SJckK57HA1XF770N/uGg7L1/zL07dhGwTPfHvJGSiL8gJ1mVSO
	hSTHYUeZLTSlcaUiRdxgyGyhWPAjMLmezsP2M5qVhCCtRfTMwaBSnZ+hn3YELVCtUq3lmkCPuUe
	3bQ3RAVOMqn3qHiIKzeRVKhdZOdMOudXmA1QrYWVfWp1W/niEiVnK7lQBMbgVsGQhXLFRgbT+Pz
	XcB2uXPHM75s1/BUwunNGoaEZJlYuVSkFYW9TGHWSl79EuFfgz8n07pRnM+B+GH9aCprykGceGC
	KPCwzDK9wrdUz0jcVA1Yrgprli79DtWVSV9/7AZeM0IkaPNwMJ6oDIcjkj42j7QkhOdH/1mTZ81
	4HaU9cc/ylEJk/TaNiRbtujyAIsaBP6kdE59n38exaIbZKLRw3X6RSwMTYUlyyuAa99M7oM2uSb
	zRWNRybiRtYVtkkxPyXem+5ayJwaCRnmpsizYjMsIxOFRpj0nNzelkgwq6CjYVAbsruIKmRvK6m
	7iPzq49CSpOlo01MK1zmoe1ARpNkZboxVjEXj2uUnhx7AYreIsu3dS8LTqdnDgYjHG6cFN2fGCg
	rF2ESioWcPICKYD58uW/zWWnQz8A==
X-Received: by 2002:a5d:5f56:0:b0:48e:f10:ceb8 with SMTP id ffacd0b85a97d-48e3eb759fcmr14555792f8f.11.1793044612929;
        Mon, 26 Oct 2026 12:56:52 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-8ce1-bbf6-5949-b0f3.ipv6.o2.cz. [2a00:1028:8388:a84e:8ce1:bbf6:5949:b0f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecde7easm18592526f8f.52.2026.10.26.12.56.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 12:56:52 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Subject: [BUG] powerpc/code-patching: IPI with interrupts disabled on e500 SMP
Date: Mon, 26 Oct 2026 20:56:44 +0100
Message-ID: <20261026195644.16384-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
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
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On a P2020 (e500v2, two CPUs) running 7.3-rc1 with
CONFIG_PROVE_LOCKING and CONFIG_STRICT_KERNEL_RWX, the BPF JIT
triggers this warning at boot:

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

patch_mem() and patch_instructions() disable interrupts and then call
flush_tlb_kernel_range(). On nohash SMP that is
smp_call_function(do_flush_tlb_mm_ipi, NULL, 1), which waits for the
other CPU with interrupts off. If the other CPU is doing the same, both
wait for each other.

I think this is why the CZ.NIC Turris 1.1 hangs early in boot with
CONFIG_JUMP_LABEL=y. On 6.18.44 it hung in 19 of 19 boots and booted
fine 9 of 9 times with jump labels off. The hang comes while static
keys are patched and modules are loaded, nothing is printed and the
watchdog resets the board. OpenWrt keeps jump labels off on these
boards for now.

The same problem in change_page_attr() was fixed in 2017 by commit
7c6a4f3b1641 ("powerpc/mm: Call flush_tlb_kernel_range with interrupts
enabled").

I can test patches on the board.

Josef

