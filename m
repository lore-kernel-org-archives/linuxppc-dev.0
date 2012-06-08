Return-Path: <benmcollins13@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 83BD5B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jun 2012 04:39:06 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so3295830pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jun 2012 11:39:04 -0700 (PDT)
Sender: Ben Collins <benmcollins13@gmail.com>
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9A3259B0-DA44-4848-826C-05B81ACE7624";
 protocol="application/pgp-signature"; micalg=pgp-sha1
From: Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <1339104753.24838.30.camel@pasglop>
Date: Fri, 8 Jun 2012 14:38:43 -0400
Message-Id: <BA42176E-B45B-4628-A143-EA7465233651@ubuntu.com>
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
 <4FCFC870.40004@freescale.com>
 <16AB27C3-8709-4A7C-AFFE-42A0B658AC1D@servergy.com>
 <1339061428.24838.24.camel@pasglop>
 <489B8149-6E40-48B3-880F-EF8BE72E94BF@servergy.com>
 <1339104753.24838.30.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_9A3259B0-DA44-4848-826C-05B81ACE7624
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On Jun 7, 2012, at 5:32 PM, Benjamin Herrenschmidt wrote:

> On Thu, 2012-06-07 at 11:38 -0400, Ben Collins wrote:
>>> Note that oddly, the second range of bus addresses looks -more-
>> correct
>>> than the first one...
>>=20
>> Except that the first one is exactly the same bus address as my bare
>> metal system:
>>=20
>> pci_bus 0000:00: root bus resource [io  0xffbeb000-0xffbfafff] (bus
>> address [0x100000000-0x10000ffff])
>>=20
>> I only have one PCIe RAID card on the bare metal system. Not
>> surprising I never noticed the problem on it directly.
>=20
> Can you show me the device-tree node for that PCI host bridge ?


It's a p4080ds, so it's in arch/powerpc/boot/

And that means that this bug affects a real hardware platform, so I =
think it makes it more valid to include it. The only reason it didn't =
affect me directly is because my only PCIe card doesn't have io, just =
mem BARs.

--
Bluecherry: http://www.bluecherrydvr.com/
SwissDisk : http://www.swissdisk.com/
Ubuntu    : http://www.ubuntu.com/
My Blog   : http://ben-collins.blogspot.com/


--Apple-Mail=_9A3259B0-DA44-4848-826C-05B81ACE7624
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.18 (Darwin)

iEYEARECAAYFAk/SRsMACgkQbVJJsWDoC1sCOwCcCLdkcuJdL7M/zdAH647jgr6S
QP8Anj7jdSAdU45R89T9i9brHpcqnJQs
=B8rN
-----END PGP SIGNATURE-----

--Apple-Mail=_9A3259B0-DA44-4848-826C-05B81ACE7624--
