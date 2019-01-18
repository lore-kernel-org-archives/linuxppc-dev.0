Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF6C5AE5E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 22:57:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6636020449
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 22:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6636020449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hGYl17pXzDrFh
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 09:57:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43hGX22MmKzDr7N
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 09:56:17 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id v23so15843904otk.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 14:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=auZQbowt5s5QjzxAiRB8oW0KegrxKItGnAZm7hbf3L8=;
 b=DO4bZAn3rkYEu3zwPOc+wo1AASbxGDoa3YSt7Z9bDAD/tmkNMGNHcUK4Ln3aGHsn2S
 vbqg+x1Q1Sd3p23SHeLO3u40rvbVU1vXlQZ2OIaXX/k991A+f4dKf5a6ce6pwcr1hxmb
 eCbGlV7ZvoqHK4/D5G+LPRpxfoFIoin0POce7TVgesoquSJiLO8rNYU2vC1NiormmddP
 eYNwhtYJ4xPZhWvYMUZ9smhfAA3hkXs9zVNsbUVwty2aeL1pl5lPGhONV5Ua7Z1aTOvq
 TofzsevKg49lJLJcxtcmyBT0aMEn7k9ViCgL7wPmjpgLUzwGTy+pHJFhxEX76UxV6KZc
 MV3Q==
X-Gm-Message-State: AJcUukevBCECeNJBeNxz7ezUOcdytme7ykocjePZZcH5DeZYTvm2maWJ
 OQPS33QdWgl8aJ4s3iQFAJtorEOV
X-Google-Smtp-Source: ALg8bN6HHrNeYuncjlJ0602+XkY1FyTLbB7gVw1PtB9tR+79BktI9UCRJ8Sav4/EXckEFQu+WAZh5w==
X-Received: by 2002:a9d:641:: with SMTP id 59mr11973486otn.215.1547852175667; 
 Fri, 18 Jan 2019 14:56:15 -0800 (PST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com.
 [209.85.167.182])
 by smtp.gmail.com with ESMTPSA id j23sm2865747oih.22.2019.01.18.14.56.15
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 14:56:15 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id x23so10271626oix.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 14:56:15 -0800 (PST)
X-Received: by 2002:aca:31cb:: with SMTP id x194mr1775720oix.213.1547852174889; 
 Fri, 18 Jan 2019 14:56:14 -0800 (PST)
MIME-Version: 1.0
References: <1545403302-22475-1-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1545403302-22475-1-git-send-email-madalin.bucur@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 18 Jan 2019 16:56:03 -0600
X-Gmail-Original-Message-ID: <CADRPPNQGxzx4uX=vOsAK0k3PUSzCj0MPfrKzZb4dYk+dpx=7-w@mail.gmail.com>
Message-ID: <CADRPPNQGxzx4uX=vOsAK0k3PUSzCj0MPfrKzZb4dYk+dpx=7-w@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qbman: avoid race in clearing QMan interrupt
To: madalin.bucur@nxp.com
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
Cc: Netdev <netdev@vger.kernel.org>, Roy Pledge <roy.pledge@nxp.com>,
 lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 21, 2018 at 8:43 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>
> By clearing all interrupt sources, not only those that
> already occurred, the existing code may acknowledge by
> mistake interrupts that occurred after the code checks
> for them.
>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Applied for fix.  Thanks.  Suggest to forward it to
stable@vger.kernel.org after merged into Linus' tree.  It would be
better to add "Cc: stable@vger.kernel.org" in the commit message for
similar patches next time.

Regards,
Leo

> ---
>  drivers/soc/fsl/qbman/qman.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index 52c153cd795a..636f83f781f5 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -1143,18 +1143,19 @@ static void qm_mr_process_task(struct work_struct *work);
>  static irqreturn_t portal_isr(int irq, void *ptr)
>  {
>         struct qman_portal *p = ptr;
> -
> -       u32 clear = QM_DQAVAIL_MASK | p->irq_sources;
>         u32 is = qm_in(&p->p, QM_REG_ISR) & p->irq_sources;
> +       u32 clear = 0;
>
>         if (unlikely(!is))
>                 return IRQ_NONE;
>
>         /* DQRR-handling if it's interrupt-driven */
> -       if (is & QM_PIRQ_DQRI)
> +       if (is & QM_PIRQ_DQRI) {
>                 __poll_portal_fast(p, QMAN_POLL_LIMIT);
> +               clear = QM_DQAVAIL_MASK | QM_PIRQ_DQRI;
> +       }
>         /* Handling of anything else that's interrupt-driven */
> -       clear |= __poll_portal_slow(p, is);
> +       clear |= __poll_portal_slow(p, is) & QM_PIRQ_SLOW;
>         qm_out(&p->p, QM_REG_ISR, clear);
>         return IRQ_HANDLED;
>  }
> --
> 2.1.0
>
