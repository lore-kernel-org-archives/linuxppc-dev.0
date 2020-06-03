Return-Path: <SRS0=sLSx=7Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35D2C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 13:56:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532D9206A2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 13:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532D9206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49cVnr2Mq4zDqRX
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 23:56:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=collabora.com (client-ip=2a00:1098:0:82:1000:25:2eeb:e3e3;
 helo=bhuna.collabora.co.uk; envelope-from=boris.brezillon@collabora.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
X-Greylist: delayed 179 seconds by postgrey-1.36 at bilbo;
 Wed, 03 Jun 2020 23:52:31 AEST
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49cVhv3Q7KzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2020 23:52:31 +1000 (AEST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E7B002A3D89;
 Wed,  3 Jun 2020 14:52:27 +0100 (BST)
Date: Wed, 3 Jun 2020 15:52:24 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Anton Vorontsov <anton@enomsg.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 10/10] dt-bindings: mtd: fsl-upm-nand: Deprecate
 chip-delay and fsl,upm-wait-flags
Message-ID: <20200603155224.3baa35f9@collabora.com>
In-Reply-To: <20200603134922.1352340-11-boris.brezillon@collabora.com>
References: <20200603134922.1352340-1-boris.brezillon@collabora.com>
 <20200603134922.1352340-11-boris.brezillon@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@microchip.com>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

And I forgot to Cc the DT maintainer/ML on this one :-/

On Wed,  3 Jun 2020 15:49:22 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> Those properties are no longer parsed by the driver which is being passed
> those information by the core now. Let's deprecate them.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt b/Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt
> index fce4894f5a98..25f07c1f9e44 100644
> --- a/Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt
> @@ -7,14 +7,16 @@ Required properties:
>  - fsl,upm-cmd-offset : UPM pattern offset for the command latch.
>  
>  Optional properties:
> -- fsl,upm-wait-flags : add chip-dependent short delays after running the
> -	UPM pattern (0x1), after writing a data byte (0x2) or after
> -	writing out a buffer (0x4).
>  - fsl,upm-addr-line-cs-offsets : address offsets for multi-chip support.
>  	The corresponding address lines are used to select the chip.
>  - gpios : may specify optional GPIOs connected to the Ready-Not-Busy pins
>  	(R/B#). For multi-chip devices, "n" GPIO definitions are required
>  	according to the number of chips.
> +
> +Deprecated properties:
> +- fsl,upm-wait-flags : add chip-dependent short delays after running the
> +	UPM pattern (0x1), after writing a data byte (0x2) or after
> +	writing out a buffer (0x4).
>  - chip-delay : chip dependent delay for transferring data from array to
>  	read registers (tR). Required if property "gpios" is not used
>  	(R/B# pins not connected).
> @@ -52,8 +54,6 @@ upm@3,0 {
>  	fsl,upm-cmd-offset = <0x08>;
>  	/* Multi-chip NAND device */
>  	fsl,upm-addr-line-cs-offsets = <0x0 0x200>;
> -	fsl,upm-wait-flags = <0x5>;
> -	chip-delay = <25>; // in micro-seconds
>  
>  	nand@0 {
>  		#address-cells = <1>;

