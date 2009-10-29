Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id A5CFEB7C15
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Oct 2009 03:48:23 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 29 Oct 2009 10:48:15 -0600
Subject: RE: Accessing flash directly from User Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330E22A84@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<4AE774ED.8050502@freescale.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D368AA@midas.usurf.usu.edu>
	<4AE7775D.8080502@freescale.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D368E3@midas.usurf.usu.edu>
	<20091029163300.GC28414@loki.buserror.net>
In-Reply-To: <20091029163300.GC28414@loki.buserror.net>
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

> On Tue, Oct 27, 2009 at 04:52:40PM -0600, Jonathan Haws wrote:
> > > Will the device respond to 0x1234 being written at offset zero?
> You
> > > generally have to poke these things pretty specifically in order
> to
> > > get
> > > them to go into command mode.
> > >
> >
> > It should because that is the first data location in flash.
>=20
> I don't follow.  Even if you have an Intel command set flash (and
> thus don't
> need unlock writes), 0x1234 isn't a valid command that I know of.
> The flash
> doesn't behave as a register that you can read back; it just
> responds in a
> certain way based on what you write to it.
>=20
> > Also, just to be sure I am telling the truth, I tried writing to
> one of
> > the registers to setup an erase and got the same results - the
> value did
> > not get written.
>=20
> Following the exact sequence that the driver uses?  What did you
> write, what
> did you expect (you're generally not going to get the same thing
> back that
> you wrote), and what did you get?  What kind of command set, bus
> width, and
> interleaving do you have?

I used the erase pattern, then write pattern for my flash device.  When I t=
ried to read back the value that should have been stored, it was what it wa=
s previously.

>=20
> If you manually do the same exact accesses from a firmware prompt,
> external
> debugger, etc. does it work?
>=20
> > > > The driver works perfectly in VxWorks,
>=20
> On this exact hardware?

Yes.

> > > Including the 0x1234 thing?
> >
> > Actually, I have not tried that - I have not had to since the
> driver worked.
>=20
> What happens without the 0x1234?

Have not bothered to try it.  My guess, after finding out what the problem =
is that it would not read back 0x1234.  In the test I performed, I intended=
 to erase the sector, prep it for write, then write out 0x1234 to the first=
 two bytes in flash.  However, I failed in include the code to erase and pr=
ep the sector for writing in my rush to find out what the heck was going on=
.

As I mentioned previously, I was just not allowing the correct sequence of =
operations to take place to erase the sector (that is where my problem bega=
n) because when I setup the sector for erasure, the sequencing did not take=
 place correctly because what I would assign to flash was not committed imm=
ediately.

I hope that makes sense.

Thanks,

Jonathan
