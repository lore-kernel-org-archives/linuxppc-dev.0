Return-Path: <marcelo.tosatti@cyclades.com>
Received: from kanga.kvack.org (kanga.kvack.org [66.96.29.28])
	by ozlabs.org (Postfix) with ESMTP id 6F5CB679E0
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Mar 2006 06:22:33 +1100 (EST)
Date: Sat, 11 Mar 2006 16:17:02 -0600
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Aristeu Sergio Rozanski Filho <aris@mandriva.com>
Subject: Re: SCCx UART status on 8xx
Message-ID: <20060311221702.GA26734@dmt.cnet>
References: <004B1D7A5257174C9044A1B7BD0E60ED0178CC4F@ratatosk.combitechsystems.com>
	<20060220141830.GA7228@oops.ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060220141830.GA7228@oops.ghostprotocols.net>
Cc: fbl@conectiva.com.br,
	=?iso-8859-1?Q?Bj=F6rn_=D6stby?= <Bjorn.Ostby@combitech.se>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Aris, 

Can you please prepare a detailed description of what the 
patch is doing and why?

Thanks

On Mon, Feb 20, 2006 at 11:18:35AM -0300, Aristeu Sergio Rozanski Filho wrote:
> Index: stable/drivers/serial/cpm_uart/cpm_uart_cpm1.c
> ===================================================================
> --- stable.orig/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2006-02-17 17:11:37.000000000 -0200
> +++ stable/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2006-02-17 17:15:57.000000000 -0200
> @@ -139,24 +139,31 @@
>  void scc1_lineif(struct uart_cpm_port *pinfo)
>  {
>  	/* XXX SCC1: insert port configuration here */
> +	cpmp->cp_sicr &= 0xFFFFFFC0;
>  	pinfo->brg = 1;
>  }
>  
>  void scc2_lineif(struct uart_cpm_port *pinfo)
>  {
>  	/* XXX SCC2: insert port configuration here */
> +	cpmp->cp_sicr &= 0xFFFFC0FF;
> +	cpmp->cp_sicr |= 0x00000900;
>  	pinfo->brg = 2;
>  }
>  
>  void scc3_lineif(struct uart_cpm_port *pinfo)
>  {
>  	/* XXX SCC3: insert port configuration here */
> +	cpmp->cp_sicr &= 0xFFC0FFFF;
> +	cpmp->cp_sicr |= 0x00140000;
>  	pinfo->brg = 3;
>  }
>  
>  void scc4_lineif(struct uart_cpm_port *pinfo)
>  {
>  	/* XXX SCC4: insert port configuration here */
> +	cpmp->cp_sicr &= 0xC0FFFFFF;
> +	cpmp->cp_sicr |= 0x1BFFFFFF;
>  	pinfo->brg = 4;
>  }
>  

> Index: stable/drivers/serial/cpm_uart/cpm_uart_core.c
> ===================================================================
> --- stable.orig/drivers/serial/cpm_uart/cpm_uart_core.c	2005-12-07 15:30:42.000000000 -0200
> +++ stable/drivers/serial/cpm_uart/cpm_uart_core.c	2005-12-08 12:39:11.000000000 -0200
> @@ -467,6 +467,7 @@
>  	/* free interrupt handler */
>  	free_irq(port->irq, port);
>  
> +#if 0
>  	/* If the port is not the console, disable Rx and Tx. */
>  	if (!(pinfo->flags & FLAG_CONSOLE)) {
>  		/* Wait for all the BDs marked sent */
> @@ -492,6 +493,7 @@
>  		/* Shut them really down */
>  		cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
>  	}
> +#endif 
>  }
>  
>  static void cpm_uart_set_termios(struct uart_port *port,
> @@ -896,7 +898,7 @@
>  		pinfo->sccp->scc_gsmrl &= ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
>  	}
>  
> -	ret = cpm_uart_allocbuf(pinfo, 0);
> +	ret = cpm_uart_allocbuf(pinfo, 1);
>  
>  	if (ret)
>  		return ret;
> @@ -912,10 +914,12 @@
>  
>  static void cpm_uart_release_port(struct uart_port *port)
>  {
> +#if 0
>  	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
>  
>  	if (!(pinfo->flags & FLAG_CONSOLE))
>  		cpm_uart_freebuf(pinfo);
> +#endif
>  }
>  
>  /*
