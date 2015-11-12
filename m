Return-Path: <dja@axtens.net>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDDDA1A072B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 09:59:51 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so78582881pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 14:59:49 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 38/50] powerpc/powernv: Exclude root bus in
 pnv_pci_reset_secondary_bus()
In-Reply-To: <1446642770-4681-39-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-39-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Fri, 13 Nov 2015 09:59:27 +1100
Message-ID: <87lha2zuwg.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> When pnv_pci_reset_secondary_bus() is called to issue reset on
> the indicated secondary bus, the bus can't be root bus. So we
> needn't consider root bus in the function.

It took me a while to convince myself that this is correct. For the
record, this is why it's correct:

pnv_pci_reset_secondary_bus fills the reset_secondary_bus callback in
the pci_controller_ops structure, and isn't used elsewhere.

In arch/powerpc/kernel/pci.c, that callback is called (if it exists) in=20
pcibios_reset_secondary_bus(). It's not called anywhere else.

The PPC pcibios_reset_secondary_bus overrides the weak version in
drivers/pci/pci.c. It's called from the same file by
pci_reset_bridge_secondary_device() (and nowhere else).

pci_reset_bridge_secondary_device() is nicely documented:

/**
 * pci_reset_bridge_secondary_bus - Reset the secondary bus on a PCI bridge.
 * @dev: Bridge device
 *
 * Use the bridge control register to assert reset on the secondary bus.
 * Devices on the secondary bus are left in power-on state.
 */

Therefore, by the definiton of pci_reset_bridge_secondary_bus,
pnv_pci_reset_secondary_bus() can only be called with a bridge
device. As such, a bridge reset only is appropriate. If this breaks
anything, the caller is broken.

It might be worth including a condensed version of this in the commit
message.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel Axtens

>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/=
platforms/powernv/eeh-powernv.c
> index a7d84a4..c69b6a1 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -880,16 +880,8 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev,=
 int option)
>=20=20
>  void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>  {
> -	struct pci_controller *hose;
> -
> -	if (pci_is_root_bus(dev->bus)) {
> -		hose =3D pci_bus_to_host(dev->bus);
> -		pnv_eeh_root_reset(hose, EEH_RESET_HOT);
> -		pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
> -	} else {
> -		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> -		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
> -	}
> +	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> +	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>  }
>=20=20
>  /**
> --=20
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWRRnPAAoJEPC3R3P2I92F/boP/iIQ9pke3BKGqtBsAAZ8dDJG
mHTNFOeC9/s1Ykh2Mru/Kp/7b/rVKxIuah5S8ODhUcu44Xf6e1tVU2O6+wAHF2nh
h+McoeF1hxD6ZWq+0eJX/h1wmUC4H6CBQrSwoaOj1Zg3m/yiStXeG/06DEwDCGtM
NJmieCPmNzIobt/I/RBkptx9vRajinZ2/kEtsSjZqwz6F65uQe3JAMsI2Vm9BNXx
YpIYCSCTrnxuEKt+3D/nve2qeBdffUw0fLYOz76EqnJ3SsI/rgPbGnMFOGRrD9SE
Bmpvhq7D9utw1BgjXvWbQAH0dLqqnL9lU12f0ouCGpaE/WCTohjF5pmvLDZvwVC8
UKRdl9TVRNJjsXyVrygLKQNqHp4Nit8NHSHUxZOjDBnkb92N/Rk2W8loxk3YbO00
kNkqBl3lVlND7ZIBOkbl0A3veVqxOai3GXwHqkgHOOxsr43fN7xlpSjBcd7U0CtC
LJuy+O+xe76U7QGjpM9zHRIn44fDyTLGtw6NWWAUvTmw8NBvHssTvrub96eojHRL
aspVRz7dyqJueX8GflbZ2cVZab1FwZP8vbMRIYFH4pcSfWEEBU6f0Lvn49tWMnwm
HYiwSBPn2dnYSKVoVg4TbmvWaQxqHqxSRF7LSZrXTd3VEMwaR3Cg9GT5P8VdJqDK
u3bhKVw2Zw4wJFJyxhd7
=5Is4
-----END PGP SIGNATURE-----
--=-=-=--
