Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3494C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 09:40:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3292221850
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 09:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3292221850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PPzY6dGPzDqGq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 20:40:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PPxv1bmpzDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 20:38:58 +1100 (AEDT)
Received: by mail-qt1-f193.google.com with SMTP id z17so639706qts.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=baqznmx5SEUGlKXy0XWhrYbi7y7TbN73HabOIUzlc9g=;
 b=dCFs/Dlzzz0h+ZF4iKhPCg1ysu57Rxv4l/VBx8cVLI43cD+NuTRvsebEBdy7kT/peV
 MYlUEN6UXp50Xihv8NMs1Bb+1TrVT8IMpqALv+lYb8vR2pt51/7jsA43WxjCyzA0yAmh
 s7IxOrIM+2yTXp6JpGi64tbtURqN++kceICzaWB401Rr/7oEA+7VXk9Ekw93AbxCwiWa
 B3sRy5332j5BNMgjHOH5a2Jdc1f9y50QQXfRP8gmEkhAzMAuoVci1BdGjp8uD5FHhYyw
 2X+R0YjoOJ/QkwReX8Mp/siggJiACAuz1+tYFh8OG638manb2GfyBlcrHJMtwYJduDcO
 PzAg==
X-Gm-Message-State: APjAAAXY0E0JuPz45XBx1S2qneE6BpnSw1cAMcob/wYN4+UkW1WECJa/
 NWZf53QF5c2/kbm8KRzwOnAGdNi73M+EqX75YW8=
X-Google-Smtp-Source: APXvYqy0JoRVFSrNJl/sRu1o+RTIjkEJdtNCtG5nQiriXKN6DBYQFFQrpf5g/fTnXJYyTn69eJne/HE0Vv+ZGAZte2M=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr6073731qth.319.1553074735819; 
 Wed, 20 Mar 2019 02:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQu9hmeSgKO_B1LhXqq9Z923H25HXNS9XYNvFi55WrFYw@mail.gmail.com>
In-Reply-To: <CAK7LNAQu9hmeSgKO_B1LhXqq9Z923H25HXNS9XYNvFi55WrFYw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Mar 2019 10:38:38 +0100
Message-ID: <CAK8P3a0-7LRE4ByO2Uf4tb5mR49SbZzBu0AgHpS=03FAMWFLgQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>,
 X86 ML <x86@kernel.org>, linux-mips@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 20, 2019 at 7:41 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> It is unclear to me how to fix it.
> That's why I ended up with "depends on !MIPS".
>
>
>   MODPOST vmlinux.o
> arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
> sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
> arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined
> references to `mips_gcr_base'
>
>
> Perhaps, MIPS folks may know how to fix it.

I would guess like this:

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 8bc5df49b0e1..a27483fedb7d 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -79,7 +79,7 @@ static inline int mips_cm_probe(void)
  *
  * Returns true if a CM is present in the system, else false.
  */
-static inline bool mips_cm_present(void)
+static __always_inline bool mips_cm_present(void)
 {
 #ifdef CONFIG_MIPS_CM
        return mips_gcr_base != NULL;
@@ -93,7 +93,7 @@ static inline bool mips_cm_present(void)
  *
  * Returns true if the system implements an L2-only sync region, else false.
  */
-static inline bool mips_cm_has_l2sync(void)
+static __always_inline bool mips_cm_has_l2sync(void)
 {
 #ifdef CONFIG_MIPS_CM
        return mips_cm_l2sync_base != NULL;
