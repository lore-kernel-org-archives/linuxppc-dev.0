Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17910.4629.587851.80369@cargo.ozlabs.ibm.com>
Date: Tue, 13 Mar 2007 13:53:09 +1100
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 02/19] bootwrapper: Set -msoft-float and assembler target
	options.
In-Reply-To: <20070312204140.GB28545@ld0162-tx32.am.freescale.net>
References: <20070312204140.GB28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> The bootwrapper should be built with the same target options as the
> kernel.  In particular, -msoft-float and the assembler target need to be
> set.

I don't like this patch as it stands because I want to keep the
wrapper independent from the kernel config as far as possible.
We need to compile up the wrapper code in a manner that means that it
can run on any processor, so clearly we need -msoft-float.

> Without the assembler target option, the assembler will use the old
> dedicated mftb/mftbu instructions, rather than mfspr.  This causes the
> boot to hang on e500, which doesn't have the dedicated instructions.

I see mftb being used for udelay in util.S, and udelay being used in
serial_edit_cmdline in serial.c.  It's somewhat bogus that we just
hard-code an assumed timebase frequency in util.S, and also bogus that
we get command line editing for serial consoles but not for OF
consoles (why should they be different?).

It looks to me like we should at least make the platform code provide
udelay (or mdelay), possibly with the aid of a helper function.  We
should also consider whether the command-line editing is generally
useful, or not, and whether the function to do it should be made more
generic.

Paul.
