Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F34C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 20:29:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7CF2175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 20:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7CF2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wGLB5SHTzF3C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 07:29:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=keith.busch@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wGHv2d2mzF3Nh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 07:27:03 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Nov 2018 12:27:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,233,1539673200"; d="scan'208";a="108104413"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by fmsmga001.fm.intel.com with ESMTP; 14 Nov 2018 12:26:59 -0800
Date: Wed, 14 Nov 2018 13:23:33 -0700
From: Keith Busch <keith.busch@intel.com>
To: Alex_Gagniuc@Dellteam.com
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181114202333.GE11416@localhost.localdomain>
References: <20181108224255.GA20619@kroah.com>
 <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
 <20181108225109.GA3023@kroah.com>
 <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
 <5da8d8aa9f3818af649b1ac547bc4e6062626ddf.camel@gmail.com>
 <df85813c9860463d85f6c302dfe07b12@ausx13mps321.AMER.DELL.COM>
 <20181113050240.GA182139@google.com>
 <19136f44cd5c45e79bbef7e78a6bf332@ausx13mps321.AMER.DELL.COM>
 <20181114055956.GA144931@google.com>
 <1eb0fa27924f426992715684f5e63346@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb0fa27924f426992715684f5e63346@ausx13mps321.AMER.DELL.COM>
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
Cc: gregkh@linuxfoundation.org, sbobroff@linux.ibm.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Shyam.Iyer@dell.com,
 lukas@wunner.de, oohall@gmail.com, mr.nuke.me@gmail.com, Austin.Bolen@dell.com,
 helgaas@kernel.org, linuxppc-dev@lists.ozlabs.org, jonathan.derrick@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 14, 2018 at 07:22:04PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 11/14/2018 12:00 AM, Bjorn Helgaas wrote:
> > Just to make sure we're on the same page, can you point me to this
> > rule?  I do see that OSPM must request control of AER using _OSC
> > before it touches the AER registers.  What I don't see is the
> > connection between firmware-first and the AER registers.
> 
> ACPI 6.2 - 6.2.11.3, Table 6-197:
> 
> PCI Express Advanced Error Reporting control:
>   * The firmware sets this bit to 1 to grant control over PCI Express 
> Advanced Error Reporting. If firmware allows the OS control of this 
> feature, then in the context of the _OSC method it must ensure that 
> error messages are routed to device interrupts as described in the PCI 
> Express Base Specification[...]
> 
> Now I'm confused too:
>   * HEST -> __aer_firmware_first
> 	This is used for touching/not touching AER bits
>   * _OSC -> bridge->native_aer
> 	Used to enable/not enable AER portdrv service
> Maybe Keith knows better why we're doing it this way. From ACPI text, it 
> doesn't seem that control of AER would be tied to HEST entries, although 
> in practice, it is.

I'm not sure, that predates me.  HEST does have a FIRMWARE_FIRST flag, but
spec does not say anymore on relation to _OSC control or AER capability.
Nothing in PCIe spec either.

I also don't know why Linux disables the AER driver if only one
device has a FIRMWARE_FIRST HEST. Shouldn't that just be a per-device
decision?

> > The closest I can find is the "Enabled" field in the HEST PCIe
> > AER structures (ACPI v6.2, sec 18.3.2.4, .5, .6), where it says:
> > 
> >    If the field value is 1, indicates this error source is
> >    to be enabled.
> > 
> >    If the field value is 0, indicates that the error source
> >    is not to be enabled.
> > 
> >    If FIRMWARE_FIRST is set in the flags field, the Enabled
> >    field is ignored by the OSPM.
> > 
> > AFAICT, Linux completely ignores the Enabled field in these
> > structures.
> 
> I don't think ignoring the field is a problem:
>   * With FFS, OS should ignore it.
>   * Without FFS, we have control, and we get to make the decisions anyway.
> In the latter case we decide whether to use AER, independent of the crap 
> in ACPI. I'm not even sure why "Enabled" matters in native AER handling. 
> Probably one of the check-boxes in "Binary table designer's handbook"?

And why doesn't Linux do anything with _OSC response other than logging
it? If OS control wasn't granted, shouldn't that take priority over HEST?
