Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id F37DCDDDCA
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 22:07:08 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Mike Ditto <mditto@consentry.com>
Subject: Re: Erratic MPC8248 CPM2 I2C behaviour
Date: Tue, 2 Dec 2008 12:07:05 +0100
References: <mailman.569.1227903153.29923.linuxppc-dev@ozlabs.org>
	<49347317.5080600@consentry.com>
In-Reply-To: <49347317.5080600@consentry.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812021207.06140.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Mike,

On Tuesday 02 December 2008 00:28:23 Mike Ditto wrote:
> Laurent Pinchart <laurentp@cse-semaphore.com> wrote:
> > Transmission timeout after one second. The first TX buffer descriptor
> > status hasn't been modified by the CPM. The CPM state dump shows that
> > processing of
>
> ...
>
> This sounds very similar to a problem I have seen on MPC8247 and
> MPC8248.
>
> It could be a variation of the CPM bug documented by Freescale as
> erratum CPM98. But the key difference is that we see a persistent
> failure, while the erratum only mentions a problem with "the next
> transaction".  What we see is that once the I2C engine gets confused
> by some anomaly on the SCL signal, it stops processing buffer
> descriptors entirely until it is turned off and back on.  You can
> observe this bug by momentarily grounding the SCL line (it's an
> open-collector bus) with a jumper while you attempt an I/O.

The I2C controller seems to be split into two parts, a firmware CPM code that 
processes buffers and a hardware shift register to handle the actual I2C 
transfers. My guess is that the hardware seems to get confused for some reason 
and times out. The CPM parameter RAM shows that the CPM started processing the 
tx buffer and stopped, probably waiting for the hardware to transfer the first 
byte.

> Our production equipment is using Linux 2.6 with the out-of-tree
> i2c-algo-8260.c by Dan Malek and Brad Parker.  I modified this
> driver to shut off the I2C controller and turn it back on when it
> hits this problem, and now it can recover from this condition.

I'm running Linux 2.6.27 with the in-tree i2c-cpm.c driver.

> However, this does not explain how the controller gets into the
> frozen state in the first place.  We see it very rarely in production
> units and have not been able to identify the cause.  If it is
> similar to erratum CPM98 then it could be noise on the SCL signal or
> perhaps an I2C device that doesn't conform to the protocol perfectly.

I don't believe noise is the cause here. I've been able to reproduce the 
problem tens of times in a row last Friday in a clean environment.

What bothers me though is that earlier experiments with an oscilloscope showed 
the problem would disappear when the scope probes were connected to the SCL 
and SDA signals. This made the problem more complex to debug, and it could 
have been a coincidence.

> Also beware, if you are using some kind of multiplexer, that you don't
> direct the multiplexer to switch to a different bus (segment) while a
> transaction is in progress.

There's no multiplexer, but thanks for the hint.

> In testing with the current (2.6.27) i2c-cpm.c driver, I found that
> it is sufficient to #define I2C_CHIP_ERRATA to allow it to recover
> from the CPM I2C freeze.  However, I don't know if I like this
> approach because it turns off the I2C engine after every transfer,
> even successful ones, and I don't know if this will affect reliability
> or performance.  And I don't know if this will actually prevent the
> freeze from happening,

It won't prevent the problem from happening, as I've been able to reproduce 
the issue on the very first I2C transfer.

> although I presume that it would protect the
> I2C engine from getting confused by a glitch that happens while no
> transfer is in progress.

Good point. I haven't thought about the controller becoming confused by SCL 
glitches outside of I2C transfers.

> I am not aware of any documentation for what exactly the I2C_CHIP_ERRATA
> conditional code in i2c-cpm.c is meant to work around.  The comment
> mentions "earlier than rev D4" but I'm not aware of any such rev for
> 8260 or 8272 chip families, and if it is related to erratum CPM98,
> Freescale seems to say that this erratum is in all revs of these chips
> and has no plan to fix it, so it seems that the workaround should be
> enabled by default.

While the problem seems to be similar to CPM98, I don't understand how it 
could happen on the first character of the first I2C transfer.

As explained in my previous mail to Joakim, I spent some more time last Friday 
investigating the problem, and it seems the baud rate generator configuration 
plays an important role. The default configuration (60kHz nominal => 65.104kHz 
using a 25MHz brg clock and a /32 predivider) leads to timeouts, while I 
haven't been able to reproduce the problem with the i2c-mpc8260.c 
configuration (100kHz nominal => 104.167kHz using a 25MHz brg clock and a /8 
predivider).

This might be a coincidence, and I can't verify any of the results right now 
as my system decide to work correctly even at 60kHz :-/ I hope I won't have to 
through clock jitter and system temperature into the mix, otherwise this is 
going to be very complex to debug.

Best regards,

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
