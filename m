Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579E8C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 17:58:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF1A208E7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 17:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N25TH/eM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF1A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wpyB3Y8gzF3My
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 04:58:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N25TH/eM";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=sabyasachi.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="N25TH/eM"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wpvP3zj2zF3fn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 04:56:17 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id g62so6787473pfd.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 09:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6G2KpmpfCtmqQlw0KlLFcSMUcNS3EWFTLTfjH5tvPWA=;
 b=N25TH/eMZ1eCRPoRQyH7sADMQ3XHsVyGl2bp2bJISV5mhZVqNr03ivatjocEmFIEt1
 gdH9/oeuBBJzCv+EdtZBPdhxHFxW9aM7c0Vu3GmGX57ZThpxrwGsCujJ6S+xmX1YJNnH
 8BJetUAtSL3ksa7GBY7T7l06bf5of9FOSRz0zYKGwAEw5SYhcPN2DktovulmYB0lF9Yx
 CI2QpSNkl1+ECtmWYyGuKUBM33VXeOJkoyA6aLdl1deZIeJaenQFy7djxwTNCZ4JMzgs
 sDmPnuIzHEXdjfEbZ3eoIS3uVESJ8DLhI98nR8CeUxXBXPOwfiPVw8H87eAIXw5eO/3I
 FdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6G2KpmpfCtmqQlw0KlLFcSMUcNS3EWFTLTfjH5tvPWA=;
 b=p8D+SVrmANDVmiQCLBfkHVw5iyOiks/8sqpZWuuYVxSQA5+P3VqV36lproVADloZtX
 AD8IqIh1iSZTbSFIBD+xRidmf+GgidW8KvwIE56PhgeLR75fq8EPzyddTel6pTxi/cVA
 OGVMpZgeum+JdJotgZJ8GEVRqSxoVgfZiqUl+wmVtH4to6iqleGLgdPsJLrCXhENUvxd
 8H6qnbkPdLzVNMDEUECEObMxmdLfWNikl4/Aowwo+GrgEjQ7m45BUWcQrkHeO/lDO1jk
 1OSznAG017nZnDBl5CQIdA053Cj1ibod+/g+DAMD7+pmIVp+xIq82BtD6FGU04RqxZsn
 TcTQ==
X-Gm-Message-State: AGRZ1gLkTC4itvGbvacaYhYpPkwKCCIjmpmOMOIKmZvvwxMwaCvKQ4/F
 X5uZFn7c+7xGvxo1mg45Qxs9KPswA+cbImxfRwk=
X-Google-Smtp-Source: AJdET5c3T/+W2EqPp6pC7PirZgkFA+xZ0xnD5veblIlBPyIzSFRxFTqCtAOqKJmdIzIk4ulEc0p27ZQFQah63F3SMVM=
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr6874893pgf.302.1542304574924; 
 Thu, 15 Nov 2018 09:56:14 -0800 (PST)
MIME-Version: 1.0
References: <5bdfa97d.1c69fb81.4aef7.c9f7@mx.google.com>
In-Reply-To: <5bdfa97d.1c69fb81.4aef7.c9f7@mx.google.com>
From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Thu, 15 Nov 2018 23:26:03 +0530
Message-ID: <CAJr6mf0HfJNdsHG2H6VnRMYW1WGqBr1gvwMQoWk3mSdDhO3EmQ@mail.gmail.com>
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
