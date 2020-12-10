Return-Path: <SRS0=IADO=FO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FCDC433FE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 09:08:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CEF22C7D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 09:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CEF22C7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cs7Pw45KKzDqkC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 20:08:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.167.194;
 helo=mail-oi1-f194.google.com; envelope-from=geert.uytterhoeven@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cs7Mv54ykzDqhH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2020 20:07:04 +1100 (AEDT)
Received: by mail-oi1-f194.google.com with SMTP id p126so4978179oif.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2020 01:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aoVanH6PpJItaGusWTgG8SDNfnDJUsCWIBki9TqzoFs=;
 b=lO2P/znD/ftQBZvY/1wB72evJDcvuCLeUB50QM7VABMJ+Y8VEj4S5d8rOsCEMZGcgE
 ZmaC3gZnNHt0jdNgxOdd5euUhrygEnzRGrSinOaP3/mrXLk4KbALipy8m6ZFgFmgZEXL
 /i+SUxU6sTUto5fvb6muIPeCwmFDuEYxKr8ja/AuKpRAc/x8iDI0rpiaGJhQZ6YYLt+F
 kuVwlk5+rGZn8h05CK77Y0CMWfkPEna05FNaoh68bWby5vriBPVyshI98kLKXuI2mG3n
 KwL0DjA3FJCyY4YJakQ5q5VP4y/1ZbtmRfjt4jNk7UmDSMGzDPKpkGAhejH3peG7ZlxS
 kyMw==
X-Gm-Message-State: AOAM530mMcC19JLRPnvvPUf9YTXrFsls/ya27fQiUm/T4/lAPwWYIfGc
 LS1+ZByPNNppr9w7WFxxaL5YaUkoEZNEgT+KZbA=
X-Google-Smtp-Source: ABdhPJzf0knRERLR8YZ9NOPlwbDHfzdOFzLG3U//gA4Oz4mzugiWqtafnbqK+P57McZqu6A2QdWTyRu7WWlaN6pAFJI=
X-Received: by 2002:aca:5c08:: with SMTP id q8mr4829513oib.54.1607591221309;
 Thu, 10 Dec 2020 01:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20201120025757.325930-1-npiggin@gmail.com>
 <20201120025757.325930-3-npiggin@gmail.com>
In-Reply-To: <20201120025757.325930-3-npiggin@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Dec 2020 10:06:50 +0100
Message-ID: <CAMuHMdUdorW03=mipgm92SXNPBZO5owW1Wp6_SacRDZ7fOe9gw@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64s: Trim offlined CPUs from mm_cpumasks
To: Nicholas Piggin <npiggin@gmail.com>
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
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Anton Vorontsov <anton.vorontsov@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Nicholas,

On Fri, Nov 20, 2020 at 4:01 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> When offlining a CPU, powerpc/64s does not flush TLBs, rather it just
> leaves the CPU set in mm_cpumasks, so it continues to receive TLBIEs
> to manage its TLBs.
>
> However the exit_flush_lazy_tlbs() function expects that after
> returning, all CPUs (except self) have flushed TLBs for that mm, in
> which case TLBIEL can be used for this flush. This breaks for offline
> CPUs because they don't get the IPI to flush their TLB. This can lead
> to stale translations.
>
> Fix this by clearing the CPU from mm_cpumasks, then flushing all TLBs
> before going offline.
>
> These offlined CPU bits stuck in the cpumask also prevents the cpumask
> from being trimmed back to local mode, which means continual broadcast
> IPIs or TLBIEs are needed for TLB flushing. This patch prevents that
> situation too.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Thanks for your patch!

> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -911,6 +911,8 @@ static int smp_core99_cpu_disable(void)
>
>         mpic_cpu_set_priority(0xf);
>
> +       cleanup_cpu_mmu_context();
> +

I guess this change broke pmac32_defconfig+SMP in v5.10-rc7?

arch/powerpc/platforms/powermac/smp.c: error: implicit
declaration of function 'cleanup_cpu_mmu_context'
[-Werror=implicit-function-declaration]:  => 914:2

http://kisskb.ellerman.id.au/kisskb/buildresult/14423174/


>         return 0;
>  }
>
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index 54c4ba45c7ce..cbb67813cd5d 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -143,6 +143,9 @@ static int pnv_smp_cpu_disable(void)
>                 xive_smp_disable_cpu();
>         else
>                 xics_migrate_irqs_away();
> +
> +       cleanup_cpu_mmu_context();
> +
>         return 0;
>  }
>
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index f2837e33bf5d..a02012f1b04a 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -90,6 +90,9 @@ static int pseries_cpu_disable(void)
>                 xive_smp_disable_cpu();
>         else
>                 xics_migrate_irqs_away();
> +
> +       cleanup_cpu_mmu_context();
> +
>         return 0;
>  }
>
> --
> 2.23.0
>


--
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
