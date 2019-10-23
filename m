Return-Path: <SRS0=qe53=YQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655BDCA9EB7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Oct 2019 14:34:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02162173B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Oct 2019 14:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iJ2v+CSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02162173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ytDg4ThGzDqSC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Oct 2019 01:34:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=armlinux.org.uk
 (client-ip=2001:4d48:ad52:3201:214:fdff:fe10:1be6;
 helo=pandora.armlinux.org.uk;
 envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.b="iJ2v+CSs"; dkim-atps=neutral
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ytBM3S3tzDqF5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Oct 2019 01:32:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cjPuS08fLHV8el8EaxndD6I/d/IQPJlUbi111PAD/l4=; b=iJ2v+CSstuLBKM08pLTx576aM
 VxntxxCQSSo10E8/SL6JaCu7DGHBQbYKoGE9AWr2TOiZmWMAk1KfV1lMlOkN3GsHB0ajoUGKqdzj8
 u202GiupQQbUAZAkvODo9ATZleYIkhkrpJRPRnu8LY4MSuAHQSWl3ggq8+45cAm2o2shQTiCGE7oc
 QAJHHRgOHofIUFTKn/4GK+tcL3Hv9lV0IQf2zQLc3zHoiaLLO8l4DaQpQFUp1fN3yI7bBQAM2O2eN
 Ph+2cwxlod+dsiP0rzFs98e6Yows2hrmXXJjtI8ixe3nYg/6TeHUpejwD6D/kMIr5FIou+yUS0Rpj
 F7KtKig6Q==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58106)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1iNHg8-0005SK-LT; Wed, 23 Oct 2019 15:32:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1iNHg7-0005cA-5R; Wed, 23 Oct 2019 15:31:59 +0100
Date: Wed, 23 Oct 2019 15:31:59 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
Message-ID: <20191023143159.GB25745@shell.armlinux.org.uk>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
 <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
 <20191015131750.GV25745@shell.armlinux.org.uk>
 <87muds586t.fsf@mpe.ellerman.id.au>
 <31d58f086f964937b27209bc18b334d9c9791767.camel@kernel.crashing.org>
 <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, mad skateman <madskateman@gmail.com>,
 linux-mmc <linux-mmc@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <chzigotzky@xenosoft.de>,
 "contact@a-eon.com" <contact@a-eon.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 23, 2019 at 08:52:33AM -0500, Rob Herring wrote:
> > I think this should have been done the other way around and default to
> > coherent since most traditional OF platforms are coherent, and you
> > can't just require those DTs to change.
> 
> You can blame me. This was really only intended for cases where
> coherency is configurable on a per peripheral basis and can't be
> determined in other ways.
> 
> The simple solution here is simply to use the compatible string for
> the device to determine coherent or not.

It really isn't that simple.

There are two aspects to coherency, both of which must match:

1) The configuration of the device
2) The configuration of the kernel's DMA API

(1) is controlled by the driver, which can make the decision any way
it pleases.

(2) on ARM64 is controlled depending on whether or not "dma-coherent"
is specified in the device tree, since ARM64 can have a mixture of
DMA coherent and non-coherent devices.

A mismatch between (1) and (2) results in data corruption, potentially
eating your filesystem.  So, it's very important that the two match.

These didn't match for the LX2160A, but, due to the way CMA was working,
we sort of got away with it, but it was very dangerous as far as data
safety went.

Then, a change to CMA happened which moved where it was located, which
caused a regression.  Reverting the CMA changes didn't seem to be an
option, so another solution had to be found.

I started a discussion on how best to solve this:

https://archive.armlinux.org.uk/lurker/thread/20190919.041320.1e53541f.en.html

and the solution that the discussion came out with was the one that has
been merged - which we now know caused a regression on PPC.

Using compatible strings doesn't solve the issue: there is no way to
tell the DMA API from the driver that the device is coherent.  The
only way to do that is via the "dma-coherent" property in DT on ARM64.

To say that this is a mess is an under-statement, but we seem to have
ended up here because of a series of piece-meal changes that don't seem
to have been thought through enough.

So, what's the right way to solve this, and ensure that the DMA API and
device match as far as their coherency expectations go?  Revert all the
changes for sdhci-of-esdhc and CMA back to 5.0 or 5.1 state?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
