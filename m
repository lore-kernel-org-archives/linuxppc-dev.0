Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id E248DDDFC8
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 00:41:50 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
Date: Fri, 15 Jun 2007 16:41:37 +0200
References: <20070615113919.142332000@pademelon.sonytel.be>
	<20070615120848.352093000@pademelon.sonytel.be>
	<1181918159.25228.543.camel@pmac.infradead.org>
In-Reply-To: <1181918159.25228.543.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706151641.37788.arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@steeleye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 15 June 2007, David Woodhouse wrote:
>=20
> On Fri, 2007-06-15 at 13:39 +0200, Geert Uytterhoeven wrote:
> > Add a Disk Storage Driver for the PS3:
> > =A0 - Implemented as a block device driver with a dynamic major
> > =A0 - Disk names (and partitions) are of the format ps3d%c(%u)
> > =A0 - Uses software scatter-gather with a 64 KiB bounce buffer as the h=
ypervisor
> > =A0 =A0 doesn't support scatter-gather
>=20
> Any particular reason why this is done as a separate block device driver
> rather than as SCSI?

Because the hypervisor interface is based on tranferring blocks, not based
on SCSI commands like the one for the optical storage drive.

The first version of this driver actually was based on SCSI command emulati=
on,
and in an earlier round of reviews it was decided to rewrite it to use the
simpler block interface directly.

	Arnd <><
