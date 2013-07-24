Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A51F92C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 06:33:22 +1000 (EST)
Date: Wed, 24 Jul 2013 15:32:49 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] kvm: powerpc: set cache coherency only for kernel
 managed pages
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <03EEFDFE-4603-44FC-8449-2450607F2864@suse.de> (from
 agraf@suse.de on Wed Jul 24 04:39:59 2013)
Message-ID: <1374697969.15592.67@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>, Gleb Natapov <gleb@redhat.com>,
 "kvm@vger.kernel.org list" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 =?UTF-8?b?4oCcdGllanVuLmNoZW7igJ0=?= <tiejun.chen@windriver.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2013 04:39:59 AM, Alexander Graf wrote:
>=20
> On 24.07.2013, at 11:35, Gleb Natapov wrote:
>=20
> > On Wed, Jul 24, 2013 at 11:21:11AM +0200, Alexander Graf wrote:
> >>> Are not we going to use page_is_ram() from  =20
> e500_shadow_mas2_attrib() as Scott commented?
> >>
> >> rWhy aren't we using page_is_ram() in kvm_is_mmio_pfn()?
> >>
> >>
> > Because it is much slower and, IIRC, actually used to build pfn map =20
> that allow
> > us to check quickly for valid pfn.
>=20
> Then why should we use page_is_ram()? :)
>=20
> I really don't want the e500 code to diverge too much from what the =20
> rest of the kvm code is doing.

I don't understand "actually used to build pfn map...".  What code is =20
this?  I don't see any calls to page_is_ram() in the KVM code, or in =20
generic mm code.  Is this a statement about what x86 does?

On PPC page_is_ram() is only called (AFAICT) for determining what =20
attributes to set on mmaps.  We want to be sure that KVM always makes =20
the same decision.  While pfn_valid() seems like it should be =20
equivalent, it's not obvious from the PPC code that it is.

If pfn_valid() is better, why is that not used for mmap?  Why are there =20
two different names for the same thing?

-Scott=
