Return-Path: <tony@bakeyournoodle.com>
Date: Fri, 3 May 2013 16:40:08 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
Subject: Re: [PATCHv4 1/2] ppc64: perform proper max_bus_speed detection
Message-ID: <20130503064008.GB4260@thor.bakeyournoodle.com>
References: <1366844090-5492-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1366844090-5492-2-git-send-email-lucaskt@linux.vnet.ibm.com>
 <20130424234838.GA1971@thor.bakeyournoodle.com>
 <51796928.2050406@linux.vnet.ibm.com>
 <51828481.2090406@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
In-Reply-To: <51828481.2090406@linux.vnet.ibm.com>
Cc: David Airlie <airlied@linux.ie>, Brian King <brking@linux.vnet.ibm.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2013 at 12:21:37PM -0300, Kleber Sacilotto de Souza wrote:

> Hi Tony,
>=20
> It seems Lucas' change is a bit incomplete and is not handling the refere=
nce counter to
> the device_node correctly. Is the following change what you had in mind?

Ahh Sorry I expected there would be a for_each_parent_of_node macro.
I did a quick grep and it seems that's not very common, so open coding
it should be fine.
=20
>=20
> 	dn =3D pcibios_get_phb_of_node(bus);
> 	if (!dn)
> 		return 0;
>=20
> 	for (pdn =3D dn; pdn !=3D NULL; pdn =3D of_get_next_parent(pdn)) {
> 		pcie_link_speed_stats =3D (const uint32_t *) of_get_property(pdn,
> 			"ibm,pcie-link-speed-stats", NULL);
> 		if (pcie_link_speed_stats)
> 			break;
> 	}
>=20
> 	of_node_put(pdn);

I think you need the of_node_put() in the body of the loop, otherwise
aren't you leaking refcounts?
=20
Yours Tony

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBCAAGBQJRg1vIAAoJEEsCiJRY75GKlUcQAKc9qdWcZsedqlp/8XT65dbF
Z5ps5hwMSpuDTBFPu5TrBd3FoqRJ1FLXAq8/r016QoFyRplC/ORLoJn4aO6erzEV
IjXSr1ghsjOVOj82B90kNDS7U2RRyJZjk+kjo55foCdtjas+loFwriPlhpKX/E8n
V4y8kcyHcKvusZ60PZlHQiCBoaTHZ4O4s9tpTgNHaLEOOsW3eXOm7b8ntj0vPcX2
o0FKajjgxqhKJqDXDCe2Yb5ci2mpkkLar8fzuRO0knMOhkVKbnZkVxaFG7vJMScs
LdP99Et7f9iNCXqAzUTJnqT57tR6FXQTTJZhgO+fNoRWdXoMw/ACCu5hUnsgiySn
slDcHUDSqEso1hGU06PDibzSdcaNjS9cOyQ/BvA8ZwwTQUubY6HuExWuTCPeeL78
BiBjk1wXRvJTsTesIxAUF7sZ9j1AJl2VWiMDlSXfBijD/shi5wLz9RJ73po2FWG3
LrB7gOfIyI7cIzqyZX1b8s3P2lP/C9251K67Virap7YoHWyZMQ6zL00SfQwXHd3r
gH6BwDKdUdYmi4WKou59NIZyzGBWEIUSo3MFpaNXc3roMa9JhoT6Y+1m8VAHxvi/
pcA0ThmY5JzLBV12uuXrDsGjIvJ3myHmQ/YAA2lzAwaqWgKzxPlPnDO72MOZKYD/
Ui7yCIuCntAizCJhp6lR
=/iEF
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
