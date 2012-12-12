Return-Path: <andrew.murray@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 9E9F42C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 23:22:53 +1100 (EST)
Date: Wed, 12 Dec 2012 12:19:12 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: pci and pcie device-tree binding - range No cells
Message-ID: <20121212121912.GA2776@arm.com>
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <20121210214127.D51773E0796@localhost> <50C85E7D.5080006@monstr.eu>
 <CACxGe6udeSbEfibC53v0wu8vFRE6K3Fd_P6EX-3JS9F2M=wUeA@mail.gmail.com>
 <CAPcvp5EJH-Q6wd7my+V+FUVE1=hzwMN-yOfHiukGvDmkcoRcsQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPcvp5EJH-Q6wd7my+V+FUVE1=hzwMN-yOfHiukGvDmkcoRcsQ@mail.gmail.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Michal Simek <monstr@monstr.eu>, linux-pci@vger.kernel.org,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Rob Herring <rob.herring@calxeda.com>, Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2012 at 10:49 AM, Grant Likely wrote:
> On Wed, Dec 12, 2012 at 10:37 AM, Michal Simek <monstr@monstr.eu<mailto:m=
onstr@monstr.eu>> wrote:
> > On 12/10/2012 10:41 PM, Grant Likely wrote:
> >> drivers/pci/pci-of.c would be good. I'd also accept drivers/of/pci.c
> >> which might actually be a good idea in the short term so that it gets
> >> appropriate supervision while being generalized before being moved int=
o
> >> the pci directory.
> >
> > Ben: Are you willing to move that ppc code to this location?
> > It is probably not good idea that I should do it when I even don't have
> > hardware available for testing (Asking someone else).
>=20
> You're a clever guy, you are more than capable of crafting the patch,
> even if you can't test on hardware. :-)
>=20
> I refactored most of the OF support code without having access to most
> of the affected hardware. Once I got the changes out there for review
> I also asked for spot testing before getting it into linux-next for
> even more testing.

I've been working on a relatively architecture agnostic PCI host bridge dri=
ver
and also wanted to avoid duplicating more generic DT parsing code for PCI
bindings.

I've ended up with a patch which provides an iterator for returning resourc=
es
based on the the typical 'ranges' binding. This has ended up living in
drivers/of/address.c. I originally started out in drivers/of/pci.c and
drivers/pci/pci-of.c but found there were good (and static) implementations=
 in
drivers/of/address.c which can be reused (e.g. of_bus_pci_get_flags,
bus->count_cells).

I'm not just ready to post it - but can do before early next week if you ca=
n
wait.

Andrew Murray
