Return-Path: <linuxppc-dev+bounces-25085-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDA2C54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 09:36:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9kbh03dKz2yYd;
	Thu, 30 Jul 2026 19:36:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785404175;
	cv=none; b=AVZvg/05f9Yhzb/0nJ6sSurvAecGesxDbMEvJevNDiRn6J4NpdGnshEb/Xap1Lq0MLShtHjmofM8LZpIDZGaKkpRNIHypP1evR4DRBzV/tJcxdbpwAmC8IHn+03eB735TNv4Ft29fOVcP6YctGrnYGJnlKr3t2FtP4KkF6nu2tHEIViKdpQ6wl4IOfVZKn7VSkZ9eDh+ekx5/mikgfTUswRzcMNYDeO2hgeKWmEogFBtF4VPMYf50Qkp/E7QR4VVdxEnbsLZD335wMbWicvu03p6NG6Alx9owTRnWktwyNkGDoFBzSj3bV5qEL1aPOa7ie5CJNIfnBxUkgrc6jtKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785404175; c=relaxed/relaxed;
	bh=BtGBUghZ3NVIAEOKhEMfE4OWjyrtG5sqoDoPPz9NCKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0yX+eLGQ6Q1s/3Ump/9VssDO2wJ9kFd0rQQW4lR7r8gGw7hSXW0HPCW+dcqovkO3PjBIgvALBC746F/MluC9oCXZ/YeTX7f4//o8XKG+0zfSV4T7UvqXTLRG4gH5cWw8t0mqQL/WWkn3cHxAgw8HVZbqOdbjpMJkdgYlcDQvUv6qxFGJ5Dv5EUVnnOAgkPinnozm+vyOM7bWkpRkM7sgOKdZ4AWYoY47jkYGp+sRHNZkjwWwFBeofGzXc1XkpQAtgFvzRvNXelmvW7s/FV5Ck8aH90W0NSHIWvwlUajWgIJ9mR98W9Wgr0oo7iF2c3WNWimkgPNpM9p15e8/DlVgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lHRpTryO; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lHRpTryO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 413 seconds by postgrey-1.37 at boromir; Thu, 30 Jul 2026 19:36:14 AEST
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9kbf4w76z2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 19:36:13 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2C50B4E41001;
	Thu, 30 Jul 2026 09:29:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E530A602B8;
	Thu, 30 Jul 2026 09:29:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 074B311C15912;
	Thu, 30 Jul 2026 11:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785403749; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BtGBUghZ3NVIAEOKhEMfE4OWjyrtG5sqoDoPPz9NCKI=;
	b=lHRpTryOpV8JKVIpccrVl2dKXfsUls7y1AdqNdu+lbrNBdtrNAs6PeL/OlQ7OxIRNx/Dwq
	hSoYbDY+ObMspxRJIPdg8y+9840xOr+OvewITwTLqWvJiKVwz/+Rz1NEwWP73Z4KURSzox
	b96T/fWI9sr1mMgS3MSzmKgVti/5PCxnIx0VFJnocoufsgrdaz7JheIudlYyWGmAkwGPLQ
	lAFLyag3CjNETsoxAIiqN3q4P9aW38M37y8u1eMIoEUu/IZ5vAc9dJek1a3w0ujpookQaW
	PGFESeP4ZrCZLJ3/Q0kfpee/sk2QAcVYqbaTlIq9/TFvZRx5FyzfGFEC7H5qHA==
Date: Thu, 30 Jul 2026 11:29:05 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, Paul
 Louvel <paul.louvel@bootlin.com>
Subject: Re: [PATCH] soc: fsl: qe: properly scan GPIO nodes at startup
Message-ID: <20260730112905.23a4b2f2@bootlin.com>
In-Reply-To: <0e5628ae-886a-4a8e-8a35-6402737ad65a@kernel.org>
References: <04dc047f8958a78a920f0a88ca3bd8bf70c56187.1785333986.git.chleroy@kernel.org>
	<20260729172156.4371a8bc@bootlin.com>
	<0e5628ae-886a-4a8e-8a35-6402737ad65a@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christophe,

On Thu, 30 Jul 2026 10:11:29 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Hi Hervé,
> 
> Le 29/07/2026 à 17:21, Herve Codina a écrit :
> > Hi Christophe,
> > 
> > On Wed, 29 Jul 2026 16:10:36 +0200
> > "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> >   
> >> Before commit 156460811def ("soc: fsl: qe: Change GPIO driver to a
> >> proper platform driver") qe_add_gpiochips() was walking the device
> >> tree to find all nodes with compatible "fsl,mpc8323-qe-pario-bank".
> >>
> >> After that commit the discovery is handled by the platform core,
> >> therefore it is necessary to call of_platform_default_populate() on
> >> the par_io node.
> >>
> >> Fixes: 156460811def ("soc: fsl: qe: Change GPIO driver to a proper platform driver")
> >> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> >> ---
> >>   drivers/soc/fsl/qe/qe_io.c | 15 +++++++++++++++
> >>   1 file changed, 15 insertions(+)
> >>
> >> diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
> >> index a5e2d0e5ab51..02ca556c8db0 100644
> >> --- a/drivers/soc/fsl/qe/qe_io.c
> >> +++ b/drivers/soc/fsl/qe/qe_io.c
> >> @@ -15,6 +15,7 @@
> >>   #include <linux/errno.h>
> >>   #include <linux/module.h>
> >>   #include <linux/ioport.h>
> >> +#include <linux/of_platform.h>
> >>   
> >>   #include <asm/io.h>
> >>   #include <soc/fsl/qe/qe.h>
> >> @@ -184,3 +185,17 @@ int par_io_of_config(struct device_node *np)
> >>   	return 0;
> >>   }
> >>   EXPORT_SYMBOL(par_io_of_config);
> >> +
> >> +static int __init par_io_populate(void)
> >> +{
> >> +	struct device_node *np = of_find_node_by_name(NULL, "par_io");
> >> +
> >> +	if (!np)
> >> +		return 0;
> >> +
> >> +	of_platform_default_populate(np, NULL, NULL);
> >> +	of_node_put(np);
> >> +
> >> +	return 0;
> >> +}
> >> +arch_initcall(par_io_populate);  
> > 
> > 
> > The par_io node is a sub-node of the soc@xxx node.
> > The soc@xxx node is simple-bus compatible. This child node should be
> > populated.
> > 
> > Why do we need this additional of_platform_default_populate?
> > 
> > Also par_io node has a compatible. Maybe the related driver should call
> > of_platform_populate() to populate children of par_io if needed. If this
> > driver is missing, maybe it should be created.
> > 
> > Do I miss something?  
> 
> As discussed together off-line, at the time being the par_io driver is 
> not a platform driver. par_io_init() is called from setup_arch() by some 
> board setups.
> 
> In order to fix the regression, I keep it minimal with an 
> arch_initcall() function which is equivalent to what we had before 
> changing this driver to a platform driver. It will also ease applying 
> the fix to stable without too much churn.
> 
> It will still be possible to rework par_io driver in a follow-up patch 
> and change it to a propoer platform driver.
> 

Yes, indeed, this makes sense.

Thanks for the clarification.

Best regards,
Hervé

