Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17EAEDDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Oct 2007 02:24:27 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 1 Oct 2007 18:24:14 +0200
References: <20070810095153.GC13994@moe.telargo.com>
	<9e4733910709280838v5deebfdbo62b9097faed9c937@mail.gmail.com>
	<200710011035.24068.jbe@pengutronix.de>
In-Reply-To: <200710011035.24068.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710011824.15639.jbe@pengutronix.de>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
Cc: Daniel Walker <dwalker@mvista.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 01 October 2007 10:35, Juergen Beisert wrote:
> 2) Same target runs 2.6.23-rc8-rt1
>
> @host$ nmap 192.168.23.226
>
> Starting Nmap 4.20 ( http://insecure.org ) at 2007-10-01 10:15 CEST
> Interesting ports on 192.168.23.226:
> Not shown: 871 filtered ports, 824 closed ports
> PORT   STATE SERVICE
> 22/tcp open  ssh
> 23/tcp open  telnet
>
> Nmap finished: 1 IP address (1 host up) scanned in 14.116 seconds
>
> Network on target dies. But can be reactivated by an "ifconfig eth0 down;
> ifconfig eth0 up". I included some printk statements into the fec.c source
> to see what interrupts are happen.
>
> "r" means fec_rx_interrupt was entered, "t" means fec_tx_interrupt was
> entered and "p" means fec_interrupt was entered. This is the output of the
> nmap "attack" above:
>
> rtrtrrr
>  at this point: fec_hard_start_xmit, stop queue
> rrt
>  at this point: fec_tx_interrupt, wake queue
> ttrr
>  at this point: fec_hard_start_xmit, stop queue
> rrt
>  at this point: fec_tx_interrupt, wake queue
> ttrr
>  at this point: fec_hard_start_xmit, stop queue
> rrt
>  at this point: fec_tx_interrupt, wake queue
> ttrr
>  at this point: fec_hard_start_xmit, stop queue
> rrt
>  at this point: fec_tx_interrupt, wake queue
> ttrr
>  at this point: fec_hard_start_xmit, stop queue
> rrt
>  at this point: fec_tx_interrupt, wake queue
> ttrr
>  at this point: fec_hard_start_xmit, stop queue
> rrt
>  at this point: fec_tx_interrupt, wake queue
> ttr
>  at this point: fec_hard_start_xmit, stop queue
> rrt
>  at this point: fec_tx_interrupt, wake queue
>  at this point: fec_hard_start_xmit, stop queue
> t
>  at this point: fec_tx_interrupt, wake queue
> tp
> <7>net eth0: ievent: 08020000
>
> ...at this point the network is dead.
>
> BTW: Without rt-preempt none of the wake/stop queue events and no
> fec_interrupt occurs. I only see a long list of "r"s and "t"s...

We tried again with rt-preempt and increased the priority of FEC's three=20
interrupts: And now it survives the nmap "attack". But we don't know now if=
=20
we only changed the behavior or fixed the bug?

BTW: Is it possible that fec_interrupt(() doesn' handle FEC_IEVENT_RFIFO_ER=
ROR =20
and FEC_IEVENT_XFIFO_ERROR)) incorrectly? The lines makes more sense with t=
he=20
following patch (but we are not sure about authors real intention).

@@ -506,7 +484,7 @@ static irqreturn_t fec_interrupt(int irq

        out_be32(&fec->ievent, ievent);         /* clear pending events */

=2D       if (ievent & ~(FEC_IEVENT_RFIFO_ERROR | FEC_IEVENT_XFIFO_ERROR)) {
+       if (!(ievent & (FEC_IEVENT_RFIFO_ERROR | FEC_IEVENT_XFIFO_ERROR))) {
                if (ievent & ~FEC_IEVENT_TFINT)
                        dev_dbg(&dev->dev, "ievent: %08x\n", ievent);
                return IRQ_HANDLED;

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
