Return-Path: <linuxppc-dev+bounces-20658-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E764ECD3427
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2026 12:59:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gD2xv1g28z2xl6;
	Sun, 10 May 2026 22:59:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778417987;
	cv=none; b=g021a0otipOMDMy4X4kK+HAU9+Gu0YIT7ermUv7rfcoMhvuAYL8yGu5hz0PwtJxulyNA5IB/xmU/YfmxVkpzhDhd1S+7trRYMLIu9fk/eSRMjofP6J7eeN6NpP3D7f2y8sX9dEkMijCmJsT4bjW4T58pn5BH2zM1Dy9cMaCmGAxvLaKNTPstbs89QlfcJVsBrKKAefsM0N7TbfuZ8kpjz8NovQcPeGsxA8nH46wxtLRbcRnraDgusal2FNyeGSfVlFt2kW22bWDQe3+X/Twej6YJy3raC32futRRXDKXKxwCeYzDR+KZUihYxYi6zZBfk9s3t0DXglPIUZ1FCoJWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778417987; c=relaxed/relaxed;
	bh=mW+6YCnMMcG+N3STMPBDPuy5FUn5TKVoLDPBk6Mi4t0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdNKVxu3V86/VZMMf0GFfqJewN83QFHkV2vZCvmV9YH3ZNPQ7QdE+39QfKXvnczj/S55xyQoAqnJtvS5uvwlZXr6gRt0DNCW1c+z9xn6jB3U4RqLvSVD6Q9uI1ce43pmUsojnRLnuBoCl1gdX6MMqTLGVBB/PmAtQgijRmg5cLvVdssIyMXXkNER+noQTXZ4+nJDl6QWy/yPSbLok2ETQ8kp9wgy+ihnkOETDDr90WX5PllG1P7FixhTpYG3M7dfrHyrdYjeyN90X7X5aTRX/+6bLWAYZRaQy4vs88efocDX24XU03yZbPs5UvF06VGaJRi5y3gNh9VuFhzE5q7xkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WI+9yRs2; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WI+9yRs2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gD2xt2PnLz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2026 22:59:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2537343ACA;
	Sun, 10 May 2026 12:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A71C2BCF6;
	Sun, 10 May 2026 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778417984;
	bh=kUmsgLX1nU1TZOEe6JDVbQeCrALlJrbC2ra/r/oY25c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WI+9yRs2J5WWa5MlZzLnbKbbQKRwTPVdMNy7FbUFlgw5jtJ3rFdHo9of+XmGy1qt+
	 +VCILRTY4nEyScWX06/9OMmdG37+AcYPKJSWKHxnfjFPbO0By7rIbzdKJAvGHqCVGz
	 Rrz69qJ27bh7o+TVLN4i+GtpPyZ+QAbqKr9TU02hqWY9MjfqxBQgr0mg3/sfcqud/7
	 HExhd8JW9h3IRPpxi2byMbodAMtKwAEzqZ4yadrVykH6OwY69cnkRae3NXTOtzaw7V
	 7SEB7SBzfalwBKwBHYVTBPV4eb3mgg4VtQq1Nu/8DbtQ+8I9k37+QIh8a/6FTfRyna
	 ykHvUQcZEBSsw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=lobster-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wM3kz-00000000nwK-2uPj;
	Sun, 10 May 2026 12:59:41 +0000
Date: Sun, 10 May 2026 14:00:15 +0100
Message-ID: <87v7cva080.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/6] fsl-mc: Move over to device MSI infrastructure
In-Reply-To: <177209938125.547814.7154250802402503122.b4-ty@kernel.org>
References: <20260224100936.3752303-1-maz@kernel.org>
	<177209938125.547814.7154250802402503122.b4-ty@kernel.org>
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
X-SA-Exim-Rcpt-To: chleroy@kernel.org, ioana.ciornei@nxp.com, tglx@kernel.org, sascha.bischoff@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 26 Feb 2026 09:50:43 +0000,
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> 
> 
> On Tue, 24 Feb 2026 10:09:30 +0000, Marc Zyngier wrote:
> > This is the second drop of this cleanup series for the fsl-mc MSI
> > infrastructure, initially posted at [1].
> > 
> > * From v1 [1]:
> > 
> >   - Drop the now unused DOMAIN_BUS_FSL_MC_MSI bus token
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/6] fsl-mc: Remove MSI domain propagation to sub-devices
>       commit: 1fb7392ee3408494d4d62c09a8c3e5f5934caba7
> [2/6] fsl-mc: Add minimal infrastructure to use platform MSI
>       commit: 0c9f522f2d41c7e055a602a0d2c41dc7af01010b
> [3/6] irqchip/gic-v3-its: Add fsl_mc device plumbing to the msi-parent handling
>       commit: cf3179b4e53f527aba9f0c6c3b921619c8adf761
> [4/6] fsl-mc: Switch over to per-device platform MSI
>       commit: 4a958e47c246fa3fb8954f4303e0da15ab3d026d
> [5/6] fsl-mc: Remove legacy MSI implementation
>       commit: 14b1cbcc6cec0b02298f4adf717646cd943b7ef6
> [6/6] platform-msi: Remove stale comment
>       commit: f0a2eac6a597268034fd40d92c1469182438b53d

Is there any particular reason why this didn't make it into 7.1?

I was really looking forward to some additional cleanups in the GICv3
ITS code, and this gets in the way.

Do I need to respin it?

Thanks,

	M.

-- 
Jazz isn't dead. It just smells funny.

