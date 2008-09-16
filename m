Return-Path: <avorontsov@ru.mvista.com>
Date: Tue, 16 Sep 2008 16:17:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: demuxing irqs
Message-ID: <20080916121740.GA9970@oksana.dev.rtsoft.ru>
References: <9e4733910809131206j125e7e25of07c19028ac07339@mail.gmail.com>
	<adaprn7is80.fsf@cisco.com>
	<9e4733910809131554mb0c6660r3bcc993bb2ca082d@mail.gmail.com>
	<adaljxvir57.fsf@cisco.com>
	<9e4733910809131623pe990495l96b31bd546d9fa6b@mail.gmail.com>
	<9e4733910809140706i599d70b2q12d3582c7a95498c@mail.gmail.com>
	<9e4733910809141625u3cd94e7jf05584031be7c1d9@mail.gmail.com>
	<9e4733910809142006x350e96abs6af304d8807ccd67@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <9e4733910809142006x350e96abs6af304d8807ccd67@mail.gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Roland Dreier <rdreier@cisco.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

On Sun, Sep 14, 2008 at 11:06:23PM -0400, Jon Smirl wrote:
> I have demultiplexing the GPIO interrupts working well enough to make
> my hardware work. But now I've discovered that these interrupts can't
> do what I need.
> 
> Anton, Grant - are either of you interested in this code? It's not
> finished but the main ideas are in place.

I think there is a small issue that ruins the whole approach.. :-/

> --- a/arch/powerpc/include/asm/gpio.h
> +++ b/arch/powerpc/include/asm/gpio.h
> @@ -38,17 +38,14 @@ static inline int gpio_cansleep(unsigned int gpio)
>         return __gpio_cansleep(gpio);
> }
> 
> -/*
> - * Not implemented, yet.
> - */
> -static inline int gpio_to_irq(unsigned int gpio)
> +static inline unsigned int gpio_to_irq(unsigned int gpio)
>  {
> -       return -ENOSYS;
> +       return gpio;

"GPIO 0" is valid gpio, but "IRQ 0" isn't valid virq. So you
can't do 1:1 mapping. :-(

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
