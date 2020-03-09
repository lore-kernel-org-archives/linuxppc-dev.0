Return-Path: <SRS0=0QC4=42=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA86C10F25
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2020 22:35:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FA124649
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2020 22:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FA124649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48btNK6jvKzDqTV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 09:35:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.167.194;
 helo=mail-oi1-f194.google.com; envelope-from=pku.leo@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48btLb2JM8zDqRj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2020 09:34:08 +1100 (AEDT)
Received: by mail-oi1-f194.google.com with SMTP id v19so11865232oic.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2020 15:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pLnP9gGfDbqjzLs0w/R1F12ZQEp2IKQhsRrBYCzbdX4=;
 b=PfTHarPGIIvej2hg5K+bGs20QxHBRaPCOqh92OgPKo9U4Q5V0WfsmtJ07cXfpJIpWF
 KRCbfEEC7y3CSdH8rvNOHdXlmTQykCxYjEQ1rkGGF4ZddZxEnC6lkSufux6VF0ejOOr2
 r4lcUdqEn0IeiBcTiVcWP6pY1SXA02dTQfVM/OmXWlq5d54pqCJJQ8v3fG5AJrhIAdCP
 w1jhELV0l2lj6JtyeD2tU2s3VeQqkHMXxJTxUDjEyACdQ2MD07AzCHzmt5w4/scwkXJ5
 lG5zw6F414d/t4Mp6Arwmg6MJhWKjiGrtxB5eXOKN4xn+Kvm9jjd+KnHyp2f5/o07747
 vmSQ==
X-Gm-Message-State: ANhLgQ3YnhjnJFaM0A5y2qudwp9iR1utn30feehmt+9mvCahqHduONAt
 LlUG/8d8Tf1NLG9BGgXC6ITkyGLn
X-Google-Smtp-Source: ADFU+vv1ek3j2y+QwiKDGT58MO8Esua5cBOteWk4vnKn1W368Ptb+d9h4exqgbv8OP/pURXrv0TL/Q==
X-Received: by 2002:aca:1017:: with SMTP id 23mr1074781oiq.47.1583793241044;
 Mon, 09 Mar 2020 15:34:01 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com.
 [209.85.210.42])
 by smtp.gmail.com with ESMTPSA id t21sm12268373otk.13.2020.03.09.15.34.00
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 15:34:00 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 66so11271123otd.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2020 15:34:00 -0700 (PDT)
X-Received: by 2002:a05:6830:104a:: with SMTP id
 b10mr14900892otp.63.1583793240222; 
 Mon, 09 Mar 2020 15:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200221083637.13392-1-yuehaibing@huawei.com>
In-Reply-To: <20200221083637.13392-1-yuehaibing@huawei.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 9 Mar 2020 17:33:49 -0500
X-Gmail-Original-Message-ID: <CADRPPNTb2_-0QpD=iuP-W-Tk6n-a3rHKp-M38xw5kf+BXXrbPg@mail.gmail.com>
Message-ID: <CADRPPNTb2_-0QpD=iuP-W-Tk6n-a3rHKp-M38xw5kf+BXXrbPg@mail.gmail.com>
Subject: Re: [PATCH -next] soc: fsl: dpio: remove set but not used variable
 'addr_cena'
To: YueHaibing <yuehaibing@huawei.com>, Youri Querry <youri.querry_1@nxp.com>
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
Cc: Roy Pledge <Roy.Pledge@nxp.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 21, 2020 at 2:38 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> commit 3b2abda7d28c ("soc: fsl: dpio: Replace QMAN array
> mode with ring mode enqueue") introduced this, but not
> used, so remove it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/soc/fsl/dpio/qbman-portal.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
> index 740ee0d..350de56 100644
> --- a/drivers/soc/fsl/dpio/qbman-portal.c
> +++ b/drivers/soc/fsl/dpio/qbman-portal.c
> @@ -658,7 +658,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
>         const uint32_t *cl = (uint32_t *)d;
>         uint32_t eqcr_ci, eqcr_pi, half_mask, full_mask;
>         int i, num_enqueued = 0;
> -       uint64_t addr_cena;
>
>         spin_lock(&s->access_spinlock);
>         half_mask = (s->eqcr.pi_ci_mask>>1);
> @@ -711,7 +710,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
>
>         /* Flush all the cacheline without load/store in between */
>         eqcr_pi = s->eqcr.pi;
> -       addr_cena = (size_t)s->addr_cena;
>         for (i = 0; i < num_enqueued; i++)
>                 eqcr_pi++;
>         s->eqcr.pi = eqcr_pi & full_mask;
> @@ -822,7 +820,6 @@ int qbman_swp_enqueue_multiple_desc_direct(struct qbman_swp *s,
>         const uint32_t *cl;
>         uint32_t eqcr_ci, eqcr_pi, half_mask, full_mask;
>         int i, num_enqueued = 0;
> -       uint64_t addr_cena;
>
>         half_mask = (s->eqcr.pi_ci_mask>>1);
>         full_mask = s->eqcr.pi_ci_mask;
> @@ -866,7 +863,6 @@ int qbman_swp_enqueue_multiple_desc_direct(struct qbman_swp *s,
>
>         /* Flush all the cacheline without load/store in between */
>         eqcr_pi = s->eqcr.pi;
> -       addr_cena = (uint64_t)s->addr_cena;

Hi Youri,

Looks like this problem exposed another issue that you removed the
cacheline related code in the upstream version.  Then the comment /*
Flush all the cacheline without load/store in between */ is no longer
true now, and probably the whole block can be replaced with a single
line to increase s->eqcr.pi?   The same for the block above.  Can you
provide a better fix for this issue?

Regards,
Leo

>         for (i = 0; i < num_enqueued; i++)
>                 eqcr_pi++;
>         s->eqcr.pi = eqcr_pi & full_mask;
> --
> 2.7.4
>
>
