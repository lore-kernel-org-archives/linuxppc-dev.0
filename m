Return-Path: <d.bosi@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D3B8DDE0EA
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 00:37:02 +1000 (EST)
Message-ID: <48BEA106.9090307@selcomgroup.com>
Date: Wed, 03 Sep 2008 16:36:54 +0200
From: Daniele Bosi <d.bosi@selcomgroup.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
Subject: Re: irq
References: <319b0ac50809030715h1a03a606jacddd400019f4483@mail.gmail.com>
In-Reply-To: <319b0ac50809030715h1a03a606jacddd400019f4483@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Try to set some flag into the third parameter of the request_irq()
function like:

SA_SHIRQ                Interrupt is shared

SA_INTERRUPT            Disable local interrupts while processing

SA_SAMPLE_RANDOM        The interrupt can be used for entropy

otherwise try to use the function install_irq_handler()


bye Daniele



Sébastien Chrétien ha scritto:
> Hello,
>
> I am trying to register a function writh IRQ :
>  
> static irqreturn_t uart_test (int irq , void *dev_id)
> {
>     printk("/!\\ Interruption : tx_empty\n");
>        return IRQ_HANDLED;
> }
>    
>     req=request_irq(0x18,uart_test,NULL,"uart_test",NULL);
>     printk("Initialisation IRQ UART : %d \n", req);   
>
> When I boot linux ppc, the req value is -38.
> What is wrong ?
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

-- 


------------------------------------------------------------------------


  Daniele Bosi

*DIGITEK S.p.A.*

Via L. Romagnoli 24,
41033 Concordia sulla Secchia
Modena (MO), Italy

*Tel*: +39-(0)53556942 Fax. +39-(0)53554550

*Web:    * http://www.digitek.it

*Mail to:* d.bosi@selcomgroup.com <mailto:d.bosi@selcomgroup.com>
