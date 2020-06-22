Return-Path: <SRS0=kptR=AD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43B7C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2020 23:50:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFD520708
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2020 23:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ue2sgyYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFD520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49rR4V5XR4zDqXN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 09:50:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::343;
 helo=mail-ot1-x343.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ue2sgyYI; dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49rR2n5NkQzDqWy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2020 09:49:21 +1000 (AEST)
Received: by mail-ot1-x343.google.com with SMTP id n6so14780880otl.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2020 16:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XX4YnsKu6BBxjSJzDCaGWKRSWOF82qbvY3/awju7/sw=;
 b=ue2sgyYI20d32494WYnE/076ePOOYD6uRc0YOVQilIAi6wEO47FXdGf7Xh0LW3J3DL
 RYAYwEE3ePDNC6EB2GW5QhGa8dV9jp1x+RWY0qw0ZkiFJC8Ibq9LCo4uq36/OMMm5Zer
 Nd/tunjQt/8Zl1ksfzJsh3MGnuTREpEKiH6RxKdzejo/kT5hc7aV2orCT3peIokrz8H5
 2YUiJDlfajOLEWw8flk0kDeUiSelDQmI3qbimGzZy+l4QcCyUJTzJDHuQ/BEdPImQsIO
 K3Zzl+pUPjpILRtENVjOtI33/SVOdRkSYsSLyatEISaUgWfdxuveq7RLBGzGv7StRjPG
 dV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XX4YnsKu6BBxjSJzDCaGWKRSWOF82qbvY3/awju7/sw=;
 b=RJNSIrdbFjJlDS5fdgqW08PmzbvAsTTTnXkvyMbbb5dns+8pwatMvqRAWs6YWpcYut
 J9ccPlHu23662PDDwvviRtk1zsATpvZA+2wTHXWgLK+VeP+zgofXptwfn4pS58Fer9xi
 PGk4xaQq4IKsvxro7QHDqMzY/C4yHylJH5oXE71yDkMNDd5gsAG+hj9CMAjGHRB8Jlpf
 ECMCUtBeNDGzb18faOJkJttaA0uUMpEN5S6Xy2QdUgQgdnRdUStC1lDcs13PkLkofrgd
 b3GFrGRg2XaGIUfrVl2zzUJ1Mj9guYtnuMnXOeC7ZNxa6XRWVRmbkFFvSTQwSB6Xzug7
 aFug==
X-Gm-Message-State: AOAM530wOKKcBAmrRaSPn2AZVEo9zOKsZol1nvqqgqPabhcwzxZoSHnb
 oeSBu1T5W6/WQe+GfW0lVCk7aFJrTX+/0nvHKWQ=
X-Google-Smtp-Source: ABdhPJxAWaCxNbKX1upWs2GsMVCNGcyF3/zLEJRuYyUQcbwD4oIpuZhnAmH/72KXlYBrzMPwrpqLLoKe4miVDC9m6+o=
X-Received: by 2002:a05:6830:18f1:: with SMTP id
 d17mr15827770otf.51.1592869759645; 
 Mon, 22 Jun 2020 16:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200622070941.759307-1-bala24@linux.ibm.com>
 <20200622070941.759307-3-bala24@linux.ibm.com>
In-Reply-To: <20200622070941.759307-3-bala24@linux.ibm.com>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Tue, 23 Jun 2020 09:49:08 +1000
Message-ID: <CACzsE9pmDyxhq8YoXYFjNBH8VR+i39oPDBGB9J17e9PDYXzcAw@mail.gmail.com>
Subject: Re: [PATCH 2/6] powerpc test_emulate_step: fix pr_info() to print
 8-byte for prefixed instruction
To: Balamuruhan S <bala24@linux.ibm.com>
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
Cc: ravi.bangoria@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
 sandipan@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 22, 2020 at 5:10 PM Balamuruhan S <bala24@linux.ibm.com> wrote:
>
> On test failure, `pr_log()` prints 4 bytes instruction
> irrespective of word/prefix instruction, fix it by printing
> them appropriately.
This patch to add a ppc_inst_as_str() function should help with this,
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200602052728.18227-1-jniethe5@gmail.com/
>
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  arch/powerpc/lib/test_emulate_step.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
> index d5902b7b4e5c..e3b1797adfae 100644
> --- a/arch/powerpc/lib/test_emulate_step.c
> +++ b/arch/powerpc/lib/test_emulate_step.c
> @@ -1225,7 +1225,14 @@ static int __init emulate_compute_instr(struct pt_regs *regs,
>
>         if (analyse_instr(&op, regs, instr) != 1 ||
>             GETTYPE(op.type) != COMPUTE) {
> -               pr_info("emulation failed, instruction = 0x%08x\n", ppc_inst_val(instr));
> +               if (!ppc_inst_prefixed(instr)) {
> +                       pr_info("emulation failed, instruction = 0x%08x\n",
> +                               ppc_inst_val(instr));
> +               } else {
> +                       pr_info("emulation failed, instruction = 0x%08x 0x%08x\n",
> +                               ppc_inst_val(instr),
> +                               ppc_inst_suffix(instr));
> +               }
>                 return -EFAULT;
>         }
>
> --
> 2.24.1
>
