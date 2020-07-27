Return-Path: <SRS0=cpv1=BH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35035C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 00:01:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814E220729
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 00:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV9jS8xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814E220729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BFxfJ5Pq4zDqlL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 10:01:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::143;
 helo=mail-il1-x143.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=QV9jS8xG; dkim-atps=neutral
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BFxbr0Bz1zDqg7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2020 09:59:03 +1000 (AEST)
Received: by mail-il1-x143.google.com with SMTP id p16so3879331ile.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2020 16:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=40PEaev2AR89A76wIRPh9VfSUB5wAXw9k1uNgC1xL9I=;
 b=QV9jS8xGVpXS1MnzL+IOlUZ00NhuszDykNVROAl12nkRTkPSRJLf8LWBy7IRcQeBX5
 Q7f1VxShoP8ALlK0YhPDWsDbywP86qxft9UyqmnZuX+rR645yR4+nVqTHWAwl2Gb52kv
 /BqhaOQy6KgfBLL+wrtuwtW4qoNCupFxb70UW7HRopA6YU2/2dju9n1s3CLS4500Q0wK
 hgbLm2BsulQtzVxybbH+gZEHdWSP1sCjbAhQBJQXzqutkN7XHkgyJE8oR+BNXYDS4r39
 T6lK2ZqTNfxiCaLRnb83C7QgeaRLag0TKTConCjZSzPTEONEKPDoaxjfEJfiWpm9lJ/A
 qAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=40PEaev2AR89A76wIRPh9VfSUB5wAXw9k1uNgC1xL9I=;
 b=tpMVEmNp8fY4bJIMUJ2m46eNWt23O7fUyF3bPZ8nYAXXmHEaTvO7UVkPPrHpy9Ihmw
 ah7ukBlhMgJJymGJHTP5ELLEzhmq3B2ufKLnHaMhT4oUO7IdQ7KsZDN8wlDHejNU4rZE
 j885VQwtmpF8EU+Lp/UFvFPH4Z5Oku+7v+VKymahd+DJ+Njy8FpQQsAifNFs7djLvX47
 sb0L3ZYKRkcgJS7PQW5Y1vgFERuQgxTGdUlsh/MGJvwWOUL0ZX51pVsi2SyFCno7owxO
 a+WFtZkvuuIHo4FSQZhp9UdYQh9Gh8RBLs/EX/wG44fFsuq2NbOvIRRjeytQABCp+9Ra
 T3Ww==
X-Gm-Message-State: AOAM530Yr/6lFoWOoXhSzbMGyLQdpMXlEF1BUxURWMiS9J3l6E4J+5Bq
 77cYUaYZiUCiyKy7V8Ec9/J9bA13TgKCidPcOAE=
X-Google-Smtp-Source: ABdhPJySvicnnryYF1OslzmbsSVu5tO/Hy3Wk6Iz23QfOb9jDrUA0O4lYDXYPFMGDFdRo7HCdOu6N4VcluEmZYHL/U0=
X-Received: by 2002:a92:7a07:: with SMTP id v7mr16791692ilc.122.1595894340476; 
 Mon, 27 Jul 2020 16:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200727171112.2781-1-weiyongjun1@huawei.com>
In-Reply-To: <20200727171112.2781-1-weiyongjun1@huawei.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Tue, 28 Jul 2020 09:58:49 +1000
Message-ID: <CAOSf1CESE9tM_oJLwzfwx0AZfeJNXP719kJuo-Ba+NSY6BYhFg@mail.gmail.com>
Subject: Re: [PATCH -next] powerpc/powernv/sriov: Remove unused but set
 variable 'phb'
To: Wei Yongjun <weiyongjun1@huawei.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Hulk Robot <hulkci@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jul 28, 2020 at 3:01 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Gcc report warning as follows:
>
> arch/powerpc/platforms/powernv/pci-sriov.c:602:25: warning:
>  variable 'phb' set but not used [-Wunused-but-set-variable]
>   602 |  struct pnv_phb        *phb;
>       |                         ^~~
>
> This variable is not used, so this commit removing it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  arch/powerpc/platforms/powernv/pci-sriov.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
> index 8404d8c3901d..7894745fd4f8 100644
> --- a/arch/powerpc/platforms/powernv/pci-sriov.c
> +++ b/arch/powerpc/platforms/powernv/pci-sriov.c
> @@ -599,10 +599,8 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>  static void pnv_pci_sriov_disable(struct pci_dev *pdev)
>  {
>         u16                    num_vfs, base_pe;
> -       struct pnv_phb        *phb;
>         struct pnv_iov_data   *iov;
>
> -       phb = pci_bus_to_pnvhb(pdev->bus);
>         iov = pnv_iov_get(pdev);
>         num_vfs = iov->num_vfs;
>         base_pe = iov->vf_pe_arr[0].pe_number;
>

Acked-by: Oliver O'Halloran <oohall@gmail.com>
