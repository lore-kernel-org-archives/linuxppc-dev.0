Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7052DDDE2C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 04:26:37 +1100 (EST)
Date: Thu, 1 Feb 2007 20:27:04 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: a b <poseidon21@post.sk>
Subject: Re: SMC as UART problem on mpc8xx
Message-ID: <20070201202704.331c0d7a@vitb.ru.mvista.com>
In-Reply-To: <45C210F7.000001.01701@kamasutra>
References: <45C210F7.000001.01701@kamasutra>
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

On 01 Feb 2007 17:10:31 +0100 (CET)
a b <poseidon21@post.sk> wrote:

> Hi,
> I have mpc8xx where I would like the following configuration:
>  - SCC1 as system console (works fine) 
>  - SMC1-2 as UART (doesn\'t work)
> 
> I use linux 2.6.16.20 with backward patch from linux-2.6.19.2 for SMCs. My only problem is 
> that even I can see cpm_uart registered for IRQ 20 (for SMC1) I never get interrupt even
> I do e.g. \"echo 123 > /dev/ttyCPM\". 
> 
> here is a short extract from /proc/interrupts:
>  20:          0   CPM       Edge      cpm_uart  <--SMC1
>  21:       7546   CPM       Edge      SPI
>  46:         20   CPM       Edge      cpm_uart  <-- SCC1 (console)
> 
> here is a short extract from /proc/tty/driver/ttyCPM:
> serinfo:1.0 driver revision:
> 0: uart:CPM UART mmio:0xFFF00A80 irq:20 tx:14 rx:0 RTS|CTS|DTR|DSR|CD
> 1: uart:CPM UART mmio:0xFFF00A90 irq:19 tx:0 rx:0 CTS|DSR|CD
> 2: uart:CPM UART mmio:0xFFF00A00 irq:46 tx:3038 rx:46 RTS|CTS|DTR|DSR|CD
> 
> Can anybody help me to get SMCs working?
> 
> 
Check IO ports? IIRC, in 8xx some SoC devices could not work simultaneously because they 
share some GPIO pins. In any case, if something does not function with CPM UART, IOports stuff is the first thing to check.

-- 
Sincerely, 
Vitaly
