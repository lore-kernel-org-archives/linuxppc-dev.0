Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809161647l4af51794m7644ce3f63b87697@mail.gmail.com>
Date: Tue, 16 Sep 2008 19:47:31 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: demuxing irqs
In-Reply-To: <20080916232429.GB15002@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080916121740.GA9970@oksana.dev.rtsoft.ru>
	<20080916131203.GA21641@oksana.dev.rtsoft.ru>
	<9e4733910809160636heaa545eld0da835b2d163811@mail.gmail.com>
	<20080916141422.GA29888@oksana.dev.rtsoft.ru>
	<9e4733910809160724x693c5af9y8df2f609e79f5005@mail.gmail.com>
	<20080916174935.GA13142@ld0162-tx32.am.freescale.net>
	<9e4733910809161132j3b0ff194hd60fcdf489fb19e4@mail.gmail.com>
	<20080916214210.GA15987@oksana.dev.rtsoft.ru>
	<9e4733910809161508m3a94baf1g818be7247439848e@mail.gmail.com>
	<20080916232429.GB15002@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Roland Dreier <rdreier@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 16, 2008 at 7:24 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, Sep 16, 2008 at 06:08:34PM -0400, Jon Smirl wrote:
>> You have to map between GPIO and IRQ inside the interrupt handlers so
>> it has to be reasonably fast. This gets done on every shared interrupt
>> so you will end up building mapping tables. Also, gpio_to_irq()
>> doesn't take the gpio chip struct as a parameter.
>
> Well, that sucks.  We should be removing magic global numberspaces, not
> adding them.
>
>> Why does this mess with all of ther GPIO controllers? If they generate
>> interrupts they obviously have to coordinate with the VIRQ system.
>
> And if they don't generate interrupts, and they decide they can also
> just park themselves at MAX_IRQ?

More coordination has to be going on here, as far as I can tell
gpiolib has a built in assumption that all gpios in a system are
uniquely numbered.  I guess that since most systems can't dynamically
add GPIO the problem hasn't been addressed.

It could be fixed by creating a function for obtaining the max gpio id
in use and then using it as a base for any that are added later. The
core complain here is: what happens if you assign non-interrupting
GPIOs to 1-8 which are also hardware IRQs and then use irq functions
on these non-interrupting GPIO ids. My answer to that is don't assign
GPIO ids that are legal hardware interrupts. The function for
determing max GPIO ID in use may even exist in the ARM code, I haven't
gone looking for it.

In the mpc5200 most (maybe all?)  GPIOs are capable of being an
interrupt source so a 1:1 mapping with VIRQs is the natural solution.

mpc5200_pic.h reserves 208 spots for hardware interrupts. I don't know
why, there aren't that many possible. There are 56 GPIO pins, so you
end up with 264 virqs total. PowerPC defaults to 512 virqs available.



-- 
Jon Smirl
jonsmirl@gmail.com
