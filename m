Return-Path: <dpelton@ciena.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: fs_enet - support for SCC on CPM2?
Date: Tue, 26 Sep 2006 11:22:30 -0400
Message-ID: <3B9518857C91E345AA1806A6F53C0EB7019F342B@onmxm01.ciena.com>
From: "Pelton, Dave" <dpelton@ciena.com>
To: "Matt Hevern" <matt.hevern@nec.com.au>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Matt Hevern
<snip>
>=20
> I am trying to compile for an freescale 82xx (CPM2) series=20
> processor, with ethernet on an SCC. (kernel 2.6.x)  From what=20
> i can see, in the file drivers/net/fs_enet/fs_enet-main.c,
> the config option "CONFIG_FS_ENET_HAS_SCC"  pulls in=20
> "fs_scc_ops" which are defined in=20
> drivers/net/fs_enet/mac-scc.c, but this file  does not seem=20
> to have support for 82xx series, failing with various compile errors:
<snip>
> It seems like these errors are mostly due to the driver being tailored
for 8xx series.
<snip>

I had the same problem trying to use fs_enet for 82xx SCC Ethernet and
came to the same conclusion.  The FCC could not be used instead of the
SCC because of pin limitations in the hardware design.  I ended up using
the "old" SCC Ethernet driver by disabling CONFIG_FS_ENET_HAS_SCC and
enabling CONFIG_SCC_ENET (Under CPM2 options in kernel config).  This
does not use the new platform bus structure, and arch/ppc/8260_io/enet.c
may require some board specific tweaks, but it does work.

- David Pelton.
