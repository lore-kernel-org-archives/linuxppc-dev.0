Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3E9C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 12:51:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458FB2070D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 12:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P/URqXVH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JcZvtZ4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458FB2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Xsfv6kKZzDqNd
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 23:51:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=codeaurora.org
 (client-ip=198.145.29.96; helo=smtp.codeaurora.org;
 envelope-from=mojha@codeaurora.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=codeaurora.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="P/URqXVH"; 
 dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="JcZvtZ4N"; dkim-atps=neutral
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Xscj490XzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 23:49:56 +1100 (AEDT)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 51F0460A42; Mon,  1 Apr 2019 12:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1554122994;
 bh=6QEKADiCw6eiXlGIMtq0jYA0TzsyZUqa74BENcomYLo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=P/URqXVHY8hM58y1zklf57wm79I2deIzE7nUlRG5tyEmvRVnZDeHa88iOxQRJ0Thi
 NHKy6iEh6mY1Ehts54GauBvX/Se/mtKpUdwlvnhxJ8+3PNfWiY8t05ueYfOeXy9V9T
 Jmj4JuNV3vWVokVCw1WEZ2lCArdrrdYKOc7X/vd4=
Received: from [10.204.79.83]
 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: mojha@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 14B1C6081E;
 Mon,  1 Apr 2019 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1554122993;
 bh=6QEKADiCw6eiXlGIMtq0jYA0TzsyZUqa74BENcomYLo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=JcZvtZ4NXyRb+UqKBDOXemAPkFVCpB/dJu0PQu8K9gBQaXXlTeSlsBVWhUvk8uZlC
 TtQFnHkhI58wxyYuGh6sGifNWjN/W+oW7G/CcgXuerXMQrnHBT067G482Xvd+PuYIy
 +Eo8OaKu+CRfmeAUX03Cm2ftemX4jYjbNMe5tDsk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14B1C6081E
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 03/12] PowerPC-83xx: add missing of_node_put after
 of_device_is_available
To: Julia Lawall <Julia.Lawall@lip6.fr>, Scott Wood <oss@buserror.net>
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
 <1550928043-14889-4-git-send-email-Julia.Lawall@lip6.fr>
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b74c558e-651b-458b-05ee-3adf5d06a685@codeaurora.org>
Date: Mon, 1 Apr 2019 18:19:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1550928043-14889-4-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 2/23/2019 6:50 PM, Julia Lawall wrote:
> Add an of_node_put when a tested device node is not available.
>
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
>
> // <smpl>
> @@
> identifier f;
> local idexpression e;
> expression x;
> @@
>
> e = f(...);
> ... when != of_node_put(e)
>      when != x = e
>      when != e = x
>      when any
> if (<+...of_device_is_available(e)...+>) {
>    ... when != of_node_put(e)
> (
>    return e;
> |
> + of_node_put(e);
>    return ...;
> )
> }
> // </smpl>
>
> Fixes: c026c98739c7e ("powerpc/83xx: Do not configure or probe disabled FSL DR USB controllers")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
>
> ---
>   arch/powerpc/platforms/83xx/usb.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff -u -p a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
> --- a/arch/powerpc/platforms/83xx/usb.c
> +++ b/arch/powerpc/platforms/83xx/usb.c
> @@ -221,8 +221,10 @@ int mpc837x_usb_cfg(void)
>   	int ret = 0;
>   
>   	np = of_find_compatible_node(NULL, NULL, "fsl-usb2-dr");
> -	if (!np || !of_device_is_available(np))
> +	if (!np || !of_device_is_available(np)) {
> +		of_node_put(np);
>   		return -ENODEV;
> +	}
>   	prop = of_get_property(np, "phy_type", NULL);
>   
>   	if (!prop || (strcmp(prop, "ulpi") && strcmp(prop, "serial"))) {
>
