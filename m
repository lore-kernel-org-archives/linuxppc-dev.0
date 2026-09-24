Return-Path: <linuxppc-dev+bounces-28149-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DC4C9830E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 21:45:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrS6g6Bqlz2yr0;
	Fri, 25 Sep 2026 07:44:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271071;
	cv=none; b=gHBKLOG08y0oCCvdgAm2SPcj5n++k2FRwXGfVtMYPfRAxRYtMVht3Jqa+hBXHevq+bjDXOaw0Y7hSmcLLJzBlqOOmu8Ia0xO6nenjghi56xMN5B/l7CVjUvkLd8Gt+C9eVHpe3cper4V8boTg597tcvXEDnLzGR8TQmD/fwxOvwpBIkhYIOyDJRBhk8UaFr00Z17KvhPFWIpAwR9urQUQJjqvC7TqGGu5rlHnYOAxmK7pitmQnDKCgmPcwbRm48tvpxxrDpvlCzCn815ndiqRBVo9zz91pU1W1EmpybHukMht3T7bAA9dRc54NjhVcjGfIFOQkDS5qjrRP3hKXZG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271071; c=relaxed/relaxed;
	bh=ap6pakDUJlnHSF/aqYwnk2uDwDP9NpWN5G+PbeaxTVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U5m9m/qmcKLXQovjBxsg8HSy/COEvopXKAeqZXlcTLwmzZWsL2B3XKS/1aLlkNVIwX2+/Bv4qj4jP5u2jnmUkQfJHfE7NSSg+ZEpS9ErJpviFMzSkojMlgmpdT+LYinwXKDU2ujR55xsT5b40UHSlktuCUfD18MKRTTS2B5wf4PtJwWvDfjNICGTf7slxYqOMJHXQV0R85H2YuCFuwcjizYMcy3cQkN28hAeHot3otuDe2Uq2859vz5iRd05pGjAp9AYTiK7DBzLMrOriXCdxg4Vpr78fnpTsS4t6PkDpkOM3GkwG18EmMcvKIuuV+TMgzOFQ6sTEnlywf6q7G7+qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=VHuMbvBt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=artem@trailofbits.com; receiver=lists.ozlabs.org) smtp.mailfrom=trailofbits.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=VHuMbvBt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=trailofbits.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=artem@trailofbits.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLTn6l6fz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:31:08 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so9083a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790271066; x=1790875866; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ap6pakDUJlnHSF/aqYwnk2uDwDP9NpWN5G+PbeaxTVk=;
        b=VHuMbvBtLbtC3ChrzV8Z7c/B7pD21HbitPyZW7GUwJjhhOULMurGdsBsx3uugpXBrO
         rgxC1SdvksZnbp/7xEEUKlUxTf74wsoQrf+5QIccxPkMsEcxpzS+p5RRCbx6PowzwnSS
         ciRs9C40r5tDNj9Jr6QhpN06TagDdV24njjxhvyr+AdNU8Yipdxa99WLaKxiDOlFdy+E
         t8DO2S6pz48cy6BnuJDlzCQ7aNyyWA2Sx/iAikxM76heQUuNBRZ+v18/2+QJH1YadSRY
         8IzTT2XF0jruBWaKSGr27v38HssM9cdjt+V+zTQdILY/jhh48oca3lpmSHmdBe7A4ZF/
         SL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271066; x=1790875866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ap6pakDUJlnHSF/aqYwnk2uDwDP9NpWN5G+PbeaxTVk=;
        b=pLw9aq/fjbqJxPnLFSys283B1fRpNCeD26uM/Vuwzc0lOsqnBsomiaz/V272Spo0di
         TelOj7YwC43RUXFs2QcdYJMCT0/pogFrOoa5hYmvYUqrpW1SvH6dOfPDRQKHdJl6aZbK
         JC9bWGBDWRVryQjThB1gw+1VGmoN6y7SNk8sSiDOT1aurQwPZYkEH34sley27QTBYsOn
         L1XvuDiZILvcyrFvTUH5Brh9MGDIH2XonqpCYBNNR1jrPsWGtw63SIdF94mKxUoMPTux
         0JIbnEF0sl0C5hfyrLs+as2BsFJd3HYdqsb6e6zwQCAFozFs3CTExBQEDgvZs5fYv0uK
         LEoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwtXtt3VLUlIvg8srki/909sUUB+6Zrf6MmOv6bt7QSmZmAxikbzx/6hA2qyKgOoek8xd5alIc5FDPsumk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lwZeywXrmhLFF4ZR3CFuxsAl8juyAeLabmj2YRZuFD/1mFu2LV
	L3oWk39D1irPfUOufFzWz404Ctc7i7KaitLvoVxAyWLF2x63zedLJNs5keKgXTtU3VI=
X-Gm-Gg: AYBFou363XqIcGkIFUJkFpIVoXVV3Ze8jBOv2vG/0kPqSV9saewOIv8LmsQec/ekWPs
	x4GZJfYbZzxmE6afTvBDH5n++ODJCAe44IQXfucFDXk1pw8tJScuMAlq3U1uxPqVkD6Zx2Y8Fyy
	AQaPtgujzNMQGJHoLBoKagDcvH43cfplslcqVfB8OW+xR41+V2CTN7u+No73dVTFlkVNSnVFO1w
	TIQ8NaIipcVIw4n/hxlBYsG1b96j7Lu65u2I7P691pLeUhbOELcanQnb+fBHS4YoyAIY63uBDYb
	ckKh3a+RL7gqgmsnVbCXq0wFcGj7t7W937ezLohOxBGPdt+u3DX+GIAJ83KwL/1cA6T29uZWU0V
	TkcfhTwzBnigg2/qDUcB/NNhmsLa+EFw1vhrCh1yQfQVAMIIsKh7UASgkv0Q1JcU/yHNOx0WJeA
	2uNd9GobikWRCPttlvi6n3zhY4mTtJRljZ3+XBi0D4lGl02xVqNNFmMGzotwO/R0NOOiImpRA6M
	ZbfAJ6AS9weKEtWBi0LyufZo9nZfc0ZscrIvHtOP3odsDRgWkR3IB8spss5kHbN+G3DfkU=
X-Received: by 2002:a17:90b:2e4e:b0:3a0:a515:c450 with SMTP id 98e67ed59e1d1-3a0a515c806mr1763774a91.27.1790271065988;
        Thu, 24 Sep 2026 10:31:05 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:f875:3165:4649:e818])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09733f48fsm6082456a91.11.2026.09.24.10.31.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 10:31:05 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Tom Rix <trix@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 6.1.y] start_kernel: Add __no_stack_protector function attribute
Date: Thu, 24 Sep 2026 13:30:59 -0400
Message-ID: <20260924173100.87358-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
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

From: "ndesaulniers@google.com" <ndesaulniers@google.com>

[ Upstream commit 514ca14ed5444b911de59ed3381dfd195d99fe4b ]

Back during the discussion of
commit a9a3ed1eff36 ("x86: Fix early boot crash on gcc-10, third try")
we discussed the need for a function attribute to control the omission
of stack protectors on a per-function basis; at the time Clang had
support for no_stack_protector but GCC did not. This was fixed in
gcc-11. Now that the function attribute is available, let's start using
it.

Callers of boot_init_stack_canary need to use this function attribute
unless they're compiled with -fno-stack-protector, otherwise the canary
stored in the stack slot of the caller will differ upon the call to
boot_init_stack_canary. This will lead to a call to __stack_chk_fail()
then panic.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94722
Link: https://lore.kernel.org/all/20200316130414.GC12561@hirez.programming.kicks-ass.net/
Tested-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20230412-no_stackp-v2-1-116f9fe4bbe7@google.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Signed-off-by: ndesaulniers@google.com <ndesaulniers@google.com>

[ Backport to 6.1.y: retain this tree's start_kernel() signature, which
  predates its upstream __noreturn annotation, and add
  __no_stack_protector. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and kernel and powerpc maintainers,

I am continuing CVE backports still missing from 6.1.y.
This fix is inherited by v6.6 and every later mainline release, but 6.1.y
still has the affected code. The target-specific adjustment is described
in the bracketed note above.

Could you please queue it for 6.1.y?

Thanks,
Artem Dinaburg

CVE: CVE-2023-53491

Build validation: The touched powerpc allmodconfig objects built
with CONFIG_WERROR=y, and the patched functions had no stack_chk_fail
reference.

AI assistance: An LLM helped find, adapt, and validate this
backport; I reviewed the patch and test output.

 arch/powerpc/kernel/smp.c           |  1 +
 include/linux/compiler_attributes.h | 12 ++++++++++++
 init/main.c                         |  3 ++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 980f2bc832d98d..fa17fdcc55a3de 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1608,6 +1608,7 @@ static void add_cpu_to_masks(int cpu)
 }
 
 /* Activate a secondary processor. */
+__no_stack_protector
 void start_secondary(void *unused)
 {
 	unsigned int cpu = raw_smp_processor_id();
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index ab1fe28162b5e8..b9778e13b0a085 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -277,6 +277,18 @@
  */
 #define __noreturn                      __attribute__((__noreturn__))
 
+/*
+ * Optional: only supported since GCC >= 11.1, clang >= 7.0.
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-no_005fstack_005fprotector-function-attribute
+ *   clang: https://clang.llvm.org/docs/AttributeReference.html#no-stack-protector-safebuffers
+ */
+#if __has_attribute(__no_stack_protector__)
+# define __no_stack_protector		__attribute__((__no_stack_protector__))
+#else
+# define __no_stack_protector
+#endif
+
 /*
  * Optional: not supported by gcc.
  * Optional: not supported by icc.
diff --git a/init/main.c b/init/main.c
index 50b84f1f9ff38a..6acfd5a78bd7a5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -908,7 +908,8 @@ static void __init print_unknown_bootoptions(void)
 	memblock_free(unknown_options, len);
 }
 
-asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
+asmlinkage __visible __init __no_sanitize_address __no_stack_protector
+void start_kernel(void)
 {
 	char *command_line;
 	char *after_dashes;
-- 
2.39.5

