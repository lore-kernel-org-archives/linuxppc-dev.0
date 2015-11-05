Return-Path: <dja@axtens.net>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B6901A0C48
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 09:28:03 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so91780673pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2015 14:28:01 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 02/50] powerpc/pci: Override pcibios_setup_bridge()
In-Reply-To: <1446642770-4681-3-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-3-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Fri, 06 Nov 2015 09:27:42 +1100
Message-ID: <87wptwhyjl.fsf@gamma.ozlabs.ibm.com>
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

>=20=20
> +void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
> +{
> +	struct pci_controller *hose =3D pci_bus_to_host(bus);
Very much a nit-pick, but I thought we were trying to move towards using
phb instead of hose in new code?

Apart from that this looks good. I would probably have merged it with
the previous patch, but I know Alexey has been suggesting a lot of
splitting and merging previously, so whatever he prefers here is OK.

> +
> +	if (hose->controller_ops.setup_bridge)
> +		hose->controller_ops.setup_bridge(bus, type);
> +}
> +
>  void pcibios_reset_secondary_bus(struct pci_dev *dev)
>  {
>  	struct pci_controller *phb =3D pci_bus_to_host(dev->bus);
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

iQIcBAEBCgAGBQJWO9ffAAoJEPC3R3P2I92FbQMP/2XjTQJHUW0IaKwIBRjhUwrR
aKKiDzghFxqPdXxayIecjPUE6rMOWI1I1/ZkpV9XjK3tghvrJHZc3d+M/GiYqFQf
ueyeDZj5wqIa4msemOOF0bpzMERvgU7uo4QlukmW6FbEHqg0JHpsQ6fLtnTSwhIs
VRP6X9sNh/Ai5cDbo2hihuZUYKQTonF5/i7tGIz7GlMM80ZNRw3gycZSLKaT948L
evOTAe6bClENpEQe75e+9R6nFGSTbLNkO8P6QEA1JLXSmfGat06B1fljQpxAw+LW
PrUKmOhoLh68gKaWOhFKHhRqxAeJI8TroWcSjRmMPadSv0lxoQS+ut3p7+5U2EuA
tY0IQmn/tKo2ukx3xPf7+WaisSHDsS08zYtBD2OmD329UO5sGzmOFdLrIuMvmKeK
bc02qexIjUIRE2QIIPdz2oZBxp6gI2kwEzWxlwLZHYVrDru32bCavlA2Q/e6hwX0
kyaiHfJPJCIuwodaQCvQ08NvbhP3MKcis2tCmXgzXG5LcNKUB3LPc2iuT4Q6++w1
UaXM6XLsAfr0XZgAepZO6lUgY/L0fddK/Pl6VwXbDEifMRycOEKSnm2dQnaqWT/e
v1s2kaS1NBtN8ETLO5u6EWhnGzZbEsKEWZjgx2EtCaNMKqg+DwneMR1pfPXhbnn/
URCSZA/vrbMtZpxg+rtt
=TMYR
-----END PGP SIGNATURE-----
--=-=-=--
