Return-Path: <mpe@ellerman.id.au>
Message-ID: <1428748932.1552.1.camel@ellerman.id.au>
Subject: Re: powerpc: CONFIG_PPC_CELLEB leftovers
From: Michael Ellerman <mpe@ellerman.id.au>
To: Valentin Rothberg <valentinrothberg@gmail.com>
Date: Sat, 11 Apr 2015 20:42:12 +1000
In-Reply-To: <20150410115410.GA21121@station.rsr.lip6.fr>
References: <20150410115410.GA21121@station.rsr.lip6.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, pebolle@tiscali.nl,
 linux-kernel@vger.kernel.org, paulus@samba.org, jk@ozlabs.org,
 rupran@einserver.de, linuxppc-dev@lists.ozlabs.org, stefan.hengelein@fau.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-10 at 13:54 +0200, Valentin Rothberg wrote:
> Hi Michael,

Hi Valentin,

> your commit bf4981a00636 ("powerpc: Remove the celleb support") in
> today's Linux next tree removes the Kconfig option PPC_CELLEB.  It looks
> like there are some leftovers in Kconfig dependencies on this option which
> avoid to properly set others (see list below).  Is there a patch queued
> somewhere to fix the issue?

There are not yet patches to fix those.

> 0 drivers/ata/Kconfig                  734 depends on PCI && PPC_CELLEB
> 1 drivers/ide/Kconfig                  648 depends on PPC_CELLEB
> 2 drivers/net/ethernet/toshiba/Kconfig   8 depends on PCI && (PPC_IBM_CELL_BLADE || PPC_CELLEB || MIPS) || PPC_PS3
> 3 drivers/net/ethernet/toshiba/Kconfig  45 depends on PCI && (PPC_IBM_CELL_BLADE || PPC_CELLEB)
> 4 drivers/tty/hvc/Kconfig               47 depends on PPC_CELLEB
> 
> I detected the issue with ./scripts/checkkonfigsymbols.py by diffing
> today's and yesterday's Linux next trees.

Thanks.

I'll try and get patches for those done this week, but no promises.

cheers
