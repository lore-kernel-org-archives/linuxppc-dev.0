Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25893C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 22:47:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C63620840
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 22:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0OgAqMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C63620840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rdh44KXWzF3V8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 09:47:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A0OgAqMG";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=nc3z=nt=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="A0OgAqMG"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rdbW5rRjzF3P0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 09:43:03 +1100 (AEDT)
Received: from localhost (unknown [208.72.13.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5934620844;
 Thu,  8 Nov 2018 22:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1541716981;
 bh=CZ0Ic1ELIM9SJl7Wg6u0NXiSoeVueCcqe0ZVBgVoFAw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A0OgAqMGMabiNBmUU0+4niKxA8gxwcLSEoP2lmRFEj/9WzpHZCi30b4FvyKjhJxhp
 CzeYe5h3s/2AyLGEAQrawRGze2o+IeSR/eBw9klYcvBN0gRH+HvADixiO6mPsfDMC6
 y7soYYn2zbv5GjOwgAQwhNpMtQo4emzQZYQL/RVY=
Date: Thu, 8 Nov 2018 14:42:55 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181108224255.GA20619@kroah.com>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com>
 <20181108200855.GE41183@google.com>
 <20181108220117.GA11466@kroah.com>
 <20181108223258.GD2932@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108223258.GD2932@localhost.localdomain>
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
Cc: alex_gagniuc@dellteam.com, Sam Bobroff <sbobroff@linux.ibm.com>,
 linux-pci@vger.kernel.org, shyam_iyer@dell.com, linux-kernel@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, Oliver O'Halloran <oohall@gmail.com>,
 austin_bolen@dell.com, linuxppc-dev@lists.ozlabs.org,
 Jonathan Derrick <jonathan.derrick@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 08, 2018 at 03:32:58PM -0700, Keith Busch wrote:
> On Thu, Nov 08, 2018 at 02:01:17PM -0800, Greg Kroah-Hartman wrote:
> > On Thu, Nov 08, 2018 at 02:09:17PM -0600, Bjorn Helgaas wrote:
> > > I'm having second thoughts about this.  One thing I'm uncomfortable
> > > with is that sprinkling pci_dev_is_disconnected() around feels ad hoc
> > > instead of systematic, in the sense that I don't know how we convince
> > > ourselves that this (and only this) is the correct place to put it.
> > 
> > I think my stance always has been that this call is not good at all
> > because once you call it you never really know if it is still true as
> > the device could have been removed right afterward.
> > 
> > So almost any code that relies on it is broken, there is no locking and
> > it can and will race and you will loose.
> 
> AIUI, we're not trying to create code to rely on this. This more about
> reducing reliance on hardware. If the software misses the race once and
> accesses disconnected device memory, that's usually not a big deal to
> let hardware sort it out, but the point is not to push our luck.

Then why even care about this call at all?  If you need to really know
if the read worked, you have to check the value.  If the value is FF
then you have a huge hint that the hardware is now gone.  And you can
rely on it being gone, you can never rely on making the call to the
function to check if the hardware is there to be still valid any point
in time after the call returns.

> Surprise hot remove is empirically more reliable the less we interact
> with hardware and firmware. That shouldn't be necessary, but is just an
> unfortunate reality.

You are not "interacting", you are reading/writing to the hardware, as
you have to do so.  So I really don't understand what you are talking
about here, sorry.

greg k-h
