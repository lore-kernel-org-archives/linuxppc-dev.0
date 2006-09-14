Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7BEB367B6C
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2006 23:37:48 +1000 (EST)
Date: Thu, 14 Sep 2006 17:37:51 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Subject: Re: cpm_uart non-console problem with write on 2nd open..
Message-ID: <20060914173751.475adf59@vitb.ru.mvista.com>
In-Reply-To: <op.tfvehinanhx3hy@draco>
References: <op.tfvehinanhx3hy@draco>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 Sep 2006 16:30:44 +0300
"Alexandros Kostopoulos" <akostop@inaccessnetworks.com> wrote:

> I'm experiencing a problem with the 2.6.13 cpm_uart driver. When opening  
> the device for the second time after the driver was inserted, if only a  
> few bytes are sent for transmission and the device is then closed, the  
> tx_empty routine called by shutdown returns 0 and the latter hangs in the  
> while loop with the call to cpm_uart_tx_empty. No bytes are actually  
> transmitted from the uart.
> 
It was addressed a while ago, fix should be in the latest stable kernel rev. for certain.

The snippet below was not the only thing to get problem completely resolved; 
You may glance at the code within current kernel, if still experiencing problems.

Thanks, Vitaly

> I found out that the difference between the first and subsequent open  
> calls is that during the first time (and until the first shutdown) the  
> transmitter is enabled in GSMRL. From this point on, the transmitter is  
> initially disabled on startup. Thus, if only a few bytes are queued for  
> transmission before shutdown and a TX interrupt is not triggered, the  
> bytes are never sent, and thus the shutdown function hangs on the  
> cpm_uart_tx_empty loop.
> 
> The fix that works for me is the following:
> 
> Index: drivers/serial/cpm_uart/cpm_uart_core.c
> ===================================================================
> --- drivers/serial/cpm_uart/cpm_uart_core.c     (revision 106)
> +++ drivers/serial/cpm_uart/cpm_uart_core.c     (working copy)
> 
> @@ -394,7 +394,7 @@ static int cpm_uart_startup(struct uart_
>                  pinfo->smcp->smc_smcmr |= SMCMR_REN;
>          } else {
>                  pinfo->sccp->scc_sccm |= UART_SCCM_RX;
> -        pinfo->sccp->scc_gsmrl |= (SCC_GSMRL_ENR);
> +        pinfo->sccp->scc_gsmrl |= (SCC_GSMRL_ENR | SCC_GSMRL_ENT);
> 
>          }
> 
> Any comments would be greatly appreciated
> 
> thank you
> 
> Alex
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 


-- 
Sincerely, 
Vitaly
