Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599A0C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:29:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14892086D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsrOItuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14892086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VfgS57C7zF1F0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 03:29:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IsrOItuO";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="IsrOItuO"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Vfcw38tFzF14w
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 03:26:56 +1100 (AEDT)
Received: from localhost (unknown [64.22.249.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6141B2086D;
 Wed, 10 Oct 2018 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539188814;
 bh=twuA02RXB5h9Jz6WjY2j3vJVNMR0BNpXQAwy23Uf9sM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IsrOItuO5lSCjpyEYiO20h/WSnHpkCvElQPSmrI87m/no9sEzUVG+IIohfYdfQtXI
 wda6mA3HKcK46cH4/DxgvJY9jvtfjgyS92qsnxuuv+hKR2gf/yT+ceO05qq3/Oy7uU
 QE2WuHt2ULBWwxEwcMJy7SOBueG9CP3/QyQjQj6Q=
Date: Wed, 10 Oct 2018 11:26:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 0/2] sriov enablement on s390
Message-ID: <20181010162653.GD5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20180912123411.23229-1-sebott@linux.ibm.com>
 <20180912130205.GG118330@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LFD.2.21.1810101451310.32089@schleppi.aag-de.ibmmobiledemo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1810101451310.32089@schleppi.aag-de.ibmmobiledemo.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 10, 2018 at 02:55:07PM +0200, Sebastian Ott wrote:
> Hello Bjorn,
> 
> On Wed, 12 Sep 2018, Bjorn Helgaas wrote:
> > On Wed, Sep 12, 2018 at 02:34:09PM +0200, Sebastian Ott wrote:
> > > On s390 we currently handle SRIOV within firmware. Which means
> > > that the PF is under firmware control and not visible to operating
> > > systems. SRIOV enablement happens within firmware and VFs are
> > > passed through to logical partitions.
> > > 
> > > I'm working on a new mode were the PF is under operating system
> > > control (including SRIOV enablement). However we still need
> > > firmware support to access the VFs. The way this is supposed
> > > to work is that when firmware traps the SRIOV enablement it
> > > will present machine checks to the logical partition that
> > > triggered the SRIOV enablement and provide the VFs via hotplug
> > > events.
> > > 
> > > The problem I'm faced with is that the VF detection code in
> > > sriov_enable leads to unusable functions in s390.
> > 
> > We're moving away from the weak function implementation style.  Can
> > you take a look at Arnd's work here, which uses pci_host_bridge
> > callbacks instead?
> > 
> >   https://lkml.kernel.org/r/20180817102645.3839621-1-arnd@arndb.de
> 
> What's the status of Arnd's patches - will they go upstream in the next
> couple of versions?

I hope so [1].  IIRC Arnd mentioned doing some minor updates, so I'm
waiting on that.

> What about my patches that I rebased on Arnd's branch
> will they be considered?

Definitely.  From my point of view they're just lined up behind Arnd's
patches.

[1] https://lore.kernel.org/linux-pci/20181002205903.GD120535@bhelgaas-glaptop.roam.corp.google.com
