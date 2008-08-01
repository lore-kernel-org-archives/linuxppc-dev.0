Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 0C836DE04F
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 14:37:26 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so445130ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 21:37:25 -0700 (PDT)
Message-ID: <9e4733910807312137w2dc9e73l39d4d99bd0cfe0c6@mail.gmail.com>
Date: Fri, 1 Aug 2008 00:37:25 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	devicetree-discuss@ozlabs.org,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Board level compatibility matching
In-Reply-To: <20080801042505.GK5008@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<9e4733910807311349l5770a17ib2ab2535bcd2868a@mail.gmail.com>
	<20080731205251.GB29834@secretlab.ca>
	<9e4733910807311358k54b5c088l1023d354fd0ad28e@mail.gmail.com>
	<20080801024729.GA5008@yookeroo.seuss>
	<9e4733910807312006l8e83d27qe1b5ca5f50b89e39@mail.gmail.com>
	<20080801033009.GG5008@yookeroo.seuss>
	<9e4733910807312100j6a8d1974k34054c2d69f417f4@mail.gmail.com>
	<20080801042505.GK5008@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/1/08, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Fri, Aug 01, 2008 at 12:00:01AM -0400, Jon Smirl wrote:
>  > On 7/31/08, David Gibson <david@gibson.dropbear.id.au> wrote:
>  > > On Thu, Jul 31, 2008 at 11:06:20PM -0400, Jon Smirl wrote:
>  > >  > On 7/31/08, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> [snip]
>
> > >  > That is what I'm doing now. But it requires every board to add a file
>  > >  > to arch/powerpc/platforms.  Can we have some common code to make the
>  > >  > fabric device? Can it be an OF device instead of a platform one? An OF
>  > >  > device could be compatible with boardname-fabric, generic-fabric. That
>  > >  > allows a stub fabric driver to always bind.
>  > >
>  > >
>  > > There are several ways to do this, and which is the most sensible
>  > >  depends on the specific design, and whether / how many boards the
>  > >  design is shared amongst.
>  > >
>  > >  In some cases it's suitable to have a "fake" device node for the sound
>  > >  wiring, to which a fabric driver can bind.  I think I've argued
>  > >  against this approach in the past, but I've since been convinced that
>  > >  it is a reasonable approach for some situations.  There's precedent,
>  > >  too, a number of Apple device trees do this.
>  > >
>  > >  In other cases it may be possible to deduce the correct fabric driver
>  > >  from the interconnections of individual sound components.
>  > >
>  > >  In yet others, we need board-specific platform code to instantiate the
>  > >  fabric driver.  In some cases that's simply the most straightforward
>  > >  way to do things.  In others it's not ideal, but we can use it as a
>  > >  fallback technique because deployed device trees simply don't have
>  > >  sufficient information in other places to use another approach.
>  > >
>  > >  There doesn't have to be One True Method for doing this.
>  >
>  > We're running into a need for the true method. With ALSA you need to
>  > have the codec driver, i2s/ac97 driver and the fabric driver all load
>  > and say here I am before ALSA can finish binding. ALSA won't complete
>  > initializing on boards without all three.
>  >
>  > So what do you do on board that doesn't need a fabric driver? That's
>  > why you want the fake device with the compatible string =
>  > board-fabric, noop-fabric. Now you know for sure one of those two
>  > drivers will bind.
>
>
> No... that would be exactly my example of a case where instantiating
>  the fabric driver from the platform code isn't ideal, but is a usable
>  fallback option.
>
>
>  > Why does the fake fabric device need to be in the device tree? Can't
>  > we just dynamically create it as part of the boot process?
>
>
> Um.. yes.. that would be exactly what instantiating it from the
>  platform code does.

Platform devices are missing the compatible chain process. If we do
this with platform drivers the boot code creates a 'fabric' device
then I'll have to ensure that my board-fabric driver gets probed
before default-fabric because they both want to bind to the fabric
device.

I can do this, but building ordering dependencies like this is not the
most robust way to do things. With an OF device the ordering is
obvious via the compatible attribute.


>
>
>  --
>  David Gibson                    | I'll have my music baroque, and my code
>  david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _other_
>                                 | _way_ _around_!
>  http://www.ozlabs.org/~dgibson
>


-- 
Jon Smirl
jonsmirl@gmail.com
