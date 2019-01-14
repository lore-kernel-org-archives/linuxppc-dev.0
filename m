Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C5FC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 19:19:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC65020651
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 19:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC65020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43djv64Nq5zDqWC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 06:18:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43djs34yZ3zDqW6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 06:17:11 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id w25so93273otm.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 11:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OM/aIfnBVafWaMBtKs+zpeHlo8uj5Rb6aKAakxLObyk=;
 b=t+G6yfZoQ+xv7G5O+LHB0Y91PHUFTaQxvIUMVn2vFyei8dRA5mqlixFCD/CAlCu+cZ
 DYo7D6V7fi4CvYfkgu2FwEqb1VSkIC54XQ3xSu2O51jbEN2ksvRmyNuBwAS65B9z5/22
 UoFp+iO7/26D65RABTMXY+3o5W1DGGepkyjT0aduc5ciM5wpQwC7OCHCXPmRGZp3OZRa
 vbe+pm29uHkfF9EIxpLAmtSvDaTP1yWbDDqMW9TBWVVE7bq2arrfnQ8fToK9HhG34n5N
 zM8UFpgmrq5PCXZ7ecB0GcBiB6o+OZEQp6Hp/JJLdVSqvWfqvEo0/Ysr0tugqepcz9+6
 KKLw==
X-Gm-Message-State: AJcUukcipJKGXUJ9XdJ39bahFNEjAEKl1VEufKbFiUe7RXsO2032K8Sm
 Wb946piYx/mgJcpT13jvomJ3ShAA
X-Google-Smtp-Source: ALg8bN6yTLj0fFcBrmxzVMwd70jnVrfEMxz2jmMigzHRVs4tUy51uGQSzBVI2NUh+6korsKkOaK+Iw==
X-Received: by 2002:a9d:2184:: with SMTP id s4mr24141otb.46.1547493429188;
 Mon, 14 Jan 2019 11:17:09 -0800 (PST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com.
 [209.85.210.53])
 by smtp.gmail.com with ESMTPSA id 31sm1244964otw.55.2019.01.14.11.17.07
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 11:17:09 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id k98so158904otk.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 11:17:07 -0800 (PST)
X-Received: by 2002:a9d:1405:: with SMTP id h5mr16517479oth.331.1547493427615; 
 Mon, 14 Jan 2019 11:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20190114050237.32140-1-Bharat.Bhushan@nxp.com>
In-Reply-To: <20190114050237.32140-1-Bharat.Bhushan@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 14 Jan 2019 13:16:56 -0600
X-Gmail-Original-Message-ID: <CADRPPNRXgR_c+7tT9nv5QVBsHxm662T0sYwAhHS1PO=O9SC5Tw@mail.gmail.com>
Message-ID: <CADRPPNRXgR_c+7tT9nv5QVBsHxm662T0sYwAhHS1PO=O9SC5Tw@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: fix cpu range check
To: Bharat Bhushan <bharat.bhushan@nxp.com>
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
Cc: Roy Pledge <roy.pledge@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Jan 13, 2019 at 11:13 PM Bharat Bhushan <bharat.bhushan@nxp.com> wrote:
>
> cpu_possible(cpu) will always return true when cpu parameter
> is from cpumask_next().
> Check for nr_cpu_ids rather than !cpu_possible(cpu).

There is another patch pending merge seems to cover this issue too.
Please let me know if it doesn't.

https://lore.kernel.org/patchwork/patch/1020905/

Leo
>
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
>  drivers/soc/fsl/dpio/dpio-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index e58fcc9096e8..eb369dd9e0a7 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -133,7 +133,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>         else
>                 next_cpu = cpumask_next(next_cpu, cpu_online_mask);
>
> -       if (!cpu_possible(next_cpu)) {
> +       if (next_cpu >= nr_cpu_ids) {
>                 dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
>                 err = -ERANGE;
>                 goto err_allocate_irqs;
> --
> 2.20.1
>
