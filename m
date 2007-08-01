Return-Path: <dgibson@ozlabs.org>
Date: Wed, 1 Aug 2007 15:04:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070801050422.GI31391@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2007 at 06:57:33AM +0200, Segher Boessenkool wrote:
> >> +	UIC0: interrupt-controller0 {
> >> +		compatible = "ibm,uic-440gp","ibm,uic";
> >
> > The first compatible entry should always be the precise model, so in
> > this case "ibm,uic-440epx".
> 
> This isn't really _required_, but it is a very good idea in
> almost all cases (the exception is for very generic or legacy
> devices).

Well, yes.  That's a "should" not a "must" in rfc-speak.

> > If it is (supposed to be) identical to
> > the UIC in the 440GP, it can also have an "ibm,uic-440gp" entry, but
> > since I believe all the UICs are supposed to operate the same, I think
> > that's implicit in the "ibm,uic" entry.
> 
> Sure, but there is no harm in having the better qualified 440gp
> name in there as well -- bytes are cheap :-)
> 
> >> +	SDR0: sdr {
> >
> > What is the SDR?
> >
> >> +		compatible = "ibm,sdr-440ep";
> >> +		dcr-reg = <00e 002>;
> >> +	};
> >> +
> >> +	CPR0: cpr {
> >
> > And the CPR?
> 
> Yeah, better names please -- if possible, something that someone
> without knowledge of this SoC will understand what it is.

I think the names are probably ok - I'm assuming they're in keeping
with the convention I've used of using the same names / abbreviations
as in the CPU user manual.  I'm asking just for my own information,
although a comment might not be a bad idea.

> >> +				nor_flash@0,0 {
> >> +					device_type = "rom";
> >> +					compatible = "direct-mapped";
> >> +					probe-type = "CFI";
> >
> > This flash binding needs to be replaced, but I guess that's not really
> > your problem.
> 
> Yeah, that's my problem, thanks for the prod :-)

Also mine.  I've been home sick the last couple of days, but by way of
a sharper prod, see my draft work below.  It patches both
booting-without-of.txt with a revised binding, and implements it in
the physmap_of driver (which needs renaming, but that's another
story).  It also revises the ebony device tree as an example.

This is certainly not complete - it defines none of the extra
properties that JEDEC chips need (although the mtd drivers'
defaults/probing seem to cope for ebony).  And there are various other
ommisions.  Still, it's a starting point - something precise for you
to flame Segher :-p.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
