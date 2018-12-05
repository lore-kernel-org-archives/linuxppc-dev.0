Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F019C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 04:55:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882AF2081C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 04:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiJexr60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882AF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438mcw2wKFzDqV2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 15:55:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EiJexr60";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=sabyasachi.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="EiJexr60"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438mKt3vgZzDqlS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 15:42:10 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id q1so9367256pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 20:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6G2KpmpfCtmqQlw0KlLFcSMUcNS3EWFTLTfjH5tvPWA=;
 b=EiJexr604usee2Xz36cu7qmvYq262sxHpdFxW1/kmiqcvFpbUhbS+sEs4uFrQU1wq5
 wkxR2E2vB8PWm/vaHtZHraB0HKG/1v8JbcOOMdc1cgpQdHrEYGerkflrTqD+xDbqWQEz
 LExpdikPc7hWY4zOC94400OA4AQr2U06LbUb40PaQN9MbdRQfmwRKTRA7032QPRw6v6j
 JjWeNWMROwBW2L4DgS5gPeGPB6sQ1V60wDuiKlyijNcWch3uPK7B2d71T/jtxHvoIXkV
 bIprobZBLZ1KtxFl6uFPpxmCN8yg3G7HzhDmtw4GQuBg6LbK+CYACGhQO3qgs4t5Qrzq
 +Mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6G2KpmpfCtmqQlw0KlLFcSMUcNS3EWFTLTfjH5tvPWA=;
 b=NfmnNxzwW3o6zLzRBMKKaRON5zxXtGosNuFKQ5U2xuYF4jGuiXGu0AHytkqiYrBkw9
 K89C6PL5WSakRcscSoZJGrgQT+B9C6//WwU2g0NvRldg7VBorefbHG21FKF2HIaRGZ/R
 2IhzqaF4muQ4sSO8g0zYFW0ziIBPfoBsI7lmPYUMsXAQ7Fx5L1e94yNI6g8z617EQnnw
 UW93/Zk+1GK2rP3rFJwzD42vN+aYJzXDmjm0brs9dfcCNEyU3iAKCT+X1aNqdudTZtso
 AjvMDi+mb1SygQ5cPGCQpZKjjAGDnoRH+ABHB0mFGOmozwc58yz0+X7UEwQfCWvxG2gn
 Z95A==
X-Gm-Message-State: AA+aEWa7ipu0j9XnK/75hpAFtGK7vwQMQa66CSGx4X5j7OcWTPW7sHEE
 4OK9vhu4Ew96D/jVzJGi5Fo1VSu8puq90Eo3JuI=
X-Google-Smtp-Source: AFSGD/XdtvLuByabpQA527LtOlvwusHUuKSPq3xzOtaVji+cQ4qW1THHtVQnqm1/Jh1IUcI2fmF4Tg8976oUsLA2qr0=
X-Received: by 2002:a63:4d66:: with SMTP id n38mr19256346pgl.270.1543984928422; 
 Tue, 04 Dec 2018 20:42:08 -0800 (PST)
MIME-Version: 1.0
References: <5bdfa97d.1c69fb81.4aef7.c9f7@mx.google.com>
In-Reply-To: <5bdfa97d.1c69fb81.4aef7.c9f7@mx.google.com>
From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Wed, 5 Dec 2018 10:11:56 +0530
Message-ID: <CAJr6mf3d4vEQBk2HEsxnoX4HKisoBV1ywRhekq_homot_DJemw@mail.gmail.com>
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
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
Cc: Brajeswar Ghosh <brajeswar.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Souptick Joarder <jrdr.linux@gmail.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 5, 2018 at 7:52 AM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Any comment on this patch?

> ---
>  arch/powerpc/sysdev/fsl_rmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
> index 88b35a3d..8b0ebf3 100644
> --- a/arch/powerpc/sysdev/fsl_rmu.c
> +++ b/arch/powerpc/sysdev/fsl_rmu.c
> @@ -756,15 +756,13 @@ fsl_open_outb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entries)
>         }
>
>         /* Initialize outbound message descriptor ring */
> -       rmu->msg_tx_ring.virt = dma_alloc_coherent(priv->dev,
> +       rmu->msg_tx_ring.virt = dma_zalloc_coherent(priv->dev,
>                                 rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE,
>                                 &rmu->msg_tx_ring.phys, GFP_KERNEL);
>         if (!rmu->msg_tx_ring.virt) {
>                 rc = -ENOMEM;
>                 goto out_dma;
>         }
> -       memset(rmu->msg_tx_ring.virt, 0,
> -                       rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE);
>         rmu->msg_tx_ring.tx_slot = 0;
>
>         /* Point dequeue/enqueue pointers at first entry in ring */
> --
> 2.7.4
>
