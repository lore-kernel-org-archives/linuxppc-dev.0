Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id D1A4BB70DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 03:33:02 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 31120-02 for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 16:32:52 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2] misc: add CARMA DATA-FPGA Access Driver
Date: Wed, 9 Feb 2011 16:30:23 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC45@saturn3.aculab.com>
In-Reply-To: <1297121021-3522-2-git-send-email-iws@ovro.caltech.edu>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>,
	<linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> This driver allows userspace to access the data processing=20
> FPGAs on the OVRO CARMA board. It has two modes of operation:
>=20
> 1) random access
>=20
> This allows users to poke any DATA-FPGA registers by using mmap to map
> the address region directly into their memory map.

I needed something similar, but used pread() and pwrite()
to request the transfers.
While this does require a system call per transfer, it allows
the driver to use dma (if available) to speed up the request.
In my case doing single cycle transfers would be too slow.

	David
