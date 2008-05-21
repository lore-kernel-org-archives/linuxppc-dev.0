Return-Path: <glikely@secretlab.ca>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.189])
	by ozlabs.org (Postfix) with ESMTP id 7253CDE1C3
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 05:06:34 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so1850762tib.13
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 12:06:32 -0700 (PDT)
Message-ID: <fa686aa40805211206g5f23d3dax3e33c5aebe7aa4f1@mail.gmail.com>
Date: Wed, 21 May 2008 13:06:30 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI
	constructors
In-Reply-To: <Pine.LNX.4.64.0805211940060.5386@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154139.GB4566@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211754300.5386@axis700.grange>
	<20080521161039.GA9050@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211820460.5386@axis700.grange>
	<20080521164841.GA17813@polina.dev.rtsoft.ru>
	<fa686aa40805211005h58ea66dfl792eae460d4ea3d@mail.gmail.com>
	<Pine.LNX.4.64.0805211940060.5386@axis700.grange>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 11:51 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Wed, 21 May 2008, Grant Likely wrote:
>
>> I concede that sometimes platform code just has to pass data to the
>> driver that cannot be described in the device tree.  callback pointers
>> being the most significant example and we do need a sane way to do so.
>
> Sorry, I just cannot understand. So far my understanding was, that OF
> bindings were there to _completely_ describe hardware, that cannot be
> autoconfigured or probed.

Correct, they describe the hardware... to a level sufficient to
identify it usefully and uniquely to an operating system.

> So a _generic_ driver gets all information it
> needs from the device tree and needs no additional information to handle
> the hardware.

Also correct.

>
> Now if a driver needs additional information from "platform code" what's
> the purpose of partial data in the device tree at all? Just use board
> information as usual.

(Note; it must be said that I think the situation is *rare* and should
be avoided)

If some behaviour is entirely board specific and doesn't have any
possibility of being duplicated on other boards, then it makes sense
for the code implementing that behaviour to live with the platform
code.  For example; consider the example of the ads7846 device driver.
 It needs a pointer to a function that will tell it whether or not the
pen is down.  This is entirely a board specific kind of thing; it
might happen via a GPIO or a key press or a phase of the moon.  The
device doesn't care; but the driver needs a way to test the state.

The driver needs some method to obtain the pointer to the function.
It cannot be encoded in the device tree because it is a function
pointer, not raw 'data'.  The device tree may have some data that
tells the platform code how it is wired up; but the pointer itself
cannot be encoded into the device tree.  I see two obvious ways to do
this.  (note: platform code cannot simply export the function because
it might be a multiplatform kernel with multiple platforms defining
the same function).

1) Pass it in a data structure passed with the device structure
2) Make the device driver call out to a lookup function that returns
the function pointer.

Option 1) is basically some form of pdata scheme.  Option 2 requires
the driver to use some API to go looking for the relevant function.
I'm not convinced yet on which method is the best; but I cannot say
that platform code must never pass data to drivers that is not
directly encoded into the device tree.

Besides, we must always account for the situation where the provided
device tree has a bug or the hardware has a quirk and platform code
needs to do something to fix it up.  Or if you prefer: 99% of the time
everything is handled with common code reading the device tree
directly; but in the 1% of the time where that does not work (due to
bugs or quirks) we have options to insert workaround code.

>
> What good is an OF-binding if it doesn't provide complete information?

It still increases the amount of common code even if there are rare
corner cases that require board specific code.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
