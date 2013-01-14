Return-Path: <andrew.murray@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 7E69C2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 20:27:58 +1100 (EST)
Date: Mon, 14 Jan 2013 09:24:45 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] pci: Provide support for parsing PCI DT ranges property
Message-ID: <20130114092445.GB23333@arm.com>
References: <20121212163749.GA17371@arm.com>
 <CACxGe6uZATX2uBjuDUsJ489-jmvFbLm-NQ6Q3SGqRVky9XGJYg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACxGe6uZATX2uBjuDUsJ489-jmvFbLm-NQ6Q3SGqRVky9XGJYg@mail.gmail.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Michal Simek <monstr@monstr.eu>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Liviu Dudau <Liviu.Dudau@arm.com>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 15, 2012 at 01:06:41AM +0000, Grant Likely wrote:
> On Wed, Dec 12, 2012 at 4:37 PM, Andrew Murray <Andrew.Murray@arm.com> wr=
ote:
> > DT bindings for PCI host bridges often use the ranges property to descr=
ibe
> > memory and IO ranges - this binding tends to be the same across archite=
ctures
> > yet several parsing implementations exist, e.g. arch/mips/pci/pci.c,
> > arch/powerpc/kernel/pci-common.c, arch/sparc/kernel/pci.c and
> > arch/microblaze/pci/pci-common.c (clone of PPC). Some of these duplicat=
e
> > functionality provided by drivers/of/address.c.
>=20
> Hi Andrew,
>=20
> Thanks for looking into this. This definitely needs to be done.
>=20
> However, I cannot merge this patch as-is because it actually makes
> things worse by adding yet another implementation of the parsing code.
> Plus it doesn't actually have any users.  :-)

I understand. Though I see Thierry has included this in his patch set - I
guess that means there is potentially one user now :).

>=20
> Instead, move the existing code that you need out of
> arch/powerpc/kernel/pci-common.c into a shared place and add in the
> features you need. Bonus points if you fixup microblaze or others at
> the same time.

In most part the patch I submitted was the common code from powerpc but
without quirks and tie-ins to powerpc structures. I'd like to convert
powerpc to using my patch and others but won't get time to do this at
present :(

>=20
> g.
>=20
Andrew Murray
