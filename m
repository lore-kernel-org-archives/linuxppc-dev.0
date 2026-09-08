Return-Path: <linuxppc-dev+bounces-26813-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F45EC79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:17:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfTcN4YLRz2yFW;
	Wed, 09 Sep 2026 02:17:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788884260;
	cv=none; b=iXTy0WRmREr92dXHC6afdjoZAWM532Hd3ntyKf6q/SBJ0u+KdZwIOqVJUqVWSDOcspsUkVzOpN0J3NBceZRimzvxyLDHyX7sp6LVlP6ZEdIK34IAQ5O1H803jy7g7Tzn01rwNFrtVBB1u3rkFcKmsoKbmZPEL90GwLjv3YkOW/NzATFxlLpFMXZ3p7ko66c5w6+A4jf6UCivf/6szGE4FE0zhtMPa2lWsFXfXhwCFWTuQLQhw0Z8pAX4qImcGICXNtn0ZX26lrUh+A02UcrrPxsGcgh0ylGD1pM6tPnhVB6fZcJz28sBoy7jXOnOSmIDDaScc4wEhb0GgMwEtD1SKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788884260; c=relaxed/relaxed;
	bh=I7AXBe2nBsZac3Ps2hZ0XISjLmnUGKdRnAnvM4vXFww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt2OYhZNvCHhn1dN/oDHL0u9yTl/k04IKNSuH2f4CHl/BEde/uHBW3SOEx2iMhjo5FQD5Ozw3QgskmVQ+r1LtiRy0SB3xgaOOX47yWX+j/Bif2GZG7xXilqFPtF6wC4HpLlaZ7GyIhDOpdt8k79J177j/MqSW6y0UDkaCrKqy6PAqqFrIKV+2uwctYeEzTj6qU3K0IipnfSp5rl0mu/JrD3+7hs5qQXpOrOKWvv38lJ5hckfoxCMk7DCcpQcMOHIkwsh51IXDSxFuMTkIybX84l7pOa7uKzKx2SYbHSetVLnm3jc8DDP9pAa+KFXjmWPate5YrviVENmCXWzoOvfTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=OhycqMCj; dkim-atps=neutral; spf=pass (client-ip=212.27.42.6; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=OhycqMCj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=212.27.42.6; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfTcM2D3rz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 02:17:38 +1000 (AEST)
Received: from L10892.iliad.local (unknown [213.36.7.12])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 7B22478050A;
	Tue,  8 Sep 2026 18:17:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1788884253;
	bh=g0TrRds+CsCyqh5G5x4Il7gz6nNDRLvdGFk0lOmfFKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhycqMCja6XUqSTHOaKuk5pWKhkMHc9yA81KgHFBtM1o2jz/PwpjEaVCMPokgt0eG
	 Jmcy6ETkgBZuhZZVpyigiOtajFYryciPjWD9RAQvHkYn/Ax0/AXh/IQnxfY6hTz5Jv
	 /15XxibscZQMzz7A86oZTCEd/rT9FOb0d7hBx+XnPQ8GrnoF1s3//pAWhd6vAZJTfq
	 jTLrip+RXI0QC6hMP0dJHIql42rRmNLLFCXLDPXk6MsAIaTugrG0IcAUvY/K+bim2T
	 FlQhR/cDSNSg4PvNr8DnsJSKWPd/WNBqSG3u6cZlRtfyoHjIJzaaufkXsnJaZgE+Qq
	 p+ZBK7vEkin5g==
Date: Tue, 8 Sep 2026 18:17:24 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH] bus: fsl-mc: register the object drivers after
 misc_class exists
Message-ID: <aqA1FKnhAA6iIuyH@L10892.iliad.local>
References: <20260901-for-upstream-fsl-mc-initcall-order-v1-1-36ffe48f767d@free.fr>
 <fmmf72ypmmooyxszz3l47xabdhvetowgvbmbjmvj6bumuh5onh@pntmny63urbg>
 <ap7mmR_4QV0k88dK@L30177.local>
 <dvnnk7fnk57x7gf4mc25codec62xtpbe4v7omhjguqxd25ssmu@pqqjwe5xif4q>
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
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dvnnk7fnk57x7gf4mc25codec62xtpbe4v7omhjguqxd25ssmu@pqqjwe5xif4q>

Hi Ioana,

> I am indeed in the case in which the uapi support is builtin but the
> dprc.1 probing is deferred, thus it will get executed after misc_init()
> had a chance to run.
> 
> The deferral happens because of_dma_configure_id() returns EPROBE_DEFER
> since it waits for arm-ssmu to probe. How did you get past this
> deferral?

I think I isolated the difference: I guess you have smmu enabled while I
did disable it. I checked and when smmu is enabled back, the issue does
not show up anymore. But it is not my goal.

I do have with my dts,
        &smmu {
                status = "disabled";
        };

for the mc to load, you need:
        fsl_mc: fsl-mc@80c000000 {
                compatible = "fsl,qoriq-mc";
                ...
                iommu-map = <0 &smmu 0 0>;
                dma-coherent;
        };

it seems due to,
of_dma_configure_id() -> of_iommu_configure() ends up with "no IOMMU" and
it returns 0 instead of -EPROBE_DEFER.

So the root DPRC, populated at arch_initcall_sync, probes now
synchronously, before misc_init() registers misc_class at subsys_initcall
and so dprc.1 is created classless. (I hope I did not miss something).

> > I started to face this issue when I did try to restart
> > the MC from Linux userland instead of uboot in order to be able to adapt
> > with some DPC changes during the runtime.
> >  see https://github.com/vjardin/lx2160-sdx/blob/main/src/lx2160-mc.c
> > But I guess this issue should be quite generic.
> 
> Can you reproduce it without restarting the MC: boot to prompt, echo
> dprc.1 > .../unbind, echo dprc.1 > ..../bind ?

Yes, see below, even without restarting the MC.

smmu disabled / without the patch of this serie:
   # grep dprc /proc/misc
   256 dprc.1
   # ls /sys/class/misc/ | grep dprc # nothing: not in the class
   # ls -l /sys/dev/char/10:256
   ... /sys/dev/char/10:256 -> ../../devices/dprc.1  <- not under devices/virtual/misc

Unbind: the minor is freed but the char link leaks:

   # echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/unbind
   [  201.633695] fsl_mc_dprc dprc.1: DPRC device unbound from driver
   # grep dprc /proc/misc    <- gone (minor 256 freed)
   # ls -l /sys/dev/char/10:256
   ... /sys/dev/char/10:256 -> ../../devices/dprc.1  <- still here: leaked

Bind:

    # echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/bind
    sh: write error: Resource temporarily unavailable
    [  203.306315] sysfs: cannot create duplicate filename '/dev/char/10:256'
    [  203.306356] Call trace:
     ...
    [  203.306440]  misc_register+0xcc/0x158
    [  203.306449]  fsl_mc_uapi_create_device_file+0x44/0x74
    [  203.306462]  dprc_setup+0x134/0x214
    [  203.306471]  dprc_probe+0x18/0xec
    [  203.306480]  fsl_mc_probe+0x1c/0x30
      ...
    [  203.306517]  bind_store+0xa8/0xc4

With the patch applied on the same board, smmu disabled, then, it is fine.

This apply patch should be ok for smmu and not smmu in order to cover any cases now.

best regards,
  Vincent

