Message-ID: <3BD5B7D8.C060B6AF@mvista.com>
Date: Tue, 23 Oct 2001 14:32:56 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David =?iso-8859-1?Q?M=FCller?= (ELSOFT AG) <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Additional IRQ handlers in ppc4xx_init_IRQ()
References: <3BD517E5.5090204@elsoft.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"David Müller (ELSOFT AG)" wrote:

> I have a question regarding the registration of additional IRQ handlers
> for a PPC405GP based board.

Where are Matt's changes for the Tivo?  It would address this and give
us another example of how this should be structured.


> extended ppc4xx_init_IRQ as follows:

This is not an appealing solution.  We should change ppc4xx_pic_init()
to initialize the internal interrupt controller irq descriptor, and then
create a standard board initialization call for board specific changes.


> static void __init
> ppc4xx_init_IRQ(void)
> {
>         int i;
>
>         ppc4xx_pic_init();
>
+	  ppc4xx_pic_board_init();
>         return;
> }
>

The '...board_init()' function can be empty for those boards that don't
require any additional controller initialization.


>         for (i = 0; i < NR_IRQS; i++)
>                 irq_desc[i].handler = ppc4xx_pic;

The NR_IRQS should represent the total number of interrupts across all
controllers.  The pic_init() should change this loop to initialize either
NR_AIC or NR_UIC depending upon a 403 or 405 interrupt controller.  No
#ifdefs necessary.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
