Return-Path: <SRS0=kug9=5Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827D0C43331
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2020 00:59:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D496C2054F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2020 00:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="QV3uo2UA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D496C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48rrZy3zDHzDqnZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2020 11:59:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48rrY95td7zDqkd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2020 11:58:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=QV3uo2UA; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48rrY83DPpz9sPF;
 Tue, 31 Mar 2020 11:58:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1585616301;
 bh=c8QxLZAVwZDP69eK2yRpjGsPj13bvRE+pFfd/mBq/58=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=QV3uo2UAfxzPxyIyOABda5NJBpGNlmDyTet2SWRKDOHs1a5Ce4nI1SL/YATBqmCgt
 jAMQcdXfKec6G97JX6DM9v+2aAcI1Y0rpdn/282c1agVOr1jQAf33/sW9WA4Js2bdc
 vMNjn/qamb82UjfKwNf5/H5RA9pEuOk6DpbH0k09WINvoLOB3TKuwiziOja3X8kqQ0
 fKUY9cHrfQqQXQN2a8i4kOVF47+5SsayMkk1HBd0oSTogF9XXQfFKcWaldfuhTxM68
 aKrqONAGWi3qqlcstgkCDge9jXJLoK0SBsFn85IaDNTw+qgA0/I8rdsSx6n+qozhao
 U5etm/SZ3tIUg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: YueHaibing <yuehaibing@huawei.com>, mporter@kernel.crashing.org,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] powerpc/44x: Make AKEBONO depends on NET
In-Reply-To: <20200330143153.32800-1-yuehaibing@huawei.com>
References: <20200330143153.32800-1-yuehaibing@huawei.com>
Date: Tue, 31 Mar 2020 11:58:28 +1100
Message-ID: <87pnctuyq3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: alistair@popple.id.au, YueHaibing <yuehaibing@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

YueHaibing <yuehaibing@huawei.com> writes:
> Fix Kconfig warnings:
>
> WARNING: unmet direct dependencies detected for NETDEVICES
>   Depends on [n]: NET [=n]
>   Selected by [y]:
>   - AKEBONO [=y] && PPC_47x [=y]
>
> WARNING: unmet direct dependencies detected for ETHERNET
>   Depends on [n]: NETDEVICES [=y] && NET [=n]
>   Selected by [y]:
>   - AKEBONO [=y] && PPC_47x [=y]
>
> AKEBONO select NETDEVICES and ETHERNET unconditionally,

It shouldn't do that, that's the job of a defconfig.

It might want to enable NET_VENDOR_IBM iff the config already has NET
and other dependencies enabled.

So the patch below might work?

cheers

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 25ebe634a661..32aac4f40f1b 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -207,9 +207,7 @@ config AKEBONO
 	select PPC4xx_HSTA_MSI
 	select I2C
 	select I2C_IBM_IIC
-	select NETDEVICES
-	select ETHERNET
-	select NET_VENDOR_IBM
+	imply NET_VENDOR_IBM
 	select IBM_EMAC_EMAC4 if IBM_EMAC
 	select USB if USB_SUPPORT
 	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD



> If NET is not set, build fails. Add this dependcy to fix this.
>
> Fixes: 2a2c74b2efcb ("IBM Akebono: Add the Akebono platform")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/powerpc/platforms/44x/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
> index 25ebe634a661..394f662d7df2 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -199,6 +199,7 @@ config FSP2
>  config AKEBONO
>  	bool "IBM Akebono (476gtr) Support"
>  	depends on PPC_47x
> +	depends on NET
>  	select SWIOTLB
>  	select 476FPE
>  	select PPC4xx_PCI_EXPRESS
> -- 
> 2.17.1
