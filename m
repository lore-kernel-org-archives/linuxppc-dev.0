Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2717C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 13:52:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11DD218D2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 13:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Szi7IsHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11DD218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q1w43l4pzDqVf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 23:52:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q1qb34sVzDqTZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 23:48:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Szi7IsHZ"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44q1qY4Jyvz8tPk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 23:48:25 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44q1qY1Ly6z9sB8; Wed, 24 Apr 2019 23:48:25 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Szi7IsHZ"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44q1qX47fmz9s9y
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2019 23:48:24 +1000 (AEST)
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 052BC218D2;
 Wed, 24 Apr 2019 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1556113702;
 bh=K1VkIZg+mS+KoGtGl0g9YAG07pIdl7IBYY8oj+x7jCk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Szi7IsHZ8YZdoH6ik5hXYaPlfncueiIk7rZ8UNlgdKgtURauXlE/+OuTpsWb+OisZ
 xxYoyY5P9U0Y3TC9KlVnU65aHm2EuP4BEp95roVEq+o3GB3JuTBMnP8kLKQFoJGNms
 +gF+SCyWilxOi5rBS++bdbI1mWfuLNk0Al48sNEY=
Date: Wed, 24 Apr 2019 15:48:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Diana Madalina Craciun <diana.craciun@nxp.com>
Subject: Re: [PATCH stable v4.4 00/52] powerpc spectre backports for 4.4
Message-ID: <20190424134820.GC20271@kroah.com>
References: <20190421142037.21881-1-mpe@ellerman.id.au>
 <20190421163421.GA8449@kroah.com>
 <VI1PR0401MB24639DFFA532DF374BB86070FF220@VI1PR0401MB2463.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB24639DFFA532DF374BB86070FF220@VI1PR0401MB2463.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: "npiggin@gmail.com" <npiggin@gmail.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "msuchanek@suse.de" <msuchanek@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 22, 2019 at 03:27:56PM +0000, Diana Madalina Craciun wrote:
> On 4/21/2019 7:34 PM, Greg KH wrote:
> > On Mon, Apr 22, 2019 at 12:19:45AM +1000, Michael Ellerman wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> Hi Greg/Sasha,
> >>
> >> Please queue up these powerpc patches for 4.4 if you have no objections.
> > why?  Do you, or someone else, really care about spectre issues in 4.4?
> > Who is using ppc for 4.4 becides a specific enterprise distro (and they
> > don't seem to be pulling in my stable updates anyway...)?
> 
> We (NXP) received questions from customers regarding Spectre mitigations
> on kernel 4.4. Not sure if they really need them as some systems are
> enclosed embedded ones, but they asked for them.

"Asking about", and "actually needing them" are two different things, as
you state.  It would be good to get confirmation from someone that these
are "actually needed".

thanks,

greg k-h
