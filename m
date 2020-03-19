Return-Path: <SRS0=RfJf=5E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3C0C4332B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 14:23:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693D32080C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 14:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRi61yux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693D32080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48jq043tv1zDr5Y
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 01:23:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=andy.shevchenko@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=nRi61yux; dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48jnyL5TwQzDr7P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2020 00:37:14 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id j10so1433209pfi.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2020 06:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MbaLg9Gua2M3U1asnVDIvDva7tQ41AoreM1Ms+SYaSk=;
 b=nRi61yuxZ0Xq+2Qr8bOpOgW2XtV6fryd3C0G4dMcc9FFEMKfZGwP+P/GAI17pT9cjn
 1lviN+GIEhx3YiHb3db3mmCnPH5CiTFUs0hR3zK+JcRGkonTqxCrgePfWqm24DVtKC+N
 yKBMMLxYkqoQHnxA9hX3R6YTpQhMUTIU2EkMA3FcYmOAraM8BMrIN/BcbR6OXfguc3Aj
 CRtrYhn61Lez9OI9owj8+MzXzOZ3Al2zvlk2n0sipwdqQik013kKza2ByhsQSUvdQQXB
 4hgKnZjY0Rdf9u5ZaK2sdFyVLPpQIw/+/l3IVizC7fEil118v2V60y5p2BgFFHrSbP+x
 N5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MbaLg9Gua2M3U1asnVDIvDva7tQ41AoreM1Ms+SYaSk=;
 b=aa/SaVlrsCXTB1cIPRnboXseVNnAPfOv6o/JC59ak8ePXPKxFxQXHofr/2G5xbQ+Km
 BXVW13GOrsDKWD26CGrSkEbeYudlgXGnlJXrLWaaP7nfDasNGK9WxufjDh4+YJwJePiq
 t60mtvWsJagAnk/6mOfheNqhWFabw6cSLuUbh9jlwq3Stjr1RnCyxSsmVMRALCDKf47n
 Y0atdpGraw0K2IrXiDCOL8W2kJpn43L39G6MJM5f0r036CjNDynoeiMoa4z2WCS+NRx3
 KyKtw10SNtG40SVS9aHMJIPj/ymNf4XBk4DVscnlS7bBzXutzBgRZYQNaBh8O5LuE87b
 mwcA==
X-Gm-Message-State: ANhLgQ3sdN9HGIqM0/gf8ZGyUlfH66e4K5rSYy2uG8WYvv2wY67Jqg/2
 4EVj6DkYC8Ef4qZXWz8Q9JxDn44/MmzS2XH2X3k=
X-Google-Smtp-Source: ADFU+vtAoSv40N/3WnXxvMcn62PtlKa6UP0H140pXfQ3uWlj/cLaUak6oaGVR1tGFhEl0JCb/O0lFMkytGGb/lpOUcA=
X-Received: by 2002:a63:798a:: with SMTP id u132mr3546499pgc.203.1584625031303; 
 Thu, 19 Mar 2020 06:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <cover.1584620202.git.msuchanek@suse.de>
 <5cd926191175c4a4a85dc2246adc84bcfac21b1a.1584620202.git.msuchanek@suse.de>
In-Reply-To: <5cd926191175c4a4a85dc2246adc84bcfac21b1a.1584620202.git.msuchanek@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 19 Mar 2020 15:37:03 +0200
Message-ID: <CAHp75VegYhz-hwSUNHbGFB3yiatAWWytwB7Vctf=mCLyCJEy3Q@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] MAINTAINERS: perf: Add pattern that matches ppc
 perf to the perf entry.
To: Michal Suchanek <msuchanek@suse.de>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>,
 Rob Herring <robh@kernel.org>, Michael Neuling <mikey@neuling.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Allison Randal <allison@lohutok.net>,
 Jordan Niethe <jniethe5@gmail.com>,
 Valentin Schneider <valentin.schneider@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Eric Richter <erichte@linux.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Mar 19, 2020 at 2:21 PM Michal Suchanek <msuchanek@suse.de> wrote:
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v10: new patch
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc8dbe4fe4c9..329bf4a31412 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13088,6 +13088,8 @@ F:      arch/*/kernel/*/perf_event*.c
>  F:     arch/*/kernel/*/*/perf_event*.c
>  F:     arch/*/include/asm/perf_event.h
>  F:     arch/*/kernel/perf_callchain.c
> +F:     arch/*/perf/*
> +F:     arch/*/perf/*/*
>  F:     arch/*/events/*
>  F:     arch/*/events/*/*
>  F:     tools/perf/

Had you run parse-maintainers.pl?

-- 
With Best Regards,
Andy Shevchenko
