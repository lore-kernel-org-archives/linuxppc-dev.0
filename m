Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84299C282CD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 02:46:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8BB214DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 02:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="jV0aActl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8BB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pW9H05wYzDqPl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 13:46:43 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pW7R2nBMzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 13:45:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="jV0aActl"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43pW7R0dPrz9sDL; Tue, 29 Jan 2019 13:45:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548729907; bh=p643i+a2NUpSJcQDrYxB8JTtd9gqx1ijt/WMATGX4kg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jV0aActl6X7tEjIB8C7XlKCR0QZcALA2jh3Nsl4EfUaatn7UYGdJBHHK+G5IlXSD/
 7gZ6jWec/NrsLK3Agj+Kclw3SkvOkP5SD6GXmYsmz6ok2DgLQwiOzyDfEImJCTtupc
 NLjjnJe8rHrgw0uUnkuIfLBoM7fBjvmMjBThL+YuLjeiOatCrzKTmhoUiHV5XAmmep
 nVLInkLyJl1igoU4kirO7vZPIJwEFzraQRcG1SbQr2h8lfS76gtwm/YClpfeXiolUQ
 DVHL4hmSZG6WzL+evVnYocibiA4Tk7By8F59A4TJB+Sh82enMXCc5YzmdI8FiyQM1g
 mNTGZqLDqfKgw==
Date: Tue, 29 Jan 2019 13:45:03 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
Message-ID: <20190129024503.GA11368@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org>
 <20190107191006.10648-2-clg@kaod.org>
 <20190122052657.GG15124@blackberry>
 <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
 <20190123103009.GB29826@blackberry>
 <75762dbe-0f08-5b06-e376-744ff87ff4cb@kaod.org>
 <20190128061353.GD3237@blackberry>
 <38b0244d-beb6-3aee-c638-279ca570633c@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38b0244d-beb6-3aee-c638-279ca570633c@kaod.org>
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

On Mon, Jan 28, 2019 at 07:26:00PM +0100, Cédric Le Goater wrote:
> On 1/28/19 7:13 AM, Paul Mackerras wrote:
> > Would we end up with too many VMAs if we just used mmap() to
> > change the mappings from the software-generated pages to the
> > hardware-generated interrupt pages?  
> The sPAPR IRQ number space is 0x8000 wide now. The first 4K are 
> dedicated to CPU IPIs and the remaining 4K are for devices. We can 

Confused.  You say the number space has 32768 entries but then imply
there are only 8K entries.  Do you mean that the API allows for 15-bit
IRQ numbers but we are only making using of 8192 of them?

> extend the last range if needed as these are for MSIs. Dynamic 
> extensions under KVM should work also.
> 
> This to say that we have with 8K x 2 (trigger+EOI) pages. This is a
> lot of mmap(), too much. Also the KVM model needs to be compatible

I wasn't suggesting an mmap per IRQ, I meant that the bulk of the
space would be covered by a single mmap, overlaid by subsequent mmaps
where we need to map real device interrupts.

> with the QEMU emulated one and it was simpler to have one overall
> memory region for the IPI ESBs, one for the END ESBs (if we support
> that one day) and one for the TIMA.
> 
> > Are the necessary pages for a PCI
> > passthrough device contiguous in both host real space 
> 
> They should as they are the PHB4 ESBs.
> 
> > and guest real space ? 
> 
> also. That's how we organized the mapping. 

"How we organized the mapping" is a significant design decision that I
haven't seen documented anywhere, and is really needed for
understanding what's going on.

> 
> > If so we'd only need one mmap() for all the device's interrupt
> > pages.
> 
> Ah. So we would want to make a special case for the passthrough 
> device and have a mmap() and a memory region for its ESBs. Hmm.
> 
> Wouldn't that require to hot plug a memory region under the guest ? 

No; the way that a memory region works is that userspace can do
whatever disparate mappings it likes within the region on the user
process side, and the corresponding region of guest real address space
follows that automatically.

> which means that we need to provision an address space/container 
> region for theses regions. What are the benefits ? 
> 
> Is clearing the PTEs and repopulating the VMA unsafe ? 

Explicitly unmapping parts of the VMA seems like the wrong way to do
it.  If you have a device mmap where the device wants to change the
physical page underlying parts of the mapping, there should be a way
for it to do that explicitly (but I don't know off the top of my head
what the interface to do that is).

However, I still haven't seen a clear and concise explanation of what
is being changed, when, and why we need to do that.

Paul.
