Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809131623pe990495l96b31bd546d9fa6b@mail.gmail.com>
Date: Sat, 13 Sep 2008 19:23:45 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Roland Dreier" <rdreier@cisco.com>
Subject: Re: demuxing irqs
In-Reply-To: <adaljxvir57.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809131206j125e7e25of07c19028ac07339@mail.gmail.com>
	<adaprn7is80.fsf@cisco.com>
	<9e4733910809131554mb0c6660r3bcc993bb2ca082d@mail.gmail.com>
	<adaljxvir57.fsf@cisco.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 13, 2008 at 7:04 PM, Roland Dreier <rdreier@cisco.com> wrote:
>  > The muxed interrupts are inside a SOC CPU.  For example eight GPIOs
>  > can each individually be enabled to trigger hardware interrupt 7. When
>  > I get hw interrupt 7 i want to demux it into 8 virtual interrupts.
>  > There are eight bit registers for individually acking, enabling, etc
>  > each of the eight multiplexed interrupts. With eight virutal
>  > interrupts each user can register a different handler and isn't aware
>  > the muxing is going on.
>
> I see... well, assuming all the issues around handling multiple
> simultaneous (or overlapping) interrupts are OK, you could look at how
> arch/powerpc/sysdev/uic.c handles the cascaded interrupt controllers for
> 4xx SoCs.  The idea of that code is that you get an interrupt, and look
> look at interrupt cause register 0, and see interrupt X, and to handle
> interrupt X you read interrupt cause register 1 to see which the real
> interrupt is.  And you might see interrupt Y, which means to go onto
> interrupt cause register 2.

I'm getting bogged down in the details. For example after doing
irq_alloc_host() some drivers follow it with
set_irq_chained_handler(). It the uic case it doesn't.

I'm not getting my main hardware int acknowleged, my handler gets
called repeatedly. This is probably from using a chained_handler.

Do I need a match function in irq_host_ops?

I have a 'struct irq_chip' with the mask/unmask/ack/etc functions.

I also need to know what the first virq number is out of the eight I
asked for in irq_alloc_host().


>
>  - R.
>



-- 
Jon Smirl
jonsmirl@gmail.com
