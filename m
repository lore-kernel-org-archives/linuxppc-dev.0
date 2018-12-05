Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5728AC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:25:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFA920989
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFA920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4399G95ggczDqMs
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:25:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4398wM6VyMzDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 07:09:52 +1100 (AEDT)
Received: by mail-oi1-f196.google.com with SMTP id a77so18671551oii.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 12:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S8ZhQTd5ZYFVNr+fp/33hqBP5kxJlkpMr3IgxwjyEBI=;
 b=QVaYSEYZohvQMslOY448BPFnHtA9QwXFKyHJfy/aFAXr8D4jElITY20HggjYYtQUkv
 pO32CEy8KlxtHRWfSxasYsGvbCd+WxEvyplemWNK0bu7li/yBvoe1zZk7Asg5IjVOlKt
 oMAD6fmJ3q6Sws/YWBjJrOiM/J38SpsKlJvy23I4tk+NbxDfxof1t7+g42kkm/n2l2eL
 NqjY7IwvjZGcqEgdR/G7i2rYIAik+KfJ4ka6n3z0AyYueBC22irE8rnqTwkIdRTdVhlC
 zken4Wj0FNpKV3Uh5sDwJOuu1HpXEgz+m87enIx4VaHOWsHjvJ2nPxstf4Of+46zjaFY
 jbQg==
X-Gm-Message-State: AA+aEWaM8xho6qusJcY1RU4p0wIAw2vHcNzCOSVXY4gUzw00BsykImHf
 NeIZ1VwpxppDEj4ZeiiCt/r7vYhcVdg=
X-Google-Smtp-Source: AFSGD/XSUvNcHryEmez9q897j4rDQAHefnDi7kNnuLnlo5TsEX8v3YP7vgGOSkNJCyQp0kA6KWXatg==
X-Received: by 2002:aca:a805:: with SMTP id r5mr16385978oie.5.1544040589997;
 Wed, 05 Dec 2018 12:09:49 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com.
 [209.85.167.175])
 by smtp.gmail.com with ESMTPSA id m207sm9232419oig.2.2018.12.05.12.09.47
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 12:09:49 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id h25so18721624oig.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 12:09:47 -0800 (PST)
X-Received: by 2002:aca:31cb:: with SMTP id
 x194mr15145275oix.213.1544040587072; 
 Wed, 05 Dec 2018 12:09:47 -0800 (PST)
MIME-Version: 1.0
References: <1542869385-48337-1-git-send-email-wang.yi59@zte.com.cn>
In-Reply-To: <1542869385-48337-1-git-send-email-wang.yi59@zte.com.cn>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 5 Dec 2018 14:09:35 -0600
X-Gmail-Original-Message-ID: <CADRPPNQ97rNJPPL8f0yqhEqTRJw9FnR0U4YCCLxrx5nDB4Ydkg@mail.gmail.com>
Message-ID: <CADRPPNQ97rNJPPL8f0yqhEqTRJw9FnR0U4YCCLxrx5nDB4Ydkg@mail.gmail.com>
Subject: Re: [PATCH] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
To: wang.yi59@zte.com.cn
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
Cc: zhong.weidong@zte.com.cn, lkml <linux-kernel@vger.kernel.org>,
 julia.lawall@lip6.fr, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 wen.yang99@zte.com.cn,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Zhao Qiang <qiang.zhao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 22, 2018 at 2:42 PM Yi Wang <wang.yi59@zte.com.cn> wrote:
>
> From: Wen Yang <wen.yang99@zte.com.cn>
>
> Currently there are 2 problems with the ucc_of_parse_tdm function:
> 1,a possible null pointer dereference in ucc_of_parse_tdm,
> detected by the semantic patch deref_null.cocci,
> with the following warning:
> drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.
> 2,dev gets modified, so in any case that devm_iounmap() will fail even when
> the new pdev is valid, because the iomap was done with a different pdev.
> This patch fixes them.

While we are at this, I think this logic need more serious fixing.  I
see there is no driver bind with the "fsl,t1040-qe-si" or
"fsl,t1040-qe-siram" device.  So allocating resources using devm_*()
with these devices won't provide a cleanup path for these resources
when the caller fails.  I think we should probably allocate resource
under device of caller (e.g. ucc-hdlc), so that when caller probe
fails or is removed it will trigger the cleanup.

>
> Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> CC: Zhao Qiang <qiang.zhao@nxp.com>
> ---
>  drivers/soc/fsl/qe/qe_tdm.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
> index f78c346..9a29f0b 100644
> --- a/drivers/soc/fsl/qe/qe_tdm.c
> +++ b/drivers/soc/fsl/qe/qe_tdm.c
> @@ -47,7 +47,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>         struct resource *res;
>         struct device_node *np2;
>         static int siram_init_flag;
> -       struct platform_device *pdev;
> +       struct platform_device *pdev_si, *pdev_siram;
>
>         sprop = of_get_property(np, "fsl,rx-sync-clock", NULL);
>         if (sprop) {
> @@ -129,16 +129,16 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>         if (!np2)
>                 return -EINVAL;
>
> -       pdev = of_find_device_by_node(np2);
> -       if (!pdev) {
> +       pdev_si = of_find_device_by_node(np2);
> +       if (!pdev_si) {
>                 pr_err("%pOFn: failed to lookup pdev\n", np2);
>                 of_node_put(np2);
>                 return -EINVAL;
>         }
>
>         of_node_put(np2);
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       utdm->si_regs = devm_ioremap_resource(&pdev->dev, res);
> +       res = platform_get_resource(pdev_si, IORESOURCE_MEM, 0);
> +       utdm->si_regs = devm_ioremap_resource(&pdev_si->dev, res);
>         if (IS_ERR(utdm->si_regs)) {
>                 ret = PTR_ERR(utdm->si_regs);
>                 goto err_miss_siram_property;
> @@ -150,8 +150,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>                 goto err_miss_siram_property;
>         }
>
> -       pdev = of_find_device_by_node(np2);
> -       if (!pdev) {
> +       pdev_siram = of_find_device_by_node(np2);
> +       if (!pdev_siram) {
>                 ret = -EINVAL;
>                 pr_err("%pOFn: failed to lookup pdev\n", np2);
>                 of_node_put(np2);
> @@ -159,8 +159,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>         }
>
>         of_node_put(np2);
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       utdm->siram = devm_ioremap_resource(&pdev->dev, res);
> +       res = platform_get_resource(pdev_siram, IORESOURCE_MEM, 0);
> +       utdm->siram = devm_ioremap_resource(&pdev_siram->dev, res);
>         if (IS_ERR(utdm->siram)) {
>                 ret = PTR_ERR(utdm->siram);
>                 goto err_miss_siram_property;
> @@ -174,7 +174,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>         return ret;
>
>  err_miss_siram_property:
> -       devm_iounmap(&pdev->dev, utdm->si_regs);
> +       devm_iounmap(&pdev_si->dev, utdm->si_regs);
>         return ret;
>  }
>  EXPORT_SYMBOL(ucc_of_parse_tdm);
> --
> 2.9.5
>
