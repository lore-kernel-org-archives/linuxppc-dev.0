Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 88352B7BEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Oct 2009 04:02:53 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Kenneth Johansson <kenneth@southpole.se>, Joakim Tjernlund
	<joakim.tjernlund@transmode.se>
Date: Thu, 29 Oct 2009 11:02:45 -0600
Subject: RE: Accessing flash directly from User Space [SOLVED]
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330E22ACD@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<20091028112430.GO22408@zod.rchland.ibm.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D36A3D@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F0330E22259@midas.usurf.usu.edu>
	<OFE3AA516D.46A96178-ONC125765E.0030DA7C-C125765E.00317B8C@transmode.se>
	<1256814536.24490.36.camel@kenjo-laptop>
In-Reply-To: <1256814536.24490.36.camel@kenjo-laptop>
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
> The address range should be outside the dram and thus uncached. Any
> write to any address in the range mmaped should go directly to the
> NOR
> flash. Any other behavior is a bug. It's not mapping an actual file
> here.

That is what I was thinking.  But I have a working driver and the extra del=
ay of writing to flash caused by the msync() calls I can deal with.  I only=
 ever write data to flash when I need to update one of my boot images.

Thanks,

Jonathan
