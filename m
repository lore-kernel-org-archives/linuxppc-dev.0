Return-Path: <andrew.murray@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id BB88B2C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 20:18:43 +1100 (EST)
Date: Mon, 14 Jan 2013 09:15:26 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] pci: Provide support for parsing PCI DT ranges property
Message-ID: <20130114091526.GA23333@arm.com>
References: <20121212163749.GA17371@arm.com>
 <20121220082500.GA32617@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
In-Reply-To: <20121220082500.GA32617@avionic-0098.adnet.avionic-design.de>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Michal Simek <monstr@monstr.eu>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
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

On Thu, Dec 20, 2012 at 08:25:00AM +0000, Thierry Reding wrote:
> On Wed, Dec 12, 2012 at 04:37:50PM +0000, Andrew Murray wrote:
> [...]
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> [...]
> > +=09start =3D of_get_property(node, "ranges", &rlen);
> > +=09if (start =3D=3D NULL)
> > +=09=09return NULL;
> > +
> > +=09end =3D start + rlen;
>=20
> I'm currently rewriting large parts of the Tegra PCIe controller driver
> and I'm trying to use this new API. This seems to work fine, except that
> I think this line needs to be:
>=20
> =09end =3D start + rlen / sizeof(__be32);
>=20
> Otherwise we'll try to process 4 times as many ranges as there are.
>=20
> Thierry

Good catch. Thanks for taking this on.

Andrew Murray
