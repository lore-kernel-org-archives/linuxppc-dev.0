Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id B1D6BB6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 19:21:47 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 02992-03 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 10 Oct 2011 09:21:43 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] mlx4_en: fix transmit of packages when blue frame is
 enabled
Date: Mon, 10 Oct 2011 09:20:38 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AE77@saturn3.aculab.com>
In-Reply-To: <1318153939.29415.401.camel@pasglop>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
 "Eli Cohen" <eli@dev.mellanox.co.il>
Cc: netdev@vger.kernel.org, Yevgeny Petrilin <yevgenyp@mellanox.co.il>,
 linuxppc-dev@lists.ozlabs.org,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Eli Cohen <eli@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> Then, this statement:
>=20
> *(u32 *) (&tx_desc->ctrl.vlan_tag) |=3D ring->doorbell_qpn;

...
> instead do ... :

> 	*(u32 *) (&tx_desc->ctrl.vlan_tag) |=3D
cpu_to_be32(ring->doorbell_qpn);
>=20
> (Also get rid of that cast and define vlan_tag as a __be32 to start
> with).

Agreed, casts that change the type of memory - *(foo *)&xxx - are
generally bad news unless you are casting a generic 'buffer' to
a specific structure.
I've seen far to much code that ends up being depending on the
endianness and system word size.

For the above I'd actually suggest making 'doorbell_qpn' have the
correct endianness in order to avoid the (potential) swap every
time it is set.

You also need to treble-check the required endianness for the
'vlan_tag' in the tx descriptor. What would be needed is the
MAC PCI slave were on an x86 (LE) system.

	David
