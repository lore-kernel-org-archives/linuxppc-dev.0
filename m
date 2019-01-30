Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D10AC282D4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 06:24:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A402175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 06:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="uMn52K5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A402175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qCxw5F29zDqKv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 17:24:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qCsn3bZrzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 17:20:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="uMn52K5O"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43qCsn1992z9sC7; Wed, 30 Jan 2019 17:20:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548829245; bh=hUjj0h82tpvsDFBnr0S+g+1XPKflcfnNodvPFOE9UC8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uMn52K5ODwAzE0VAbOXH6LKNjEVlnhx64cP6gtu/l6oF0QX4+8kcI8MeaGSvPX89D
 IlAR/GDucylc9CWkUq0bvCTq8KSCIeK9T2oO0ya4FM2A3urV81Ap5pGsk0ulE6UHV7
 av/KSZHjAADNmfsWik1fuK6LDy72NHfYoHtWYzmKPOfEizm7YfpHpI9ETU5Tl81owB
 nSOU2oDoDnzGvN8ltRtnC26+WR2noScLhuIGayEKamyKIIi2zJIBi/HLo0X/VNQHpp
 eWf67J9Fw90bnvWe8JfXMjgFbHniyb4r+B9DnBxkbYlWH8k66ElE5sbJjTkeSlo76r
 tVbR7o+3jon3A==
Date: Wed, 30 Jan 2019 17:20:41 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
Message-ID: <20190130062041.GD27109@blackberry>
References: <20190107191006.10648-1-clg@kaod.org>
 <20190107191006.10648-2-clg@kaod.org>
 <20190122052657.GG15124@blackberry>
 <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
 <20190123103009.GB29826@blackberry>
 <75762dbe-0f08-5b06-e376-744ff87ff4cb@kaod.org>
 <20190128061353.GD3237@blackberry>
 <38b0244d-beb6-3aee-c638-279ca570633c@kaod.org>
 <20190129024503.GA11368@blackberry>
 <f92f71ee-5c8e-f6b1-dbbf-436bbb0624cd@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f92f71ee-5c8e-f6b1-dbbf-436bbb0624cd@kaod.org>
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

On Tue, Jan 29, 2019 at 02:47:55PM +0100, Cédric Le Goater wrote:
> On 1/29/19 3:45 AM, Paul Mackerras wrote:
> > On Mon, Jan 28, 2019 at 07:26:00PM +0100, Cédric Le Goater wrote:
> >> On 1/28/19 7:13 AM, Paul Mackerras wrote:
> >>> Would we end up with too many VMAs if we just used mmap() to
> >>> change the mappings from the software-generated pages to the
> >>> hardware-generated interrupt pages?  
> >> The sPAPR IRQ number space is 0x8000 wide now. The first 4K are 
> >> dedicated to CPU IPIs and the remaining 4K are for devices. We can 
> > 
> > Confused.  You say the number space has 32768 entries but then imply
> > there are only 8K entries.  Do you mean that the API allows for 15-bit
> > IRQ numbers but we are only making using of 8192 of them?
> 
> Ouch. My bad. Let's do it again. 
> 
> The sPAPR IRQ number space is 0x2000 wide :
> 
> https://git.qemu.org/?p=qemu.git;a=blob;f=hw/ppc/spapr_irq.c;h=1da7a32348fced0bd638717022fc37a83fc5e279;hb=HEAD#l396
> 
> The first 4K are dedicated to the CPU IPIs and the remaining 4K are for 
> devices (which can be extended if needed).
> 
> So that's 8192 x 2 ESB pages.
> 
> >> extend the last range if needed as these are for MSIs. Dynamic 
> >> extensions under KVM should work also.
> >>
> >> This to say that we have with 8K x 2 (trigger+EOI) pages. This is a
> >> lot of mmap(), too much. Also the KVM model needs to be compatible
> > 
> > I wasn't suggesting an mmap per IRQ, I meant that the bulk of the
> > space would be covered by a single mmap, overlaid by subsequent mmaps
> > where we need to map real device interrupts.
> 
> ok. The same fault handler could be used to populate the VMA with the 
> ESB pages. 
> 
> But it would mean extra work on the QEMU side, which is not needed 
> with this patch. 

Maybe, but just storing a single vma pointer in our private data is
not a feasible approach.  First, you have no control on the lifetime
of the vma and thus this is a use-after-free waiting to happen, and
secondly, there could be multiple vmas that you need to worry about.
Userspace could do multiple mmaps, or could do mprotect or similar on
part of an existing mmap, which would split the vma for the mmap into
multiple vmas.  You don't get notified about munmap either as far as I
can tell, so the vma is liable to go away.  And it doesn't matter if
QEMU would never do such things; if userspace can provoke a
use-after-free in the kernel using KVM then someone will write a
specially crafted user program to do that.

So we either solve it in userspace, or we have to write and maintain
complex kernel code with deep links into the MM subsystem.  I'd much
rather solve it in userspace.

> >> with the QEMU emulated one and it was simpler to have one overall
> >> memory region for the IPI ESBs, one for the END ESBs (if we support
> >> that one day) and one for the TIMA.
> >>
> >>> Are the necessary pages for a PCI
> >>> passthrough device contiguous in both host real space 
> >>
> >> They should as they are the PHB4 ESBs.
> >>
> >>> and guest real space ? 
> >>
> >> also. That's how we organized the mapping. 
> > 
> > "How we organized the mapping" is a significant design decision that I
> > haven't seen documented anywhere, and is really needed for
> > understanding what's going on.
> 
> OK. I will add comments on that. See below for some description.
> 
> There is nothing fancy, it's simply indexed with the interrupt number,
> like for HW, or for the QEMU XIVE emulated model.
> 
> >>> If so we'd only need one mmap() for all the device's interrupt
> >>> pages.
> >>
> >> Ah. So we would want to make a special case for the passthrough 
> >> device and have a mmap() and a memory region for its ESBs. Hmm.
> >>
> >> Wouldn't that require to hot plug a memory region under the guest ? 
> > 
> > No; the way that a memory region works is that userspace can do
> > whatever disparate mappings it likes within the region on the user
> > process side, and the corresponding region of guest real address space
> > follows that automatically.
> 
> yes. I suppose this should work also for 'ram device' memory mappings.
> 
> So when the passthrough device is added to the guest, we would add a 
> new 'ram device' memory region for the device interrupt ESB pages 
> that would overlap with the initial guest ESB pages.  

Not knowing the QEMU internals all that well, I don't at all
understand why a new ram device is necesssary.  I would see it as a
single virtual area mapping the ESB pages of guest hwirqs that are in
use, and we manage those mappings with mmap and munmap.

> This is really a different approach.
> 
> >> which means that we need to provision an address space/container 
> >> region for theses regions. What are the benefits ? 
> >>
> >> Is clearing the PTEs and repopulating the VMA unsafe ? 
> > 
> > Explicitly unmapping parts of the VMA seems like the wrong way to do
> > it.  If you have a device mmap where the device wants to change the
> > physical page underlying parts of the mapping, there should be a way
> > for it to do that explicitly (but I don't know off the top of my head
> > what the interface to do that is).
> > 
> > However, I still haven't seen a clear and concise explanation of what
> > is being changed, when, and why we need to do that.
> 
> Yes. I agree on that. The problem is not very different from what we 
> have today with the XICS-over-XIVE glue in KVM. Let me try to explain.
> 
> 
> The KVM XICS-over-XIVE device and the proposed KVM XIVE native device 
> implement an IRQ space for the guest using the generic IPI interrupts 
> of the XIVE IC controller. These interrupts are allocated at the OPAL
> level and "mapped" into the guest IRQ number space in the range 0-0x1FFF.
> Interrupt management is performed in the XIVE way: using loads and 
> stores on the addresses of the XIVE IPI interrupt ESB pages.
> 
> Both KVM devices share the same internal structure caching information 
> on the interrupts, among which the xive_irq_data struct containing the 
> addresses of the IPI ESB pages and an extra one in case of passthrough. 
> The later contains the addresses of the ESB pages of the underlying HW 
> controller interrupts, PHB4 in all cases for now.    
> 
> A guest when running in the XICS legacy interrupt mode lets the KVM 
> XICS-over-XIVE device "handle" interrupt management, that is to perform  
> the loads and stores on the addresses of the ESB pages of the guest 
> interrupts. 
> 
> However, when running in XIVE native exploitation mode, the KVM XIVE 
> native device exposes the interrupt ESB pages to the guest and lets 
> the guest perform directly the loads and stores. 
> 
> The VMA exposing the ESB pages make use of a custom VM fault handler
> which role is to populate the VMA with appropriate pages. When a fault
> occurs, the guest IRQ number is deduced from the offset, and the ESB 
> pages of associated XIVE IPI interrupt are inserted in the VMA (using
> the internal structure caching information on the interrupts).
> 
> Supporting device passthrough in the guest running in XIVE native 
> exploitation mode adds some extra refinements because the ESB pages 
> of a different HW controller (PHB4) need to be exposed to the guest 
> along with the initial IPI ESB pages of the XIVE IC controller. But
> the overall mechanic is the same. 
> 
> When the device HW irqs are mapped into or unmapped from the guest
> IRQ number space, the passthru_irq helpers, kvmppc_xive_set_mapped()
> and kvmppc_xive_clr_mapped(), are called to record or clear the 
> passthrough interrupt information and to perform the switch.
> 
> The approach taken by this patch is to clear the ESB pages of the 
> guest IRQ number being mapped and let the VM fault handler repopulate. 
> The handler will insert the ESB page corresponding to the HW interrupt 
> of the device being passed-through or the initial IPI ESB page if the
> device is being removed.   

That's a much better write-up.  Thanks.

Paul.
