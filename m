Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 6EB37DDDD5
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 14:49:16 +1000 (EST)
Subject: Re: [PATCH 2/3] 82xx: Parse SMC serial device node in DTS
From: Mark Zhan <rongkai.zhan@windriver.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200707170302.07469.arnd@arndb.de>
References: <469B33F9.2080604@windriver.com> <200707170302.07469.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 12:49:02 +0800
Message-Id: <1184647742.10499.34.camel@mark>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Arnd,

I think, the function of_find_compatible_node(), which is called in the
for loop, has already done that. So definitely, no need to call
of_device_is_compatible() any more.

Thanks
Mark Zhan
On Tue, 2007-07-17 at 03:02 +0200, Arnd Bergmann wrote:
> On Monday 16 July 2007, Mark Zhan wrote:
> > -               cpm_uart_data.uart_clk = ppc_proc_freq;
> > +               if (strstr(model, "SMC")) {
> > +                       cpm_uart_dev = platform_device_register_simple("fsl-cpm-smc:uart",
> > +                                                       i, &r[0], 3);
> > +               } else if (strstr(model, "SCC")) {
> > +                       cpm_uart_dev = platform_device_register_simple("fsl-cpm-scc:uart",
> > +                                                       i, &r[0], 3);
> > +               }
> > 
> 
> You should probably use of_device_is_compatible() to check
> if a given device can be used by a particular driver.
> 
> 	Arnd <><
