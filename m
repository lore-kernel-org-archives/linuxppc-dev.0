Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809160636heaa545eld0da835b2d163811@mail.gmail.com>
Date: Tue, 16 Sep 2008 09:36:22 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: avorontsov@ru.mvista.com
Subject: Re: demuxing irqs
In-Reply-To: <20080916131203.GA21641@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809131206j125e7e25of07c19028ac07339@mail.gmail.com>
	<9e4733910809131554mb0c6660r3bcc993bb2ca082d@mail.gmail.com>
	<adaljxvir57.fsf@cisco.com>
	<9e4733910809131623pe990495l96b31bd546d9fa6b@mail.gmail.com>
	<9e4733910809140706i599d70b2q12d3582c7a95498c@mail.gmail.com>
	<9e4733910809141625u3cd94e7jf05584031be7c1d9@mail.gmail.com>
	<9e4733910809142006x350e96abs6af304d8807ccd67@mail.gmail.com>
	<20080916121740.GA9970@oksana.dev.rtsoft.ru>
	<9e4733910809160537s67812bf5x3d4d46a384f8237f@mail.gmail.com>
	<20080916131203.GA21641@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Roland Dreier <rdreier@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 16, 2008 at 9:12 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Tue, Sep 16, 2008 at 08:37:55AM -0400, Jon Smirl wrote:
>> On Tue, Sep 16, 2008 at 8:17 AM, Anton Vorontsov
>> <avorontsov@ru.mvista.com> wrote:
>> > Hi Jon,
>> >
>> > On Sun, Sep 14, 2008 at 11:06:23PM -0400, Jon Smirl wrote:
>> >> I have demultiplexing the GPIO interrupts working well enough to make
>> >> my hardware work. But now I've discovered that these interrupts can't
>> >> do what I need.
>> >>
>> >> Anton, Grant - are either of you interested in this code? It's not
>> >> finished but the main ideas are in place.
>> >
>> > I think there is a small issue that ruins the whole approach.. :-/
>> >
>> >> --- a/arch/powerpc/include/asm/gpio.h
>> >> +++ b/arch/powerpc/include/asm/gpio.h
>> >> @@ -38,17 +38,14 @@ static inline int gpio_cansleep(unsigned int gpio)
>> >>         return __gpio_cansleep(gpio);
>> >> }
>> >>
>> >> -/*
>> >> - * Not implemented, yet.
>> >> - */
>> >> -static inline int gpio_to_irq(unsigned int gpio)
>> >> +static inline unsigned int gpio_to_irq(unsigned int gpio)
>> >>  {
>> >> -       return -ENOSYS;
>> >> +       return gpio;
>> >
>> > "GPIO 0" is valid gpio, but "IRQ 0" isn't valid virq. So you
>> > can't do 1:1 mapping. :-(
>>
>> I changed the GPIO numbers inside of Linux to match the virqs.
>>
>>       ofchip->gc.base             = IRQ_GPIO_WKUP(0);
>
> Well, I didn't say that it will not work, what I'm trying to say
> is that I don't quite like the idea of 1:1 mapping for all gpio
> chips.
>
> It is error prone, i.e. gpio_to_irq() can't fail, so you can't
> tell if gpio to irq translation really happened or not. Plus
> we might decide to not do 1:1 mapping for other gpio chips.

>From reading the ARM code my understanding is that gpio_to_irq() and
irq_to_gpio() are meant to be fast paths without error checking.  In
the gpiolib doc it says these functions should only take a couple of
instructions.

You'll detect errors if you take an invalid IRQ from the function and
feed it into any of the rest of the IRQ API.
The idea for setting the GPIO number equal to the VIRQ number came out
of the ARM code. Making GPIO==VIRQ greatly simplified the code.


>
> I think that this translation should go via gpiolib's callback
> (there is no .to_irq callback, but we should implement one).
>
> In the callback you can still do 1:1 mapping, but this mapping
> will work only for this particular gpio chip, and not for others.
>
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>



-- 
Jon Smirl
jonsmirl@gmail.com
