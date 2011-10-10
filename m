Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id E94E3B6FD1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 19:41:28 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 08874-03 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 10 Oct 2011 09:41:23 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] mlx4_en: fix transmit of packages when blue frame is
 enabled
Date: Mon, 10 Oct 2011 09:40:17 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AE78@saturn3.aculab.com>
In-Reply-To: <1318145118.29415.371.camel@pasglop>
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
> What is this __iowrite64_copy... oh I see
>=20
> Nice, somebody _AGAIN_ added a bunch of "generic" IO=20
> accessors that are utterly wrong on all archs except
> x86 (ok, -almost-).
> There isn't a single bloody memory barrier in there !

Actually memory barriers shouldn't really be added to
any of these 'accessor' functions.
(Or, at least, ones without barriers should be provided.)

The driver may want to to a series of writes, then a
single barrier, before a final write of a command (etc).

in_le32() from io.h is specially horrid!

	David
