Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C5C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 19:02:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16E820815
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 19:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UORXOUKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16E820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42y4GS69CvzF3lW
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 06:02:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UORXOUKY";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="UORXOUKY"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42y4912xvKzF3kp
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 05:57:21 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id 32-v6so12035925pgu.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 10:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=KK24Xtf0yZxdzxm9LC+famSI28x00YC11YF96N0BM3E=;
 b=UORXOUKYewxZBY9q60veahrHkEtPpR9GSai6HV7K7LIRYSUmveL4hgphwWKykjezr5
 5aJslRjRd5lwcVzGm/diuVIZt/WHst6O5IT8qVuNmMEHGGC3uCNjKCW4U/6UPunf//Ri
 Yog90RJJIsfBEnEswOgbukRNoDii/RYXBxk8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=KK24Xtf0yZxdzxm9LC+famSI28x00YC11YF96N0BM3E=;
 b=Bh1vtkfUXfbKen0BYbof/0RL3m7Hxk/MXHCiUw06smPhKJdWxx7XPH5SySbm6QFTLH
 GKosrNa4Uw977uA9UDsMARemqaGkQOC9srjqrF+dkbgk9nvsCASl08fOwyvJ+oNzzE3z
 B15AORrUpu+txwhs8ejnoYN51UuzIGpzPpRXm9EYqFAvHdgeLmWpM7+pxWFByUfBWTo3
 4EOGf99Jjxac0QcLhCALnDLtoZaV7QDKOY/ALvjO8sBg7l9EKFlEfWYqSDLwMblMPpmg
 NpZMAl4eWBPvVpFL73VP7Y0cIh7VlwsLCOuZcZboAKs879UFw8alayIQYf4o9iqhHFEU
 DLKg==
X-Gm-Message-State: AGRZ1gIPMvOfIWIjEqXhEy16T6IlI4ZQ648G99ZPaRby/oVuUM9txnG9
 prPY65ZIRnSzNHctyKjCn9Cjyg==
X-Google-Smtp-Source: AJdET5dcu85Awa0hWemuaG/qBca5+pUPD7vYP+djiZMTtvFzptSWkQPdpArsamMNJVlWr5986121ww==
X-Received: by 2002:a63:3c44:: with SMTP id i4mr14292473pgn.286.1542481039552; 
 Sat, 17 Nov 2018 10:57:19 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
 by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 17 Nov 2018 10:57:18 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] bpf: permit JIT allocations to be served outside the
 module region
Date: Sat, 17 Nov 2018 10:57:11 -0800
Message-Id: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
 Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Jann Horn <jannh@google.com>, linux-arm-kernel@lists.infradead.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, netdev@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Jessica Yu <jeyu@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On arm64, modules are allocated from a 128 MB window which is close to
the core kernel, so that relative direct branches are guaranteed to be
in range (except in some KASLR configurations). Also, module_alloc()
is in charge of allocating KASAN shadow memory when running with KASAN
enabled.

This means that the way BPF reuses module_alloc()/module_memfree() is
undesirable on arm64 (and potentially other architectures as well),
and so this series refactors BPF's use of those functions to permit
architectures to change this behavior.

Patch #1 fixes a bug introduced during the merge window, where the new
alloc/free tracking does not account for memory that is freed by some
arch code.

Patch #2 refactors the freeing path so that architectures can switch to
something other than module_memfree().

Patch #3 does the same for module_alloc().

Patch #4 implements the new alloc/free overrides for arm64

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>

Cc: Jessica Yu <jeyu@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: netdev@vger.kernel.org

Ard Biesheuvel (4):
  bpf: account for freed JIT allocations in arch code
  net/bpf: refactor freeing of executable allocations
  bpf: add __weak hook for allocating executable memory
  arm64/bpf: don't allocate BPF JIT programs in module memory

 arch/arm64/net/bpf_jit_comp.c     | 11 ++++++++++
 arch/mips/net/bpf_jit.c           |  7 ++-----
 arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
 arch/powerpc/net/bpf_jit_comp64.c | 12 +++--------
 arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
 kernel/bpf/core.c                 | 22 ++++++++++----------
 6 files changed, 31 insertions(+), 35 deletions(-)

-- 
2.17.1

