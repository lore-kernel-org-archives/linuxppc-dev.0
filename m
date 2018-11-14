Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20516C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 06:02:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E5D208E7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 06:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVCQ0lvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E5D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vv6H1L1dzF3Nv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 17:02:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TVCQ0lvk";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="TVCQ0lvk"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vv3P6WVWzF3Nj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 17:00:01 +1100 (AEDT)
Received: from localhost (unknown [64.114.255.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E29F02146D;
 Wed, 14 Nov 2018 05:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542175199;
 bh=H2FkeEHLjL414bPVZegIRuuO4If/uRSi8gkmWujMtmo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TVCQ0lvkqVaQX7IzQ6sB1YTaDnpSqWGCgogaM4MdLzoWX9Gk7M72yAaO/rDTLiqty
 HwEaeulvV1AD+VaUuFWxUre0Ja1LTpdMutmsU8VKhoVSyI+ZI4qDyfNAx/ydBVvOPQ
 xI+nvbkp4AUY1UBt+SwL2Afq3yiFvHIeYipeBfjc=
Date: Tue, 13 Nov 2018 23:59:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex_Gagniuc@Dellteam.com
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181114055956.GA144931@google.com>
References: <20181108220117.GA11466@kroah.com>
 <20181108223258.GD2932@localhost.localdomain>
 <20181108224255.GA20619@kroah.com>
 <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
 <20181108225109.GA3023@kroah.com>
 <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
 <5da8d8aa9f3818af649b1ac547bc4e6062626ddf.camel@gmail.com>
 <df85813c9860463d85f6c302dfe07b12@ausx13mps321.AMER.DELL.COM>
 <20181113050240.GA182139@google.com>
 <19136f44cd5c45e79bbef7e78a6bf332@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19136f44cd5c45e79bbef7e78a6bf332@ausx13mps321.AMER.DELL.COM>
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
Cc: Shyam.Iyer@dell.com, sbobroff@linux.ibm.com, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, keith.busch@intel.com,
 lukas@wunner.de, oohall@gmail.com, mr.nuke.me@gmail.com, Austin.Bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, jonathan.derrick@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 13, 2018 at 10:39:15PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 11/12/2018 11:02 PM, Bjorn Helgaas wrote:
> > 
> > [EXTERNAL EMAIL]
> > Please report any suspicious attachments, links, or requests for sensitive information.

It looks like Dell's email system adds the above in such a way that the
email quoting convention suggests that *I* wrote it, when I did not.

> ...
> > Do you think Linux observes the rule about not touching AER bits on
> > FFS?  I'm not sure it does.  I'm not even sure what section of the
> > spec is relevant.
> 
> I haven't found any place where linux breaks this rule. I'm very 
> confident that, unless otherwise instructed, we follow this rule.

Just to make sure we're on the same page, can you point me to this
rule?  I do see that OSPM must request control of AER using _OSC
before it touches the AER registers.  What I don't see is the
connection between firmware-first and the AER registers.

The closest I can find is the "Enabled" field in the HEST PCIe
AER structures (ACPI v6.2, sec 18.3.2.4, .5, .6), where it says:

  If the field value is 1, indicates this error source is
  to be enabled.

  If the field value is 0, indicates that the error source
  is not to be enabled.

  If FIRMWARE_FIRST is set in the flags field, the Enabled
  field is ignored by the OSPM.

AFAICT, Linux completely ignores the Enabled field in these
structures.

These structures also contain values the OS is apparently supposed to
write to Device Control and several AER registers (in struct
acpi_hest_aer_common).  Linux ignores these as well.

These seem like fairly serious omissions in Linux.

> > The whole issue of firmware-first, the mechanism by which firmware
> > gets control, the System Error enables in Root Port Root Control
> > registers, etc., is very murky to me.  Jon has a sort of similar issue
> > with VMD where he needs to leave System Errors enabled instead of
> > disabling them as we currently do.
> 
> Well, OS gets control via _OSC method, and based on that it should 
> touch/not touch the AER bits. 

I agree so far.

> The bits that get set/cleared come from _HPX method,

_HPX tells us about some AER registers, Device Control, Link Control,
and some bridge registers.  It doesn't say anything about the Root
Control register that Jon is concerned with.

For firmware-first to work, firmware has to get control.  How does it
get control?  How does OSPM know to either set up that mechanism or
keep its mitts off something firmware set up before handoff?  In Jon's
VMD case, I think firmware-first relies on the System Error controlled
by the Root Control register.  Linux thinks it owns that, and I don't
know how to learn otherwise.

> and there's a more about the FFS described in ACPI spec. It 
> seems that if platform, wants to enable VMD, it should pass the correct 
> bits via _HPX. I'm curious to know in what new twisted way FFS doesn't 
> work as intended.

Bjorn
