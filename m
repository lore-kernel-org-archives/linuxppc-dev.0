To: Ruedi.Hofer@ascom.ch
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA support for 860
References: <0FSF00NFMHXF1M@pmdf-it.hasler.ascom.ch>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 03 Apr 2000 19:01:10 +0200
In-Reply-To: Ruedi.Hofer@ascom.ch's message of "Mon, 03 Apr 2000 08:55:29 +0100 (CED)"
Message-ID: <kfypus7w23t.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi.Hofer@ascom.ch writes:

> In the february mailing list I found the PCMCIA patch from Magnus Damm. It looks
> very interesting and useful.
> >From reading the 'Kernel modification' list I assume that I need some help.
>
> Extract from Mail http://lists.linuxppc.org/listarcs/linuxppc-embedded/200002/msg00093.html:
>
> > 1. First of all you need to ioremap 64KByte at _IO_BASE.
> >    This is for the emulated ISA-bus.
> >    VIRT must be PHYS and I don't know how to do that
> >    from a module.

Hi,

diff -u -b -u -r1.3 -r1.4
--- include/asm-ppc/mpc8xx.h	2000/01/31 16:37:46	1.3
+++ include/asm-ppc/mpc8xx.h	2000/02/28 16:12:36	1.4
@@ -53,7 +53,8 @@
 #define	_ISA_MEM_BASE PCI_ISA_MEM_ADDR
 #define PCI_DRAM_OFFSET 0x80000000
 #else
-#define _IO_BASE        0
+#define _IO_BASE	0xf4000000
+#define _IO_BASE_SIZE	0x10000
 #define _ISA_MEM_BASE   0
 #define PCI_DRAM_OFFSET 0
 #endif

Then just add:

#ifdef _IO_BASE_SIZE
        ioremap(_IO_BASE, _IO_BASE_SIZE);
#endif

together with the other ioremap()s in arch/ppc/mm/init.c.

> > 2. All bus operations that are 16 bit or more should be
> >    big endian - no swapping. This is the same as APUS in io.h.
> >    We need to figure out how this should co-exist with
> >    the swapped ISA.

This proved to be wrong, and is not necessary.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
