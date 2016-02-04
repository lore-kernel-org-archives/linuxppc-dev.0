Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E6551A0964
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 22:02:29 +1100 (AEDT)
Date: Thu, 4 Feb 2016 12:02:24 +0100
From: Petr Mladek <pmladek@suse.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Torsten Duwe <duwe@lst.de>, Jiri Kosina <jikos@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 1/9] ppc64 (le): prepare for -mprofile-kernel
Message-ID: <20160204110224.GD731@pathway.suse.cz>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170723.D2CCE692CE@newverein.lst.de>
 <56B1AAE5.10500@linaro.org>
 <alpine.LNX.2.00.1602030952220.22727@cbobk.fhfr.pm>
 <20160203112449.GA27247@lst.de> <56B31A7C.2050803@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B31A7C.2050803@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 2016-02-04 18:31:40, AKASHI Takahiro wrote:
> Jiri, Torsten
> 
> Thank you for your explanation.
> 
> On 02/03/2016 08:24 PM, Torsten Duwe wrote:
> >On Wed, Feb 03, 2016 at 09:55:11AM +0100, Jiri Kosina wrote:
> >>On Wed, 3 Feb 2016, AKASHI Takahiro wrote:
> >>>those efforts, we are proposing[1] a new *generic* gcc option, -fprolog-add=N.
> >>>This option will insert N nop instructions at the beginning of each function.
> >
> >>The interesting part of the story with ppc64 is that you indeed want to
> >>create the callsite before the *most* of the prologue, but not really :)
> >
> >I was silently assuming that GCC would do this right on ppc64le; add the NOPs
> >right after the TOC load. Or after TOC load and LR save? ...
> 
> On arm/arm64, link register must be saved before any function call. So anyhow
> we will have to add something, 3 instructions at the minimum, like:
>    save lr
>    branch _mcount
>    restore lr
>    <prologue>
>    ...
>    <body>
>    ...

So, it is similar to PPC that has to handle LR as well.


> >>The part of the prologue where TOC pointer is saved needs to happen before
> >>the fentry/profiling call.
> >
> >Yes, any call, to any profiler/tracer/live patcher is potentially global
> >and needs the _new_ TOC value.

The code below is generated for PPC64LE with -mprofile-kernel using:

$> gcc --version
gcc (SUSE Linux) 6.0.0 20160121 (experimental) [trunk revision 232670]
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


0000000000000050 <cmdline_proc_show>:
  50:   00 00 4c 3c     addis   r2,r12,0
                        50: R_PPC64_REL16_HA    .TOC.
  54:   00 00 42 38     addi    r2,r2,0
                        54: R_PPC64_REL16_LO    .TOC.+0x4
  58:   a6 02 08 7c     mflr    r0
  5c:   01 00 00 48     bl      5c <cmdline_proc_show+0xc>
                        5c: R_PPC64_REL24       _mcount
  60:   a6 02 08 7c     mflr    r0
  64:   10 00 01 f8     std     r0,16(r1)
  68:   a1 ff 21 f8     stdu    r1,-96(r1)
  6c:   00 00 22 3d     addis   r9,r2,0
                        6c: R_PPC64_TOC16_HA    .toc
  70:   00 00 82 3c     addis   r4,r2,0
                        70: R_PPC64_TOC16_HA    .rodata.str1.8
  74:   00 00 29 e9     ld      r9,0(r9)
                        74: R_PPC64_TOC16_LO_DS .toc
  78:   00 00 84 38     addi    r4,r4,0
                        78: R_PPC64_TOC16_LO    .rodata.str1.8
  7c:   00 00 a9 e8     ld      r5,0(r9)
  80:   01 00 00 48     bl      80 <cmdline_proc_show+0x30>
                        80: R_PPC64_REL24       seq_printf
  84:   00 00 00 60     nop
  88:   00 00 60 38     li      r3,0
  8c:   60 00 21 38     addi    r1,r1,96
  90:   10 00 01 e8     ld      r0,16(r1)
  94:   a6 03 08 7c     mtlr    r0
  98:   20 00 80 4e     blr


And the same function compiled using:

$> gcc --version
gcc (SUSE Linux) 4.8.5
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


0000000000000050 <cmdline_proc_show>:
  50:   00 00 4c 3c     addis   r2,r12,0
                        50: R_PPC64_REL16_HA    .TOC.
  54:   00 00 42 38     addi    r2,r2,0
                        54: R_PPC64_REL16_LO    .TOC.+0x4
  58:   a6 02 08 7c     mflr    r0
  5c:   10 00 01 f8     std     r0,16(r1)
  60:   01 00 00 48     bl      60 <cmdline_proc_show+0x10>
                        60: R_PPC64_REL24       _mcount
  64:   a6 02 08 7c     mflr    r0
  68:   10 00 01 f8     std     r0,16(r1)
  6c:   a1 ff 21 f8     stdu    r1,-96(r1)
  70:   00 00 42 3d     addis   r10,r2,0
                        70: R_PPC64_TOC16_HA    .toc
  74:   00 00 82 3c     addis   r4,r2,0
                        74: R_PPC64_TOC16_HA    .rodata.str1.8
  78:   00 00 2a e9     ld      r9,0(r10)
                        78: R_PPC64_TOC16_LO_DS .toc
  7c:   00 00 84 38     addi    r4,r4,0
                        7c: R_PPC64_TOC16_LO    .rodata.str1.8
  80:   00 00 a9 e8     ld      r5,0(r9)
  84:   01 00 00 48     bl      84 <cmdline_proc_show+0x34>
                        84: R_PPC64_REL24       seq_printf
  88:   00 00 00 60     nop
  8c:   00 00 60 38     li      r3,0
  90:   60 00 21 38     addi    r1,r1,96
  94:   10 00 01 e8     ld      r0,16(r1)
  98:   a6 03 08 7c     mtlr    r0
  9c:   20 00 80 4e     blr


Please, note that are used either 3 or 4 instructions before the
mcount location depending on the compiler version.

Best Regards,
Petr
