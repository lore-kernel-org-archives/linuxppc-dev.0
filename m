Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76CFC282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 15:47:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04CC222CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 15:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04CC222CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44m0j046HSzDqTg
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 01:47:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44m0gH5pD0zDqT1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 01:45:45 +1000 (AEST)
Received: by mail-ot1-f66.google.com with SMTP id c16so4655649otn.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 08:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rgm+DlPYj4YwXD0IUlXbIhCkCaP4ItKaQlGxc47GSHs=;
 b=e7KNZQhlIJJ2nMwEbD5JuO/qZFZovAZYh8UUPmsliK0H1n8SBbwRSbj5N440jZQz+L
 4L8yAh4Hh0DO8iUqR0tBJVlXFGxqn0PLmoUqAoHhqlSs11woUvPVzzFEDIcw622QIzfJ
 Ou2qXRxFl+WV6FvQXRTF9EQ5bKpkkUuhsyq+z2vN0XeFJuHv56sUNnNzsRq50+6i0F3d
 PaYz9APAxRH0Yo8ZkYzSEyEKBkd+TCcu3+mhvAt005URhGtIJrHYQV2/1iKnVTeyMOYm
 zOwvHGGNtqoXTMgvP8DCmS3wwHPOcK5cClwmWR7PYCPXPi7jNgqALWjNs7QcAeuyirOm
 GEOw==
X-Gm-Message-State: APjAAAWOpSbmF8b9kCMJSiK5MmBHQEKEtweWB1a/WDMWr/QX5G7rio7w
 wwBGomQ7OWYY7m4u0/bOTeZ1H8NfhUMBcPS0HqI=
X-Google-Smtp-Source: APXvYqyzS5bhws5CT7A5nXn4OpfeWT4dvhjZS6lwiZnWt+A2qa8xQlOemhAXzlKYNBL6JXPtGyLamsLnBS+1CfuvVbc=
X-Received: by 2002:a9d:7dda:: with SMTP id k26mr2666597otn.354.1555688742221; 
 Fri, 19 Apr 2019 08:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
 <20190419094754.24667-7-yamada.masahiro@socionext.com>
In-Reply-To: <20190419094754.24667-7-yamada.masahiro@socionext.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 19 Apr 2019 17:45:31 +0200
Message-ID: <CA+7wUsygTo=AN_giku_X6_a4mQWdJL48RoVbVB4hBqkZSKkP0Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] MIPS: mark __fls() as __always_inline
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-mtd@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Fri, Apr 19, 2019 at 12:06 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> place. We need to eliminate potential issues beforehand.
>
> If it is enabled for mips, the following errors are reported:
>
> arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
> sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
> arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined references to `mips_gcr_base'

Tested with success on ppc32/G4. But on CI20 (ci20_defconfig from
master), I get:

  MODPOST vmlinux.o
mipsel-linux-gnu-ld: arch/mips/kernel/traps.o: in function
`addr_gcr_err_control':
/home/mathieu/tmp/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:169:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld:
/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:169:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld: arch/mips/mm/sc-mips.o: in function
`addr_gcr_l2_pft_control':
/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld:
/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld:
/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld:
arch/mips/mm/sc-mips.o:/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
more undefined references to `mips_gcr_base' follow


> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - new patch
>
>  arch/mips/include/asm/bitops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
> index 830c93a010c3..6a26ead1c2b6 100644
> --- a/arch/mips/include/asm/bitops.h
> +++ b/arch/mips/include/asm/bitops.h
> @@ -482,7 +482,7 @@ static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *
>   * Return the bit position (0..63) of the most significant 1 bit in a word
>   * Returns -1 if no 1 bit exists
>   */
> -static inline unsigned long __fls(unsigned long word)
> +static __always_inline unsigned long __fls(unsigned long word)
>  {
>         int num;
>
> --
> 2.17.1
>
