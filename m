Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656C0C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 04:56:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3EB20684
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 04:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="SUmZuxBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3EB20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QgZz0rsnzF3B8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 14:56:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="SUmZuxBZ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QgX61V2YzF37S
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 14:53:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="SUmZuxBZ"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42QgX60lfYz9s7W; Thu,  4 Oct 2018 14:53:58 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42QgX56fMcz9s7h; Thu,  4 Oct 2018 14:53:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538628837; bh=Q0O9LP29vAe62Z5TLHPaXY0E5NgbBN6XPidNObqkXUs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SUmZuxBZTZChte2kOJoG9Dlj4Bbtcq/4Kw7sDOEXgiyNgkxWmVxvHHC9upN6Lua2B
 yA7qRWkwRuU3ZKhobiW09cKCkNVwYtwEXekV7jfiE/lceZDVbtfANmZ9cxL8uusspo
 rXjMfOMWOGOby75V1vhWv7GBErfnp7JqiVbsjllEd9iTgYJvJEPyiyb//Hk4Tf3W5u
 pSGktrjVNA2YEVHfBqsKedr02rNu15KeQlKwfHtqs8r6Ns9Z3GbgMi4679r1ImMVvE
 iiA/DxVsro47++zJtXy37tFoRfQFXiBOiIA5HlrKyhCIbALORF7O+a0LQHJtnD1ngu
 m1Rd+SFiIc68Q==
Date: Thu, 4 Oct 2018 13:05:09 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 23/33] KVM: PPC: Book3S HV: Introduce rmap to track
 nested guest mappings
Message-ID: <20181004030509.GB16300@fergus>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-24-git-send-email-paulus@ozlabs.org>
 <20181003055637.GS1886@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003055637.GS1886@umbus.fritz.box>
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

On Wed, Oct 03, 2018 at 03:56:37PM +1000, David Gibson wrote:
> On Tue, Oct 02, 2018 at 09:31:22PM +1000, Paul Mackerras wrote:
> > From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > 
> > When a host (L0) page which is mapped into a (L1) guest is in turn
> > mapped through to a nested (L2) guest we keep a reverse mapping (rmap)
> > so that these mappings can be retrieved later.
> > 
> > Whenever we create an entry in a shadow_pgtable for a nested guest we
> > create a corresponding rmap entry and add it to the list for the
> > L1 guest memslot at the index of the L1 guest page it maps. This means
> > at the L1 guest memslot we end up with lists of rmaps.
> > 
> > When we are notified of a host page being invalidated which has been
> > mapped through to a (L1) guest, we can then walk the rmap list for that
> > guest page, and find and invalidate all of the corresponding
> > shadow_pgtable entries.
> > 
> > In order to reduce memory consumption, we compress the information for
> > each rmap entry down to 52 bits -- 12 bits for the LPID and 40 bits
> > for the guest real page frame number -- which will fit in a single
> > unsigned long.  To avoid a scenario where a guest can trigger
> > unbounded memory allocations, we scan the list when adding an entry to
> > see if there is already an entry with the contents we need.  This can
> > occur, because we don't ever remove entries from the middle of a list.
> > 
> > A struct nested guest rmap is a list pointer and an rmap entry;
> > ----------------
> > | next pointer |
> > ----------------
> > | rmap entry   |
> > ----------------
> > 
> > Thus the rmap pointer for each guest frame number in the memslot can be
> > either NULL, a single entry, or a pointer to a list of nested rmap entries.
> > 
> > gfn	 memslot rmap array
> >  	-------------------------
> >  0	| NULL			|	(no rmap entry)
> >  	-------------------------
> >  1	| single rmap entry	|	(rmap entry with low bit set)
> >  	-------------------------
> >  2	| list head pointer	|	(list of rmap entries)
> >  	-------------------------
> > 
> > The final entry always has the lowest bit set and is stored in the next
> > pointer of the last list entry, or as a single rmap entry.
> > With a list of rmap entries looking like;
> > 
> > -----------------	-----------------	-------------------------
> > | list head ptr	| ----> | next pointer	| ---->	| single rmap entry	|
> > -----------------	-----------------	-------------------------
> > 			| rmap entry	|	| rmap entry		|
> > 			-----------------	-------------------------
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > ---
> >  arch/powerpc/include/asm/kvm_book3s.h    |   3 +
> >  arch/powerpc/include/asm/kvm_book3s_64.h |  70 ++++++++++++++++-
> >  arch/powerpc/kvm/book3s_64_mmu_radix.c   |  44 +++++++----
> >  arch/powerpc/kvm/book3s_hv.c             |   1 +
> >  arch/powerpc/kvm/book3s_hv_nested.c      | 130 ++++++++++++++++++++++++++++++-
> >  5 files changed, 233 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> > index d983778..1d2286d 100644
> > --- a/arch/powerpc/include/asm/kvm_book3s.h
> > +++ b/arch/powerpc/include/asm/kvm_book3s.h
> > @@ -196,6 +196,9 @@ extern int kvmppc_mmu_radix_translate_table(struct kvm_vcpu *vcpu, gva_t eaddr,
> >  			int table_index, u64 *pte_ret_p);
> >  extern int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
> >  			struct kvmppc_pte *gpte, bool data, bool iswrite);
> > +extern void kvmppc_unmap_pte(struct kvm *kvm, pte_t *pte, unsigned long gpa,
> > +			unsigned int shift, struct kvm_memory_slot *memslot,
> > +			unsigned int lpid);
> >  extern bool kvmppc_hv_handle_set_rc(struct kvm *kvm, pgd_t *pgtable,
> >  				    bool writing, unsigned long gpa,
> >  				    unsigned int lpid);
> > diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
> > index 5496152..38614f0 100644
> > --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> > +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> > @@ -53,6 +53,66 @@ struct kvm_nested_guest {
> >  	struct kvm_nested_guest *next;
> >  };
> >  
> > +/*
> > + * We define a nested rmap entry as a single 64-bit quantity
> > + * 0xFFF0000000000000	12-bit lpid field
> > + * 0x000FFFFFFFFFF000	40-bit guest physical address field
> 
> I thought we could potentially support guests with >1TiB of RAM..?

We can, that's really a (4k) page frame number, not a physical
address.  We can support 52-bit guest physical addresses.

Paul.
