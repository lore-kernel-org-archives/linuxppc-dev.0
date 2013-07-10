Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 224D92C02B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 20:18:15 +1000 (EST)
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1373415151.8183.213@snotra>
Date: Wed, 10 Jul 2013 12:18:10 +0200
Message-Id: <27E6FCB1-322F-410D-A87C-D5410C7374E7@suse.de>
References: <1373415151.8183.213@snotra>
To: Scott Wood <scottwood@freescale.com>
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


On 10.07.2013, at 02:12, Scott Wood wrote:

> On 07/09/2013 04:45:10 PM, Alexander Graf wrote:
>> On 28.06.2013, at 11:20, Mihai Caraman wrote:
>> > +	/* Get page size */
>> > +	if (MAS0_GET_TLBSEL(mfspr(SPRN_MAS0)) =3D=3D 0)
>> > +		psize_shift =3D PAGE_SHIFT;
>> > +	else
>> > +		psize_shift =3D MAS1_GET_TSIZE(mas1) + 10;
>> > +
>> > +	mas7_mas3 =3D (((u64) mfspr(SPRN_MAS7)) << 32) |
>> > +		    mfspr(SPRN_MAS3);
>> > +	addr =3D (mas7_mas3 & (~0ULL << psize_shift)) |
>> > +	       (geaddr & ((1ULL << psize_shift) - 1ULL));
>> > +
>> > +	/* Map a page and get guest's instruction */
>> > +	page =3D pfn_to_page(addr >> PAGE_SHIFT);
>> While looking at this I just realized that you're missing a check =
here. What if our IP is in some PCI BAR? Or can't we execute from those?
>=20
> We at least need to check pfn_valid() first.  That'll just keep us =
from accessing a bad pointer in the host kernel, though -- it won't make =
the emulation actually work.  If we need that, we'll probably need to =
create a temporary TLB entry manually.

ioremap()?

However, if we were walking the guest TLB cache instead we would get a =
guest physical address which we can always resolve to a host virtual =
address.

I'm not sure how important that whole use case is though. Maybe we =
should just error out to the guest for now.


Alex
