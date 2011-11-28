Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DCAA0B6F95
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 11:30:20 +1100 (EST)
Message-ID: <1322440206.23348.35.camel@pasglop>
Subject: Re: [PATCH 01/16] pmac_zilog: fix unexpected irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>
Date: Mon, 28 Nov 2011 11:30:06 +1100
In-Reply-To: <alpine.LNX.2.00.1111250207040.6314@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1111250133321.6314@nippy.intranet>
 <20111124145624.24438832@lxorguk.ukuu.org.uk>
 <alpine.LNX.2.00.1111250207040.6314@nippy.intranet>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Removing ifdefs makes the changes more invasive and the suspend/resume 
> code then has to be addressed, which I've avoided.
> 
> The suspend/resume code path can't be tested on m68k macs and the common 
> code paths I can't easily test on a powermac.
> 
> This patch should not be needed because the chip reset shouldn't leave the 
> tx and rx interrupts enabled. Those interrupts are explicitly enabled only 
> after request_irq(), so patching the master interrupt enable behaviour 
> should be redundant. But that's not the case in practice.
> 
> The chip reset code is already messy. I was inclined towards ifdefs and 
> reluctant to share more code after practical experience suggested possible 
> differences in the SCC/ESCC devices.
> 
> I guess I was hoping that the powermac maintainers might prefer ifdefs to 
> increased risk of destabilising the driver on powermacs...
> 
> But a more invasive patch would make for better code. I will see if I can 
> borrow a suitable PCI PowerMac.

Please do the more invasive patch, I'll beat it up on powermacs.

Cheers,
Ben.
