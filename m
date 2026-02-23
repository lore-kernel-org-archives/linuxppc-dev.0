Return-Path: <linuxppc-dev+bounces-17048-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38D8EA4FBA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Feb 2026 13:37:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKMNF6bf3z2yDk;
	Tue, 24 Feb 2026 00:37:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771853837;
	cv=none; b=WC4g7xVAqn5GWuxNMZf1e1gTquBaqUcFyFwQ7w1k+d2rLYYQ36Q8o0qHc3+1iIKq9fYH5cl2/rjA1wkoI0dPss3zlp8fa45reJr5+gGARTeMymYW5yf2S18up9SmGi+QNMy0X9CvGGQcfdDSUqH7IXVCdNkK/mV8l9dHYiRBsVFI1fFQB+CtAyN0ilXX+KTop9HHApxdt047i+hzxcNbzWoz5RqXbWYsRmYet0dd3Fr2uMTux4mqYNLvGt6vnQbGXh5nXetpnjk3mfTal+ELK3bZeNL9mEwDoZA+ALDRu1YHroexsebcXemRh1UMMJfd5z81Z3jDp1nxGAOd2Jy2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771853837; c=relaxed/relaxed;
	bh=LRc2M8STgNz5ILK4RHNGIZ4msDLZv24RyUi8WCcf184=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TY5uOJwQsOIRVa9i30hEFVQ8M62pdEPmEMxy2Kdnc4392QT9hvErRu2wZEg3qQmqhRZOBCuTQKrnBFY/GmC4u2I2uFWIWOJ8lChoLthApA90nEF/R3UdSxvAhUM+WBHbHmvYFVZlevssE6lW/1AJJ53lqxP3yJFzHt2u6NFlE2ipigGKuSeWFyDkAOi3sxTf7ZMzhG6MOIzDRCv49jEgGiPiZAHrqZzMG/QIdMvgZDQ6c5WbDZxYeDYwHrqNBt8tbbez2g9hcf1ROZxNd26qVhvUjGNx09W9IMWso7fLkVnPctoUnLyWEE+TqXRSlLvn6y+rlL8qNmOVNg4cUb3wmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BDV0RPPI; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BDV0RPPI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKMND5VJ9z2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 00:37:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A6F3A60054;
	Mon, 23 Feb 2026 13:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57615C116C6;
	Mon, 23 Feb 2026 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771853834;
	bh=K8tVBSZeTJU53L/A4kfm1miMVhrIxXZibSQWP4+wIXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BDV0RPPISyNknKpWsxe9ZWj9wfWxkXrP/wUkQ6iXOox3djPC0/JmYzYaIzboiwKiU
	 uyhhRVivF9YhYckZ8sQtG99YvsOwdfh8E8XEh4TAVqH3LIg5/tXRF9v+sG+ilaF1gW
	 9YlLsdR3lJJdwtMn62vNr3+QaBfZU49iOJl1u/sh7qKfebrPA/JoLCWZ0n4u0rvhBn
	 yqvNS1y+4+P6MvhLXATOtxN3jQzJ55GrRLbeeMI1t8S//0gQTsdnL5OdhJ7gOv9oUi
	 lNPsN5zfw42E9fVEPyfLHYxBwp+sxUkIuU4c7FLXTXNoXwr+RSQeDeMCq3s4LHqZdR
	 u+38kNvvfWeCQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vuW7c-0000000Czww-1217;
	Mon, 23 Feb 2026 13:37:12 +0000
Date: Mon, 23 Feb 2026 13:37:11 +0000
Message-ID: <86ms0za8e0.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/6] fsl-mc: Move fsl_over to device MSI
In-Reply-To: <kukzdg7cym2cwytx3zgbu5ik2cw7c2zq7irwp6q6o4jzupjzla@qgkrv7emus6f>
References: <20260218135203.2267907-1-maz@kernel.org>
	<kukzdg7cym2cwytx3zgbu5ik2cw7c2zq7irwp6q6o4jzupjzla@qgkrv7emus6f>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
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
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: ioana.ciornei@nxp.com, tglx@kernel.org, chleroy@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 20 Feb 2026 15:41:03 +0000,
Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
> 
> On Wed, Feb 18, 2026 at 01:51:57PM +0000, Marc Zyngier wrote:
> > Over the past few years, I have become increasingly annoyed by this
> > sort of messages in my boot log:
> > 
> > [    0.067861] fsl-mc MSI: ITS@0x100100040000 domain created
> > [    0.073352] fsl-mc MSI: ITS@0x100100060000 domain created
> > [    0.078841] fsl-mc MSI: ITS@0x100100080000 domain created
> > [    0.084328] fsl-mc MSI: ITS@0x1001000a0000 domain created
> > [    0.089815] fsl-mc MSI: ITS@0x1001000c0000 domain created
> > [    0.095303] fsl-mc MSI: ITS@0x1001000e0000 domain created
> > [    0.100792] fsl-mc MSI: ITS@0x100100100000 domain created
> > [    0.106281] fsl-mc MSI: ITS@0x100100120000 domain created
> > 
> > While this is useful on fsl-mc systems, this is completely irrelevant
> > on 99.99999% of the arm64 machines, which know nothing about the
> > Freescale stuff. Including all of my machine -- bar *one*.
> > 
> > Global MSI domains such as the above have been obsoleted for the past
> > two years, but nobody at NXP seems to have got the message.
> 
> I do admit that I wasn't aware that this neeeded work. In the future,
> please let me know of this kind of things and I will do the work.

I guess Thomas did too good a job not breaking fsl-mc when both PCI
and platform MSIs were rewritten, hence you missing on the good stuff!

> 
> > 
> > The obvious solution is to delete some code! While my first port of
> > call would be to just 'git rm -r drivers/bus/fsl-mc' (only kidding!),
> > a less invasive solution is to drag that code into the present times.
> > Which is what this series is doing by converting the whole thing to
> > device MSI, reusing the platform MSI infrastructure instead of
> > duplicating it.
> > 
> > This results in the expected cleanup, and kills the last user of the
> > non-device-MSI stuff on arm64. You're welcome.
> 
> Thanks!
> 
> Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com> # LX2160ARDB, LS2088ARDB
> Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thanks for giving it a go.

	M.

-- 
Without deviation from the norm, progress is not possible.

