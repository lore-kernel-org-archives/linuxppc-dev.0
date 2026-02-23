Return-Path: <linuxppc-dev+bounces-17035-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1DFE98E06
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Feb 2026 09:02:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKFFd0xD7z3bhG;
	Mon, 23 Feb 2026 20:01:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771837269;
	cv=none; b=LYkaiaZKzUS9Qf/hVlb/XSh2FFPeTKndwrIzcKgWA2aTRNyhgfRYvK7G0sXPbE8H+6plGx465tRf1Z+sviLjQRW+aX2z1TcRROkHJvpY20sjoEUHjpMbuKw0rpV/5jTEPSMTBwMGKuhI8MLYgomH/h5hUBFEnIRkLkf9Q3BQ0hgSKDDYTLMvQFve+5zudIZW9LOYHGr0nZuVjWZaezA7XmSV1xKi5nWtgfKHzSYxLL4f9WHWuqsSItQbM4L32ls2pR0piTr/IJHpkHqhATmX5PLLvRiApsJ+w6BluFN2BArHBb3auVJvFaEUWW7Xn11+b6WI7wUdbVZRNZiyUj5NIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771837269; c=relaxed/relaxed;
	bh=P5lFFDMfBIrpW6XseQq1jJQjIZGNoUH+oNYvxSeo3qs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYPtFROyTgv4JB3a7Fr9SU31kuA88BQ4vjBKmQFmj14qpV2lzu59mv2v32BQVNRlVQ+JY86SQReStWw4Auqm//asWBfmz2JSHZnumCru58jmwowx4/U+/tmJgZmRM2Gm3obnQbdMKMEYd1zdMvyJNcduxyJ1ymNKeCYiPG1Hy14FhdDk6LplTKCElqw6R0gXN/sOEg9rBsv2/vhqbn8uOYasBa1CxP2p7snSFMqfkHQk+wFuJC0kQ+jhr6RHDdOhSuIVOKCu6rwa3+P5Fb+TEk4nXG28awU33uIa7Y2dRa2Cy4RTWwDbTKbFAh8U/m6DIiBfeLrC3AX5IYfYtx9Qhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MGC6nUA+; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MGC6nUA+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKFFb5Nd7z3bf2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2026 20:01:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 05FDF42D8B;
	Mon, 23 Feb 2026 09:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0789C116C6;
	Mon, 23 Feb 2026 09:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771837264;
	bh=4vuzCx1aOjRijmhGiJ5+UQ/LV7nStKuzYY7m4/tcVfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MGC6nUA+8iEkHYRirJB7Fcsr4TSf/P2GGv2A1OibnMvl75otkg0iwX0lTUqtPDN43
	 XqlhzXURlya0mXm/UG5rpAK+5iFNM4fOXrbOU5mP4QXNg0jisaAfQgRmJOVX8nsuYL
	 ZkkPwctaDiai5Lv2zFwqRlwKs7/ItkNZh66XdkS2gxdyIkNWH/vC0ydrjPG29gplEd
	 6N9vzfrI0+TWZPRSpEGcN3peP25qBdibf7cFf3EAuAtcbiEvaRrI5BuQ/dHLtjOESE
	 wk5TRZ/4BRK/Q7RdQGdHlGWhnfgmAdDoaT9XnTlGm8vxLH8ffNgnIvtB7sWGtGmQx+
	 Io5fZgB8X07dA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vuRoM-0000000Cun9-2AMJ;
	Mon, 23 Feb 2026 09:01:02 +0000
Date: Mon, 23 Feb 2026 09:01:02 +0000
Message-ID: <86qzqbal69.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/6] irqchip/gic-v3-its: Add fsl_mc device plumbing to the msi-parent handling
In-Reply-To: <87seasv11z.ffs@tglx>
References: <20260218135203.2267907-1-maz@kernel.org>
	<20260218135203.2267907-4-maz@kernel.org>
	<87seasv11z.ffs@tglx>
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
X-SA-Exim-Rcpt-To: tglx@kernel.org, ioana.ciornei@nxp.com, chleroy@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sun, 22 Feb 2026 22:57:44 +0000,
Thomas Gleixner <tglx@kernel.org> wrote:
> 
> On Wed, Feb 18 2026 at 13:52, Marc Zyngier wrote:
> > Make the ITS code aware of fsl_mc devices by plumbing the devid
> > retrieval primitive.
> >
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/irqchip/irq-gic-its-msi-parent.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
> > index 12f45228c8674..532c0d626ca04 100644
> > --- a/drivers/irqchip/irq-gic-its-msi-parent.c
> > +++ b/drivers/irqchip/irq-gic-its-msi-parent.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/acpi_iort.h>
> >  #include <linux/of_address.h>
> >  #include <linux/pci.h>
> > +#include <linux/fsl/mc.h>
> >  
> >  #include "irq-gic-its-msi-parent.h"
> >  #include <linux/irqchip/irq-msi-lib.h>
> > @@ -186,9 +187,11 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
> >  {
> >  	struct msi_domain_info *msi_info;
> >  	u32 dev_id;
> > -	int ret;
> > +	int ret = 0;
> >  
> > -	if (dev->of_node)
> > +	if (dev_is_fsl_mc(dev))
> > +		dev_id = fsl_mc_get_msi_id(dev);
> > +	else if (dev->of_node)
> >  		ret = of_pmsi_get_msi_info(domain->parent, dev, &dev_id, NULL);
> >  	else
> >  		ret = iort_pmsi_get_dev_id(dev, &dev_id);
> 
> This rejects as you are building against an unmerged change (I assume
> it's Lorenzos GIC5 stuff). I can fix it up when applying.

That was against vanilla 6.19. I'll rebase on -rc1 to satisfy myself
that this is still doing the right thing after the ACPI crap fest, and
repost the result.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

