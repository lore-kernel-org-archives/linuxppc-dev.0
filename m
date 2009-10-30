Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 5037EB7C2E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 31 Oct 2009 01:50:32 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Scott Wood <scottwood@freescale.com>, Joakim Tjernlund
	<joakim.tjernlund@transmode.se>
Date: Fri, 30 Oct 2009 08:50:22 -0600
Subject: RE: Accessing flash directly from User Space [SOLVED]
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330E230FC@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<20091028112430.GO22408@zod.rchland.ibm.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D36A3D@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F0330E22259@midas.usurf.usu.edu>
	<OFE3AA516D.46A96178-ONC125765E.0030DA7C-C125765E.00317B8C@transmode.se>
	<20091029233038.GA21587@b07421-ec1.am.freescale.net>
In-Reply-To: <20091029233038.GA21587@b07421-ec1.am.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Bill Gatliff <bgat@billgatliff.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Thu, Oct 29, 2009 at 10:00:28AM +0100, Joakim Tjernlund wrote:
> > > I have found the problem.  It occurred to me in the shower (okay
> not really,
> > > but most good ideas happen there).
> > >
> > > What was happening is that I was in fact able to write to the
> correct
> > > registers.  However, I would try and write to them in a batch.
> But the way
> > > mmap works (at least according to the man page) with MAP_SHARED
> is that the
> > > file may not be updated until msync() is called.  Now, I thought
> that O_SYNC
> > > would take care of that when I open /dev/mem, but that was not
> the case.
> > >
> > > Anyway, to make a long story short, I inserted an msync() after
> each
> > > assignment to the flash.  This resolved my problem and I can now
> program my flash.
> >
> > Ouch, this was news to me too. Calling msync() after every write
> kills performance.
> > We use mmap(/dev/mem) to access HW and havn't seen any issues yet.
> Is this
> > perhaps a new behaviour for mmap(/dev/mem) and is there a way
> > to avoid calling msync()?
>=20
> I suspect that the msync() was merely serving as a very heavyweight
> memory barrier.

I did try hacking the mb() calls from the kernel source to use them in user=
 space, but they had no effect.  I still had to include the calls to msync(=
).
