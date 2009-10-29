Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E7A02B7BE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Oct 2009 10:30:43 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9TNUdP2021117 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Oct 2009 16:30:39 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n9TNUdFf005788
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Oct 2009 18:30:40 -0500 (CDT)
Date: Thu, 29 Oct 2009 18:30:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Accessing flash directly from User Space [SOLVED]
Message-ID: <20091029233038.GA21587@b07421-ec1.am.freescale.net>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<20091028112430.GO22408@zod.rchland.ibm.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D36A3D@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F0330E22259@midas.usurf.usu.edu>
	<OFE3AA516D.46A96178-ONC125765E.0030DA7C-C125765E.00317B8C@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFE3AA516D.46A96178-ONC125765E.0030DA7C-C125765E.00317B8C@transmode.se>
Cc: Bill Gatliff <bgat@billgatliff.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 29, 2009 at 10:00:28AM +0100, Joakim Tjernlund wrote:
> > I have found the problem.  It occurred to me in the shower (okay not really,
> > but most good ideas happen there).
> >
> > What was happening is that I was in fact able to write to the correct
> > registers.  However, I would try and write to them in a batch.  But the way
> > mmap works (at least according to the man page) with MAP_SHARED is that the
> > file may not be updated until msync() is called.  Now, I thought that O_SYNC
> > would take care of that when I open /dev/mem, but that was not the case.
> >
> > Anyway, to make a long story short, I inserted an msync() after each
> > assignment to the flash.  This resolved my problem and I can now program my flash.
> 
> Ouch, this was news to me too. Calling msync() after every write kills performance.
> We use mmap(/dev/mem) to access HW and havn't seen any issues yet. Is this
> perhaps a new behaviour for mmap(/dev/mem) and is there a way
> to avoid calling msync()?

I suspect that the msync() was merely serving as a very heavyweight
memory barrier.

-Scott
