Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1502B7D4F
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2010 05:05:38 +1100 (EST)
Date: Tue, 2 Feb 2010 19:05:03 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Breno Leitao <leitao@linux.vnet.ibm.com>
Subject: Re: [PATCH] eeh: Fixing a bug when pci structure is null
Message-ID: <20100202180503.GL4757@pengutronix.de>
References: <1264789719-15591-1-git-send-email-leitao@linux.vnet.ibm.com>
	<4B6864F4.1030106@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dpynvXbW/eW9Tpc3"
In-Reply-To: <4B6864F4.1030106@linux.vnet.ibm.com>
Cc: Linas Vepstas <linasvepstas@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dpynvXbW/eW9Tpc3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2010 at 03:46:28PM -0200, Breno Leitao wrote:
>  During a EEH recover, the pci_dev structure can be null, mainly if an
>  eeh event is detected during cpi config operation. In this case, the
>  pci_dev will not be known (and will be null) and the kernel will crash
>  with the following message:
> =20
>  Unable to handle kernel paging request for data at address 0x000000a0
>  Faulting instruction address: 0xc00000000006b8b4
>  Oops: Kernel access of bad area, sig: 11 [#1]
> =20
>  NIP [c00000000006b8b4] .eeh_event_handler+0x10c/0x1a0
>  LR [c00000000006b8a8] .eeh_event_handler+0x100/0x1a0
>  Call Trace:
>  [c0000003a80dff00] [c00000000006b8a8] .eeh_event_handler+0x100/0x1a0
>  [c0000003a80dff90] [c000000000031f1c] .kernel_thread+0x54/0x70
> =20
>  The bug occurs because pci_name() tries to access a null pointer.
>  This patch just guarantee that pci_name() is not called on Null pointers.
> =20
>  Signed-off-by: Breno Leitao <leitao@linux.vnet.ibm.com>
>  Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>
>  ---
>   arch/powerpc/include/asm/ppc-pci.h          |    7 +++++++
>   arch/powerpc/platforms/pseries/eeh.c        |    4 ++--
>   arch/powerpc/platforms/pseries/eeh_driver.c |    4 ++--
>   arch/powerpc/platforms/pseries/eeh_event.c  |    2 +-
>   4 files changed, 12 insertions(+), 5 deletions(-)
> =20
>  diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/a=
sm/ppc-pci.h
>  index 2828f9d..724dbe2 100644
>  --- a/arch/powerpc/include/asm/ppc-pci.h
>  +++ b/arch/powerpc/include/asm/ppc-pci.h
>  @@ -137,6 +137,13 @@ struct device_node * find_device_pe(struct device_n=
ode *dn);
>   void eeh_sysfs_add_device(struct pci_dev *pdev);
>   void eeh_sysfs_remove_device(struct pci_dev *pdev);
> =20
>  +static inline const char *eeh_pci_name(struct pci_dev *pdev)=20
>  +{=20
>  +	if (NULL=3D=3Dpdev)=20
>  +		return "<null>";=20
>  +	return pci_name(pdev);=20

What about:

	return pdev ? pci_name(pdev) : "<null>";


>  +}=20
>  +
>   #endif /* CONFIG_EEH */
> =20
>   #else /* CONFIG_PCI */
>  diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platfor=
ms/pseries/eeh.c
>  index ccd8dd0..f9360fe 100644
>  --- a/arch/powerpc/platforms/pseries/eeh.c
>  +++ b/arch/powerpc/platforms/pseries/eeh.c
>  @@ -491,7 +491,7 @@ int eeh_dn_check_failure(struct device_node *dn, str=
uct pci_dev *dev)
>   	    pdn->eeh_mode & EEH_MODE_NOCHECK) {
>   		ignored_check++;
>   		pr_debug("EEH: Ignored check (%x) for %s %s\n",
>  -			 pdn->eeh_mode, pci_name (dev), dn->full_name);
>  +			 pdn->eeh_mode, eeh_pci_name (dev), dn->full_name);

No space after function name, please.

>   		return 0;
>   	}
> =20
>  @@ -515,7 +515,7 @@ int eeh_dn_check_failure(struct device_node *dn, str=
uct pci_dev *dev)
>   			printk (KERN_ERR "EEH: %d reads ignored for recovering device at "
>   				"location=3D%s driver=3D%s pci addr=3D%s\n",
>   				pdn->eeh_check_count, location,
>  -				dev->driver->name, pci_name(dev));
>  +				dev->driver->name, eeh_pci_name(dev));

ditto

>   			printk (KERN_ERR "EEH: Might be infinite loop in %s driver\n",
>   				dev->driver->name);
>   			dump_stack();
>  diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/=
platforms/pseries/eeh_driver.c
>  index ef8e454..8f948a0 100644
>  --- a/arch/powerpc/platforms/pseries/eeh_driver.c
>  +++ b/arch/powerpc/platforms/pseries/eeh_driver.c
>  @@ -337,7 +337,7 @@ struct pci_dn * handle_eeh_events (struct eeh_event =
*event)
>   		location =3D location ? location : "unknown";
>   		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint "
>   		                "for location=3D%s pci addr=3D%s\n",
>  -		        location, pci_name(event->dev));
>  +		        location, eeh_pci_name(event->dev));
>   		return NULL;
>   	}
> =20
>  @@ -368,7 +368,7 @@ struct pci_dn * handle_eeh_events (struct eeh_event =
*event)
>   		pci_str =3D pci_name (frozen_pdn->pcidev);
>   		drv_str =3D pcid_name (frozen_pdn->pcidev);
>   	} else {
>  -		pci_str =3D pci_name (event->dev);
>  +		pci_str =3D eeh_pci_name (event->dev);

ditto

>   		drv_str =3D pcid_name (event->dev);
>   	}
>   =09
>  diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/p=
latforms/pseries/eeh_event.c
>  index ddb80f5..ec5df8f 100644
>  --- a/arch/powerpc/platforms/pseries/eeh_event.c
>  +++ b/arch/powerpc/platforms/pseries/eeh_event.c
>  @@ -80,7 +80,7 @@ static int eeh_event_handler(void * dummy)
>   	eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);
> =20
>   	printk(KERN_INFO "EEH: Detected PCI bus error on device %s\n",
>  -	       pci_name(event->dev));
>  +	       eeh_pci_name(event->dev));
> =20
>   	pdn =3D handle_eeh_events(event);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--dpynvXbW/eW9Tpc3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktoaU8ACgkQD27XaX1/VRttUwCgrdu4DCNHw00AplOaUGGvJd8l
iMoAn0+Y4jKG2Wal69T42UNrUbLSrVlq
=c58H
-----END PGP SIGNATURE-----

--dpynvXbW/eW9Tpc3--
