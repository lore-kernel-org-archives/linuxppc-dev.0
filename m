Date: Fri, 22 Jun 2001 14:18:08 +0200 (MEST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Takashi Oe <toe@unlserve.unl.edu>
Subject: Re: clock drift on PPC601
In-Reply-To: <20010621135433.22817@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.21.0106221405580.10296-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 21 Jun 2001, Benjamin Herrenschmidt wrote:

> >
> >OTOH, I have a problem with my MVME2400/2600. Sometimes the calibrated
> >frequency is wrong by ~400ppm (about 1.5s/hour), most of the time it's
> >correct however. I can't understand how I get 400 microseconds off out of
> >a 1 second calibration period with interrupts masked. The value given by
> >the firmware never varies that much.
> >
> >I suspect that reading the CUDA RTC takes time. So using it for
> >calibration would not be very precise, no ?
>
> That's definitely an issue. We used to have some code based on the
> VIAs in the mac-io chip. This should be more precise and I beleive
> the VIA timer frequency is constant on all macs.

It is still this way on the Macs, although we cold use a longer interval
to improve precision (it's done once at boot) or take the firmware value.
On the MVME boards I have however, the precision/stability of the legacy
ISA timer looks like a joke, and only solution is to use the RTC. I'm
still trying to figure out if the variations I see are a bug or if the RTC
has hmm... a flexible definition of the second :-)

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
