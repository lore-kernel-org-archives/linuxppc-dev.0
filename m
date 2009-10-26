Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id BEBA2B7BE0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 06:16:07 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Michael Buesch <mb@bu3sch.de>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Date: Mon, 26 Oct 2009 13:16:00 -0600
Subject: RE: Network Stack SKB Reallocation
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330BEB3FB@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330BEB38D@midas.usurf.usu.edu>
	<200910262013.52458.mb@bu3sch.de>
In-Reply-To: <200910262013.52458.mb@bu3sch.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So, in my case, I allocate a bunch of skb's that I want to be able to reuse=
 during network operation (256 in fact).  When I pass it up the stack, the =
stack will free that skb back to the system making any further use of it in=
valid until I call alloc_skb() again?

Thanks.

> On Monday 26 October 2009 19:43:00 Jonathan Haws wrote:
> > Quick question about the network stack in general:
> >
> > Does the stack itself release an SKB allocated by the device
> driver back to the heap upstream, or does it require that the device
> driver handle that?
>=20
> There's the concept of passing responsibilities for the frames
> between
> the networking layers. So the driver passes the frame and all
> responsibilities
> to the networking stack. So if the networking stack accepts the
> packet in the first place,
> it needs to free it (or pass it to somebody else to take care of).
>=20
> --
> Greetings, Michael.
