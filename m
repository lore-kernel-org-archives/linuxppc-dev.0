MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16565.52051.873680.11310@cargo.ozlabs.ibm.com>
Date: Thu, 27 May 2004 21:04:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 2/7] clean up apus support
In-Reply-To: <Pine.LNX.4.58.0405250227510.19017@scrub.local>
References: <Pine.LNX.4.58.0405250227510.19017@scrub.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel writes:

> This brings the APUS into 2.6 and cleans up a lot of indirect calls
> via the mach_* functions and removes amiga/ints.c, amiga/time.c
> and the the reference to <asm-m68k/machdep.h>.

Some comments:

> --- 2.6/arch/ppc/amiga/Makefile	31 Jan 2004 23:23:58 -0000	1.1.1.1
> +++ 2.6/arch/ppc/amiga/Makefile	24 May 2004 23:12:48 -0000
> @@ -2,7 +2,7 @@
>  # Makefile for Linux arch/m68k/amiga source directory

It would be nice to fix that comment.

> +++ 2.6/arch/ppc/platforms/apus_setup.c	Wed Feb  4 13:21:35 2004
...
> +int amiga_hwclk(int, struct rtc_time *);
> +int amiga_set_clock_mmss (unsigned long nowtime);

I really don't like seeing function prototypes in a .c file for
functions that are actually in another .c file.  I understand the
temptation but it is a source of bugs.  Please move these declarations
to a header which gets included in both the file where they are
defined and the file where they are used.

> +	ciab.cra = (ciab.cra & 0xc0) | 0x08;
> +	ciab.icr;
> +	wmb();
> +	ciab.talo = 0;
> +	wmb();
> +	ciab.tahi = 0x80;
> +	wmb();

What the heck is this?  Is this some sort of access to an I/O device?
Are you assuming a 1-1 virtual<->physical mapping to make this work?
This looks to me like it should be using some of the in/out macros
instead of explicitly putting in wmb.

The other patches all look fine to me.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
