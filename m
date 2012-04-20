Return-Path: <B08248@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4BCB7B6FBC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2012 04:37:40 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: pci node question
Date: Fri, 20 Apr 2012 18:37:28 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There was refactoring change a while back that moved=20
the interrupt map down into the virtual pci bridge.

example:=20
42 /* controller at 0x200000 */
43 &pci0 {
44         compatible =3D "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";
45         device_type =3D "pci";
46         #size-cells =3D <2>;
47         #address-cells =3D <3>;
48         bus-range =3D <0x0 0xff>;
49         clock-frequency =3D <33333333>;
50         interrupts =3D <16 2 1 15>;
51         pcie@0 {
52                 reg =3D <0 0 0 0 0>;
53                 #interrupt-cells =3D <1>;
54                 #size-cells =3D <2>;
55                 #address-cells =3D <3>;
56                 device_type =3D "pci";
57                 interrupts =3D <16 2 1 15>;
58                 interrupt-map-mask =3D <0xf800 0 0 7>;
59                 interrupt-map =3D <
60                         /* IDSEL 0x0 */
61                         0000 0 0 1 &mpic 40 1 0 0
62                         0000 0 0 2 &mpic 1 1 0 0
63                         0000 0 0 3 &mpic 2 1 0 0
64                         0000 0 0 4 &mpic 3 1 0 0
65                         >;
66         };
67 };

Why was the interrupt-map moved here?

Do we really need the error interrupt specified twice?

Why is there a zeroed out reg property: reg =3D <0 0 0 0 0> ??

Thanks,
Stuart
