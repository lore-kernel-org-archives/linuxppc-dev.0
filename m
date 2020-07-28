Return-Path: <SRS0=cpv1=BH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FD7C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 08:12:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E93720656
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 08:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNG6JL/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E93720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BG8YF5fxpzDr7b
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 18:12:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=jcmvbkbc@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=bNG6JL/O; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BG8VS15sZzDr4F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2020 18:10:00 +1000 (AEST)
Received: by mail-pj1-x1044.google.com with SMTP id c6so4500542pje.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2020 01:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mO4UW6jhce2IwLYWJIjyNoNVa+Gr5PBQ2rV1LkhhIeA=;
 b=bNG6JL/O5TVQki3sHfHEOfTczEIMUXR0OLqZGWSVnVXN0YvSLXQj4R1CZin1hIrLmj
 rDRSSHKktD8YAK18dQ3Ix7Lo07yJ8erIxBxxxxqVLyUXKDeyjbkBvyU6KTuEXDNL+VQr
 1QQzuFpqB0CYmf+5pX3A4eJDz9R/FeezQPycBuGnXY4EFLSYZVijwWE1t6E2M5B99qAH
 FniHRX5RxN1gZw65OKCdqnG/UzIrS3ICQ278hYR6IoGyzyd6ykow+PajTtCN7ldzFD83
 Hcz6o03i9dPHjv0yz+B7ucVCSupfsp/DKM7XkQQq14g4beE60uqTFBLLU79wWmkWweg4
 xE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mO4UW6jhce2IwLYWJIjyNoNVa+Gr5PBQ2rV1LkhhIeA=;
 b=f5bgY1Gy92+FWM4IniqgGfwF1oem7uKT/pwxQqKNKbcinHlntoceQ1miXuZwa4hzaB
 opBPL3MXyrcvAGUXCI/wqRwmNTjf8F5aCxUK3IFGGi//5h+sUJ2DjL6FZTI1Vzoyo2Re
 dFg1V5+LWm2RNgFORZxd7C0rjInFsQHM0ipeLVi50OVuvJ55FkIluMHNiXBdWN8eOsrn
 hYy5WhcN7y3gGO8xnW+Khb9L2WxYxNhmfqMbnehoeLcFmnlhC4vQfjZ6EE2dndHq89Ac
 iEtsbSdeTBhTbmdGNWm6FQFWQVdpTSLuX8avTzxMQOFdBzojoOZ+bkF39xWFSUxpuRVp
 QuRg==
X-Gm-Message-State: AOAM530DHyD19sA7i2OB2GMxJZCrwX1oMMqTi3Cs79Wry0szhBBHG85c
 jfSWEXPRXA0nhne7o2znK1cnQLIgu1p8XHFjvOA=
X-Google-Smtp-Source: ABdhPJwl2tr9ClL3asn7D0daWCLxpbWcicGBHl3RglmUadciWpYNtKvtb4F0xzOXS215QqSA9z2se3QNEhc8iGYlMEA=
X-Received: by 2002:a17:90a:8918:: with SMTP id
 u24mr3082134pjn.7.1595923796912; 
 Tue, 28 Jul 2020 01:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-4-rppt@kernel.org>
In-Reply-To: <20200728051153.1590-4-rppt@kernel.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 28 Jul 2020 01:09:45 -0700
Message-ID: <CAMo8Bf+VKHmAm1GV=0D9Um2mpsxjnwp9WrAJq_eKW1MK+_8r6g@mail.gmail.com>
Subject: Re: [PATCH 03/15] arm,
 xtensa: simplify initialization of high memory pages
To: Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "open list:SUPERH" <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>,
 "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
 Stafford Horne <shorne@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 "open list:TENSILICA XTENSA PORT \(xtensa\)" <linux-xtensa@linux-xtensa.org>,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jul 27, 2020 at 10:12 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> The function free_highpages() in both arm and xtensa essentially open-code
> for_each_free_mem_range() loop to detect high memory pages that were not
> reserved and that should be initialized and passed to the buddy allocator.
>
> Replace open-coded implementation of for_each_free_mem_range() with usage
> of memblock API to simplify the code.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm/mm/init.c    | 48 +++++++------------------------------
>  arch/xtensa/mm/init.c | 55 ++++++++-----------------------------------
>  2 files changed, 18 insertions(+), 85 deletions(-)

For the xtensa part:
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
