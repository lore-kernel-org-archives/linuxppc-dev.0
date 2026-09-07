Return-Path: <linuxppc-dev+bounces-26691-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C09C79FA0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 16:30:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdsxr6ZTRz2xmh;
	Tue, 08 Sep 2026 02:30:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0c:1:1599::15"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788798640;
	cv=none; b=QqgEvGr6pmn/idCOexnkRgxmPe6jjQDqUxb1Pavf8dvTY0btzpPGZKxLtPYaD7QoYB4Wu6hqG07u3aKnKSrQlmmS8pot0hnNqhsTkRaqD7m7GVlNsZWnYowXnURvArUccdv4AvBaaYlZ1DLXMrcraqQlFnwctTFixUfBVRK7kAmm618RGjFGFaCqyEONedIAVRIcJC+H1UvWJ50MnDFlZhcCT240BmIbsF2jkfmbdymHdbcyzpf6WO6Ip8sEQe83bM82b0Ek0iZYOlGaZ252pfqEQ5mo2HaBT3L4DQQuD/6Y6y6CJhgkcP0WgCdgCf9kxsudsL64GyAkqzYcmkSZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788798640; c=relaxed/relaxed;
	bh=kCjFhWPNIHyCCGcOUKXpSBj6qunRSHfl8V2Z8EoV8nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b52299obxckVaYPZxogTRIj2+DRCziSpmw6dJzkCeB62fYhvFGsbWRFUbuC4ws8j8cSDOo1YLPKCCpsRDUv/gYHyJQN8OWSoOygjXU6/30MY33LjeMKwT52yFTtO7Vitn8eQ8HioA3DqePIBg3lNvFy5wZ4Qae/A5dyl16z6rXkFdUG31ILGK913N4ZL5GRPJNuf0s6SzShyPsD79+BNB+j98CGXnCGCZVhl9GKIgW4TLg5kamVQz72IsVG3viIEIdI/5PSZxE7jvaNRSJoCN0zijwXoixmkT0weQ1yhfeVOCbGVFVAnLTpIFKVgIKpnv/ntLRpiIh91gM2KpnJdCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=SrVgf5A7; dkim-atps=neutral; spf=pass (client-ip=2a01:e0c:1:1599::15; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=SrVgf5A7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=2a01:e0c:1:1599::15; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdsxp1TQgz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 02:30:36 +1000 (AEST)
Received: from L30177.local (unknown [213.36.7.12])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id CBF1F780333;
	Mon,  7 Sep 2026 18:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1788798627;
	bh=WBKBczPmnFNqn4oIBcLRMTmSwk8E7CwqvkPMeqXkv/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrVgf5A7eKYt7GcaIfUWEc2J962GNTRiqS4oleuwDrm0Q81xaxIZ+6YgQQ1Kh5ECi
	 8Hi3DwQR1SgbwCldFJ6RnfI9F51NAqShrz9BM7OpxWOfAPu3RWpcl+ffU59PP3hvyI
	 Avxgz7X6z2iXrwAQkIgNa6JHNzIOr4ygSO3ac2nERcIRpc+ADW0kSnwM7RigCaRgjz
	 OcxEUl2LkMsX7sPMJ/wkSlnEckqLCoetx+FSnDVabZmhCibG/8LO79WNf7NS6yUnbP
	 PVad2zu6mtidc84Npf65aHE1KAZQ6Zmv7YCI2C5b4ZRJ6UBeskblftFbxlsfBgWy/1
	 EluxjPQQ4xkrw==
Date: Mon, 7 Sep 2026 18:30:17 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH] bus: fsl-mc: register the object drivers after
 misc_class exists
Message-ID: <ap7mmR_4QV0k88dK@L30177.local>
References: <20260901-for-upstream-fsl-mc-initcall-order-v1-1-36ffe48f767d@free.fr>
 <fmmf72ypmmooyxszz3l47xabdhvetowgvbmbjmvj6bumuh5onh@pntmny63urbg>
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
In-Reply-To: <fmmf72ypmmooyxszz3l47xabdhvetowgvbmbjmvj6bumuh5onh@pntmny63urbg>

Hi Ioana,

> Do you mean that the above error messages are triggered by an unbind and
> bind sequence like below?
> 
> $ echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/unbind
> $ echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/bind

Yes, same sequence on the root DPRC

> I am asking this because I cannot seem to trigger it myself. There is a
> misc_deregister() which should remove the char device upon unbinding the
> root DPRC.

It does for every normal misc device, but not for this one, because the
root DPRC's misc device is created classless.

You can check the states with:
    grep dprc /proc/misc   # e.g. "256 dprc.1"  -> registered
    ls /sys/class/misc/ | grep dprc

If dprc.1 shows in /proc/misc but is absent from /sys/class/misc, its
misc device is classless and the unbind/bind should collide. If it is
present under /sys/class/misc, it was created after misc_class and the
sequence is clean on your setup.

fsl_mc_bus_driver_init() is a postcore_initcall, it registers both the
platform and the dprc drivers.

The fsl-mc DT node is populated at arch_initcall_sync, so the root DPRC
probes synchronously.

dprc_setup() -> fsl_mc_uapi_create_device_file() -> misc_register() runs
before misc_init() does class_register(&misc_class) at subsys_initcall.

misc_register() does not fail in that window: device_create_with_groups()
with an unregistered class creates the device with no misc_class
membership and still returns 0.

-> So at unbind, misc_deregister() -> device_destroy(&misc_class, devt)
cannot find the device within misc_class, it returns without removing it,
and then it leaks the device + its /sys/dev/char/10:<minor> link while freeing
the minor. The next bind reuses the minor and dies on the
duplicate /sys/dev/char/ entry.

I guess, from my setup, it happens when the root DPRC's misc device is
created during the early probe, which needs CONFIG_FSL_MC_UAPI_SUPPORT=y,
fsl-mc built in (not a module), and the root DPRC probe not going through
EPROBE_DEFER.

If it defers, the retry runs after subsys_initcall, misc_class exists,
and unbind/bind is clean -> which is probably what you are seeing.

I started to face this issue when I did try to restart
the MC from Linux userland instead of uboot in order to be able to adapt
with some DPC changes during the runtime.
 see https://github.com/vjardin/lx2160-sdx/blob/main/src/lx2160-mc.c
But I guess this issue should be quite generic.

best regards,
  Vincent

