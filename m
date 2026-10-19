Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFF606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mMWcbiw0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7qyc3H0yz2y7r;
	Tue, 20 Oct 2026 09:31:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::122e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792449080;
	cv=pass; b=j4LZc8Fq6uk5Hpz3KiafZTzGi5fL7ee6LlYS5zKpUIieA6T/8QsYL5N+Q5iuQ9gZ5Hkf01C/RlkM2IqTky67TpRRG2bi6GLezn3SoK36I4jgQHjc4k86HbuYuLqRwoTvjX4oUFU4VO+0sXBitZ+/idOxeJq6npVrtq/eKIGC4lTEcJMllptO/f9imm/NInLBmBjcxsbMmRxGbxT7vtxt6++/HmZApsbaxXYEmd+OGubxySdmnM40tfGSUftznw85xg62rjlUj4vgkONArqCdUsJpgXj/HAD7zzLihsSMVShFlVNjNoYwvHFtziTYGQhFGpkheB+0ERNkbhQRhogmpw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792449080; c=relaxed/relaxed;
	bh=7Y7YiwpHnHRTlx4OY6pg4GKzGSuy4/quEwIOKfF9VTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbjIBktxfAhYFpx1unSwsmfe+50n9jOs73RjsBWaohkW+DtHFBeSJCS2AFAzDbivYWsCBeF1B0cH/i9e2P335T0W8IUoBw7sQShsHT4PoHWfs9hBKXK8QCa4GQmbPifidenpqvC0B4XRRrnX5FeLLSSIgZAJcBIZVRSujMZaa14QRY5ADYr/L5rdF4imgI6u19vYMtepm8HXLnD8XL9mAD+AoVu83/9jvJuZsq4rz/0c1dD26X4piPc6h1vqotcCUeHnYsi/jRX99fpmSjWARYQNfTf5AXcQzKXfm0NSbGy68mgQOE7ICKcIpHdcoS94JuHxtg5xIcrz3GthpQ182g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mMWcbiw0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com; envelope-from=elver@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mMWcbiw0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com; envelope-from=elver@google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com [IPv6:2607:f8b0:4864:20::122e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7qyZ5VSfz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 09:31:18 +1100 (AEDT)
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1517bda04a0so2159670c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 15:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792449075; cv=none;
        d=google.com; s=arc-20260327;
        b=pIuJ1xyKWsYCGGKksy9qMlK1Tou4kNc5E6ggkl6apsqKvdypIWZOk+4yFVQ51LJprO
         aWcSkjSnVUH/uzENY0HTETf6OhCcNyTbtndchfqTN2MyuBBVDJjbCGCB3XKr1zXPFw4N
         qDIRaeUPZRtIDW5YI4ae48eOqR+qbzwXqi8hUagENyiB88BDsD8Mva8JhNwKqKSnAOp+
         XF51nzONGV36yZWpY8TZ+Ve6/Rdbu0vxoS+ngOZI6IOoUKJqfhB20mePkhSsfLQVjVe8
         WsVIslBCtRBdq9jQGdNCdH6mCb+rqzv/pDLkg7jnZLBPZmGE0IootxUMO9P81g3Je+2U
         HHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7Y7YiwpHnHRTlx4OY6pg4GKzGSuy4/quEwIOKfF9VTA=;
        fh=WX5rgOAvO1+XCh6ri+ZZ6KEPW3WkmEBuyoTjCNLIqBo=;
        b=rVzQcllMzkDRqIN5Cf+zftUdHgE252jiuc1nsBw+raCLv0X/N1drf7Z8OuMp8yRwXG
         nHtdkcR7md+1I3lXIdE7CnCSBbzwJcXVRpDfuV2FG4W1hG+FzKg0XFjZ4ML7a6dUd6/U
         WD+4l5cSpCsST9U5465zH/O0j1MukV31hRVVEiqkBu5h6DshsSuztuHUU4o9+C7g3C31
         Z9uxSdbhlelk8w0sA72YZTbeVrvdCj9cbJpp2Wx+FfOplqblHntQ9nbjRp/mThwDNg/B
         iw0I0USELoTKMBQFGxrAsWzEgxtFEF0wEuVzwlaPfUwVtAmR7CsGmkmpjODDlaSCFXvE
         IOhA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792449075; x=1793053875; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Y7YiwpHnHRTlx4OY6pg4GKzGSuy4/quEwIOKfF9VTA=;
        b=mMWcbiw073H3KN36Ob6q2mVnKW32hieHqOREUmZRP7GS4Km9R4tHwF7LWGc7SjkeA+
         jRV7i8P6fMNGYvUfyqBVlN0esUOY4y73tuEdsSX8tBChG46BU76mV0zgv1cbpcjxGuI+
         13+t5oYuWmFKUE0Bgh2pOEJFnapZzMj532BKdiBB8fQlxRv/K4vvV+ps7MHsPdOjgYtj
         DrWCJ4EjrES9feNHFzgZnPBOq2IK1X6pSdz8F8tXYW7bDMrynD9JtmcwxNpRV9s+MjEB
         0b6bWdWwBqBqXC/06MokgZw9SbIRhJbW84BNBJBfO5AoZOK48XnTVXeHWv+FlDwsiu9/
         IXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792449075; x=1793053875;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Y7YiwpHnHRTlx4OY6pg4GKzGSuy4/quEwIOKfF9VTA=;
        b=kqMQiofAn8BkpwAqc14zR7M87AVYtfCR4m7Jae5HFBgRgTE21d6NjwSOe4Hcv0XAJa
         PikoeLtoUD6ZhUrfm4ieUstuD/dvREBzTrsDsaUK/c6Qs0VNlKGyaYb3c+vzWx8sODt9
         za/Z93Bef299tjdK4i+GMakj0eY7xR0qJU4tqpJenxILssxz0r2aomphmacggfs6fzsE
         eCF59IlxJrgTNtFMb1sBB5q4zlAdGr/XTln2eC5g2WGyO6464ZE1uWM8nRHpAHSegEMV
         STAQz3Ny7PYaw1qoTDMAu3GRgC2arHsAz7/Yz1gRjY926/5HJr36Des30vyBqX4LBCQm
         0ifQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCzvxbHxfW7w6URnDgVeTt48+LbMLfjszNUNGly/mqUNM8vvp+DzlcbtnljocoZcn1ZL076D8rJXrhm2U=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIDQNVFbToEFQXMx8PE1G66chzEorO4OZXHxi4EeFffccWXEAkC
	VvRlQOH0+Ydo1nfEf0sNg+rTs/WoMyA2kCGA40MQ9nWouUV1E3O0jUGxMmw6/pm2oUXEe/q8Mcr
	SbmNbt48savp/2H7YYBBXDfdTgvzNIOw7Bhol8CIn
X-Gm-Gg: AYBFou3gnuf7f+hMs4FBAKiZIURaRHUl9sqBICyFA1xPUGFHfI3mWTQFZH7C4fG1Xc0
	7VDGK20VGFrQ91Yi05BVdGhALn7M9eV6v6cSo5W6HEwb5hfP4G0B/6IPKIfiABkUYjNg6SsGotX
	xLa+sIY+uHy+ywBVhAYRqM016Q4O0NJ3hZGHB/0bDtw59hqZclCyDzo3VUcXICjps8eaHeR5uRo
	r4XCjvzJKtRBCizcMjAuVALzPTvlM5kyR1kegaJLUgneNBTv/46/uk0qvj9cJCfH9cuvLFt8AyN
	KV1RaFfwlHbOFYn7FGUODwDfF1boRIo6FkScXgGbVxgOL1ZDM/HaSCIinmT3Jqdb3Nwu4pu8K17
	ntk5C1paCCvQTtxNeceAsmfcyYeerCOZN4cTPu8I0PCBDKXwck7kRsVD7+KcQWoAmgYIS
X-Received: by 2002:a05:701b:42cb:10b0:169:b1b1:1445 with SMTP id
 a92af1059eb24-18512e2515fmr12984330c88.31.1792449074316; Mon, 19 Oct 2026
 15:31:14 -0700 (PDT)
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
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 20 Oct 2026 00:30:37 +0200
X-Gm-Features: AclHuK-9KfyXQ0m8f9CHsU2jTa1lgiXB2sNpwhyCmDMarQWZL2s0qBm4al6Ih6c
Message-ID: <CANpmjNPPncfo41Hu=TKB8cd1aFm0Lm-9+AT6pXVsYyUgFVx8TQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Peter Collingbourne <peter@pcc.me.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 at 03:58, Qiliang Yuan <odys.yuan@gmail.com> wrote:
>
> load_unaligned_zeropad() reads a word that may run into an unmapped
> page and recovers through an exception fixup. It does the word loads of
> sized_strscpy() and of the name compare in dentry_string_cmp(), path
> components in hash_name() and hashlen_string(), and the trailing bytes
> in x86's csum_partial().
>
> It is inline assembly on every architecture that implements it, so
> KASAN and KCSAN never see these loads, while read_word_at_a_time() at
> least checks the first byte of each word. A use-after-free or
> out-of-bounds read of a name handed to path lookup goes unreported, and
> so does strscpy() reading from a bad source, which the kasan_strings
> KUnit case expects to be reported. On x86_64 with generic KASAN:
>
>   KASAN and string KUnit suites      failures
>                                   before    after
>   CONFIG_FORTIFY_SOURCE=n              1        0
>   CONFIG_FORTIFY_SOURCE=y              1        0
>
> Check the first byte at the start of load_unaligned_zeropad() on every
> architecture, as read_word_at_a_time() does. All callers only load a
> word whose first byte belongs to the string or buffer they read, so
> the check does not flag their intended reads past the end. Add no-op
> stubs for the powerpc selftest that builds the header in user space.
>
> Suggested-by: Peter Collingbourne <peter@pcc.me.uk>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>

Thanks!

> ---
>  arch/arm/include/asm/word-at-a-time.h                           | 7 +++++++
>  arch/arm64/include/asm/word-at-a-time.h                         | 7 +++++++
>  arch/powerpc/include/asm/word-at-a-time.h                       | 6 ++++++
>  arch/riscv/include/asm/word-at-a-time.h                         | 6 ++++++
>  arch/s390/include/asm/word-at-a-time.h                          | 6 ++++++
>  arch/x86/include/asm/word-at-a-time.h                           | 6 ++++++
>  tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h | 3 +++
>  tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h | 3 +++
>  8 files changed, 44 insertions(+)
>
> diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
> index 5023f98d8293d..f672aad2e30e6 100644
> --- a/arch/arm/include/asm/word-at-a-time.h
> +++ b/arch/arm/include/asm/word-at-a-time.h
> @@ -56,6 +56,9 @@ static inline unsigned long find_zero(unsigned long mask)
>  #include <asm-generic/word-at-a-time.h>
>  #endif
>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +
>  #ifdef CONFIG_DCACHE_WORD_ACCESS
>
>  /*
> @@ -69,6 +72,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret, tmp;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         /* Load word from unaligned pointer addr */
>         asm(
>         "1:     ldr     %0, [%2]\n"
> diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
> index 824ca6987a516..11ecca99057aa 100644
> --- a/arch/arm64/include/asm/word-at-a-time.h
> +++ b/arch/arm64/include/asm/word-at-a-time.h
> @@ -40,6 +40,9 @@ static inline unsigned long zero_bytemask(unsigned long bits)
>  #include <asm-generic/word-at-a-time.h>
>  #endif
>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +
>  /*
>   * Load an unaligned word from kernel space.
>   *
> @@ -51,6 +54,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         __mte_enable_tco_async();
>
>         /* Load word from unaligned pointer addr */
> diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
> index 54653a8634149..49c6a1f65c493 100644
> --- a/arch/powerpc/include/asm/word-at-a-time.h
> +++ b/arch/powerpc/include/asm/word-at-a-time.h
> @@ -5,6 +5,8 @@
>   * Word-at-a-time interfaces for PowerPC.
>   */
>  #include <linux/bitops.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  #include <linux/wordpart.h>
>  #include <asm/asm-compat.h>
>  #include <asm/extable.h>
> @@ -168,6 +170,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret, offset, tmp;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         asm(
>         "1:     " PPC_LL "%[ret], 0(%[addr])\n"
>         "2:\n"
> diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
> index 3802cda71ab7e..fb7e2904dd7fd 100644
> --- a/arch/riscv/include/asm/word-at-a-time.h
> +++ b/arch/riscv/include/asm/word-at-a-time.h
> @@ -11,6 +11,8 @@
>
>  #include <asm/asm-extable.h>
>  #include <linux/bitops.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  #include <linux/wordpart.h>
>
>  struct word_at_a_time {
> @@ -60,6 +62,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         /* Load word from unaligned pointer addr */
>         asm(
>         "1:     " REG_L " %0, %2\n"
> diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
> index eaa19dee76994..59393cf065964 100644
> --- a/arch/s390/include/asm/word-at-a-time.h
> +++ b/arch/s390/include/asm/word-at-a-time.h
> @@ -3,6 +3,8 @@
>  #define _ASM_WORD_AT_A_TIME_H
>
>  #include <linux/bitops.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  #include <linux/wordpart.h>
>  #include <asm/asm-extable.h>
>  #include <asm/bitsperlong.h>
> @@ -52,6 +54,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long data;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         asm_inline volatile(
>                 "0:     lg      %[data],0(%[addr])\n"
>                 "1:     nopr    %%r7\n"
> diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
> index 422a47746657a..1319e1d87a9c4 100644
> --- a/arch/x86/include/asm/word-at-a-time.h
> +++ b/arch/x86/include/asm/word-at-a-time.h
> @@ -3,6 +3,8 @@
>  #define _ASM_WORD_AT_A_TIME_H
>
>  #include <linux/bitops.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
>  #include <linux/wordpart.h>
>
>  struct word_at_a_time {
> @@ -71,6 +73,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>         unsigned long ret;
>
> +       /* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
> +       kasan_check_read(addr, 1);
> +       kcsan_check_read(addr, 1);
> +
>         asm volatile(
>                 "1:     mov %[mem], %[ret]\n"
>                 "2:\n"
> diff --git a/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h b/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h
> new file mode 100644
> index 0000000000000..000c92de6baf2
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* There is nothing for KASAN to check in user space. */
> +#define kasan_check_read(p, size)      ((void)(p), (void)(size))
> diff --git a/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h b/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h
> new file mode 100644
> index 0000000000000..39c97bc15531e
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* There is nothing for KCSAN to check in user space. */
> +#define kcsan_check_read(p, size)      ((void)(p), (void)(size))
>
> --
> 2.43.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477%40gmail.com.

