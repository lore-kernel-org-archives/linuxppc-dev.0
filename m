Date: Wed, 17 Mar 2004 08:33:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppcdev@qbjnet.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Can't get 7248 PreP boot disk working in 2.6
Message-ID: <20040317153319.GC23551@smtp.west.cox.net>
References: <20040316234723.18931.qmail@kunk.qbjnet.com> <16472.13017.785682.193184@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16472.13017.785682.193184@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 17, 2004 at 10:13:29PM +1100, Paul Mackerras wrote:

> linuxppcdev@qbjnet.com writes:
>
> > I've never had trouble making a boot disk for 2.4.x kernels. Using the
> > current bitkeeper 2.4 and 2.6 however, the 2.4 works fine and the 2.6
> > reads a few sectors and goes to the System Maint disk insert dialog.
> > Tried different floppies, etc.
>
> There is a bug in arch/ppc/boot/utils/mkprep.c in 2.6.  This patch
> should fix it.  Tom, how about sending this to Linus and Andrew?
>
> diff -urN linux-2.5/arch/ppc/boot/utils/mkprep.c linux-2.4/arch/ppc/boot/utils/mkprep.c
> --- linux-2.5/arch/ppc/boot/utils/mkprep.c	2004-01-03 11:27:07.000000000 +1100
> +++ linux-2.4/arch/ppc/boot/utils/mkprep.c	2003-12-31 09:32:23.000000000 +1100
> @@ -219,6 +219,8 @@
>    pe.number_of_sectors = cpu_to_le32(2*18*80-1);
>  #endif /* __i386__ */
>
> +  memcpy(&block[0x1BE],&pe,sizeof(pe));
> +
>    write( out, block, sizeof(block) );
>    write( out, entry, sizeof(*entry) );
>    write( out, length, sizeof(*length) );

Done.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
