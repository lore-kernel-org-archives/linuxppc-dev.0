Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9346D679FD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 03:05:12 +1000 (EST)
Date: Thu, 13 Jul 2006 21:05:25 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: cpm_uart_port_map not initialised before serial console setup
Message-ID: <20060713210525.2d3d1abf@vitb.ru.mvista.com>
In-Reply-To: <200607131655.35899.laurent.pinchart@tbox.biz>
References: <200607131655.35899.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 13 Jul 2006 16:55:35 +0200
Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:

> Hi everybody,
> 
> while trying to use SCC1 as a serial console, I found a bug in the cpm_uart 
> driver.
> 
> The cpm_uart_port_map table is initialised by cpm_uart_count() which is called 
> in cpm_uart_init() at module_init() time. cpm_uart_console_setup(), called at 
> console_initcall() time, accesses cpm_uart_port_map, leading to a crash when 
> using any serial port except SMC1 as the serial console.
> 
> I attached a very simple patch to fix the problem, but it might be subject to 
> race conditions. Could anyone familiar with the cpm_uart driver have a look 
> at it ?
> 
Ugh, you're right.

But I think we need to finally get rid of the stupid count/port_map creation based on #ifdefs.
I'll have a look at it immediately as time permits
 

-- 
Sincerely, 
Vitaly
