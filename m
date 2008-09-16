Return-Path: <scottwood@freescale.com>
Date: Tue, 16 Sep 2008 18:24:29 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: demuxing irqs
Message-ID: <20080916232429.GB15002@ld0162-tx32.am.freescale.net>
References: <20080916121740.GA9970@oksana.dev.rtsoft.ru>
	<9e4733910809160537s67812bf5x3d4d46a384f8237f@mail.gmail.com>
	<20080916131203.GA21641@oksana.dev.rtsoft.ru>
	<9e4733910809160636heaa545eld0da835b2d163811@mail.gmail.com>
	<20080916141422.GA29888@oksana.dev.rtsoft.ru>
	<9e4733910809160724x693c5af9y8df2f609e79f5005@mail.gmail.com>
	<20080916174935.GA13142@ld0162-tx32.am.freescale.net>
	<9e4733910809161132j3b0ff194hd60fcdf489fb19e4@mail.gmail.com>
	<20080916214210.GA15987@oksana.dev.rtsoft.ru>
	<9e4733910809161508m3a94baf1g818be7247439848e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910809161508m3a94baf1g818be7247439848e@mail.gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Roland Dreier <rdreier@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 16, 2008 at 06:08:34PM -0400, Jon Smirl wrote:
> You have to map between GPIO and IRQ inside the interrupt handlers so
> it has to be reasonably fast. This gets done on every shared interrupt
> so you will end up building mapping tables. Also, gpio_to_irq()
> doesn't take the gpio chip struct as a parameter.

Well, that sucks.  We should be removing magic global numberspaces, not
adding them.

> Why does this mess with all of ther GPIO controllers? If they generate
> interrupts they obviously have to coordinate with the VIRQ system.

And if they don't generate interrupts, and they decide they can also
just park themselves at MAX_IRQ?

-Scott
