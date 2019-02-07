Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4AFC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 10:19:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0BE218FE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 10:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0BE218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wDnw5607zDqDP
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 21:19:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wDl375mQzDqMm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 21:17:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43wDl25b58z8tCk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 21:17:18 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43wDl242m3z9sN6; Thu,  7 Feb 2019 21:17:18 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43wDl16FH1z9s9G
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2019 21:17:17 +1100 (AEDT)
Received: by mail-ot1-f66.google.com with SMTP id n8so17308670otl.6
 for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2019 02:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b0+U45eMrzYUydjJCnVdTFMtG88Ys60uhVn21EG6rcI=;
 b=B+56hbEK16qyC49kdoMN0ZO4848NsFabBGXCGTLTOb+yNZPf1VnuUuT2+j5GczGx6K
 0kssrY4RKEdATmhex+tg5W+Qar29RoUDAxt2cDfDICi6vajExJeuAT/yM96nyQnUq3Tk
 L/nwwBLsKkkRopq+PcZ1cIXP9c2QJdm6F8kU7pEnDr9hVjM9ruquM/Ie5RymahrGO8g0
 fNMwJK1ATZeBHcRJEoNhtUGyWCae7CFGuFug4fPqkWf7/QTY9ew66nNe6iYZcMZRTOXN
 mzCIqI7xOtfYqLR6dvooOQIfxPK7Zee2Va8YAR7lLO3h6SQl+u3Us5+W2sCe4whjo5bf
 RstA==
X-Gm-Message-State: AHQUAua8JVfWrr7yqXDbsksU/pOg/DDDSSpHqvFNxnoCxBt+uLGInfHs
 KYgQ+Y2jNbYcZCVI8/A19SOM2SuQY/G4vLoEhAxztWOS
X-Google-Smtp-Source: AHgI3IbtvL9mOX1TxhSGkkujr5ldM7FLVTsqFzFSiGkEpitQ5cOeEQ+HA3Z1Yslwk9e5XxVMplV1IhvMvtlxEFmFSWE=
X-Received: by 2002:a9d:3d24:: with SMTP id a33mr8416330otc.365.1549534635425; 
 Thu, 07 Feb 2019 02:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20190207051652.11380-1-mpe@ellerman.id.au>
In-Reply-To: <20190207051652.11380-1-mpe@ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 7 Feb 2019 11:17:03 +0100
Message-ID: <CA+7wUsyuLtWAhO=uwu_x6b2s6qu9o506xRtQpY=+6RdpTdnvmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/32: Add ppc_defconfig
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 7, 2019 at 6:18 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Add a generic 32-bit defconfig called ppc_defconfig. This means we'll
> have a defconfig matching "uname -m" for all cases.

Looks good to me:

$ make defconfig
*** Default configuration is based on 'ppc_defconfig'
arch/powerpc/configs/ppc_defconfig:175:warning: symbol value 'm'
invalid for NF_TABLES_INET
arch/powerpc/configs/ppc_defconfig:176:warning: symbol value 'm'
invalid for NF_TABLES_NETDEV
arch/powerpc/configs/ppc_defconfig:304:warning: symbol value 'm'
invalid for NF_TABLES_ARP
arch/powerpc/configs/ppc_defconfig:358:warning: symbol value 'm'
invalid for NF_TABLES_BRIDGE
arch/powerpc/configs/ppc_defconfig:1427:warning: symbol value 'm'
invalid for LIRC
#
# configuration written to .config
#

Tested-by: Mathieu Malaterre <malat@debian.org>

> This config is mostly intended for build testing but if someone wants
> to tweak it to get it booting on something that would be fine too.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index ac033341ed55..70e6e8119aeb 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -367,6 +367,10 @@ PHONY += ppc32_allmodconfig
>         $(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.config \
>                 -f $(srctree)/Makefile allmodconfig
>
> +PHONY += ppc_defconfig
> +ppc_defconfig:
> +       $(call merge_into_defconfig,book3s_32.config,)
> +
>  PHONY += ppc64le_allmodconfig
>  ppc64le_allmodconfig:
>         $(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/le.config \
> --
> 2.20.1
>
