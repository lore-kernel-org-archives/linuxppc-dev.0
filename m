Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27738C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 11:39:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9419321783
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 11:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9419321783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bgrW3J6XzDr1Q
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 22:39:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bgpW2QCpzDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 22:37:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43bgpV0C64z9sBQ;
 Fri, 11 Jan 2019 22:37:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Corentin Labbe <clabbe@baylibre.com>, benh@kernel.crashing.org,
 mark.rutland@arm.com, paulus@samba.org, robh+dt@kernel.org
Subject: Re: [PATCH] powerpc: build virtex dtb
In-Reply-To: <1546951970-29079-1-git-send-email-clabbe@baylibre.com>
References: <1546951970-29079-1-git-send-email-clabbe@baylibre.com>
Date: Fri, 11 Jan 2019 22:37:53 +1100
Message-ID: <87y37re86m.fsf@concordia.ellerman.id.au>
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
 linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Corentin Labbe <clabbe@baylibre.com> writes:

> I wanted to test the virtex440-ml507 qemu machine and found that the dtb
> for it was not builded.
> All powerpc DTB are only built when CONFIG_OF_ALL_DTBS is set which depend on
> COMPILE_TEST.
>
> This patchs adds build of virtex dtbs depending on
> CONFIG_XILINX_VIRTEX440_GENERIC_BOARD option.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/powerpc/boot/dts/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
> index fb335d05aae8..cae14fca682e 100644
> --- a/arch/powerpc/boot/dts/Makefile
> +++ b/arch/powerpc/boot/dts/Makefile
> @@ -4,3 +4,5 @@ subdir-y += fsl
>  
>  dtstree		:= $(srctree)/$(src)
>  dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
> +dtb-$(CONFIG_XILINX_VIRTEX440_GENERIC_BOARD) += virtex440-ml507.dtb
> +dtb-$(CONFIG_XILINX_VIRTEX440_GENERIC_BOARD) += virtex440-ml510.dtb

I'll squash these onto one line, eg:

dtb-$(CONFIG_XILINX_VIRTEX440_GENERIC_BOARD) += virtex440-ml507.dtb virtex440-ml510.dtb


cheers
