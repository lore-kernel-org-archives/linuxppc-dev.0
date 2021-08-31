Return-Path: <SRS0=qVND=NW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510EDC432BE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 20:30:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFF96103A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 20:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCFF96103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gzf2S1VSzz2yg5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Sep 2021 06:30:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=BBMK7o+g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82a;
 helo=mail-qt1-x82a.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=BBMK7o+g; dkim-atps=neutral
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gzf1l2zlLz2yHt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Sep 2021 06:29:45 +1000 (AEST)
Received: by mail-qt1-x82a.google.com with SMTP id b4so759313qtx.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2021 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=HZ3pj56mGoBpB6xSaPok/o43VKjWK5QuZ3X0xEylQ7A=;
 b=BBMK7o+guuqTDQOFARaHRkaRTvS1c+yc3Lo6N9osZWow/fEaRX9vXQgPfVvLCKRAbS
 rYlEleVtV+xAkrL2t7kEDkfu3RJhBeKrF8Ppb4CY1l8nOaQXdasY360nDcjaxmC6ToCf
 jt4m8ipskpVtAun9oah/uZ/AwkHPPLsh1vSzqO2y5d8ULYYFgIpist2HBCDD7P9fCrBb
 kNz7cThumSgAxwRXvgSewucHuF6ZBg4cU7Sl6PbCzL2pmDu/yAms01vQ184aJzkHQjxt
 80t919GkhucHsuQ8jSHAgwMq6sgEZxzz9bjWrnCkrVL5UumlNy/Uh1yCZyszkTgix4o1
 N9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=HZ3pj56mGoBpB6xSaPok/o43VKjWK5QuZ3X0xEylQ7A=;
 b=fge/x+76R3T6nB7kot7xcc16Pp1dF9N5tl/NL4of1/1f0cu9ZppSCmQCKAGaABiCmN
 Ti7kD4AvoidI2tt7Qeq1PAeQ7t18BlD+aSjQ7U5lNo/GzcpCj8seWmTyPO6n+BgoyunP
 sTWDz3fkcvJBj9rzwYJoUeS+fNoUvXCQjZCXah7QATMppd+yrte2abnx/s2+T/UTV2yN
 Caczgz9U0bunFRL+dJYxzz5wQhSgioS0wbKXY6H4NylzKyC4Yqy0BCBrqGNycP7ZSpi6
 9CZH8nEF1g+dZ1YV44mCZ89W2TRVqKmezE78xhOUZ8cWxbnhlYiLPAQWstou7Wds0zFx
 Qsgg==
X-Gm-Message-State: AOAM5336UyFkKSaK/wyRmHxNsDT44qU7igcNaTQyD/hI/eIzlqhz3vBf
 4+lrMPigJeNI/KM5ysHaJWc=
X-Google-Smtp-Source: ABdhPJyX0j27HVECx4O2VgHX34zIa84/GutgBUzDHsVpXWO1ZkIzLYiQS+eWA1ICVuFpC2q7PBh7Hw==
X-Received: by 2002:ac8:4891:: with SMTP id i17mr4525321qtq.321.1630441782665; 
 Tue, 31 Aug 2021 13:29:42 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f1:e948:8e69:9cd6:5512:12f4?
 ([2804:431:c7f1:e948:8e69:9cd6:5512:12f4])
 by smtp.gmail.com with ESMTPSA id t8sm11433605qtn.37.2021.08.31.13.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 13:29:42 -0700 (PDT)
Message-ID: <12346f49d2f9962d654efe4466754c519a98c236.camel@gmail.com>
Subject: Re: [PATCH kernel] KVM: PPC: Fix clearing never mapped TCEs in
 realmode
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 31 Aug 2021 17:30:00 -0300
In-Reply-To: <20210827040706.517652-1-aik@ozlabs.ru>
References: <20210827040706.517652-1-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Alexey,

On Fri, 2021-08-27 at 14:07 +1000, Alexey Kardashevskiy wrote:
> Since e1a1ef84cd07, pages for TCE tables for KVM guests are allocated
> only when needed. This allows skipping any update when clearing TCEs.
> This works mostly fine as TCE updates are handled when MMU is enabled.
> The realmode handlers fail with H_TOO_HARD when pages are not yet
> allocated except when clearing a TCE in which case KVM prints a warning
> but proceeds to dereference a NULL pointer which crashes the host OS.
> 
> This has not been caught so far as the change is reasonably new,
> POWER9 runs mostly radix which does not use realmode handlers.
> With hash, the default TCE table is memset() by QEMU the machine reset
> which triggers page faults and the KVM TCE device's
> kvm_spapr_tce_fault()
> handles those with MMU on. And the huge DMA windows are not cleared
> by VMs whicn instead successfully create a DMA window big enough to map
> the VM memory 1:1 and then VMs just map everything without clearing.
> 
> This started crashing now as upcoming sriov-under-powervm support added
> a mode when a dymanic DMA window not big enough to map the VM memory
> 1:1
> but it is used anyway, and the VM now is the first (i.e. not QEMU) to
> clear a just created table. Note that the upstream QEMU needs to be
> modified to trigger the VM to trigger the host OS crash.
> 
> This replaces WARN_ON_ONCE_RM() with a check and return.
> This adds another warning if TCE is not being cleared.
> 
> Cc: Leonardo Bras <leobras.c@gmail.com>
> Fixes: e1a1ef84cd07 ("KVM: PPC: Book3S: Allocate guest TCEs on demand
> too")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> With recent changes in the printk() department, calling pr_err() when
> MMU
> off causes lockdep lockups which I did not dig any further so we should
> start getting rid of the realmode's WARN_ON_ONCE_RM().
> ---
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c
> b/arch/powerpc/kvm/book3s_64_vio_hv.c
> index 083a4e037718..e5ba96c41f3f 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -173,10 +173,13 @@ static void kvmppc_rm_tce_put(struct
> kvmppc_spapr_tce_table *stt,
>         idx -= stt->offset;
>         page = stt->pages[idx / TCES_PER_PAGE];
>         /*
> -        * page must not be NULL in real mode,
> -        * kvmppc_rm_ioba_validate() must have taken care of this.
> +        * kvmppc_rm_ioba_validate() allows pages not be allocated if
> TCE is
> +        * being cleared, otherwise it returns H_TOO_HARD and we skip
> this.
>          */
> -       WARN_ON_ONCE_RM(!page);
> +       if (!page) {
> +               WARN_ON_ONCE_RM(tce != 0);
> +               return;
> +       }
>         tbl = kvmppc_page_address(page);
>  
>         tbl[idx % TCES_PER_PAGE] = tce;

That looks reasonable IMHO.

FWIW:
Reviewed-by: Leonardo Bras <leobras.c@gmail.com>

