Return-Path: <SRS0=l0Nn=JE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13782C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 11:28:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2F861130
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 11:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2F861130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFhwF0P0Jz304F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 21:28:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ODAla7nd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ODAla7nd; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFhvn4WnKz2xy0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Apr 2021 21:27:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FFhvf0Fmvz9sWY;
 Wed,  7 Apr 2021 21:27:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1617794864;
 bh=Cj3f8ngloiA9HcJv0SBAooX4hLm02FHFDJHGT11hot4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ODAla7ndUsbsO31oqNPjrBU8zkC7Fp+vECJBoGGzU4J2dhiOl2L8LmJfhtgbZWVzt
 Y3mI9rf0jAiGHgr7KCr0OLNDnDSTl30UsMWXxcjChJT8goqJgYeInQdX3DlhWqMhvw
 MRxLqA34JMfG+VoniqJjTnhuOGueMiyk/BQWhKbmZadcseizWT316Fk6BEZf0yjffQ
 5MbKTdD9VaJ1B6XsrxNJ0xPIfwW/TenRQpQ9eOKUF78y+AuJ3+UxI69Ufz46OX/k3/
 dUpboJ8nF3C/9dcFuyW6j+19SI4BsnlQ65lBGF/dDbVuBIj+m4J1sNNMLxxokK214e
 e/SIus9w4F7Yg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Youlin Song <syl.loop@gmail.com>, robh+dt@kernel.org,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] powerpc/dts: fix not include DTC_FLAGS
In-Reply-To: <20210403020423.85278-1-syl.loop@gmail.com>
References: <20210403020423.85278-1-syl.loop@gmail.com>
Date: Wed, 07 Apr 2021 21:27:22 +1000
Message-ID: <87y2due3mt.fsf@mpe.ellerman.id.au>
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Youlin Song <syl.loop@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Youlin Song <syl.loop@gmail.com> writes:
> I wanted to build the fsl dts in my machine and found that
> the dtb have not extra space,so uboot will cause about
> FDT_ERR_NOSPACE issue.
>
> Signed-off-by: Youlin Song <syl.loop@gmail.com>
> ---
>  arch/powerpc/boot/dts/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
> index fb335d05aae8..c21165c0cd76 100644
> --- a/arch/powerpc/boot/dts/Makefile
> +++ b/arch/powerpc/boot/dts/Makefile
> @@ -2,5 +2,6 @@
>  
>  subdir-y += fsl
>  
> +DTC_FLAGS   ?= -p 1024
>  dtstree		:= $(srctree)/$(src)
>  dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))

I guess that was missed in 1acf1cf8638a ("powerpc: build .dtb files in dts directory").

Which I think means the assignment to DTC_FLAGS in
arch/powerpc/boot/Makefile is not needed anymore.

Can you send a v2 removing that assignment and explaining that's what
happened?

cheers
