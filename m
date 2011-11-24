Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from earthlight.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
 [81.2.110.250])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 765EB1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 02:15:51 +1100 (EST)
Date: Thu, 24 Nov 2011 14:56:24 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 01/16] pmac_zilog: fix unexpected irq
Message-ID: <20111124145624.24438832@lxorguk.ukuu.org.uk>
In-Reply-To: <alpine.LNX.2.00.1111250133321.6314@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1111250133321.6314@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 25 Nov 2011 01:34:58 +1100 (EST)
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
> Fix this by setting the SCC master interrupt enable bit only after the 
> handler is installed. This is achieved by extracting that operation out of 
> __pmz_startup() and placing it into a seperate routine.
> 
> A similar problem arises when the irq is freed. Fix this by resetting the 
> chip first (on m68k mac).
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> ---
> 
> This patch has been tested on a variety of m68k Macs but no PowerMacs.
> 
> I am re-sending this patch Cc linux-serial. It still needs a suitable ack 
> so that Geert can push it through his tree.

Given the change should work for all hardware do we really need the
ifdefs. Far better I would have thought to just change it so we don't
have to maintain what is effectively two versions of the code between now
and 2038.

So no ack from me yet - I'd like to understand the ifdef decision first.
Otherwise it looks sensible.

Alan
