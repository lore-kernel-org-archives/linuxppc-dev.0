Return-Path: <trini@kernel.crashing.org>
Date: Mon, 22 May 2006 18:13:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [HACK] add sandpoint + flattened dt support to arch/powerpc/boot
Message-ID: <20060523011319.GU32112@smtp.west.cox.net>
References: <20060518002142.GA23182@mag.az.mvista.com>
	<1147930376.17679.72.camel@localhost.localdomain>
	<20060523005846.GA15797@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060523005846.GA15797@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 22, 2006 at 05:58:46PM -0700, Mark A. Greer wrote:

[snip]
> All of the boards would likely have to be of the same "class".
> Where "class" would be:
> 	1) OF system
> 	2) e300 core + PQIIPro (e.g., 83xx)
> 	3) e500 core + PQIII (e.g., 85xx)
> 	4) 6xx/7xx/74xx + mpc10x (e.g., sandpoint)
> etc.  Something like that, anyway--maybe there are only "OF" and
> "non-OF'?

That's more limiting than we strictly need, I think.  So long as we keep
the instructions that can't/aren't run-time nop'd over, or already done
in a way they don't run on the wrong core (ie ARCH=ppc and sandpoint
running fine on both 745x and 750), it should be (guessing a bit on the
64bit cpus):
1) 6xx/7xx/74xx/8xxx
2) 4xx
3) 8xx
4) 970
5) cell
6) etc

Or so.  IOW, so long as we can either nop out, or possibly better yet,
have the compiler get things right (use Makefile/Kconfig magic to get
the LCD -mcpu=/-mtune= option so we run right).  Things like PPC_BOARD1
and PPC_BOARD2 would then select PQIII core stuff, MPC10X core stuff,
TSI108 core stuff, GT64x60 core stuff, and so on.  And maybe 8xxx has to
be split into BookE/non-BookE, at least to start with, for head*.S
reasons.

As a reminder to all, this also lets us say that if we just pick
PPC_8548CDS then only the stuff required for the 8548CDS would be
compiled into the kernel.

-- 
Tom Rini
