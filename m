Return-Path: <paubert@iram.es>
Received: from navarro.puc.rediris.es (unknown [IPv6:2001:720:418:ca01::139])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CD131A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 21:50:52 +1100 (AEDT)
Date: Wed, 9 Mar 2016 11:28:55 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Scott Wood <oss@buserror.net>
Cc: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/1] powerpc/embedded6xx: Make reboot works on MVME5100
Message-ID: <20160309102855.GA12303@visitor2.iram.es>
References: <1457423952-13014-1-git-send-email-alessio.bogani@elettra.eu>
 <20160309063818.GA10069@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160309063818.GA10069@home.buserror.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2016 at 12:38:18AM -0600, Scott Wood wrote:
> On Tue, Mar 08, 2016 at 08:59:12AM +0100, Alessio Igor Bogani wrote:
> > The mtmsr() function hangs during restart. Make reboot works on
> > MVME5100 removing that function call.
> > ---
> >  arch/powerpc/platforms/embedded6xx/mvme5100.c | 2 --
> >  1 file changed, 2 deletions(-)
> 
> Missing signoff
> 
> Do you know why MSR_IP was there to begin with? 

Huh? The patch sets MSR_IP for reset but it is cleared while running Linux.
I don't have any MVME5100, however I do have MVME2400/2700 with the same
bridge (Hawk), so I can say that the address space layout is quite standard: 
memory at 0, ROM at the high end of the 32-bit address space. However the
reset method is quite different (no external register set on the Hawk).

> Does this board have a switch that determines whether boot vectors 
> are high or low (I remember some 83xx boards that did), in which 
> case is this fixing one config by breaking another?

For the switch, no AFAICT. And the code is MVME5100 specific so I
suspect that it is very unlikely to break other boards.

Very likely the source of the problem is that the restart address is remapped 
(ioremap) but never accessed while the kernel is running (the only access to
*restart is in the reboot routine) so we take a DSI exception to fill the hash 
table when attempting to reboot. 

It would be enough to move the setting of MSR_IP until after triggering the 
restart, but this performs a hard reset of the CPU, which will set MSR_IP 
anyway (granted that the CPU will probably set MSR_IP way before the reset 
signal comes in).

One way to check this hypothesis would be to introduce a write of 0 to
the restart address before setting MSR_IP.

This said restart is declared as u_char *, so the cast in the out_8 
register access is useless and ugly.

    Gabriel

P.S.: my MVME24xx/26x/27xx do not run such a modern kernel. 
