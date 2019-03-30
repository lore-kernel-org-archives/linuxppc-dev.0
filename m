Return-Path: <SRS0=BcJT=SB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114F7C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 15:35:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B25218A6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 15:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="OTcZC1+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B25218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WjN059lZzDqVs
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 02:34:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="OTcZC1+D"; 
 dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WjLG1RshzDqNp
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 02:33:20 +1100 (AEDT)
Received: by mail-oi1-x244.google.com with SMTP id l203so3339955oia.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4GAUNn1jlLkHDaow21lIHTP+Puz2N/vLdbErLotRvmA=;
 b=OTcZC1+Dt6ADlK4IHQNx0ywCtFYFyG3aSyhIdIIkTnbYvgCqUDXgR7a0/kZjfTMTgV
 UnULf3uZMjUQFPBtxNWHJjiTiLWdo9BY7I3W8zBY+3Q1YpsFg/yMJzfflNCs+LUl39M2
 Bg3rKuRl4Ly/wKbIE3BFXgfu/nq7fGGKrjYQCHKqBqMOsfxEOBtYOdlG7rZC+DUuFpT2
 B9JU/LLUR2aBjjfB1UoVR/vEt+zgRhgYgNPtedsOGKZN1/QRY/KOhcFqV7Zt58z1Zu+B
 N8Q5Z6mymxjd3DJPq3vjf5ZQxaY6znI64vrd0HCKEIEK5tJ+i+Otzv2jezGInmZsaKCk
 12Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4GAUNn1jlLkHDaow21lIHTP+Puz2N/vLdbErLotRvmA=;
 b=Y5nne7WdkPSQE6MDOtLo5/GCs1NARJTvm2yJzTegU71nNZJiHi6qBgwh+gAonEFovx
 RRVI3OjdiDNN5suUgWjQdG8NSCg2h3FKwiw8KbMnD2ZbYgs2WthX0PoQ4m2HLV/iWFTG
 zPTZ5ngCXiJf+exLDaTzhw8O0XrLytJyEm8Aav9Iyy/2FBmrakvzlKPs3rbIOUcD+w9W
 XQ21pF7IoZ8tSKXCOBflkuYqb+iDKESI+SdjedFWXc9Ma0hL5zeD3gBtMXxGXPTJHZGS
 WpMYLf1J9e6sbgS0UWHJ5RtepUEzTEOIKnidHXOeV0KNTw4TfMlHZnDj0OFX3kPUGYqW
 9RYQ==
X-Gm-Message-State: APjAAAUqLPeXDcgnUY2t0FnQX92EdV4lnwaPww3jxKjRqOWW4Ng2RlUv
 1kDNtrtPJz8YSEOdGLk1ykHYR9MCFr4u1pSXpnKfSOCJ+4M=
X-Google-Smtp-Source: APXvYqyTSOpqIN7uIlKFUYlk5hlpF2z/2pdp+qirv56Y99XuV3yvIMDZKwXw04w36vdc1cu+n8LNwnd45GHpTlNqydQ=
X-Received: by 2002:aca:d513:: with SMTP id m19mr7133565oig.73.1553959997075; 
 Sat, 30 Mar 2019 08:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190330054205.28005-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190330054205.28005-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 30 Mar 2019 08:33:05 -0700
Message-ID: <CAPcyv4h60V+1pnsF28AJQrFjNbU2jp6G+wVeEucxVbo-RETXOg@mail.gmail.com>
Subject: Re: [RFC PATCH] drivers/dax: Allow to include DEV_DAX_PMEM as builtin
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: Linux MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 29, 2019 at 10:42 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> This move the dependency to DEV_DAX_PMEM_COMPAT such that only
> if DEV_DAX_PMEM is built as module we can allow the compat support.
>
> This allows to test the new code easily in a emulation setup where we
> often build things without module support.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/dax/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index 5ef624fe3934..e582e088b48c 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -23,7 +23,6 @@ config DEV_DAX
>  config DEV_DAX_PMEM
>         tristate "PMEM DAX: direct access to persistent memory"
>         depends on LIBNVDIMM && NVDIMM_DAX && DEV_DAX
> -       depends on m # until we can kill DEV_DAX_PMEM_COMPAT
>         default DEV_DAX
>         help
>           Support raw access to persistent memory.  Note that this
> @@ -50,7 +49,7 @@ config DEV_DAX_KMEM
>
>  config DEV_DAX_PMEM_COMPAT
>         tristate "PMEM DAX: support the deprecated /sys/class/dax interface"
> -       depends on DEV_DAX_PMEM
> +       depends on DEV_DAX_PMEM=m

Looks ok, just also a needs a "depends on m" here, because
DEV_DAX_PMEM_COMPAT=y is an invalid config.
