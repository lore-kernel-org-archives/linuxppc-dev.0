Return-Path: <f.fainelli@gmail.com>
Sender: Florian Fainelli <f.fainelli@gmail.com>
From: Florian Fainelli <florian@openwrt.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 4/5] net: mvmdio: allow Device Tree and platform device to
 coexist
Date: Tue, 29 Jan 2013 21:41:45 +0100
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1359473048-26551-5-git-send-email-florian@openwrt.org>
 <20130129175912.GE25646@obsidianresearch.com>
In-Reply-To: <20130129175912.GE25646@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201301292141.45931.florian@openwrt.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Mackerras <paulus@samba.org>, Lennert Buytenhek <buytenh@wantstofly.org>,
 Rob Landley <rob@landley.net>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le mardi 29 janvier 2013 18:59:12, Jason Gunthorpe a =E9crit :
> On Tue, Jan 29, 2013 at 04:24:07PM +0100, Florian Fainelli wrote:
> > -	dev->err_interrupt =3D irq_of_parse_and_map(pdev->dev.of_node, 0);
> > +	if (pdev->dev.of_node) {
> > +		dev->regs =3D of_iomap(pdev->dev.of_node, 0);
> > +		if (!dev->regs) {
> > +			dev_err(&pdev->dev, "No SMI register address given in=20
DT\n");
> > +			ret =3D -ENODEV;
> > +			goto out_free;
> > +		}
> > +
> > +		dev->err_interrupt =3D irq_of_parse_and_map(pdev->dev.of_node, 0);
> > +	} else {
> > +		r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +
> > +		dev->regs =3D ioremap(r->start, resource_size(r));
> > +		if (!dev->regs) {
> > +			dev_err(&pdev->dev, "No SMI register address given\n");
> > +			ret =3D -ENODEV;
> > +			goto out_free;
> > +		}
> > +
> > +		dev->err_interrupt =3D platform_get_irq(pdev, 0);
> > +	}
>=20
> Why do you have these different paths for OF and platform? AFAIK these
> days when a OF device is automatically converted into a platform
> device all the struct resources are created too, so you can't you just
> use platform_get_resource and devm_request_and_ioremap for both flows?
>=20
> Ditto for the interrupt - platform_get_irq should work in both cases?

There was no particular reason and I updated the patchset to do that precis=
ely=20
in version 2.
=2D-=20
=46lorian
