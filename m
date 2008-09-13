Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809131554mb0c6660r3bcc993bb2ca082d@mail.gmail.com>
Date: Sat, 13 Sep 2008 18:54:58 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Roland Dreier" <rdreier@cisco.com>
Subject: Re: demuxing irqs
In-Reply-To: <adaprn7is80.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809131206j125e7e25of07c19028ac07339@mail.gmail.com>
	<adaprn7is80.fsf@cisco.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 13, 2008 at 6:41 PM, Roland Dreier <rdreier@cisco.com> wrote:
>  > Can someone point me at a simple example of how to demux irqs using
>  > the powerpc irq functions? I have eight devices on a single irq and I
>  > want to turn them into virtual irqs.
>
> Sorry about the previous reply.
>
> Anyway, what are you going to demux based on?  Do you have some other
> signal you can read in the interrupt dispatch code that tells you which
> device raised the interrupt?  What happens if two devices raise an
> interrupt at the same time?
>
> If you just have 8 interrupt lines wire-ORed together then you probably
> just need to register your interrupt handlers with IRQF_SHARED and run 8
> interrupt handlers on an interrupt.

The muxed interrupts are inside a SOC CPU.  For example eight GPIOs
can each individually be enabled to trigger hardware interrupt 7. When
I get hw interrupt 7 i want to demux it into 8 virtual interrupts.
There are eight bit registers for individually acking, enabling, etc
each of the eight multiplexed interrupts. With eight virutal
interrupts each user can register a different handler and isn't aware
the muxing is going on.

-- 
Jon Smirl
jonsmirl@gmail.com
