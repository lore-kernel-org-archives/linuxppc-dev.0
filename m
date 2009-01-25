Return-Path: <jonsmirl@gmail.com>
MIME-Version: 1.0
In-Reply-To: <fa686aa40901242224i3f4c8d3fkae964126aa69282e@mail.gmail.com>
References: <9e4733910901241720j157b7946t58792a9b2b21f1a3@mail.gmail.com>
	<fa686aa40901242224i3f4c8d3fkae964126aa69282e@mail.gmail.com>
Date: Sun, 25 Jan 2009 10:44:38 -0500
Message-ID: <9e4733910901250744l40587f00j4f74bb2606313ab@mail.gmail.com>
Subject: Re: mpc5200 and PWM
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 25, 2009 at 1:24 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Sat, Jan 24, 2009 at 6:20 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> Is it possible to use Bestcomm with PWM to generate complex waveforms?
>> For example change the frequency and duty cycle after each cycle? Has
>> anyone tried doing this? I'd like to build a table of count/width
>> pairs and then feed them to the PWM pin without taking an interrupt on
>> each cycle.
>
> I assume you're looking at using one of the GPT PWMs devices, correct?

Yes, so this is as hard as I thought it would be. I think I'll stick
with Plan A and use a PSC to make the wave form.

We're trying to figure out a cheap way to add X10/Insteon support. You
can buy PIC chips to do it but they cost $10 with the software
license. The external transmit receive circuitry costs about $2 to
build. I have the output from it hooked up to a PSC. The signals are
131.65Khz BPSK. I need to get the mpc5200 to make and decode those
signals.

We want to use X10/Insteon in combination with a keypad to do volume
and channel selection. But it works the other way around too. The same
circuit can turn the lights off/on.

I'd love to get a GPL driver in the kernel for X10/Insteon that just
needs the $2 of external circuitry. I'll write one if I can figure out
how to do the low level signal processing (my background in it is
zero) to get at the packets. I'm not having much luck decoding the
BPSK since it has a lot of noise and frequency variance in it.

>  If so, the you probably cannot do what you want easily.  While you
> may be able to writing a custom bestcomm task to write into the PWM
> registers, the bestcomm engine isn't wired up to the PWM and so cannot
> be triggered on PWM events.
>
> However, the gpio blocks are wired up to the Bestcomm engine so they
> can be used as requestors, so if you wired up the PWM output to one of
> the GPIO inputs, then you may be able to do something with that.
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- 
Jon Smirl
jonsmirl@gmail.com
