Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound8-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 83F74DE22C
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 05:10:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Xilinx: framebuffer: add compatibility for ml507 dvi core.
Date: Mon, 12 May 2008 12:10:24 -0700
In-reply-to: <fa686aa40805121130n53b14a8fye692e06616dc3bc7@mail.gmail.com>
References: <20080505175918.2AD03A58056@mail164-sin.bigfish.com>
	<fa686aa40805120724u17a380adnd0826044ae3ac369@mail.gmail.com>
	<20080512173130.0D747181804D@mail89-sin.bigfish.com>
	<fa686aa40805121130n53b14a8fye692e06616dc3bc7@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080512191025.67682630064@mail160-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The best possibility that I see is glopping the compatibility
information about what cores are compatible with which drivers and
generating something.  This is moderately better than blindly treating
all cores with the same major version as interface compatible, but still
has the potential to blindly declare that core versions are compatible
when they are not really compatible.

I *really* don't want to put this into the device tree generator on a
case-by-case basis, so unless there is something that can be generated
from whatever meta-information EDK has, I think we're going to have to
just have the explicit versions in the drivers for the time being.

Steve=20

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
> Sent: Monday, May 12, 2008 11:30 AM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Xilinx: framebuffer: add compatibility for ml507
dvi core.
>=20
> On Mon, May 12, 2008 at 11:31 AM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> >
> >  Not easily.  As we discussed before, there is nowhere that really
> >  specifies this information.  In some cases I've modified the device
tree
> >  generator to understand what is backward compatible, as with
ns16550,
> >  but for other cores it makes more sense to me to put this
compatibility
> >  information with the driver if it has to be anywhere.
>=20
> The main concern is that the driver will balloon with data which
> impacts the load size for all builds that compile it in.  It also
> reduces the impact of minor modifications of the IP cores (ie. the
> kernel still works when I've up-revved an ip core from 1.00a to
> 1.00b.)
>=20
> I understand that it is hard within the EDK TCL scripts context, but
> this is exactly what compatible is designed for and I don't think
> continually adding more versions to the list is sustainable in the
> long term.  The more I think about it, the more I'm uneasy about this
> approach.
>=20
> For the time being, I'm going to resist merging this change into my
> tree, but I'll keep it in my "don't forget about this" list.  It's not
> going into .26 anyway, so there is no time pressure.  Later, when
> we're closer to the .27 merge window, I'll look at it again, but I
> really would prefer to find a way to add to the compatible list.
>=20
> Cheers,
> g.
>=20
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
