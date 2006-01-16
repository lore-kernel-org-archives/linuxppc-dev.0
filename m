Return-Path: <ARNDB@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CCE6D68A1B
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2006 03:09:59 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.12.10/8.12.10) with ESMTP id k0GCkaI5121750
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 12:46:44 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP
	id k0GCjKp8193078
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 13:45:20 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k0GCjKY4016299
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 13:45:20 +0100
In-Reply-To: <20060116121157.GA7171@suse.de>
Subject: Re: [PATCH] fix spider compilation
To: Olaf Hering <olh@suse.de>
Message-ID: <OFB9B4EF24.E1169CA8-ONC12570F8.0044F4E5-C12570F8.00461122@de.ibm.com>
From: Arnd Bergmann <ARNDB@de.ibm.com>
Date: Mon, 16 Jan 2006 13:45:19 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com,
	Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering <olh@suse.de> wrote on 01/16/2006 01:11:57 PM:

>
> linux-2.6.15/drivers/net/spider_net.c: In function
> `spider_net_set_txdescr_cmdstat':
> linux-2.6.15/drivers/net/spider_net.c:890: error: `IPPROTO_TCP'
> undeclared (first use in this function)
> linux-2.6.15/drivers/net/spider_net.c:890: error: (Each undeclared
> identifier is reported only once
> linux-2.6.15/drivers/net/spider_net.c:890: error: for each function
> it appears in.)
> linux-2.6.15/drivers/net/spider_net.c:892: error: `IPPROTO_UDP'
> undeclared (first use in this function)
>
> Signed-off-by: Olaf Hering <olh@suse.de>


Thanks. I already submitted the same patch to Jeff Garzik,
but had a problem with a quilt bug that caused another patch
in the series to fail.

Jeff, did you get the '[RESEND 2]' patches for spidernet?
Sorry for messing this up twice before, but I'm pretty
sure that I fixed up the diff now and the contents are
somewhat important, at least the compile fix.

      Arnd <><

>  drivers/net/spider_net.c |    1 +
>  1 files changed, 1 insertion(+)
>
> Index: linux-2.6.15/drivers/net/spider_net.c
> ===================================================================
> --- linux-2.6.15.orig/drivers/net/spider_net.c
> +++ linux-2.6.15/drivers/net/spider_net.c
> @@ -33,6 +33,7 @@
>  #include <linux/init.h>
>  #include <linux/ioport.h>
>  #include <linux/ip.h>
> +#include <linux/in.h>
>  #include <linux/kernel.h>
>  #include <linux/mii.h>
>  #include <linux/module.h>
