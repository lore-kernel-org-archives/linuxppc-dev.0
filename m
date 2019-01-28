Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36D5C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 06:15:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5E52147A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 06:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="LpiPq/s1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5E52147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43nzrd3zdHzDqHL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 17:15:29 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43nzpr6wRxzDqGM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 17:13:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="LpiPq/s1"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43nzpr51FKz9sBQ; Mon, 28 Jan 2019 17:13:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548656036; bh=7SKFtxUdm17N9MbrwRVK3jGKEcDAABGvkfmOtqAHOgw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LpiPq/s1KPa70pNqoqjFPZxpbgLAx6NMuauO3SSb2cTEFTXtOHuzOpNaTMbr9A2kf
 O2jqhCIFC2DBn/0lQNDuXEedlxv58i2CbNx+vSCIY8qrvWTR9VrkLS3jv2mmE1EIee
 FjMp4rEQaNibPQmutzaGQ/5jonezHbqwMg6mtHZiKWwiWfSABVW9q1fhVr1lng0QSr
 Uo+7xG8Tpz1t1H/XpD+vfPAwEriMp2Q/p595IZcyKaHRzRoqGh0IBWXI3YUe60WBdD
 6ENJUdoLnPd6i248G4HO6j7ZmwFb2Yh4rSBjpTEztS/sCKhpB5TPWNjgFOcSyvXAq/
 YhPVePufF0NLw==
Date: Mon, 28 Jan 2019 17:13:54 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
Message-ID: <20190128061353.GD3237@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org>
 <20190107191006.10648-2-clg@kaod.org>
 <20190122052657.GG15124@blackberry>
 <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
 <20190123103009.GB29826@blackberry>
 <75762dbe-0f08-5b06-e376-744ff87ff4cb@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75762dbe-0f08-5b06-e376-744ff87ff4cb@kaod.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 23, 2019 at 12:07:19PM +0100, Cédric Le Goater wrote:
> On 1/23/19 11:30 AM, Paul Mackerras wrote:
> > On Wed, Jan 23, 2019 at 05:45:24PM +1100, Benjamin Herrenschmidt wrote:
> >> On Tue, 2019-01-22 at 16:26 +1100, Paul Mackerras wrote:
> >>> On Mon, Jan 07, 2019 at 08:10:05PM +0100, Cédric Le Goater wrote:
> >>>> Clear the ESB pages from the VMA of the IRQ being pass through to the
> >>>> guest and let the fault handler repopulate the VMA when the ESB pages
> >>>> are accessed for an EOI or for a trigger.
> >>>
> >>> Why do we want to do this?
> >>>
> >>> I don't see any possible advantage to removing the PTEs from the
> >>> userspace mapping.  You'll need to explain further.
> >>
> >> Afaik bcs we change the mapping to point to the real HW irq ESB page
> >> instead of the "IPI" that was there at VM init time.
> 
> yes exactly. You need to clean up the pages each time.
>  
> > So that makes it sound like there is a whole lot going on that hasn't
> > even been hinted at in the patch descriptions...  It sounds like we
> > need a good description of how all this works and fits together
> > somewhere under Documentation/.
> 
> OK. I have started doing so for the models merged in QEMU but not yet 
> for KVM. I will work on it.
> 
> > In any case we need much more informative patch descriptions.  I
> > realize that it's all currently in Cedric's head, but I bet that in
> > two or three years' time when we come to try to debug something, it
> > won't be in anyone's head...
> 
> I agree. 
> 
> 
> So, storing the ESB VMA under the KVM device is not shocking anyone ?  

Actually, now that I think of it, why can't userspace (QEMU) manage
this using mmap()?  Based on what Ben has said, I assume there would
be a pair of pages for each interrupt that a PCI pass-through device
has.  Would we end up with too many VMAs if we just used mmap() to
change the mappings from the software-generated pages to the
hardware-generated interrupt pages?  Are the necessary pages for a PCI
passthrough device contiguous in both host real space and guest real
space?  If so we'd only need one mmap() for all the device's interrupt
pages.

Paul.
