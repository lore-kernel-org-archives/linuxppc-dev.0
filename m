Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F481C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 05:49:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B962082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 05:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="DoWYQ+fT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B962082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433GFL6hqgzDqNL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 16:49:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="DoWYQ+fT";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::b44; helo=mail-yb1-xb44.google.com;
 envelope-from=keescook@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="DoWYQ+fT"; 
 dkim-atps=neutral
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433GBV1733zDqMw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 16:46:35 +1100 (AEDT)
Received: by mail-yb1-xb44.google.com with SMTP id u103-v6so7003127ybi.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2018 21:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OPYJrPbi4xgHLG3J68EW2anneGmN+RcxUCwe6o68Pu8=;
 b=DoWYQ+fTrFcvi2iyqm3DXUSlW8aom8xJtbQL/YYSjslZrSIjWwlZ2fYSQJi6A3etI3
 semQgPpK03B2+6wW8CT0vkrSJsqvkTN3G7rzAVGMufi1rl54nX8hrtmV5Ufgl0lCLqxL
 SUaEr0GfNh+wWwU13oFJiL/qEedUJHudEsWSzuANlSQFBSFnu/mtt8TeNV0vaXthPdvM
 D5P8jigwRerV4nLNHVMsKZEx2PVuysagqwKIC4oGXwR+3XbQPywmvOn2vOBUcO1pWQPA
 jj1SX0N7UT3qoJFakNPYyFy1E+hE9CYFSW75hh2DYvgxcLeVyNcG3qcUIjCz/0WRx4h7
 xttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OPYJrPbi4xgHLG3J68EW2anneGmN+RcxUCwe6o68Pu8=;
 b=A0OTu6bMKnzSVIAQQjrPJH26nnB4WNb2WIL0+62Zie52Ur8VHdg1JR6cR193pE4pfj
 ix4nMQKwOh4mwZ/P9bzE8neHeVuIeaqlynXpxEoWZVpSbw/BUJskU6PreFlttaA51eeH
 SCSKIxcdCcC8WKM2vzakLSL3s51vgJr/NWyCEni5WN3WyNUr2BshI/QZOeDWr9hoMZGy
 s/e9TtWPlSpPA1vsMdHvUWTH4iYvzOvwR7bnqHLvjFNVB6u4qZmLtTfs74kaddSvUioW
 Q2hP+hv3Sullc+5n7tTFOS8K3HqiKgSmrUX7RclTVcwtd/8qrpebshpt+/kYdqvxD9/L
 KN9g==
X-Gm-Message-State: AA+aEWaZxY0Mt3GQFU03pDoVo22CgOqqXX8lIxEzdy7Ko3Ykn6AnTVVm
 5oVD1Hugr+HNTU1VlsLeOFlZf9edoPXC9uSHHzXOug==
X-Google-Smtp-Source: AFSGD/VuUdh7lo/hG/IRhvrwhnsPVUaeNVbh3D3FkAD5a/PAwEFuBHtnGslGKNTJY5GYXlqB/p0kEBgWFH2pTSQyEtk=
X-Received: by 2002:a25:7644:: with SMTP id
 r65-v6mr21732566ybc.403.1543211192468; 
 Sun, 25 Nov 2018 21:46:32 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jL9WDRVCzPP0V2cvFHWfwAfd74kBNX9O+0frFkD26ti1Q@mail.gmail.com>
 <20181126084841.13679afd@canb.auug.org.au>
In-Reply-To: <20181126084841.13679afd@canb.auug.org.au>
From: Kees Cook <keescook@google.com>
Date: Sun, 25 Nov 2018 21:46:20 -0800
Message-ID: <CAGXu5jL38a1Tx_LW9_j0sEHwLFGpuX-r2Y7dJq32eoED8BFrhw@mail.gmail.com>
Subject: Re: New linux-next KCFLAGS
To: Stephen Rothwell <sfr@canb.auug.org.au>
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Nov 25, 2018 at 1:48 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Kees,
>
> On Fri, 26 Oct 2018 01:34:33 +0100 Kees Cook <keescook@google.com> wrote:
> >
> > So, if you it's possible to "seed" some new flags for linux-next, I'd
> > be interested in making sure no new instances of warnings from
> > -Wimplicit-fallthrough (gcc 7.1 and later) appear. VLAs will be gone
> > in a couple days, so I'm currently only interested in killing implicit
> > fallthroughs[1] now. There are hundreds of cases remaining, so ignore
> > those on the first build, but anything NEW is what I'd like to get
> > maintainer nags sent for (CCing myself and Gustavo Silva would be
> > especially nice, too).
>
> I don't know Gustavo's email address ...
>
> > Thanks!
> >
> > [1] Gustavo has fixed lots of actual bugs as part of this work:
> >      https://lkml.kernel.org/r/1f64449a-ef19-20c8-f8cb-7e629f8fe71b@embeddedor.com
>
> I finally got around to this.  I have added the following patch to my
> fixes tree (which is merged immediately after Linus' tree).

Excellent! (Though, wait, does this mean everyone _else_ will see this
too? I'm worried that will be way too noisy...)

> FYI, I am currently ignoring 659 such warnings in Linus' tree ...

That sound about right. Before Gustavo started there maybe 1000 more. (!) :)

Thanks!

-Kees

> commit 4d8360ade996cf1823e570544791c9d7bd660ffb
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Mon Nov 26 07:58:34 2018 +1100
>
>     Check for new cases of implict fallthrough
>
>     for Kees
>
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
> diff --git a/Makefile b/Makefile
> index ddbf627cad8f..380164f590bc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -804,6 +804,9 @@ KBUILD_CFLAGS += -Wdeclaration-after-statement
>  # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
>  KBUILD_CFLAGS += $(call cc-option,-Wvla)
>
> +# Check for implict fallthroughs
> +KBUILD_CFLAGS += $(call cc-option,-Wimplicit-fallthrough)
> +
>  # disable pointer signed / unsigned warnings in gcc 4.0
>  KBUILD_CFLAGS += -Wno-pointer-sign
>
>
> Unfortunately, some of the kernel is built with -Werror, so I have had
> to add the following patch as well just to build Linus' tree:
>
> (I just marked them as "fall through", I am not sure if that is the
> correct resolution.)
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 26 Nov 2018 08:32:39 +1100
> Subject: [PATCH] powerpc: tag implicit fall throughs
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/kernel/nvram_64.c            | 1 +
>  arch/powerpc/platforms/powermac/feature.c | 1 +
>  arch/powerpc/xmon/xmon.c                  | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index 22e9d281324d..06e2eda2430e 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -809,6 +809,7 @@ static long dev_nvram_ioctl(struct file *file, unsigned int cmd,
>  #ifdef CONFIG_PPC_PMAC
>         case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
>                 printk(KERN_WARNING "nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
> +               /* fall through */
>         case IOC_NVRAM_GET_OFFSET: {
>                 int part, offset;
>
> diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
> index ed2f54b3f173..a7ec06876b53 100644
> --- a/arch/powerpc/platforms/powermac/feature.c
> +++ b/arch/powerpc/platforms/powermac/feature.c
> @@ -1471,6 +1471,7 @@ static long g5_i2s_enable(struct device_node *node, long param, long value)
>         case 2:
>                 if (macio->type == macio_shasta)
>                         break;
> +               /* fall through */
>         default:
>                 return -ENODEV;
>         }
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 36b8dc47a3c3..308326f8b7ed 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -4033,6 +4033,7 @@ static int do_spu_cmd(void)
>                 subcmd = inchar();
>                 if (isxdigit(subcmd) || subcmd == '\n')
>                         termch = subcmd;
> +               /* fall through */
>         case 'f':
>                 scanhex(&num);
>                 if (num >= XMON_NUM_SPUS || !spu_info[num].spu) {
> --
> 2.19.1
>
> --
> Cheers,
> Stephen Rothwell



-- 
Kees Cook
