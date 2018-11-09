Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDBFC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 16:42:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8EF20818
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 16:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8EF20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s5Xb3xXXzF3Zq
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 03:42:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=keith.busch@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s5VR17PGzF3ZG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 03:40:10 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Nov 2018 08:40:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,483,1534834800"; d="scan'208";a="106901690"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by orsmga001.jf.intel.com with ESMTP; 09 Nov 2018 08:40:06 -0800
Date: Fri, 9 Nov 2018 09:36:29 -0700
From: Keith Busch <keith.busch@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181109163629.GF2932@localhost.localdomain>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com>
 <20181108200855.GE41183@google.com>
 <20181108220117.GA11466@kroah.com>
 <20181109072953.ox7qfpnibb7drmf6@wunner.de>
 <20181109113257.GB29785@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109113257.GB29785@kroah.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
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

On Fri, Nov 09, 2018 at 03:32:57AM -0800, Greg Kroah-Hartman wrote:
> On Fri, Nov 09, 2018 at 08:29:53AM +0100, Lukas Wunner wrote:
> > On Thu, Nov 08, 2018 at 02:01:17PM -0800, Greg Kroah-Hartman wrote:
> > > On Thu, Nov 08, 2018 at 02:09:17PM -0600, Bjorn Helgaas wrote:
> > > > I'm having second thoughts about this.  One thing I'm uncomfortable
> > > > with is that sprinkling pci_dev_is_disconnected() around feels ad hoc
> > > 
> > > I think my stance always has been that this call is not good at all
> > > because once you call it you never really know if it is still true as
> > > the device could have been removed right afterward.
> > > 
> > > So almost any code that relies on it is broken, there is no locking and
> > > it can and will race and you will loose.
> > 
> > Hm, to be honest if that's your impression I think you must have missed a
> > large portion of the discussion we've been having over the past 2 years.
> > 
> > Please consider reading this LWN article, particularly the "Surprise
> > removal" section, to get up to speed:
> > 
> > https://lwn.net/Articles/767885/
> > 
> > You seem to be assuming that all we care about is the *return value* of
> > an mmio read.  However a transaction to a surprise removed device has
> > side effects beyond returning all ones, such as a Completion Timeout
> > which, with thousands of transactions in flight, added up to many seconds
> > to handle removal of an NVMe array and occasionally caused MCEs.
> 
> Again, I still claim this is broken hardware/firmware :)

Indeed it is, but I don't want to abandon people with hardware in hand
if we can make it work despite being broken. Perfection is the enemy of
good. :)
 
> > It is not an option to just blindly carry out device accesses even though
> > it is known the device is gone, Completion Timeouts be damned.
> 
> I don't disagree with you at all, and your other email is great with
> summarizing the issues here.
> 
> What I do object to is somehow relying on that function call as knowing
> that the device really is present or not.  It's a good hint, yes, but
> driver authors still have to be able to handle the bad data coming back
> from when the call races with the device being removed.

The function has always been a private interface. It is not available
for drivers to rely on.

The only thing we're trying to accomplish is not start a transaction
if software knows it will not succeed. There are certainly times when
a transaction will fail that software does not forsee, but we're not
suggesting the intent handles that either.
