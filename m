Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5661C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 22:39:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7F620844
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 22:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7F620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rdW46VJyzF13P
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 09:39:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=keith.busch@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rdSD2JcRzF3Tb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 09:36:40 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Nov 2018 14:36:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,481,1534834800"; d="scan'208";a="279543465"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by fmsmga006.fm.intel.com with ESMTP; 08 Nov 2018 14:36:37 -0800
Date: Thu, 8 Nov 2018 15:32:58 -0700
From: Keith Busch <keith.busch@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181108223258.GD2932@localhost.localdomain>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com>
 <20181108200855.GE41183@google.com>
 <20181108220117.GA11466@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108220117.GA11466@kroah.com>
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

On Thu, Nov 08, 2018 at 02:01:17PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Nov 08, 2018 at 02:09:17PM -0600, Bjorn Helgaas wrote:
> > I'm having second thoughts about this.  One thing I'm uncomfortable
> > with is that sprinkling pci_dev_is_disconnected() around feels ad hoc
> > instead of systematic, in the sense that I don't know how we convince
> > ourselves that this (and only this) is the correct place to put it.
> 
> I think my stance always has been that this call is not good at all
> because once you call it you never really know if it is still true as
> the device could have been removed right afterward.
> 
> So almost any code that relies on it is broken, there is no locking and
> it can and will race and you will loose.

AIUI, we're not trying to create code to rely on this. This more about
reducing reliance on hardware. If the software misses the race once and
accesses disconnected device memory, that's usually not a big deal to
let hardware sort it out, but the point is not to push our luck.

Surprise hot remove is empirically more reliable the less we interact
with hardware and firmware. That shouldn't be necessary, but is just an
unfortunate reality.
