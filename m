Return-Path: <linuxppc-dev+bounces-6369-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B6BC021B1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2025 13:13:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YzDH43JrJz30Tm;
	Fri, 21 Feb 2025 00:13:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740057232;
	cv=none; b=T25uL3Qon+ppCWvm1Aq/BJbFvfnznYsLHn4sZA23k5/tgAH6IpOJ/Uz+/+kSo0wVh1Wt2BIrHG+Hm6BE5AHoE9wD7wivZ4yW8+n/g7cE3ZztLKJ/+tOMHDSSBzHltL+uNW27UGaAkon+nGcppGoPMEvGKjYJUjOi4NrmcC73+mUlKaE4rV5fqKcFtUos7Fg+qRoK7tw11i/rFEwa1kfevj9kFNAIz5Dty+2hmebopmAAJXKz1suhIx35nyxF32x/iqOxUZzW2dx7jBg1j4FoNvjwdeGi8/cqyGFdhugNpM8Ym/gj1I0uipEztWFzndRTwxQoEzN6Z1vhb6pzOHz7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740057232; c=relaxed/relaxed;
	bh=eCW1aNnWqb/8IdIvy8tGaFtwvEUt9emvGnFkbfHDHw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE5yfaep2t0esFul85+Zwdpw45Ab3YByCZPOAhhrgVFrSQ+YK636O8q8Ekyrc+4rdU+2weAw2aLyzMZIv0gKseMSFzDNTRHv/hj/gSthTeRS1r+ekCAPH/A2Etl9wEOsZ+gP1Ln/qYLffw7cZXbuR2HplWtCwebdZm2dc6M58XsILFBa+kf42PXgisvUrt0Gh1PMRQYkOCJ0XceQsJ/0vPZSnTAxlBxBocBnJH506wQdYitM5rORVt6J5pdRx5cbcE6iDE4aVqEqYMli8eddQZRrvcuPcSE4aCvNq3gvIQ0ZKFlmoirn327JYCackPYw+HdwkaafLAHlvncPU9FKgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=posteo.net; dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=2017 header.b=eFsd9nWv; dkim-atps=neutral; spf=pass (client-ip=185.67.36.66; helo=mout02.posteo.de; envelope-from=j.ne@posteo.net; receiver=lists.ozlabs.org) smtp.mailfrom=posteo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=2017 header.b=eFsd9nWv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=posteo.net (client-ip=185.67.36.66; helo=mout02.posteo.de; envelope-from=j.ne@posteo.net; receiver=lists.ozlabs.org)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YzDH15cTXz30TH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2025 00:13:46 +1100 (AEDT)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 87CAE240101
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2025 14:13:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1740057220; bh=zgle9CkTdgmTkE8vQAPkindwi88AxR8vCiCMOn6LD7U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=eFsd9nWvXJX3p7Juqu2She/EHq8UFMWm+ZDyTBQgu8l3vcr46U8YctQGoaxNyXqPX
	 om67Mv6ceGxhTw9qC6CyjAIAdrKZvCwZNCXm9w3QAk5lvfR1cwwlVfKSoaRYSlItdy
	 3/ZmVtw8REzp6j5y4hbVx+XCqfsyJP/K9QbddZMrp1K0cdMTjQ+PkBhMhbOOMX3HCK
	 Q1hX6QxVhzhksmBe+3aJe4L0jkOresYkdaR3CU5wNIK2AjTjd+3/V5XYdIXvrBdQ0n
	 a2E876V/G+dPrGfUlN2I7fNSjCF6k0A3hLKnfxwnYJxNSWYkV2sawzWvtVjaZzsJ3Q
	 YNvWsKb0r7MNQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YzDGn6MP7z6tvk;
	Thu, 20 Feb 2025 14:13:37 +0100 (CET)
Date: Thu, 20 Feb 2025 13:13:37 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: j.ne@posteo.net
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/fsl_lbc: Explicitly populate bus
Message-ID: <Z7cqgbullhR47Bb-@probook>
References: <20250209-localbus-v1-1-efcd780153a0@posteo.net>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250209-localbus-v1-1-efcd780153a0@posteo.net>

On Sun, Feb 09, 2025 at 10:58:50PM +0100, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> Historically, devicetree nodes representing the Freescale Enhanced
> Local Bus Controller (eLBC) have compatible strings such as:
> 
>     compatible = "fsl,mpc8313-elbc", "fsl,elbc", "simple-bus";
> 
> The "simple-bus" string causes the bus to be populated, and the memory
> devices contained within it to be discovered. The eLBC bus (as
> represented in device trees) differs from a simple-bus in a few ways,
> though:
> 
>  - Addresses are not simple/linear: The first cell of an address is a
>    chip select, the second is an linear address within the space thus
>    selected. Representing 1,0 as 100000000, for example, would decrease
>    readability[1].
>  - It is expected that the devices on a simple-bus "can be accessed
>    directly without additional configuration required"[2], but the eLBC
>    needs some configuration.
> 
> To accommodate devicetrees that declare an eLBC without "simple-bus",
> explicitly populate the bus in the eLBC driver.
> 
> [1]: dtc makes such a suggestion opon encountering an eLBC
> [2]: Quoting the Devicetree Specification Release v0.3
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---

Due to advice from Crystal Wood and Rob Herring[1], I reached the
conclusion that this patch is not necessary.

[1]: https://lore.kernel.org/lkml/Z7ILej_AJYot_wKP@probook/

>  arch/powerpc/sysdev/fsl_lbc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
> index 217cea150987df1e1b5c6dbf9e9a1607dd5ce49b..2007ced997fcf0c7059e5b780893b530764dc8b2 100644
> --- a/arch/powerpc/sysdev/fsl_lbc.c
> +++ b/arch/powerpc/sysdev/fsl_lbc.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_platform.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/platform_device.h>
> @@ -336,7 +337,7 @@ static int fsl_lbc_ctrl_probe(struct platform_device *dev)
>  	/* Enable interrupts for any detected events */
>  	out_be32(&fsl_lbc_ctrl_dev->regs->lteir, LTEIR_ENABLE);
>  
> -	return 0;
> +	return devm_of_platform_populate(&dev->dev);
>  
>  err1:
>  	free_irq(fsl_lbc_ctrl_dev->irq[0], fsl_lbc_ctrl_dev);
> 
> ---
> base-commit: 7ccde445dddcca030cd6ed66974bb80915ad9dd5
> change-id: 20250209-localbus-94a6ebb04c12
> 
> Best regards,
> -- 
> J. Neuschäfer <j.ne@posteo.net>
> 
> 

