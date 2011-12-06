Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from earthlight.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
 [81.2.110.250])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0FF7A1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 02:37:59 +1100 (EST)
Date: Tue, 6 Dec 2011 15:39:26 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 01/16 v2] pmac_zilog: fix unexpected irq
Message-ID: <20111206153926.32d26bf8@lxorguk.ukuu.org.uk>
In-Reply-To: <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 7 Dec 2011 02:13:41 +1100 (EST)
Finn Thain <fthain@telegraphics.com.au> wrote:

> 
> On most 68k Macs the SCC IRQ is an autovector interrupt and cannot be 
> masked. This can be a problem when pmac_zilog starts up.
> 
> For example, the serial debugging code in arch/m68k/kernel/head.S may be 
> used beforehand. It disables the SCC interrupts at the chip but doesn't 
> ack them. Then when a pmac_zilog port is opened and SCC chip interrupts 
> become enabled, the machine locks up with "unexpected interrupt" because 
> request_irq() hasn't happened yet.
> 
> Fix this by setting the interrupt enable bits only after the handler is 
> installed and before it is uninstalled. Also move this bit flipping into a 
> separate pmz_interrupt_control() routine. Replace all instances of these 
> operations with calls to this routine.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Nice

Acked-by: Alan Cox <alan@linux.intel.com>
