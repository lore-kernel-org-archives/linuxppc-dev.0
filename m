Date: Fri, 28 Sep 2001 08:15:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "KOBAYASHI R. Taizo" <tkoba@ike-dyn.ritsumei.ac.jp>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem serial.c on module
Message-ID: <20010928081508.S23005@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010928.143301.74755222.tkoba@ike-dyn.ritsumei.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010928.143301.74755222.tkoba@ike-dyn.ritsumei.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 28, 2001 at 02:33:01PM +0900, KOBAYASHI R. Taizo wrote:

> I examined this problem and had a question.
> Dose it need following branch?
> ================L5375==
> #ifdef CONFIG_ALL_PPC
>         /* early PowerMacs would machine check */
>         if (_machine == _MACH_Pmac) {
>                 printk(KERN_INFO "serial.c: nothing to do on PowerMacs.\n");
>                 return 0;
>         }
> #endif
> =======================

Some older machines apparently do.  The current 'workaround' in 2_4 is
#if defined(CONFIG_ALL_PPC) && !defined(MODULE).

> Anyway, pcmcia modem card on my TiBook seems work fine with following patch.
> --- linux/drivers/char/serial.c.orig	Fri Sep 28 13:57:02 2001
> +++ linux/drivers/char/serial.c	Fri Sep 28 13:46:41 2001
> @@ -4015,7 +4015,10 @@
>   * seems to be mainly needed on card using the PLX which also use I/O
>   * mapped memory.
>   */
> -static int __devinit
> +static int
> +#ifndef MODULE
> +__devinit
> +#endif
>  pci_plx9050_fn(struct pci_dev *dev, struct pci_board *board, int enable)
>  {
>  	u8 data, *p, irq_config;

Are these actually needed?  They really shouldn't be...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
