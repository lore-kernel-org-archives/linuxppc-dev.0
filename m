Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E8F5DDFC6
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 15:08:13 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4R58ATu002829
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 22:08:10 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4R588aZ011175
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 00:08:09 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Net: ucc_geth ethernet driver optimization space
Date: Wed, 27 May 2009 13:08:07 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208934920A@zch01exm21.fsl.freescale.net>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: <netdev@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys,

The ucc_geth ethernet driver have dozens of strong sync read/write
operation, such as in_be32/16/8, out_be32/16/8.

all of them is sync read/write, it is very expensive for performance.

For the critical patch, we can remove some unnecessary in_be(x),
out_be(x) with normal memory operation, and keep some necessary
memory barrier.

eg: BD access in the interrupt handler and start_xmit.

The BD operation only need the memory barrier between length/buffer
and status.

struct buffer descriptor {
	u16 status;
	u16 length;
	u32 buffer;
} __attribute__ ((packed));

struct buffer descriptor *BD;

BD->length =3D xxxx;
BD->buffer =3D yyyy;
wmb();
BD->status =3D zzzz;

For powerpc, eieio is enough for 60x, mbar 1 is enough for e500.
Of couse, also need the memory clobber to avoid the compiler
reorder between them.

Thanks, Dave
