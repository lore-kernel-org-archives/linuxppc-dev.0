Return-Path: <SRS0=5fv2=YV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF59CA9EAF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Oct 2019 02:45:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0575420663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Oct 2019 02:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxSmDbo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0575420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 471fG22QMXzDqW1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Oct 2019 13:45:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d43;
 helo=mail-io1-xd43.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rxSmDbo0"; 
 dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 471fCw2cHCzDqT8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2019 13:43:23 +1100 (AEDT)
Received: by mail-io1-xd43.google.com with SMTP id 1so9025095iou.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Oct 2019 19:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WajkIfso2UlXgRkDGGI9iOFobax0DuU9gdm0Iijm/A8=;
 b=rxSmDbo0YmfGeXOIN+Q9biZMXG5q+/XkXO3AjnWZKG9k2QoYsiz7/3dMdXaUmdydtA
 6BWrxQMI0AHuw0nXVv4ks4FtDO7UoGpAD31IjfmfGxPe4Gt//TYkVcJYWnDP1v1jNz+o
 c75oqllYLie1bX5jJdtqgLTrpy7qu3HR3TgrMMT1EF/Lmiodbh/48fx9vULV8AFTCVh4
 fcDqWkceNEwGsW++o1WE2+6Q5BW2nt6F1IKAKdnQqPfjoMyeDjSDkldHsSGNfZ72PjAv
 F/EwrYkqQLRi7CzIaRe56lr3UGRIuZFnStLJw69W5mywrUb9uT2V7KbcbKewcbFnfShe
 B4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WajkIfso2UlXgRkDGGI9iOFobax0DuU9gdm0Iijm/A8=;
 b=G3OPriCFKVh2yxRxtfmQPB5TIupCAc2T/mcMpqRECMAuyiLgSTD0qFuu2ySkb/ZPVY
 gMnTZxt+6JPXDcP23LtLzJinxTIfA25iiG9VAJ19fTbvLxricYTSNG/yxCO6jcUtMP/y
 GkXLEJ9yBSugIcB15trBGAt9SjAPTjA1RnazrLFrj1gDR/eTDAFyAMxMiF6huBe59g0c
 pk4E2h/kSjzkEeDG5/PqG+LTc7wHkLnaIyKGGKQkQeziSdvFPJFTDzcvwz63hMRktqgV
 m6XYXhA6+RrQnahBDa4XcHz5ao3cq9GAkyrSmAbsY0lWycIxTcI+x0lYfDGlgZejkv+K
 j8xQ==
X-Gm-Message-State: APjAAAUKlLHmP69FPgjj7YR2V6zUCFGPjlI74ErhL2pZtS1RHWI6WBUI
 amb80N5+Jx43zEDEsiLPb+LM6rt2wMDT7gOGAJfSsck55LA=
X-Google-Smtp-Source: APXvYqwOWm0fMe4Z+23NbNt4s3moVCNRfSkGYs68cOaCdJ7rNfZZA3zAvx6xOt8t6pKut1UDb6mLgbG5D1F93mKzz20=
X-Received: by 2002:a5d:8247:: with SMTP id n7mr8103790ioo.195.1572230600541; 
 Sun, 27 Oct 2019 19:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-10-alastair@au1.ibm.com>
In-Reply-To: <20191025044721.16617-10-alastair@au1.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Mon, 28 Oct 2019 13:43:09 +1100
Message-ID: <CAOSf1CGwuAkeayfk0uowN8gkKXWy8jKzgLX5-Gxxqn3ENNiUdA@mail.gmail.com>
Subject: Re: [PATCH 09/10] powerpc: Enable OpenCAPI Storage Class Memory
 driver on bare metal
To: "Alastair D'Silva" <alastair@au1.ibm.com>
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
Cc: Andrew Donnellan <ajd@linux.ibm.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, alastair@d-silva.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 25, 2019 at 3:51 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> From: Alastair D'Silva <alastair@d-silva.org>
>
> Enable OpenCAPI Storage Class Memory driver on bare metal
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  arch/powerpc/configs/powernv_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index 6658cceb928c..45c0eff94964 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -352,3 +352,7 @@ CONFIG_KVM_BOOK3S_64=m
>  CONFIG_KVM_BOOK3S_64_HV=m
>  CONFIG_VHOST_NET=m
>  CONFIG_PRINTK_TIME=y
> +CONFIG_OCXL_SCM=m

> +CONFIG_DEV_DAX=y
> +CONFIG_DEV_DAX_PMEM=y

These should probably be modules. Having them as builtins will force
their dependencies (i.e. libnvdimm) to be built into the kernel too.

> +CONFIG_FS_DAX=y
> --
> 2.21.0
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
