Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1654C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 21:52:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE3920666
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 21:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE3920666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PGGh3WyNzF3CH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 07:52:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PGDZ2jNWzF31q
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 07:50:37 +1000 (AEST)
Received: by mail-ot1-f66.google.com with SMTP id m23-v6so14794929otf.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 14:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/O6QRlDqLd5gAz8+kYofksX8uV70Hv28i08lFxCk0tU=;
 b=GIHV15S0GRNTLEO1mdBQO9zsKl3mRZlabRA3MnDDXyKs9YMky6Yhaeyjla9QlzEC3k
 JKMX+6y7XDb5IEyl+kZ8U8i7hwbakJFTitsnBsfoobz3WjTsvuSlMLMq83JgIVL3HEmb
 vvfsAV9sTRtkIoCQQCj5xjnQk5+c4PtrIDQOvrl535ZG9L9el5SOVeu8d1KJ6tKcV8q9
 w4rqmKNm/d8JtPN4ORUkmVj1iOCzWpzIHsSemqlm7tpcCcWa+40nZN51jN6z6gf7fJcC
 lOMDdjOifud5mC1dAikqQC/phI9nm7cs+dh5z9p19ZK/LmqjEH0MnQBrRIgDMXz5b4k7
 uV9g==
X-Gm-Message-State: ABuFfoiQp1+dtVh8QDon9gVIqNCd7mzrZ9EOfkYku1a7/83h+F9shf6j
 BneZtlrg1QPjhMMpWrg5/f58Z0JSifQ=
X-Google-Smtp-Source: ACcGV61vFVjBV1zYwKrkAjVUCKvcHGCyNDWIdz6svKM6XasDy4GA+SipAomV/yuMGb0hYg7A+OnzpA==
X-Received: by 2002:a9d:9a1:: with SMTP id
 q30-v6mr7497145otd.351.1538430635314; 
 Mon, 01 Oct 2018 14:50:35 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com.
 [209.85.167.179])
 by smtp.gmail.com with ESMTPSA id o18sm1001680otb.47.2018.10.01.14.50.34
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Oct 2018 14:50:34 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id m11-v6so12572819oic.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 14:50:34 -0700 (PDT)
X-Received: by 2002:aca:2cc6:: with SMTP id
 s189-v6mr6444310ois.72.1538430634410; 
 Mon, 01 Oct 2018 14:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
 <1538124204-31406-6-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1538124204-31406-6-git-send-email-madalin.bucur@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 1 Oct 2018 16:50:22 -0500
X-Gmail-Original-Message-ID: <CADRPPNQgGAYTCmppyxPwQnnC433QLm21D5iq_4EvSj0LrsAxGQ@mail.gmail.com>
Message-ID: <CADRPPNQgGAYTCmppyxPwQnnC433QLm21D5iq_4EvSj0LrsAxGQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] soc/fsl_qbman: export coalesce change API
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Roy Pledge <roy.pledge@nxp.com>,
 lkml <linux-kernel@vger.kernel.org>, Scott Wood <oss@buserror.net>,
 claudiu.manoil@nxp.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 28, 2018 at 3:45 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>
> Export the API required to control the QMan portal interrupt coalescing
> settings.

These are new APIs not just old APIs being exported.  What is the user
of these APIs?  Is the user being submitted?  We cannot have APIs in
kernel that has no users.

>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  drivers/soc/fsl/qbman/qman.c | 31 +++++++++++++++++++++++++++++++
>  include/soc/fsl/qman.h       | 27 +++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index 99d0f87889b8..8ab75bb44c4d 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -1012,6 +1012,37 @@ static inline void put_affine_portal(void)
>
>  static struct workqueue_struct *qm_portal_wq;
>
> +void qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh)
> +{
> +       if (!portal)
> +               return;
> +
> +       qm_dqrr_set_ithresh(&portal->p, ithresh);
> +       portal->p.dqrr.ithresh = ithresh;
> +}
> +EXPORT_SYMBOL(qman_dqrr_set_ithresh);
> +
> +void qman_dqrr_get_ithresh(struct qman_portal *portal, u8 *ithresh)
> +{
> +       if (portal && ithresh)
> +               *ithresh = portal->p.dqrr.ithresh;
> +}
> +EXPORT_SYMBOL(qman_dqrr_get_ithresh);
> +
> +void qman_portal_get_iperiod(struct qman_portal *portal, u32 *iperiod)
> +{
> +       if (portal && iperiod)
> +               *iperiod = qm_in(&portal->p, QM_REG_ITPR);
> +}
> +EXPORT_SYMBOL(qman_portal_get_iperiod);
> +
> +void qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod)
> +{
> +       if (portal)
> +               qm_out(&portal->p, QM_REG_ITPR, iperiod);
> +}
> +EXPORT_SYMBOL(qman_portal_set_iperiod);
> +
>  int qman_wq_alloc(void)
>  {
>         qm_portal_wq = alloc_workqueue("qman_portal_wq", 0, 1);
> diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
> index d4dfefdee6c1..42f50eb51529 100644
> --- a/include/soc/fsl/qman.h
> +++ b/include/soc/fsl/qman.h
> @@ -1186,4 +1186,31 @@ int qman_alloc_cgrid_range(u32 *result, u32 count);
>   */
>  int qman_release_cgrid(u32 id);
>
> +/**
> + * qman_dqrr_get_ithresh - Get coalesce interrupt threshold
> + * @portal: portal to get the value for
> + * @ithresh: threshold pointer
> + */
> +void qman_dqrr_get_ithresh(struct qman_portal *portal, u8 *ithresh);
> +
> +/**
> + * qman_dqrr_set_ithresh - Set coalesce interrupt threshold
> + * @portal: portal to set the new value on
> + * @ithresh: new threshold value
> + */
> +void qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh);
> +
> +/**
> + * qman_dqrr_get_iperiod - Get coalesce interrupt period
> + * @portal: portal to get the value for
> + * @iperiod: period pointer
> + */
> +void qman_portal_get_iperiod(struct qman_portal *portal, u32 *iperiod);
> +/*
> + * qman_dqrr_set_iperiod - Set coalesce interrupt period
> + * @portal: portal to set the new value on
> + * @ithresh: new period value
> + */
> +void qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod);
> +
>  #endif /* __FSL_QMAN_H */
> --
> 2.1.0
>
