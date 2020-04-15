Return-Path: <SRS0=owsf=57=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8E8C2BA19
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 19:34:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DE920732
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 19:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DE920732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492XbX4d4ZzDrB1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 05:34:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492XW324HWzDr9N
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2020 05:30:06 +1000 (AEST)
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1jOnhQ-0007A4-KH; Wed, 15 Apr 2020 14:27:52 -0500
Message-ID: <f2a1f91f92c0fe4bce46c28222dea355d96e2090.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Wang Wenhu
 <wenhu.wang@vivo.com>,  gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org
Date: Wed, 15 Apr 2020 14:27:51 -0500
In-Reply-To: <37b6b890-e537-7424-6b26-04565681f40a@c-s.fr>
References: <20200415124929.GA3265842@kroah.com>
 <20200415152442.122873-1-wenhu.wang@vivo.com>
 <20200415152442.122873-6-wenhu.wang@vivo.com>
 <37b6b890-e537-7424-6b26-04565681f40a@c-s.fr>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: christophe.leroy@c-s.fr, wenhu.wang@vivo.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel@vivo.com, mpe@ellerman.id.au
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v2,5/5] drivers: uio: new driver for fsl_85xx_cache_sram
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: kernel@vivo.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2020-04-15 at 18:52 +0200, Christophe Leroy wrote:
> 
> Le 15/04/2020 à 17:24, Wang Wenhu a écrit :
> > +
> > +		if (uiomem >= &info->mem[MAX_UIO_MAPS]) {
> 
> I'd prefer
> 		if (uiomem - info->mem >= MAX_UIO_MAPS) {
> 
> > +			dev_warn(&pdev->dev, "more than %d uio-maps for
> > device.\n",
> > +				 MAX_UIO_MAPS);
> > +			break;
> > +		}
> > +	}
> > +
> > +	while (uiomem < &info->mem[MAX_UIO_MAPS]) {
> 
> I'd prefer
> 
> 	while (uiomem - info->mem < MAX_UIO_MAPS) {
> 

I wouldn't.  You're turning a simple comparison into a division and a
comparison (if the compiler doesn't optimize it back into the original form),
and making it less clear in the process.

Of course, working with array indices to begin with instead of incrementing a
pointer would be more idiomatic.

> > +		uiomem->size = 0;
> > +		++uiomem;
> > +	}
> > +
> > +	if (info->mem[0].size == 0) {
> 
> Is there any point in doing all the clearing loop above if it's to bail 
> out here ?
> 
> Wouldn't it be cleaner to do the test above the clearing loop, by just 
> checking whether uiomem is still equal to info->mem ?

There's no point doing the clearing at all, since the array was allocated with
kzalloc().

> > +		dev_err(&pdev->dev, "error no valid uio-map configured\n");
> > +		ret = -EINVAL;
> > +		goto err_info_free_internel;
> > +	}
> > +
> > +	info->version = "0.1.0";
> 
> Could you define some DRIVER_VERSION in the top of the file next to 
> DRIVER_NAME instead of hard coding in the middle on a function ?

That's what v1 had, and Greg KH said to remove it.  I'm guessing that he
thought it was the common-but-pointless practice of having the driver print a
version number that never gets updated, rather than something the UIO API
(unfortunately, compared to a feature query interface) expects.  That said,
I'm not sure what the value is of making it a macro since it should only be
used once, that use is self documenting, it isn't tunable, etc.  Though if
this isn't a macro, UIO_NAME also shouldn't be (and if it is made a macro
again, it should be UIO_VERSION, not DRIVER_VERSION).

Does this really need a three-part version scheme?  What's wrong with a
version of "1", to be changed to "2" in the hopefully-unlikely event that the
userspace API changes?  Assuming UIO is used for this at all, which doesn't
seem like a great fit to me.

-Scott


