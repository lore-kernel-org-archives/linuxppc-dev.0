Message-ID: <3A2550AF.F6585169@mvista.com>
Date: Wed, 29 Nov 2000 10:53:35 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Nguyen Xuan Hoang <jerry.nguyen@serialsystem.com.sg>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA Card Service
References: <DKEFKEENEHPHKNLLKHCGGEEICDAA.support@mvista.com> <005201c059b0$2cdef7e0$ef0fa8c0@hoangmobile> <3A23F07A.FF2F643@mvista.com> <004f01c05a58$a60a7920$ef0fa8c0@hoangmobile>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


you need to install the kernel patches on the ftp site as well. the
patch with ide and kernel in the name take care of that problem.

Nguyen Xuan Hoang wrote:
>
> Hi Matthew,
>
> Thank very much for your info. I have look at your patch but it seems not
> solving our problem. I would like explain more:
>
> -  From my investigation is: there's one confliction of the interrupt:
>
> 1. The PCMCIA card service (m8xx_pcmcia) register it's interrupt handler by
> calling:
>     request_8xxirq(pcmcia_schlvl, m8xx_interrupt, 0, "m8xx_pcmcia", NULL);
>    well, that seems logical.
>
> 2. But when an PCMCIA card plug in, it remap the memory and route it's
> interrupt to the system interrupt (of course only one PCMCIA interrupt). The
> problem is most of  driver using REQUEST_8XXIRQ to register the handler. For
> Example the FLASH card will call IDE driver, IDE driver will call
> IDE_REQUEST_IRQ to register ide_intr.
> As I saw the IDE_REQUEST_IRQ call REQUEST_8XXIRQ with PCMCIA interrupt. It
> fails because the interrupt already occupy by PCMCIA (see step 1).
>
> I may be wrong...please give me some advices
>
> Thank in advances.
> Hoang
>
> >
> > yeah, I have done it.  use my patches on
> > ftp://ftp.mvista.com/pub/Area51/ppc_8xx.  I still have not done a
> > README, but if you have a MV support contract just contact support and
> > they will help you out.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
