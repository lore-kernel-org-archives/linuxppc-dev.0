Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17145.13414.996858.522127@cargo.ozlabs.ibm.com>
Date: Wed, 10 Aug 2005 08:55:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <dc3d7701e701266ffe852acf4da127ed@kernel.crashing.org>
References: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
	<42F79D89.3040709@austin.ibm.com>
	<bb9b1e9e1ebdc3ac5b23b3cab327bfd5@kernel.crashing.org>
	<Pine.LNX.4.62.0508091510400.28068@numbat.sonytel.be>
	<dc3d7701e701266ffe852acf4da127ed@kernel.crashing.org>
Cc: linuxppc64-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Yes, and that is exactly what I do not want.  We are not going
> to require OF implementations that do not need yaboot or similar
> to pass a flattened device tree to the kernel, eh?  Also, there
> is no reason why something like yaboot (with an OF still running
> underneath) should have to care about anything device-tree related
> at all; the OS can just as easily ask the OF itself.

For now the kernel will cope with either having an OF client interface
entry point or a flattened device tree passed to it.  In the future we
intend to move all the OF client calls into the zImage wrapper and
have the zImage wrapper pass the flattened device tree to the kernel
proper.  That will be much cleaner because we will be able to get rid
of all of the dodgy RELOC stuff in prom_init.c.

It is already the case (and has always been the case) that you can't
boot a vmlinux image directly from OF - there is always either or both
of yaboot or a zImage wrapper in between anyway.

Paul.
