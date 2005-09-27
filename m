Return-Path: <dan@embeddedalley.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 2C2D0683E0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 02:58:18 +1000 (EST)
In-Reply-To: <43395322.1080407@iki.fi>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <384d09b865d454875c447cc02c89d001@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Date: Tue, 27 Sep 2005 12:39:54 -0400
To: Kalle Pokki <kalle.pokki@iki.fi>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 27, 2005, at 10:11 AM, Kalle Pokki wrote:

> Is the alloc_bootmem() function in e.g. cpm_uart_allocbuf() supposed 
> to give non-cached memory? In my 8248 board it seems not to.

It provides cache coherent memory, whether it is cached or not
depends upon the capabilities of the cache controller and
peripherals.  On the 82xx, it is supposed to be cached.

>  Only using DPRAM as buffer storage allows booting to proceed without 
> hanging right in the beginning.

The only thing that would cause a problem is an
incorrect CPM configuration.

> Any ideas what can set the bootmem memory as cached?

All of memory is always cached on 82xx.  Which is fine
since the cache controller keeps the processor core
and peripherals coherent in hardware.

Thanks.

	-- Dan
