Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDD9C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 09:34:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499AF213A2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 09:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="T1NMCAK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499AF213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QnlT75BwzF3HC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 19:34:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="T1NMCAK6";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QnhT56vwzF3HF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 19:31:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="T1NMCAK6"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42QnhT3zvPz9sB7; Thu,  4 Oct 2018 19:31:37 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42QnhT355nz9s7W; Thu,  4 Oct 2018 19:31:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538645497; bh=YM6/EiNg6nx3JKF9Lc2egASEzc3KTEZErB4P9Ffd4p4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T1NMCAK69U+fFhx3629eBykhMn3+mXpMdsDJtWRsk0OtTi67Xfx2e8zgw/p82DOGX
 LQ48o43FgsA7JpFC3i4BXOh+/0HVnS3EN1CB3mHTe7vKh49QSlASyc86bgwai8RfQA
 LcPkoB3s9c66BIOsKeZJ1n1+V34rEX+4C25h6YATlygf6nb1rKeLu71n5owwlsMESA
 /GuBGq+w+KGTK3LRENu5gIA6h/R77+Nxct/mXmHVVWvPG+ZJPpkoiYg2wQSWIlKWpx
 U5RdWRRk0/nN9/oIJXutHsovkF4J+jdRx5oZ86WFwbprtwgFpyYla9Ss1PmSPCAQ1Z
 +Yw511XQ/LpAA==
Date: Thu, 4 Oct 2018 19:21:20 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 22/33] KVM: PPC: Book3S HV: Handle page fault for a
 nested guest
Message-ID: <20181004092120.GA3255@fergus>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-23-git-send-email-paulus@ozlabs.org>
 <20181003053913.GP1886@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003053913.GP1886@umbus.fritz.box>
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
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 03, 2018 at 03:39:13PM +1000, David Gibson wrote:
> On Tue, Oct 02, 2018 at 09:31:21PM +1000, Paul Mackerras wrote:
> > From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > @@ -367,7 +367,9 @@ struct kvmppc_pte {
> >  	bool may_write		: 1;
> >  	bool may_execute	: 1;
> >  	unsigned long wimg;
> > +	unsigned long rc;
> >  	u8 page_size;		/* MMU_PAGE_xxx */
> > +	u16 page_shift;
> 
> It's a bit ugly that this has both page_size and page_shift, which is
> redundant information AFAICT.  Also, why does page_shift need to be
> u16 - given that 2^255 bytes is much more than our supported address
> space, let alone a plausible page size.

These values are all essentially function outputs, so I don't think
it's ugly to have the same information in different forms.  I actually
don't like using the MMU_PAGE_xxx values, because the information in
the mmu_psize_defs[] array depends on the MMU mode of the host, but
KVM needs to be able to work with guests in both MMU modes.  More
generally I don't think it's a good idea that the KVM <-> guest
interface depends so much on what the host firmware tells us about the
physical machine we're on.  Thus I'm trying to move away from using
MMU_PSIZE_xxx values and mmu_psize_defs[] in KVM code.

I'll change the type to u8.

> > diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> > index bd06a95..ee6f493 100644
> > --- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
> > +++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> > @@ -29,43 +29,16 @@
> >   */
> >  static int p9_supported_radix_bits[4] = { 5, 9, 9, 13 };
> >  
> > -/*
> > - * Used to walk a partition or process table radix tree in guest memory
> > - * Note: We exploit the fact that a partition table and a process
> > - * table have the same layout, a partition-scoped page table and a
> > - * process-scoped page table have the same layout, and the 2nd
> > - * doubleword of a partition table entry has the same layout as
> > - * the PTCR register.
> > - */
> > -int kvmppc_mmu_radix_translate_table(struct kvm_vcpu *vcpu, gva_t eaddr,
> > -				     struct kvmppc_pte *gpte, u64 table,
> > -				     int table_index, u64 *pte_ret_p)
> > +int kvmppc_mmu_walk_radix_tree(struct kvm_vcpu *vcpu, gva_t eaddr,
> > +			       struct kvmppc_pte *gpte, u64 root,
> > +			       u64 *pte_ret_p)
> >  {
> >  	struct kvm *kvm = vcpu->kvm;
> >  	int ret, level, ps;
> > -	unsigned long ptbl, root;
> > -	unsigned long rts, bits, offset;
> > -	unsigned long size, index;
> > -	struct prtb_entry entry;
> > +	unsigned long rts, bits, offset, index;
> >  	u64 pte, base, gpa;
> >  	__be64 rpte;
> >  
> > -	if ((table & PRTS_MASK) > 24)
> > -		return -EINVAL;
> > -	size = 1ul << ((table & PRTS_MASK) + 12);
> > -
> > -	/* Is the table big enough to contain this entry? */
> > -	if ((table_index * sizeof(entry)) >= size)
> > -		return -EINVAL;
> > -
> > -	/* Read the table to find the root of the radix tree */
> > -	ptbl = (table & PRTB_MASK) + (table_index * sizeof(entry));
> > -	ret = kvm_read_guest(kvm, ptbl, &entry, sizeof(entry));
> > -	if (ret)
> > -		return ret;
> > -
> > -	/* Root is stored in the first double word */
> > -	root = be64_to_cpu(entry.prtb0);
> 
> This refactoring somewhat obscures the changes directly relevant to
> the nested guest handling.  Ideally it would be nice to fold some of
> this into the earlier reworkings.

True, but given the rapidly approaching merge window, I'm not inclined
to rework it.

> > +	if (ret) {
> > +		/* We didn't find a pte */
> > +		if (ret == -EINVAL) {
> > +			/* Unsupported mmu config */
> > +			flags |= DSISR_UNSUPP_MMU;
> > +		} else if (ret == -ENOENT) {
> > +			/* No translation found */
> > +			flags |= DSISR_NOHPTE;
> > +		} else if (ret == -EFAULT) {
> > +			/* Couldn't access L1 real address */
> > +			flags |= DSISR_PRTABLE_FAULT;
> > +			vcpu->arch.fault_gpa = fault_addr;
> > +		} else {
> > +			/* Unknown error */
> > +			return ret;
> > +		}
> > +		goto resume_host;
> 
> This is effectively forwarding the fault to L1, yes?  In which case a
> different name might be better than the ambiguous "resume_host".

I'll change it to "forward_to_l1".

Paul.


