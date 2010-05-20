Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CDE72B7D29
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 May 2010 03:06:14 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4KH6APa028527 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 May 2010 10:06:10 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o4KHH63C000240
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 May 2010 12:17:07 -0500 (CDT)
Date: Thu, 20 May 2010 12:06:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: hellohello <hellohello008@163.com>
Subject: Re: Problem of PowerPc 82xx  when using smc
Message-ID: <20100520170608.GA10712@schlenkerla.am.freescale.net>
References: <042201caf7fa$9d038a20$a51cbcc0@sfdomain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <042201caf7fa$9d038a20$a51cbcc0@sfdomain.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 20, 2010 at 04:58:27PM +0800, hellohello wrote:
> 
> I find a problem in 
> drivers/serial/cpm_uart/cpm_uart_cpm2.c:
> int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
> {
> ... ...
> pinfo->tx_bd_base = pinfo->rx_bd_base + pinfo->rx_nrfifos;
> /*The above line should be ：*/
>  pinfo->tx_bd_base = pinfo->rx_bd_base + sizeof(cbd_t) * pinfo->rx_nrfifos;

No, it shouldn't -- rx_bd_base is of type "cbd_t *", so the multiplication
already happens as part of pointer arithmetic.

> return 0;
> }
> 
> Where to get the newest code for kernel?

git.kernel.org

> How to know whether it is already patched by anyone else?  Just search in  this mail list?

As well as the current git tree.

-Scott
