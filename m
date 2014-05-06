Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9BFD41401AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 06:36:04 +1000 (EST)
Message-ID: <1399408553.18906.29.camel@pasglop>
Subject: Re: [RFC PATCH] KVM: PPC: BOOK3S: HV: THP support for guest
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 07 May 2014 06:35:53 +1000
In-Reply-To: <87ha52ritd.fsf@linux.vnet.ibm.com>
References: <1399224616-25142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5368A78D.4070509@suse.de> <1399368400.18906.9.camel@pasglop>
 <5368ADE3.1050503@suse.de> <87oazbq73t.fsf@linux.vnet.ibm.com>
 <5368FE66.5040809@suse.de> <87ha52ritd.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-06 at 21:38 +0530, Aneesh Kumar K.V wrote:

> >> I updated the commit message as below. Let me know if this is ok.
> >>
> >>      KVM: PPC: BOOK3S: HV: THP support for guest
> >
> > This has nothing to do with THP.
> 
> THP support in guest depend on KVM advertising MPSS feature. We already
> have rest of the changes needed to support transparent huge pages
> upstream. (We do support THP with PowerVM LPAR already). The primary
> motivation of this patch is to enable THP in powerkvm guest. 

I would argue (nit picking, I know ... :-) that the subject should be
"Enable MPSS support for guests", and the description can then explain
that this allows Linux guests to use THP.

Cheers,
Ben.

> >
> >>      
> >>      On recent IBM Power CPUs, while the hashed page table is looked up using
> >>      the page size from the segmentation hardware (i.e. the SLB), it is
> >>      possible to have the HPT entry indicate a larger page size.  Thus for
> >>      example it is possible to put a 16MB page in a 64kB segment, but since
> >>      the hash lookup is done using a 64kB page size, it may be necessary to
> >>      put multiple entries in the HPT for a single 16MB page.  This
> >>      capability is called mixed page-size segment (MPSS).  With MPSS,
> >>      there are two relevant page sizes: the base page size, which is the
> >>      size used in searching the HPT, and the actual page size, which is the
> >>      size indicated in the HPT entry. [ Note that the actual page size is
> >>      always >= base page size ].
> >>      
> >>      We advertise MPSS feature to guest only if the host CPU supports the
> >>      same. We use "ibm,segment-page-sizes" device tree node to advertise
> >>      the MPSS support. The penc encoding indicate whether we support
> >>      a specific combination of base page size and actual page size
> >>      in the same segment. It is also the value used in the L|LP encoding
> >>      of HPTE entry.
> >>      
> >>      In-order to support MPSS in guest, KVM need to handle the below details
> >>      * advertise MPSS via ibm,segment-page-sizes
> >>      * Decode the base and actual page size correctly from the HPTE entry
> >>        so that we know what we are dealing with in H_ENTER and and can do
> >
> > Which code path exactly changes for H_ENTER?
> 
> There is no real code path changes. Any code path that use
> hpte_page_size() is impacted. We return actual page size there. 
> 
> >
> >>        the appropriate TLB invalidation in H_REMOVE and evictions.
> >
> > Apart from the grammar (which is pretty broken for the part that is not 
> > copied from Paul) and the subject line this sounds quite reasonable.
> >
> 
> Wll try to fix.
> 
> -aneesh
