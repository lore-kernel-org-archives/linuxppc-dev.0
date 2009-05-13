Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4D26DDFB0
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 12:36:20 +1000 (EST)
Date: Wed, 13 May 2009 12:36:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: device trees.
Message-ID: <20090513023614.GJ24338@yookeroo.seuss>
References: <fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<20090511155232.A30671B6005D@mail89-va3.bigfish.com>
	<4A08593C.4010503@dlasys.net>
	<20090511183638.F07C01438054@mail184-wa4.bigfish.com>
	<4A08C599.2030100@dlasys.net>
	<20090512005554.EEE1019D009B@mail129-dub.bigfish.com>
	<4A08E050.9000302@dlasys.net>
	<20090512042733.8D4A21400054@mail184-dub.bigfish.com>
	<fa686aa40905112230ve176b30o25abcdf5c203f6c7@mail.gmail.com>
	<20090513001048.490B533005D@mail141-va3.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090513001048.490B533005D@mail141-va3.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, "David H. Lynch Jr." <dhlii@dlasys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 12, 2009 at 05:10:46PM -0700, Stephen Neuendorffer wrote:
> 
> Another possibility is to pad the DTB with a DESYNC command and the
> correct pad frame, just in case it cannot be prevented.

Um.. one thing I'm missing in this discussion of attaching the dtb to
the bitstream:  I don't see how the bitstream becomes accessible to
the kernel at runtime.  Unless you were exposing the dtb as part of
the fpga programming, but I thought you explicitly weren't doing that
because of limited bram space.

I imagine this is simply due to my ignorance about FPGA techniques,
but if someone could enlighten me...?

> > -----Original Message-----
> > From: Grant Likely [mailto:grant.likely@secretlab.ca]
> > Sent: Monday, May 11, 2009 10:30 PM
> > To: Stephen Neuendorffer
> > Cc: David H. Lynch Jr.; linuxppc-dev@ozlabs.org
> > Subject: Re: device trees.
> > 
> > On Mon, May 11, 2009 at 10:27 PM, Stephen Neuendorffer
> > <stephen.neuendorffer@xilinx.com> wrote:
> > >> > OK, so the key question seems to be *when* the bitstream is
> > > associated
> > >> > with the
> > >> > device tree.  If at bitstream generation time, you can prepend the
> > > .dtb
> > >> > to the bitstream.  As long as the dtb doesn't contain the magic
> > >> > bitstream start code, you can go back and access it later.
> > >> >
> > >> You really mean prepend ? I was presuming that things would work
> > > better
> > >> if it was appended ?
> > >
> > > Yes, actually prepend is simpler because you don't have to know the size
> > > of the bitstream.
> > > Everything before the SYNC code in the bitstream is ignored.
> > 
> > ...In this case, might need to preprocess the .dtb the escape out the
> > possibility of a sync code appearing.
> > 
> > g.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
