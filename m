Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A41111A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 14:29:36 +1100 (AEDT)
Received: by padhk11 with SMTP id hk11so26348080pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 20:29:34 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V10 05/12] powerpc/eeh: Cache only BARs,
 not windows or IOV BARs
In-Reply-To: <1445829362-2738-6-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-6-git-send-email-weiyang@linux.vnet.ibm.com>
Date: Thu, 29 Oct 2015 14:29:19 +1100
Message-ID: <87h9lapd2o.fsf@gamma.ozlabs.ibm.com>
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

Wei Yang <weiyang@linux.vnet.ibm.com> writes:

> EEH address cache, which helps to locate the PCI device according to
> the given (physical) MMIO address, didn't cover PCI bridges. Also, it
> shouldn't return PF with address in PF's IOV BARs. Instead, the VFs
> should be returned.
>
> Also, by doing so, it removes the type check in
> eeh_addr_cache_insert_dev(), since bridge's window would not be cached.
>
> The patch restricts the address cache to cover first 7 BARs for the
> above purposes.
If I've understoond the patch correctly, I think you want to swap the
last two paragraphs in the commit message:

"Restrict the address cache to cover the first 7 BARs...

Since the window of a bridge will now not be cached, remove the type
check..."

With regards to the actual patch, I have now got access to the PCI and
SR-IOV specs, but I'm still getting to grips with it all so let me know
if something I say doesn't make sense.

Here, you restrict the enumeration of resources to the standard and
extension ROM resources (the first 7), which excludes enumeration of
VF resources. That much I understand.

I'm having more trouble convincing myself that it's safe or desirable to
drop the test for bridges. I think I understand that the change to the
for loop means it _should_ be safe, but is there any motivation for the
change other than making the code more straightforward?

>  	/* Walk resources on this device, poke them into the tree *
This comment probably needs to be made more descriptive given the change.
> -	for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +	for (i =3D 0; i <=3D PCI_ROM_RESOURCE; i++) {
>  		resource_size_t start =3D pci_resource_start(dev,i);
>  		resource_size_t end =3D pci_resource_end(dev,i);
>  		unsigned long flags =3D pci_resource_flags(dev,i);
> @@ -222,10 +222,6 @@ void eeh_addr_cache_insert_dev(struct pci_dev *dev)
>  {

Regards,
Daniel

>  	unsigned long flags;
>=20=20
> -	/* Ignore PCI bridges */
> -	if ((dev->class >> 16) =3D=3D PCI_BASE_CLASS_BRIDGE)
> -		return;
> -
>  	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
>  	__eeh_addr_cache_insert_dev(dev);
>  	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
> --=20
> 2.5.0
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

iQIcBAEBCgAGBQJWMZKPAAoJEPC3R3P2I92F4yUP/2+LVfLEulfsQFlu8wYybzFB
Ql7EBUTmS0jLABLiEstd5vbQCtMIwZeqDkeKYyJwXC0AqNBK2QjIRGviTS/VdK6l
9SFMfiefVUPd/kKCHTNCSP3ZCTbPNWZHqxuyfrDIsTO9rRnKWRBrxBWs/jDk3Ids
BZ4JZuEt3i6sgEwnivnD6sMIO7ZqIghVHG9cutIKWxCi/H8weO2UZwtaalySCQ2h
98WR91l2/kz/wH0Q49tVxijcaqx0+m8IAzxTFBismTGh00uikW3REm1euIfrqZSs
KXmpPZSWJPjPj0JjIuZFE73XJnbTlNBIA7x/pUC0a0SaSVRb5irk+EzpHlCTGPvx
zi98ugS842la+I2mx7x8IxQVNkPMBcnY669XrZOvaJM+fDg2M0n/tbWXuf3m2gJ8
kRVN7rBiSE59wr9g585KE/YZBQ6S1R7apX2Ha3f9Ze+StvrQ1DkVSHwh+Qq0HBli
fAzgbbpxu1+wW4l10R9a3RNsDB5nx5mCAZRPPlNSqgj4rY4M10CjGIDZEXdv+HCL
tYXQr1KZtz3ORB35OlUMDg6fkkWr5cBJ1Oq6Cw9Pjcqesqw0w+FeslXzHbs06jKe
sPV2z2a/xl0uJ1PgSOx+5UV+UjpvMbOM/hQnH4JUIWkfG1ECKGrpE9kN4K83EZrt
BVphs8FSiX0s4hLmPI+p
=y51B
-----END PGP SIGNATURE-----
--=-=-=--
