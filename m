Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18417.44855.137234.450478@cargo.ozlabs.ibm.com>
Date: Tue, 1 Apr 2008 14:42:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Move phys_addr_t definition into asm/types.h
In-Reply-To: <Pine.LNX.4.64.0803281338360.15109@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0803281338360.15109@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Moved phys_addr_t out of mmu-*.h and into asm/types.h so we can use it in
> places that before would have caused recursive includes.
> 
> For example to use phys_addr_t in <asm/page.h> we would have included
> <asm/mmu.h> which would have possibly included <asm/mmu-hash64.h> which
> includes <asm/page.h>.  Wheeee recursive include.

In general this looks fine.  I wonder if you should use u64 rather
than unsigned long long.  Since CONFIG_PHYS_64BIT=n on 64-bit machines
(which is itself somewhat counterintuitive) we will actually use
unsigned long on 64-bit machines, so it matters less than I originally
thought, but it would be worth explaining that in a comment and/or the
commit message.

Paul.
