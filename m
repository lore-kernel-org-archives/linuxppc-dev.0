Return-Path: <rzhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 65D5ADDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 00:00:05 +1000 (EST)
Subject: Re: [PATCH] Add the support of ST M48T59 RTC chip in rtc-class
	driver subsystem
From: Mark Zhan <rongkai.zhan@windriver.com>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20070611121145.GA11297@iram.es>
References: <1181548600.5217.16.camel@mark> <20070611121145.GA11297@iram.es>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 21:59:36 +0800
Message-Id: <1181656776.3975.16.camel@mark>
Mime-Version: 1.0
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Gabriel,

On Mon, 2007-06-11 at 14:11 +0200, Gabriel Paubert wrote:
....
> There are other boards which have exactly the same chip, but use
> a very different (uglier) access method: using ISA 2 I/O ports
> (0x74 and 0x75) to write the address and another port (0x77) to 
> read/write the data.
> 
> Besides that, these boards also use the NVRAM part which means that
> a spinlock must be used to serialize between RTC and NVRAM access.
> 
> I have no idea whether the drivers should be shared or two
> different drivers should be written... But if there are two
> different drivers, there should be a way to distinguish them
> (different config name, different module names, and some
> explanation in the config help text).
> 

I will rework this driver to add a platform data structure which enables
the platform to provide the platform specific access method.

For the NVRAM issue, I have no idea how other boards access the NVRAM.
So could you provide me more information?

> > +
> > +static unsigned char * m48t59_vbase = NULL;
> > +static unsigned int m48t59_irq = -1;
> 
> Shouldn't it be NO_IRQ (here and in several other places) ?
> 

Yeah, agree. I will modify it.

Thanks your comment.

Best Regards
Mark Zhan
