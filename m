Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E378DDDCA
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 05:06:03 +1000 (EST)
Message-ID: <46A79F14.9040409@freescale.com>
Date: Wed, 25 Jul 2007 14:05:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<46A79DE0.8060405@ru.mvista.com>
In-Reply-To: <46A79DE0.8060405@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
>>+	hwif->hw.io_ports[IDE_DATA_OFFSET] = port;
>>+
>>+	port += (1 << pdata->ioport_shift);
>>+	for (i = IDE_ERROR_OFFSET; i <= IDE_STATUS_OFFSET;
>>+	     i++, port += (1 << pdata->ioport_shift))
> 
> 
>     Looks like shift doesn't buy as anything, why not just use stride?

It doesn't buy us anything in here, but it's conceivable that someone 
may want to write a driver that uses a shift in the I/O accessor rather 
than an array of port offsets, and it's easier to convert a shift to a 
stride than the other way around (not all architectures have an 
equivalent of the cntlzw innstruction, and shift makes it clear that the 
stride must be power-of-two).  Plus, using shift is consistent with what 
we do on ns16550.

-Scott
