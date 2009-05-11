Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B46EDDF8C
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 10:54:16 +1000 (EST)
Date: Tue, 12 May 2009 09:27:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: device trees.
Message-ID: <20090511232751.GB15371@yookeroo.seuss>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<ed82fe3e0905110758l59ee1c94nffbfa50280851613@mail.gmail.com>
	<4A085862.5070303@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A085862.5070303@dlasys.net>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 11, 2009 at 12:54:58PM -0400, David H. Lynch Jr. wrote:
> Timur Tabi wrote:
> > On Mon, May 11, 2009 at 1:32 AM, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
> >
> > So all you need to do is have your boot loader create a device tree
> > from scratch.  If you're using U-Boot, then you can already do this by
> > making the appropriate libfdt calls.  Otherwise, you should probably
> > add libfdt to your boot loader.
> >   
>     As I mentioned before, we do nto use u-boot. I am not looking to
> start a debate on it either, but it does not meet a number of our needs,
>     and would require significant architectural changes to do so. The
> difference between it and devicetrees is that u-boot is avaiable to us
> if we want, I did port u-boot to our hardware at one point and it did
> everything it promised, but u-boot is optional, device trees are not.
>     I do not have to re-architect u-boot to fit into 16k of bram, or
> load bit files or .....
>      If I want to move past 2.6.26 I have to not only use device trees
> but actually make them work in a way that will function as we need with
> our systems.
>     It is likely I will use libdft as a starting point, but I can not
> see it as more than a short term solution. libdft is orders of magnitude
> large than our entire monitor, and it is a toolkit rather than the whole
> solution.

I'm very willing to make changes to libfdt, if it helps make it more
useful to you without breaking it for other people.  I'm a little
horrified at the size of libfdt, and a bit baffled as to why it's
ending up that large.  From some initial poking around, it looks like
-fPIC inflates the code size a *lot* (~3x on x86, which I know is not
what we're dealing with here, but was the easiest for a quick test).
So if you don't need that in your context, that could save a heap.
The separation into separate .o files is also deliberate, so that
portions you don't use can be omitted.  I have considered breaking it
up into many more .c files, so that you can omit individual not-needed
functions.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
