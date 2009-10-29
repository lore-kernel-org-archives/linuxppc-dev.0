Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09B73B7C12
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Oct 2009 03:32:45 +1100 (EST)
Date: Thu, 29 Oct 2009 11:33:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: Accessing flash directly from User Space
Message-ID: <20091029163300.GC28414@loki.buserror.net>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<4AE774ED.8050502@freescale.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D368AA@midas.usurf.usu.edu>
	<4AE7775D.8080502@freescale.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D368E3@midas.usurf.usu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330D368E3@midas.usurf.usu.edu>
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

On Tue, Oct 27, 2009 at 04:52:40PM -0600, Jonathan Haws wrote:
> > Will the device respond to 0x1234 being written at offset zero?  You
> > generally have to poke these things pretty specifically in order to
> > get
> > them to go into command mode.
> > 
> 
> It should because that is the first data location in flash. 

I don't follow.  Even if you have an Intel command set flash (and thus don't
need unlock writes), 0x1234 isn't a valid command that I know of.  The flash
doesn't behave as a register that you can read back; it just responds in a
certain way based on what you write to it.

> Also, just to be sure I am telling the truth, I tried writing to one of
> the registers to setup an erase and got the same results - the value did
> not get written.

Following the exact sequence that the driver uses?  What did you write, what
did you expect (you're generally not going to get the same thing back that
you wrote), and what did you get?  What kind of command set, bus width, and
interleaving do you have?

If you manually do the same exact accesses from a firmware prompt, external
debugger, etc. does it work?

> > > The driver works perfectly in VxWorks,

On this exact hardware?

> > Including the 0x1234 thing?
> 
> Actually, I have not tried that - I have not had to since the driver worked.

What happens without the 0x1234?

-Scott
