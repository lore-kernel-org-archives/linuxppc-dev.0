MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16113.6008.29477.779178@cargo.ozlabs.ibm.com>
Date: Thu, 19 Jun 2003 11:52:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] 2.4.21 fixes
In-Reply-To: <Pine.GSO.4.21.0306141056270.14234-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0306141056270.14234-100000@vervain.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven writes:

>   - arch/ppc/kernel/checks.c: Kill warning about undeclared printf() by
>     including <stdio.h> _after_ all other includes (including it first doesn't
>     work)

checks.c is broken for cross-compiling anyway, I would rather just
remove it.

>   - arch/ppc/kernel/open_pic.c: Kill warning about unused openpic_reset(). An
>     alternative is to add an #ifdef, but since it's never used before its
>     definition, just removing the forward declaration looks better to me

OK.

>   - arch/ppc/kernel/ppc_ksyms.c, arch/ppc/kernel/setup.c: Define and export
>     screen_info unconditionally, so vga16fb can be built as a module. An
>     alternative is to make the definition dependent on CONFIG_FB_VGA16 ||
>     CONFIG_FB_VGA16_MODULE, and the export on CONFIG_FB_VGA16_MODULE, but this
>     is ugly.
>
>     Another reason is that screen_info is referenced in
>     arch/ppc/platforms/prep_setup.c on the following (complex) condition:
>
>     #if defined(CONFIG_PREP_RESIDUAL) && \
>         (defined(CONFIG_FB_VGA16) || defined(CONFIG_FB_VGA_16_MODULE) || \
> 	         defined(CONFIG_FB_VESA))
>
>     which causes a link failure with the current code, too. The alternative
>     #ifdef solution would clutter this even more...

I think we could make this depend on CONFIG_FB.  I don't think we want
to make it depend on CONFIG_FB_VGA_16_MODULE since that would mean
that you couldn't set CONFIG_FB_VGA_16=m and make a module that would
work with an existing kernel that had been compiled with
CONFIG_FB_VGA_16=n.  The screen_info structure is only 52 bytes so
it's not that big a deal to have it always included if CONFIG_FB=y.

>   - include/asm-ppc/posix_types.h: Kill warning about incorrect printf()-style
>     format in the ext2 code by making __kernel_ino_t unsigned long, like on
>     most other architectures.

Yes, good idea.

I'll send this stuff to Marcelo in due course.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
