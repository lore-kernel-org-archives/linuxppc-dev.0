Date: Tue, 21 May 2002 09:08:19 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
Cc: andrew may <acmay@acmay.homeip.net>,
	linuxppc-embedded@lists.linuxppc.org,
	Armin Kuster <akuster@mvista.com>
Subject: Re: [PATCH] ibm ocp gpio
Message-ID: <20020521090819.G9190@ecam.san.rr.com>
References: <20020520182657.B17318@ecam.san.rr.com> <3CEA0F45.BDBBA25@etx.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CEA0F45.BDBBA25@etx.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 21, 2002 at 11:11:33AM +0200, Kenneth Johansson wrote:
> andrew may wrote:
> >
> > The most common thing I want to use the GPIO pins for is
> > simple lighting of some LED's. I decided to roll in some timers
> > into the generic GPIO driver rather than haveing each user of the
> > GPIO driver be forced to do some form of timers to get a usable
> > LED visual as well.
> >
> > I think I got the timer stuff correct but I am not sure.
> > I didn't bother cleaning it up until I get some feedback on it.
>
> I don't think we should add this It's not really something that needs to be
> done in the driver. Also you have not exported this functionality to
> userspace.

Well no it doesn't need to be in the driver, but you then are forced with
having every other driver doing there own timer to turn off the bit rather
than having one timer take care of them all. And do you really want to
have you UserSpace app wake up and do an ioctl just to turn off an LED
a quarter second after you turn it on?

As I said I didn't clean it up. That would include not having it exported
as an ioctl or having the symbol export to modules. Or making it a config
option to compile it out if you are worried about the size of the code.
Or removing the extra printk's.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
