Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85937C65BAF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 21:57:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A8520849
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 21:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyUxfosF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A8520849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FVzj0HK4zDqNH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 08:57:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fyUxfosF";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="fyUxfosF"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FVwJ3VDYzDqVb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 08:54:56 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4A5F720849;
 Wed, 12 Dec 2018 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544651694;
 bh=t3YYNpPBx1z+6p8Tbmzzf/WmziQU/QjuYd9ADWXvg4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fyUxfosFt5dlvq3VJw8rq2Da5alE/WwdqKil4hw0LQmc5tAH4Tfsbb5LlyWF6lRzV
 SDx9fa39jLV/A1JxTZi+xjOlpjph2b0QPGnfmAVluwkzF9WsEhwvWmASnnWriGECIc
 2hrEJ3SqjVs98/J80SG9+Ix2ykyioeKf1nXAttvM=
Date: Wed, 12 Dec 2018 15:54:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 0/2] sriov enablement on s390
Message-ID: <20181212215453.GJ99796@google.com>
References: <20180912123411.23229-1-sebott@linux.ibm.com>
 <20180912130205.GG118330@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LFD.2.21.1810101451310.32089@schleppi.aag-de.ibmmobiledemo.com>
 <20181010162653.GD5906@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LFD.2.21.1812051432580.1828@schleppi.aag-de.ibmmobiledemo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1812051432580.1828@schleppi.aag-de.ibmmobiledemo.com>
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
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 05, 2018 at 02:45:14PM +0100, Sebastian Ott wrote:
> Hello Bjorn,
> 
> On Wed, 10 Oct 2018, Bjorn Helgaas wrote:
> > On Wed, Oct 10, 2018 at 02:55:07PM +0200, Sebastian Ott wrote:
> > > On Wed, 12 Sep 2018, Bjorn Helgaas wrote:
> > > > On Wed, Sep 12, 2018 at 02:34:09PM +0200, Sebastian Ott wrote:
> > > > > On s390 we currently handle SRIOV within firmware. Which means
> > > > > that the PF is under firmware control and not visible to operating
> > > > > systems. SRIOV enablement happens within firmware and VFs are
> > > > > passed through to logical partitions.
> > > > > 
> > > > > I'm working on a new mode were the PF is under operating system
> > > > > control (including SRIOV enablement). However we still need
> > > > > firmware support to access the VFs. The way this is supposed
> > > > > to work is that when firmware traps the SRIOV enablement it
> > > > > will present machine checks to the logical partition that
> > > > > triggered the SRIOV enablement and provide the VFs via hotplug
> > > > > events.
> > > > > 
> > > > > The problem I'm faced with is that the VF detection code in
> > > > > sriov_enable leads to unusable functions in s390.
> > > > 
> > > > We're moving away from the weak function implementation style.  Can
> > > > you take a look at Arnd's work here, which uses pci_host_bridge
> > > > callbacks instead?
> > > > 
> > > >   https://lkml.kernel.org/r/20180817102645.3839621-1-arnd@arndb.de
> > > 
> > > What's the status of Arnd's patches - will they go upstream in the next
> > > couple of versions?
> > 
> > I hope so [1].  IIRC Arnd mentioned doing some minor updates, so I'm
> > waiting on that.
> > 
> > > What about my patches that I rebased on Arnd's branch
> > > will they be considered?
> > 
> > Definitely.  From my point of view they're just lined up behind Arnd's
> > patches.
> > 
> > [1] https://lore.kernel.org/linux-pci/20181002205903.GD120535@bhelgaas-glaptop.roam.corp.google.com
> 
> It appears like these patches are not in-line for the next merge window.
> Would it be possible to go with my original patches (using __weak
> functions)? (This would also make life easier with regards to backports)
> I can post patches to convert this to use function pointers once Arnd's
> patches make it to the kernel.

Yeah, sorry, I think we should just go with your original approach.

Can you repost those patches with minor changelog updates so
"git log --online" on the files looks consistent.  Also, capitalize
"PCI", "VF", etc, consistently when used in English text.

Bjorn
