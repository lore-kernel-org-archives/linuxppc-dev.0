Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6949C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 11:36:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAE620883
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 11:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tozr26f2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAE620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rylR3m5hzF3bh
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 22:36:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tozr26f2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=8jp/=nu=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tozr26f2"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ryh12wcYzF3Zj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 22:33:01 +1100 (AEDT)
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A84C520825;
 Fri,  9 Nov 2018 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1541763178;
 bh=0DUF34A95pkCj93K68jf3LRXiQrTfL8ZmLN1ZhB5A30=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tozr26f2KCK6bZF3T7jOTCNnJj3hvHyXvM6dbBm2a+JTH/ehrOGD+zkg5kg8nVp7w
 US8MDdsB032ur6avIu0eUoXA73d85ixGax85t3gYlhEEtZP7V8hxbdAk2lugcmLN7q
 SBaoCeqTJbteJ1e4tj9KOAH7jHGwNThWie8o1Yeg=
Date: Fri, 9 Nov 2018 03:32:57 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181109113257.GB29785@kroah.com>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com>
 <20181108200855.GE41183@google.com>
 <20181108220117.GA11466@kroah.com>
 <20181109072953.ox7qfpnibb7drmf6@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109072953.ox7qfpnibb7drmf6@wunner.de>
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
 keith.busch@intel.com, Bjorn Helgaas <helgaas@kernel.org>,
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, Oliver O'Halloran <oohall@gmail.com>,
 austin_bolen@dell.com, linuxppc-dev@lists.ozlabs.org,
 Jonathan Derrick <jonathan.derrick@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 09, 2018 at 08:29:53AM +0100, Lukas Wunner wrote:
> On Thu, Nov 08, 2018 at 02:01:17PM -0800, Greg Kroah-Hartman wrote:
> > On Thu, Nov 08, 2018 at 02:09:17PM -0600, Bjorn Helgaas wrote:
> > > I'm having second thoughts about this.  One thing I'm uncomfortable
> > > with is that sprinkling pci_dev_is_disconnected() around feels ad hoc
> > 
> > I think my stance always has been that this call is not good at all
> > because once you call it you never really know if it is still true as
> > the device could have been removed right afterward.
> > 
> > So almost any code that relies on it is broken, there is no locking and
> > it can and will race and you will loose.
> 
> Hm, to be honest if that's your impression I think you must have missed a
> large portion of the discussion we've been having over the past 2 years.
> 
> Please consider reading this LWN article, particularly the "Surprise
> removal" section, to get up to speed:
> 
> https://lwn.net/Articles/767885/
> 
> You seem to be assuming that all we care about is the *return value* of
> an mmio read.  However a transaction to a surprise removed device has
> side effects beyond returning all ones, such as a Completion Timeout
> which, with thousands of transactions in flight, added up to many seconds
> to handle removal of an NVMe array and occasionally caused MCEs.

Again, I still claim this is broken hardware/firmware :)

> It is not an option to just blindly carry out device accesses even though
> it is known the device is gone, Completion Timeouts be damned.

I don't disagree with you at all, and your other email is great with
summarizing the issues here.

What I do object to is somehow relying on that function call as knowing
that the device really is present or not.  It's a good hint, yes, but
driver authors still have to be able to handle the bad data coming back
from when the call races with the device being removed.

> However there is more to it than just Completion Timeouts, this is all
> detailed in the LWN article.

And that's a great article and your work here is much appreciated.  I
think we are in violent agreement :)

thanks,

greg k-h
