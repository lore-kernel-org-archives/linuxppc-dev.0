Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 330BCB6FCE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 00:15:39 +1000 (EST)
Subject: Re: Revert 737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Gabriel Paubert <paubert@iram.es>
Date: Wed, 13 Apr 2011 16:15:24 +0200
In-Reply-To: <20110413122751.GA21050@iram.es>
References: <20110406204327.GA11148@iram.es>
	<1302185075.24704.143.camel@thor.local>
	<20110411133128.GA24344@iram.es>
	<1302535963.24704.268.camel@thor.local>
	<20110412113033.GA16649@iram.es>
	<1302608770.27054.36.camel@thor.local> <20110412120055.GA7995@iram.es>
	<1302629362.15520.25.camel@thor.local> <20110413075943.GA27996@iram.es>
	<1302696736.15520.63.camel@thor.local> <20110413122751.GA21050@iram.es>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1302704124.15520.72.camel@thor.local>
Mime-Version: 1.0
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Dave Airlie <airlied@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mit, 2011-04-13 at 14:27 +0200, Gabriel Paubert wrote:=20
> On Wed, Apr 13, 2011 at 02:12:16PM +0200, Michel D=C3=A4nzer wrote:
> > On Mit, 2011-04-13 at 09:59 +0200, Gabriel Paubert wrote:=20
> > > On Tue, Apr 12, 2011 at 07:29:22PM +0200, Michel D=C3=A4nzer wrote:
> > > > On Die, 2011-04-12 at 14:00 +0200, Gabriel Paubert wrote:
> > > > > On Tue, Apr 12, 2011 at 01:46:10PM +0200, Michel D=C3=A4nzer wrot=
e:
> > > > > > >=20
> > > > > > > With no_wb=3D1 the driver goes a bit further but the X server=
 ends
> > > > > > > up in an infinite ioctl loop and the logs are:=20
> > > > > >=20
> > > > > > Which ioctl does it loop on? Please provide the Xorg.0.log file=
 as well.
> > > > >=20
> > > > > From memory, the code was 0x64, which is DRM_RADEON_GEM_WAIT_IDLE=
.
> > > >=20
> > > > Note that it's normal for this ioctl to be called every time before=
 the
> > > > GPU accessible pixmap memory is accessed by the CPU. Unless the ioc=
tl
> > > > always returns an error, this may not indicate a problem on its own=
.=20
> > >=20
> > > It seems to be an infinite loop, always returning EINTR because
> > > of regular SIGALRM delivery.
> >=20
> > That does sound like the GPU locks up. Do you get any messages in dmesg
> > about lockups and attempts to reset the GPU at any time?
>=20
> No.

Hmm, I guess the constant SIGALRMs might prevent the lockup detection
from kicking in... Maybe you can try starting the X server with
-dumbSched to see if that gets things along any further, but in the end
there's probably no way around figuring out what causes the lockup and
fixing that anyway.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
