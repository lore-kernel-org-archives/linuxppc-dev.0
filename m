Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrLsl0DtqzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 15:36:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joe Perches <joe@perches.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powernv: Use __printf in pe_level_printk
In-Reply-To: <1468558752.8745.52.camel@perches.com>
References: <b204dbb1d8d13998eb8dee4dabbc91a0ee4b38b4.1468511136.git.joe@perches.com>
 <87eg6vbjr2.fsf@@concordia.ellerman.id.au>
 <1468558752.8745.52.camel@perches.com>
Date: Fri, 15 Jul 2016 15:36:42 +1000
Message-ID: <878tx3bgyd.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joe Perches <joe@perches.com> writes:

> On Fri, 2016-07-15 at 14:36 +1000, Michael Ellerman wrote:
>> Joe Perches <joe@perches.com> writes:
>> >=20
>> > diff --git a/arch/powerpc/platforms/powernv/pci.h
>> > b/arch/powerpc/platforms/powernv/pci.h
>> > index 3a97990..1c1a586 100644
>> > --- a/arch/powerpc/platforms/powernv/pci.h
>> > +++ b/arch/powerpc/platforms/powernv/pci.h
>> > @@ -213,6 +213,7 @@ extern void pnv_pci_dma_bus_setup(struct pci_bus
>> > *bus);
>> > =C2=A0extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int
>> > type);
>> > =C2=A0extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
>> > =C2=A0
>> > +__printf(3, 4)
>> > =C2=A0extern void pe_level_printk(const struct pnv_ioda_pe *pe, const
>> > char *level,
>> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0const char *fmt, ...);
>> Thanks, but it breaks the build due to lots of new warnings.
>>=20
>> We'll have to fix those before merging it.
>
> Good. =C2=A0Are you going to fix those?

Not this month.

> I thought I did a powerpc defconfig build of arch/powerpc/
> and I believe it finished without error, but I'm pleased
> it found some defects.

Hmm, I'd be surprised, but it might depend on the exact config /
compiler etc.

> I think it's now marked "rejected" in patchwork.
> Perhaps it'd better to mark it "deferred" instead.

I can do that. Though realistically I'm unlikely to go back and find it.

cheers
