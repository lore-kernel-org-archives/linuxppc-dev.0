Return-Path: <poseidon21@post.sk>
Received: from otrok.post.sk (otrok.post.sk [85.248.69.172])
	by ozlabs.org (Postfix) with ESMTP id 6962CDDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 22:38:53 +1100 (EST)
Message-ID: <45C31795.000001.05998@kamasutra>
Mime-Version: 1.0
Content-Type: Text/Plain;
	Charset = "ISO-8859-2"
From: Ladislav Klenovic <poseidon21@post.sk>
To: <linuxppc-embedded@ozlabs.org>
Subject: Re: Re: SMC as UART problem on mpc8xx
Date: 02 Feb 2007 11:51:01 +0100 (CET)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> On 01 Feb 2007 17:10:31 +0100 (CET)
> a b  wrote:
> 
> > Hi,
> > I have mpc8xx where I would like the following configuration:
> >  - SCC1 as system console (works fine) 
> >  - SMC1-2 as UART (doesn\\\'t work)
> > 
> > I use linux 2.6.16.20 with backward patch from linux-2.6.19.2 for SMCs. My only problem is 
> > that even I can see cpm_uart registered for IRQ 20 (for SMC1) I never get interrupt even
> > I do e.g. \\\"echo 123 > /dev/ttyCPM\\\". 
> > 
> > here is a short extract from /proc/interrupts:
> >  20:          0   CPM       Edge      cpm_uart  <--SMC1
> >  21:       7546   CPM       Edge      SPI
> >  46:         20   CPM       Edge      cpm_uart  <-- SCC1 (console)
> > 
> > here is a short extract from /proc/tty/driver/ttyCPM:
> > serinfo:1.0 driver revision:
> > 0: uart:CPM UART mmio:0xFFF00A80 irq:20 tx:14 rx:0 RTS|CTS|DTR|DSR|CD
> > 1: uart:CPM UART mmio:0xFFF00A90 irq:19 tx:0 rx:0 CTS|DSR|CD
> > 2: uart:CPM UART mmio:0xFFF00A00 irq:46 tx:3038 rx:46 RTS|CTS|DTR|DSR|CD
> > 
> > Can anybody help me to get SMCs working?
> > 
> > 
> Check IO ports? IIRC, in 8xx some SoC devices could not work simultaneously because they 
> share some GPIO pins. In any case, if something does not function with CPM UART, IOports stuff is the first thing to check.
> 
> -- 
> Sincerely, 
> Vitaly
> 

Hi,
thnx for hint, you were right, problem was in I/O port configuration. 
I am a bit wondered why is B port for mpc8xx not configured in 2.16.19.2. Or is it  
configured somewhere else? I especially miss this part of code in cpm_uart_cpm1.c:

void smc1_lineif(struct uart_cpm_port *pinfo){
...
#elif defined (CONFIG_MPC86XADS)
       if (!pinfo->is_portb) {
                cp->cp_pbpar |= iobits;
                cp->cp_pbdir &= ~iobits;
                cp->cp_pbodr &= ~iobits;
        } else {
                ((immap_t *)IMAP_ADDR)->im_ioport.iop_papar |= iobits;
                ((immap_t *)IMAP_ADDR)->im_ioport.iop_padir &= ~iobits;
                ((immap_t *)IMAP_ADDR)->im_ioport.iop_paodr &= ~iobits;
        }
#endif
...
}

Regards,
Ladislav.



__________
Mobilné telefóny v slovenskej premiére a najaktuálnej¹ie informácie - http://mobil.sme.sk/
