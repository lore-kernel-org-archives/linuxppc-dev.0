Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 8C88C2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 11:29:33 +1000 (EST)
Date: Tue, 11 Sep 2012 11:29:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: linux-next: build failure after merge of the pci tree
Message-Id: <20120911112924.c2206bc738a2c29259f6e2d8@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__11_Sep_2012_11_29_24_+1000_iNe+q0uYS_AENYPQ"
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Yijing Wang <wangyijing@huawei.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__11_Sep_2012_11_29_24_+1000_iNe+q0uYS_AENYPQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

After merging the pci tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/platforms/powernv/pci-ioda.c: In function 'pnv_pci_window_alig=
nment':
arch/powerpc/platforms/powernv/pci-ioda.c:1163:13: error: 'struct pci_dev' =
has no member named 'pcie_type'

Caused by commit ac161fbfdaa2 ("powerpc/powernv: I/O and memory alignment
for P2P bridges").  pcie_type was removed in commit b2ef39be5744 ("PCI:
Remove unused field pcie_type from struct pci_dev") (also in the pci
tree).

I have used the pci tree from next-20120910 for today.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__11_Sep_2012_11_29_24_+1000_iNe+q0uYS_AENYPQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQTpP0AAoJEECxmPOUX5FEr4MP/2W9SM+iSjubcg3/8vXMIA8f
VR0r04cBnh11Lmj1Z9ucYJ52awAZgRwlKDBUfmjLUauCFugtB//qnoyP+ewtkadZ
4tMd698uyqXrihJLeSHgle8rAMMA/txaPm9fxOyj1y7RZ6YIBErssbuEDry3ejhH
sNHn/lDmuzZrwoR/O6ad+XCmibPJOb09AW87xn1srpGB9CPtt/LTjMDP/jXyHFvG
/UzBMARpzShs1Vso/s6ANK5u2Yg5cYBZ9J5QaRUwpnGCt1zaW+WfrQyXMr/04z0/
jhQGXutGug44PZ/wwqhhOEznSnHJFoRP07uOjTyfoNjla16qnepGqLt6oy6ykgdb
QXx1+bgiNxrKCjkGuCCVaNIPEqv3cNS+4SdfPeVzRL2qTt2LV6ogIWBxT3y2/kfO
bnhQE7ln1j14C0BpJRe3/U4e8q0xIFoahWeZcmQ3776wC7w/GVMKkRwhO7LRt08N
pX+is/IxTbL4tMJBTqza3v1VqIsJFZKa0Nm1dbuO3RuhlpGxe5BBD6jYkcbPZVz5
SWTUU67yjiZTx0yUDxsYfNLracmWQYUu/8T5lqBT+wGQ6KEhCDEllnX492HwoBq2
tQsU9Gck9SY3vqWQXSbM/hvWWoMoQV88GS5kH5+m9Dsk0kUE8dSw8ZWTyn2M1YmY
sPMWVZKx0255vrxvsVma
=IMl4
-----END PGP SIGNATURE-----

--Signature=_Tue__11_Sep_2012_11_29_24_+1000_iNe+q0uYS_AENYPQ--
