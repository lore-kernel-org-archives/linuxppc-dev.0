Return-Path: <Hans.Schillstrom@lgpallgon.com>
Received: from aseit003.allgon.net (mail.lgpallgon.com [193.235.198.4])
	by ozlabs.org (Postfix) with ESMTP id E568F67A63
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Jan 2005 23:20:27 +1100 (EST)
From: Hans Schillstrom <hans.schillstrom@pwav.com>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
In-Reply-To: <313680C9A886D511A06000204840E1CF0A6474FB@whq-msgusr-02.pit.comms.marconi.com>
References: <313680C9A886D511A06000204840E1CF0A6474FB@whq-msgusr-02.pit.comms.marconi.com>
Content-Type: text/plain
Message-Id: <1106050810.7900.311.camel@hawk.allgon.net>
Mime-Version: 1.0
Date: Tue, 18 Jan 2005 13:20:10 +0100
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: Linux 2.6-10.rc3  8xx: debugging (over-writing)  content of
	bd_in fo structure  in the kernel booting code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Alex,
On Tue, 2005-01-18 at 12:45, Povolotsky, Alexander wrote:
> I am now suspecting that the content of my bd_info structure is set or is
> handled incorrectly,
> thus causing incorrect behavior of the serial driver upon kernel booting
> (only 3 characters are printed correctly and the rest is the garbage - as I
> reported before), 
> so I am trying (for debugging purposes) to over-write the values, passed
> from bd_info
> during the kernel booting, by the hard-coded "correct" values.
> 
> So far I tried forcing baud, bits, parity, flow directly in in
> cpm_uart_console_setup()
> ( drivers/serial/cpm_uart/cpm_uar t_core.c ) - see below - it didn't help
> ...
> 
> Where in the kernel booting code the clock speed is handled (it also comes
> from the bd_info)
>  - so I could try to force set clock speed there ?

Have a look into ppc/8xx_io/commproc.c
There you have the baudrate dependency - "bi_intfreq"

#define BRG_INT_CLK		(((bd_t *)__res)->bi_intfreq)
#define BRG_UART_CLK		(BRG_INT_CLK/16)
#define BRG_UART_CLK_DIV16	(BRG_UART_CLK/16)

void
cpm_setbrg(uint brg, uint rate)
{
 ...

/Hans

> 
> Thanks,
> Alex
> ****************************************************************
> static int __init cpm_uart_console_setup(struct console *co, char *options)
> {
>         struct uart_port *port;
>         struct uart_cpm_port *pinfo;
>         int baud = 38400;
>         int bits = 8;
>         int parity = 'n';
>         int flow = 'n';
>         int ret;
> 
>         port =
>             (struct uart_port
> *)&cpm_uart_ports[cpm_uart_port_map[co->index]];
>         pinfo = (struct uart_cpm_port *)port;
> 
>         pinfo->flags |= FLAG_CONSOLE;
> 
>         if (options) {
>                 uart_parse_options(options, &baud, &parity, &bits, &flow);
>         } else {
>                 bd_t *bd = (bd_t *) __res;
> 
>                 if (bd->bi_baudrate)
>                         baud = bd->bi_baudrate;
>                 else
>                         baud = 9600;
>         }
>         baud = 38400;
> <<===========================================
>         parity = 'n';
> <<===========================================
>         flow = 'n';
> <<===========================================
>         bits = 8;
> <<===========================================
>         /*
>          * Setup any port IO, connect any baud rate generators,
>          * etc.  This is expected to be handled by board
>          * dependant code
>          */
>         if (pinfo->set_lineif)
>                 pinfo->set_lineif(pinfo);
> 
>         if (IS_SMC(pinfo)) {
>                 pinfo->smcp->smc_smcm &= ~(SMCM_RX | SMCM_TX);
>                 pinfo->smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
>         } else {
>                 pinfo->sccp->scc_sccm &= ~(UART_SCCM_TX | UART_SCCM_RX);
>                 pinfo->sccp->scc_gsmrl &= ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
>         }
> 
>         ret = cpm_uart_allocbuf(pinfo, 1);
> 
>         if (ret)
>                 return ret;
> 
>         cpm_uart_initbd(pinfo);
> 
>         if (IS_SMC(pinfo))
>                 cpm_uart_init_smc(pinfo);
>         else
>                 cpm_uart_init_scc(pinfo);
> 
>         uart_set_options(port, co, baud, parity, bits, flow);
> 
>         return 0;
> }
> 
