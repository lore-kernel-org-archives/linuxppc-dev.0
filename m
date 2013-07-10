Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 892DB2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 10:12:43 +1000 (EST)
Date: Tue, 9 Jul 2013 19:12:31 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <D6991806-B666-4043-8D74-1465B855DE3B@suse.de> (from
 agraf@suse.de on Tue Jul  9 16:45:10 2013)
Message-ID: <1373415151.8183.213@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2013 04:45:10 PM, Alexander Graf wrote:
>=20
> On 28.06.2013, at 11:20, Mihai Caraman wrote:
>=20
> > +	/* Get page size */
> > +	if (MAS0_GET_TLBSEL(mfspr(SPRN_MAS0)) =3D=3D 0)
> > +		psize_shift =3D PAGE_SHIFT;
> > +	else
> > +		psize_shift =3D MAS1_GET_TSIZE(mas1) + 10;
> > +
> > +	mas7_mas3 =3D (((u64) mfspr(SPRN_MAS7)) << 32) |
> > +		    mfspr(SPRN_MAS3);
> > +	addr =3D (mas7_mas3 & (~0ULL << psize_shift)) |
> > +	       (geaddr & ((1ULL << psize_shift) - 1ULL));
> > +
> > +	/* Map a page and get guest's instruction */
> > +	page =3D pfn_to_page(addr >> PAGE_SHIFT);
>=20
> While looking at this I just realized that you're missing a check =20
> here. What if our IP is in some PCI BAR? Or can't we execute from =20
> those?

We at least need to check pfn_valid() first.  That'll just keep us from =20
accessing a bad pointer in the host kernel, though -- it won't make the =20
emulation actually work.  If we need that, we'll probably need to =20
create a temporary TLB entry manually.

-Scott=
