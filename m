Subject: Re: [PATCH] ibm ocp gpio
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
To: andrew may <acmay@acmay.homeip.net>
Cc: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>,
	Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>,
	Armin Kuster <akuster@mvista.com>
In-Reply-To: <20020521112617.C20012@ecam.san.rr.com>
References: <20020520182657.B17318@ecam.san.rr.com>
	<3CEA0F45.BDBBA25@etx.ericsson.se> <20020521090819.G9190@ecam.san.rr.com>
	<1021998521.7266.46.camel@swb11>  <20020521112617.C20012@ecam.san.rr.com>
Content-Type: text/plain
Date: 22 May 2002 12:58:05 +0200
Message-Id: <1022065085.7265.92.camel@swb11>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2002-05-21 at 20:26, andrew may wrote:
>
> On Tue, May 21, 2002 at 06:28:41PM +0200, Kenneth Johansson wrote:
> > On Tue, 2002-05-21 at 18:08, andrew may wrote:
> >
> > > Well no it doesn't need to be in the driver, but you then are forced with
> > > having every other driver doing there own timer to turn off the bit rather
> > > than having one timer take care of them all. And do you really want to
> >
> > Well I don't think that would be a problem and if we are talking led's
> > its not going to happen more than a few time a second you have to see
> > the thing flash. I don't want more code in the kernel than absolutely
> > necessary all it takes is one bug.
> >
> > If you really want to make something that can't be done other than in
> > the driver it's some type of streaming mode and then you have to have
> > timers to control the speed. Think any card that needs to program sram
> > based FPGA it would probably go many times faster than todays interface.
>
> Look at the code and stop the hand-waving generalities.

relax I did not say your code was buggy it was more .. well general
hand-waving :)

> The other motto of the kernel is do it once right. If this code is not
> there every thing that just wants to turn on a LED for a half second needs
> to do their own timer. I have a couple drivers where I use some LED's on the
> GPIO pins and I don't want to do a timer in each one of them.

I do not see a problem with everyone doing the timers but it's not me
you have to convince I can't commit the code anyway.

It would be better if you made a more generic interface. perhaps
something that took commands in the form of.

struct gpio_command{
	int action;
	int value;
	int ns_wait;
	}

action would code in what register to use and if you want to set or
clear the bits specified in value.

Now you could do a mode that loop over an array of this type of
commands.

This would have the "side effect" of speeding up large transfers over
SPI bus or similar things and help you with flashing your led.


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
