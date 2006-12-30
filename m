Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 28899DDDFB
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Dec 2006 21:49:22 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Scott Wood'" <scottwood@freescale.com>,
	"'Kumar Gala'" <galak@kernel.crashing.org>
Subject: RE: mpc83xx_restart() buggy
Date: Sat, 30 Dec 2006 11:49:14 +0100
Message-ID: <012101c72c00$256bc370$1e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <45959EFC.4040404@freescale.com>
Cc: 'linuxppc-dev' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: 
> linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org 
> [mailto:linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozl
> abs.org] On Behalf Of Scott Wood
> Sent: den 30 december 2006 00:04
> To: Kumar Gala
> Cc: Tjernlund; 'linuxppc-dev'
> Subject: Re: mpc83xx_restart() buggy
> 
> Kumar Gala wrote:
> > On Dec 27, 2006, at 6:45 PM, Tjernlund wrote:
> >>mpc83xx_restart() uses ioremap(), which doesn't like
> >>beeing called while in IRQ context.
> >>
> >>Calling mpc83xx_restart() in IRQ context yields OOPS
> >>which calls mpc83xx_restart() again and the loop never
> >>termintes.
> > 
> > This is interesting, I know I've seen restart work properly w/o an  
> > oops.  How are you causing the restart?
> 
> sysrq-b triggers it, as probably does crashing from an 
> interrupt handler 
> with panic_timeout nonzero.  You'll need CONFIG_DEBUG_SPINLOCK_SLEEP 
> turned on, of course.

For me it was http://ozlabs.org/pipermail/linuxppc-dev/2006-December/029414.html

ucc_geth_timeout() is buggy and so is ucc_geth_start_xmit(), needs to 
return NETDEV_TX_BUSY or NETDEV_TX_OK.

 Jocke
