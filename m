Return-Path: <thierry.reding@gmail.com>
Received: from mail-wg0-x22c.google.com (mail-wg0-x22c.google.com
 [IPv6:2a00:1450:400c:c00::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AE5B1A009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:34:43 +1000 (EST)
Received: by mail-wg0-f44.google.com with SMTP id z12so3591788wgg.15
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 00:34:39 -0700 (PDT)
Date: Thu, 25 Sep 2014 09:34:36 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 12/22] MIPS/Octeon/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
Message-ID: <20140925073435.GJ12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-13-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rwgQ89ZNnFUwFHTC"
In-Reply-To: <1411614872-4009-13-git-send-email-wangyijing@huawei.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, David Vrabel <david.vrabel@citrix.com>,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--rwgQ89ZNnFUwFHTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:22AM +0800, Yijing Wang wrote:
[...]
> diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
[...]
> @@ -132,12 +132,12 @@ msi_irq_allocated:
>  	/* Make sure the search for available interrupts didn't fail */
>  	if (irq >=3D 64) {
>  		if (request_private_bits) {
> -			pr_err("arch_setup_msi_irq: Unable to find %d free interrupts, trying=
 just one",
> +			pr_err("octeon_setup_msi_irq: Unable to find %d free interrupts, tryi=
ng just one",
>  			       1 << request_private_bits);

Perhaps while at it make this (and other similar changes in this patch):

	pr_err("%s(): Unable to ...", __func__, ...);

So that it becomes more resilient against this kind of rename?

>  			request_private_bits =3D 0;
>  			goto try_only_one;
>  		} else
> -			panic("arch_setup_msi_irq: Unable to find a free MSI interrupt");
> +			panic("octeon_setup_msi_irq: Unable to find a free MSI interrupt");

> @@ -210,14 +210,13 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nv=
ec, int type)
> =20
>  	return 0;
>  }
> -

This...

> @@ -240,7 +239,7 @@ void arch_teardown_msi_irq(unsigned int irq)
>  	 */
>  	number_irqs =3D 0;
>  	while ((irq0 + number_irqs < 64) &&
> -	       (msi_multiple_irq_bitmask[index]
> +		(msi_multiple_irq_bitmask[index]

=2E.. and this seem like unrelated whitespace changes.

>  		& (1ull << (irq0 + number_irqs))))
>  		number_irqs++;
>  	number_irqs++;
> @@ -249,8 +248,8 @@ void arch_teardown_msi_irq(unsigned int irq)
>  	/* Shift the mask to the correct bit location */
>  	bitmask <<=3D irq0;
>  	if ((msi_free_irq_bitmask[index] & bitmask) !=3D bitmask)
> -		panic("arch_teardown_msi_irq: Attempted to teardown MSI "
> -		      "interrupt (%d) not in use", irq);
> +		panic("octeon_teardown_msi_irq: Attempted to teardown MSI "
> +			"interrupt (%d) not in use", irq);

And the second line here also needlessly changes the indentation.

Thierry

--rwgQ89ZNnFUwFHTC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8WLAAoJEN0jrNd/PrOhp2MQAK6S7hsneW6O97w/t1chjlGR
ug1JLAxeP84A0Vj4I6KwfrHjux8rDqoByI5bDhH+ywcRQuf90Dx9+L9QEfWlzkcC
K1qT+twZDUqVFhCIJtuEtNVJbEXb0NlPK74W/6cUubFdAKbY1+MZe66Z0BZlBl36
bjxEyTh6uZkemh8PLwP45mJQCTD/d5/lNGDCrgzKgurE1HIHXV1r0FoD9zLJZpfA
UATpp5rQYfePlynE1mCT+G0QXcfo+zf8kp49jLxeciX5QZYs8DbZ2IwbhG4ov2je
p8SHV5T+c8D1+Q7UjNbXpDGHz12Ctpby/bLd3+FGsmeIZJbE4o5NcE5pChZfI52v
Rgl0wLOlswsM2xoSGdhA1x51QEHqFxShBf/+FwbxLA7shNWELd6gRpv9mcYSv6oy
MgALA5tV5r18NZyBm+SsvwUrgAF7e1ndIU/UYhAH1lIz3CMtqTnZ2AZIpXoJeKLo
rtzWB2MThJnnZXUpW3Umj3UWoZkcAy6zQSWBGV40hC+t3dkr1US9bOgGIrO6huyy
qTqNG+A20dRO85W7LoslDg5CO401jS8JRiHbYQW9g+QhHkWLpROgcrCoK1dz+Q2B
QjaLp2fjuM7wyyYXRLcQo68i7Y9AUv2R+k1fidvlfuWXfvzbeK6x0BHSx8nhBec6
SU2aBh+SOaTeNEFZjRFv
=dRXg
-----END PGP SIGNATURE-----

--rwgQ89ZNnFUwFHTC--
