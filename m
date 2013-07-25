Return-Path: <gleb@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 1BEE72C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 02:14:56 +1000 (EST)
Date: Thu, 25 Jul 2013 19:14:48 +0300
From: Gleb Natapov <gleb@redhat.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/2] kvm: powerpc: set cache coherency only for kernel
 managed pages
Message-ID: <20130725161448.GS6029@redhat.com>
References: <03EEFDFE-4603-44FC-8449-2450607F2864@suse.de>
 <1374697969.15592.67@snotra> <20130725085042.GJ16400@redhat.com>
 <4DADA80E-9513-45D5-AFC0-1CEE2290F691@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DADA80E-9513-45D5-AFC0-1CEE2290F691@suse.de>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
 =?cp1255?B?IpN0aWVqdW4uY2hlbpQgQ2hlbiI=?= <tiejun.chen@windriver.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 Scott Wood <scottwood@freescale.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 25, 2013 at 06:07:55PM +0200, Alexander Graf wrote:
> 
> On 25.07.2013, at 10:50, Gleb Natapov wrote:
> 
> > On Wed, Jul 24, 2013 at 03:32:49PM -0500, Scott Wood wrote:
> >> On 07/24/2013 04:39:59 AM, Alexander Graf wrote:
> >>> 
> >>> On 24.07.2013, at 11:35, Gleb Natapov wrote:
> >>> 
> >>>> On Wed, Jul 24, 2013 at 11:21:11AM +0200, Alexander Graf wrote:
> >>>>>> Are not we going to use page_is_ram() from
> >>> e500_shadow_mas2_attrib() as Scott commented?
> >>>>> 
> >>>>> rWhy aren't we using page_is_ram() in kvm_is_mmio_pfn()?
> >>>>> 
> >>>>> 
> >>>> Because it is much slower and, IIRC, actually used to build pfn
> >>> map that allow
> >>>> us to check quickly for valid pfn.
> >>> 
> >>> Then why should we use page_is_ram()? :)
> >>> 
> >>> I really don't want the e500 code to diverge too much from what
> >>> the rest of the kvm code is doing.
> >> 
> >> I don't understand "actually used to build pfn map...".  What code
> >> is this?  I don't see any calls to page_is_ram() in the KVM code, or
> >> in generic mm code.  Is this a statement about what x86 does?
> > It may be not page_is_ram() directly, but the same into page_is_ram() is
> > using. On power both page_is_ram() and do_init_bootmem() walks some kind
> > of memblock_region data structure. What important is that pfn_valid()
> > does not mean that there is a memory behind page structure. See Andrea's
> > reply.
> > 
> >> 
> >> On PPC page_is_ram() is only called (AFAICT) for determining what
> >> attributes to set on mmaps.  We want to be sure that KVM always
> >> makes the same decision.  While pfn_valid() seems like it should be
> >> equivalent, it's not obvious from the PPC code that it is.
> >> 
> > Again pfn_valid() is not enough.
> > 
> >> If pfn_valid() is better, why is that not used for mmap?  Why are
> >> there two different names for the same thing?
> >> 
> > They are not the same thing. page_is_ram() tells you if phys address is
> > ram backed. pfn_valid() tells you if there is struct page behind the
> > pfn. PageReserved() tells if you a pfn is marked as reserved. All non
> > ram pfns should be reserved, but ram pfns can be reserved too. Again,
> > see Andrea's reply.
> > 
> > Why ppc uses page_is_ram() for mmap? How should I know? But looking at
> 
> That one's easy. Let's just ask Ben. Ben, is there any particular reason PPC uses page_is_ram() rather than what KVM does here to figure out whether a pfn is RAM or not? It would be really useful to be able to run the exact same logic that figures out whether we're cacheable or not in both TLB writers (KVM and linux-mm).
> 
KVM does not only try to figure out what is RAM or not! Look at how KVM
uses the function. KVM tries to figure out if refcounting needed to be
used on this page among other things.

--
			Gleb.
