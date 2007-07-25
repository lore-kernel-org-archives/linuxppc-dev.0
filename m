Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 54E81DDED8
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 05:33:00 +1000 (EST)
Message-ID: <46A7A5E4.4090105@ru.mvista.com>
Date: Wed, 25 Jul 2007 23:35:00 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<46A79DE0.8060405@ru.mvista.com> <46A79F14.9040409@freescale.com>
	<46A7A17C.8090505@ru.mvista.com> <46A7A1D5.7020003@freescale.com>
In-Reply-To: <46A7A1D5.7020003@freescale.com>
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

Scott Wood wrote:

>>> It doesn't buy us anything in here, but it's conceivable that someone 
>>> may want to write a driver that uses a shift in the I/O accessor 
>>> rather than an array of port offsets,

>>    It wouldn't be IDE driver then, and neither it would be libata 
>> which also does this another way this (despite pata_platform uses 
>> shifts too -- not in the accessors, so no speed loss).

> The device tree is not just for Linux.

    Yeah, and I can't wait to see some other its users. ;-)
    This doesn't mean that shift is better anyway. If everyone considers it 
better, I give up. But be warned that shift (stride) is not the only property 
characterizing register accesses -- the regs might be only accessible as 
16/32-bit quantities, for example (16-bit is a real world example -- from 
Amiga or smth of that sort, IIRC).

>>> equivalent of the cntlzw innstruction, and shift makes it clear that 
>>> the stride must be power-of-two).  Plus, using shift is consistent 
>>> with what we do on ns16550.

>>    Why the heck should we care about the UART code taling about IDE?!

> Consistency?

    We're not obliged to be consistent with every piece of the kernel code.

> -Scott

MBR, Sergei
