Return-Path: <tnt@246tNt.com>
Received: from outmx028.isp.belgacom.be (outmx028.isp.belgacom.be
	[195.238.3.49]) by ozlabs.org (Postfix) with ESMTP id 5D4F767A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 02:08:16 +1100 (EST)
Received: from outmx028.isp.belgacom.be (localhost [127.0.0.1])
	by outmx028.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j23F8ER9018856
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Mar 2005 16:08:14 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4227286E.5090406@246tNt.com>
Date: Thu, 03 Mar 2005 16:08:30 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Babarovic Ivica <ivica@asist-traffic.com>
References: <42270DCE.8060703@asist-traffic.com>
In-Reply-To: <42270DCE.8060703@asist-traffic.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: FEC_IEVENT_RFIFO_ERROR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

> I run 2.6.10-rc2 kernel (http://www.246tNt.com/mpc52xx/)
> for MPC5200 chip on a custom board that is almost lite5200 compatible.
> I noticed a couple of times I have a strange error at bootup.
> It was FEC_IEVENT_RFIFO_ERROR. Most of the times this
> went trough without problems but since today system just hangs.
> Sometimes with several printouts of this error.
> ---boot sequence ------
> FEC_IEVENT_RFIFO_ERROR
> FEC_IEVENT_RFIFO_ERROR
> FEC_IEVENT_RFIFO_ERROR
> ....

Theses are definitly not "normal" but you said "since today it just hangs",
did something change in the environment of the card ?

> I traced a problem a bit and found that this happenes at
> mpc52xx_fec_probe() function in fec.c at this point:
> ----------------------------------------------------------------------------------------- 
>
>       /* Get the IRQ we need one by one */
>                /* Control */
>        dev->irq = ocp->def->irq;
> -->       if (request_irq(dev->irq, &fec_interrupt, SA_INTERRUPT, 
>                        "mpc52xx_fec_ctrl", dev)) {
>                printk(KERN_ERR "mpc52xx_fec: ctrl interrupt request 
> failed\n");
>                ret = -EBUSY;
>                dev->irq = -1;  /* Don't try to free it */
>                goto probe_error;
>        }
> ------------------------------------------------------------------------------------------ 
>

It ovbiously can't happen before since the message it printed in that 
interrupt
handler. But it should not happen there either (not so early) !

This error globally says : "Somthing got wrong with the receive buffer". But
at this point, frame reception is not yet enabled, how could it go wrong 
? Unless
your bootloader don't take care of shutting down the fec, then frames 
may be
stuck in the fifo between the bootloader and the fec init ...

> This is what I found in MPC5200 Users Manual:
> Receive FIFO Error--indicates error occurred within the forest green 
> version
> RX FIFO. When RFIFO_ERROR bit is set, ECNTRL.ETHER_EN is cleared,
> halting FEC frame processing. When this occurs, software must ensure both
> the FIFO Controller and BestComm are soft-reset.
>
> Any ideas on what could be causing this?

I can't explain why this happen so early at init (as I said before) but 
other things that could
cause such an event :
 - We don't have enough buffer descriptors : The bescomm task just fill 
them all and runs out
   of them before the interrupt is handled.
 - The bestcomm engine don't flush the RX fifo quicly enough. Currently 
the only tasks
 - Bestcomm stopped processing for whatever reason ...
 - Something else that I don't see at the moment. I'll try to "stress 
test" network a little bit,
 see if I can reproduce the issue.

In the mean time, pull the latest change, I just pushed some fixes 
related to frame reception,
I don't think it's related to your issue but ...



    Sylvain
