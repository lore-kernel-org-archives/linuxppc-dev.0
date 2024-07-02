Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DD1C30658
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2024 19:50:07 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JJp1yF3Z;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDD5p0KDDz3dSR
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2024 05:50:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JJp1yF3Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDD516tHhz3cZr
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2024 05:49:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2303662033;
	Tue,  2 Jul 2024 19:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB711C116B1;
	Tue,  2 Jul 2024 19:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719949761;
	bh=IzPBlqQ/4Tj0Uk881o0FtB2r6D4ok3HgHe3q8VdKMYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JJp1yF3ZqPfcjcf1fQipSRB97E8twMHSKw2qvDcIkGsQufK9CbZMjG1tHNofyntZw
	 zVLxQ3TvW2Ex7gPj0v+r7PopNZNh11BDv28j1KD/MzCpH3dP+esWC2JBepOdhde7QT
	 jcWu6vEGnDo3CO6iej+4BBhjQRnNoTX6MC5XAusQjb2eJS9XtyATJ9kpUmCKxigaHW
	 mczEY797vfO1L6B6nON6QiRZoLtiRpGhKiOGDt9wxA7cEzomDz9km1AZxfavq6bgbI
	 i2f2iulHL+yX3lqJ8PHGi9lgiyhb4vaS9FcIaMpD0s51BFvR6+ZvcyFNBohWH9zBok
	 OLk6cHB/FRYAA==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sOjV9-009CvD-B4;
	Tue, 02 Jul 2024 20:49:19 +0100
MIME-Version: 1.0
Date: Tue, 02 Jul 2024 20:49:18 +0100
From: Marc Zyngier <maz@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives
 after the of/irq updates 2024-05-29
In-Reply-To: <68b7988d-eaaa-4713-99c3-525a34c5b322@xenosoft.de>
References: <3ab66fab-c3f2-4bed-a04d-a10c57dcdd9b@xenosoft.de>
 <861q4bizxc.wl-maz@kernel.org>
 <68b7988d-eaaa-4713-99c3-525a34c5b322@xenosoft.de>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <5a6166f107ae31536665d42f410d314d@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: chzigotzky@xenosoft.de, robh@kernel.org, apatel@ventanamicro.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, madskateman@gmail.com, rtd2@xtra.co.nz, matthew@a-eon.biz, darren@stevens-zone.net, info@xenosoft.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
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
Cc: apatel@ventanamicro.com, Rob Herring <robh@kernel.org>, Darren Stevens <darren@stevens-zone.net>, "R.T.Dickinson" <rtd2@xtra.co.nz>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mad skateman <madskateman@gmail.com>, Matthew Leaman <matthew@a-eon.biz>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2024-07-02 18:55, Christian Zigotzky wrote:
> Hello Marc,
> 
> Thank you for your reply.
> 
> On 02.07.24 17:19, Marc Zyngier wrote:
>> Please provide the device tree for your platform. It isn't possible to
>> debug this without it, no matter how many pictures you provide. If it
>> doesn't exist in source form, you can dump it using:
>> 
>> # dtc -I dtb /sys/firmware/fdt
>> 
>> and posting the full output.
>> 
>> Additionally, a full dmesg of both working and non working boots would
>> be useful.
>> 
>> Thanks,
>> 
>> 	M.
>> 
> The device tree of the Nemo board and further information:
> https://forum.hyperion-entertainment.com/viewtopic.php?p=54406#p54406

Please post these things on the list. I have no interest in
fishing things on a random forum, and this information is
useful for everyone.

Thanks,

          M.
-- 
Jazz is not dead. It just smells funny...
