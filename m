Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5531C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 22:53:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4621D20840
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 22:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1kPRhi5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4621D20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rdqy2sFSzF3Rk
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 09:53:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="1kPRhi5R";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=nc3z=nt=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="1kPRhi5R"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rdn117N0zDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 09:51:17 +1100 (AEDT)
Received: from localhost (unknown [208.72.13.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 32FA720840;
 Thu,  8 Nov 2018 22:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1541717475;
 bh=+A4Yk9rsTJ5fgMBsXuMp1vbc52NbBU5sjznE6bIOTIQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1kPRhi5R6xhBL936bs2ojfbazsPbs8i7QPLtXSb3qM+1cRjgN5B0ZPW3P/J0QjNJY
 zaa3UxUZDAbKzm/rimMNkJYno/5RBDppg6XzXtVuDAkVexHzyuscVy44jIDRIa0axa
 bq/phPyVh9R88PYRsUn9VaFraKn5vo0z3Glhth8Q=
Date: Thu, 8 Nov 2018 14:51:09 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex_Gagniuc@dellteam.com
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181108225109.GA3023@kroah.com>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com>
 <20181108200855.GE41183@google.com>
 <20181108220117.GA11466@kroah.com>
 <20181108223258.GD2932@localhost.localdomain>
 <20181108224255.GA20619@kroah.com>
 <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
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
Cc: Shyam.Iyer@dell.com, sbobroff@linux.ibm.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, keith.busch@intel.com, lukas@wunner.de,
 helgaas@kernel.org, mr.nuke.me@gmail.com, Austin.Bolen@dell.com,
 oohall@gmail.com, linuxppc-dev@lists.ozlabs.org, jonathan.derrick@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 08, 2018 at 10:49:08PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 11/08/2018 04:43 PM, Greg Kroah-Hartman wrote:
> > 
> > [EXTERNAL EMAIL]
> > Please report any suspicious attachments, links, or requests for sensitive information.
> > 
> > 
> > On Thu, Nov 08, 2018 at 03:32:58PM -0700, Keith Busch wrote:
> >> On Thu, Nov 08, 2018 at 02:01:17PM -0800, Greg Kroah-Hartman wrote:
> >>> On Thu, Nov 08, 2018 at 02:09:17PM -0600, Bjorn Helgaas wrote:
> >>>> I'm having second thoughts about this.  One thing I'm uncomfortable
> >>>> with is that sprinkling pci_dev_is_disconnected() around feels ad hoc
> >>>> instead of systematic, in the sense that I don't know how we convince
> >>>> ourselves that this (and only this) is the correct place to put it.
> >>>
> >>> I think my stance always has been that this call is not good at all
> >>> because once you call it you never really know if it is still true as
> >>> the device could have been removed right afterward.
> >>>
> >>> So almost any code that relies on it is broken, there is no locking and
> >>> it can and will race and you will loose.
> >>
> >> AIUI, we're not trying to create code to rely on this. This more about
> >> reducing reliance on hardware. If the software misses the race once and
> >> accesses disconnected device memory, that's usually not a big deal to
> >> let hardware sort it out, but the point is not to push our luck.
> > 
> > Then why even care about this call at all?  If you need to really know
> > if the read worked, you have to check the value.  If the value is FF
> > then you have a huge hint that the hardware is now gone.  And you can
> > rely on it being gone, you can never rely on making the call to the
> > function to check if the hardware is there to be still valid any point
> > in time after the call returns.
> 
> In the case that we're trying to fix, this code executing is a result of 
> the device being gone, so we can guarantee race-free operation. I agree 
> that there is a race, in the general case. As far as checking the result 
> for all F's, that's not an option when firmware crashes the system as a 
> result of the mmio read/write. It's never pretty when firmware gets 
> involved.

If you have firmware that crashes the system when you try to read from a
PCI device that was hot-removed, that is broken firmware and needs to be
fixed.  The kernel can not work around that as again, you will never win
that race.

thanks,

greg k-h
