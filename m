Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9E221A0274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 20:05:25 +1000 (AEST)
Message-ID: <1442484325.26748.7.camel@ellerman.id.au>
Subject: Re: Time to remove platforms/cell?
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Geoff Levand <geoff@infradead.org>
Date: Thu, 17 Sep 2015 20:05:25 +1000
In-Reply-To: <7144823.dIR0EDXkmx@wuerfel>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <2023345.Irprl084gX@fb07-iapwap2> <7144823.dIR0EDXkmx@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-17 at 11:31 +0200, Arnd Bergmann wrote:
> On Thursday 17 September 2015 10:43:39 Marc Dietrich wrote:
> > Am Donnerstag, 17. September 2015, 15:28:47 schrieb Michael Ellerman:
> > > Discuss ...
> > 
> > as long as Geoff still maintains the ps3 port - why?
> > 
> We already removed celleb a while ago, which was arguably the least
> commonly used one.

Hi Arnd,

Thanks for the input, I probably should have CC'ed you, sorry!

> Within platforms/cell, we have three separate portions that we need
> to look at:
> 
> a) Common ps3/ibm parts: spufs, oprofile
>    We should not remove them before we plan to also remove platforms/ps3
>    support, which doesn't seem likely in the near term. We can move them
>    to platforms/ps3 if we decide to remove the rest.

Right. I wouldn't bet money that the oprofile code still works, but spufs
definitely would have to stay.

> b) Support for IBM blades:
>    It is unlikely that there are QS20 blades still around and being used
>    at all, but there is very little code specific to them.

Wasn't spider QS20 only? So that would be a bit of code that could go,
including (some of) the io-workarounds code (I think).

>    For QS21/QS22, there are probably still a few in existence, but
>    I have no idea whether anybody would consider running a 4.x kernel
>    on them. There are also some customer-specific Cell machines that
>    are vaguely related to QS22 and that are in a similar state.
>    I don't mind removing the code, but if anybody is still using it
>    on new kernels, we should be prepared to put it back.

Yeah, that's my impression. We obviously still have a QS22, but really we're
only keeping it alive for testing purposes.

Hopefully this email will bring some more folks out of the woodwork.

> c) QPACE. We know who the three users were, and they have upgraded to
>    QPACE2 (based on Intel Xeon Phi) this year. Removing this would be
>    appreciated as it lets us clean up one of the ugly corners of the
>    8250 uart driver.

Ah excellent info.

I had done some googling on QPACE and from the web site there is no suggestion
that it's been shutdown, but I guess that's the nature of web pages, they tend
not to get updated:

  http://www.fz-juelich.de/ias/jsc/EN/Expertise/Supercomputers/QPACE/QPACE_node.html


So we can probably remove the QPACE code sooner rather than later, unless
someone yells.

cheers
