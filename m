Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D658C1A01D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 23:12:29 +1100 (AEDT)
Date: Tue, 2 Feb 2016 13:12:24 +0100
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Torsten Duwe <duwe@lst.de>, Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 8/9] Implement kernel live patching for ppc64le (ABIv2)
Message-ID: <20160202121224.GS3305@pathway.suse.cz>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170804.A11DB692DD@newverein.lst.de>
 <alpine.LNX.2.00.1601261142190.24510@pobox.suse.cz>
 <20160126124853.GL3305@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160126124853.GL3305@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 2016-01-26 13:48:53, Petr Mladek wrote:
> On Tue 2016-01-26 11:50:25, Miroslav Benes wrote:
> > 
> > [ added Petr to CC list ]
> > 
> > On Mon, 25 Jan 2016, Torsten Duwe wrote:
> > 
> > >   * create the appropriate files+functions
> > >     arch/powerpc/include/asm/livepatch.h
> > >         klp_check_compiler_support,
> > >         klp_arch_set_pc
> > >     arch/powerpc/kernel/livepatch.c with a stub for
> > >         klp_write_module_reloc
> > >     This is architecture-independent work in progress.
> > >   * introduce a fixup in arch/powerpc/kernel/entry_64.S
> > >     for local calls that are becoming global due to live patching.
> > >     And of course do the main KLP thing: return to a maybe different
> > >     address, possibly altered by the live patching ftrace op.
> > > 
> > > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > 
> > Hi,
> > 
> > I have a few questions...
> > 
> > We still need Petr's patch from [1] to make livepatch work, right? Could 
> > you, please, add it to this patch set to make it self-sufficient?
> > 
> > Second, what is the situation with mcount prologue between gcc < 6 and 
> > gcc-6? Are there only 12 bytes in gcc-6 prologue? If yes, we need to 
> > change Petr's patch to make it more general and to be able to cope with 
> > different prologues. This is unfortunate. Either way, please mention it 
> > somewhere in a changelog.
> 
> I am going to update the extra patch. There is an idea to detect the
> offset during build by scrips/recordmcount. This tool looks for the
> ftrace locations. The offset should always be a constant that depends
> on the used architecture, compiler, and compiler flags.
> 
> The tool is called post build. We might need to pass the constant
> as a symbol added to the binary. The tool already adds some symbols.

Hmm, the size of the offset is not a constant. In particular, leaf
functions do not set TOC before the mcount location.

For example, the code generated for int_to_scsilun() looks like:


00000000000002d0 <int_to_scsilun>:
 2d0:   a6 02 08 7c     mflr    r0
 2d4:   10 00 01 f8     std     r0,16(r1)
 2d8:   01 00 00 48     bl      2d8 <int_to_scsilun+0x8>
                        2d8: R_PPC64_REL24      _mcount
 2dc:   a6 02 08 7c     mflr    r0
 2e0:   10 00 01 f8     std     r0,16(r1)
 2e4:   e1 ff 21 f8     stdu    r1,-32(r1)
 2e8:   00 00 20 39     li      r9,0
 2ec:   00 00 24 f9     std     r9,0(r4)
 2f0:   04 00 20 39     li      r9,4
 2f4:   a6 03 29 7d     mtctr   r9
 2f8:   00 00 40 39     li      r10,0
 2fc:   02 c2 68 78     rldicl  r8,r3,56,8
 300:   78 23 89 7c     mr      r9,r4
 304:   ee 51 09 7d     stbux   r8,r9,r10
 308:   02 00 4a 39     addi    r10,r10,2
 30c:   01 00 69 98     stb     r3,1(r9)
 310:   02 84 63 78     rldicl  r3,r3,48,16
 314:   e8 ff 00 42     bdnz    2fc <int_to_scsilun+0x2c>
 318:   20 00 21 38     addi    r1,r1,32
 31c:   10 00 01 e8     ld      r0,16(r1)
 320:   a6 03 08 7c     mtlr    r0
 324:   20 00 80 4e     blr
 328:   00 00 00 60     nop
 32c:   00 00 42 60     ori     r2,r2,0


Note that non-leaf functions starts with

0000000000000330 <scsi_set_sense_information>:
 330:   00 00 4c 3c     addis   r2,r12,0
                        330: R_PPC64_REL16_HA   .TOC.
 334:   00 00 42 38     addi    r2,r2,0
                        334: R_PPC64_REL16_LO   .TOC.+0x4
 338:   a6 02 08 7c     mflr    r0
 33c:   10 00 01 f8     std     r0,16(r1)
 340:   01 00 00 48     bl      340 <scsi_set_sense_information+0x10>
                        340: R_PPC64_REL24      _mcount


The above code is generated from kernel-4.5-rc1 sources using

$> gcc --version
gcc (SUSE Linux) 4.8.5
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


But I get similar code also with

$> gcc-6 --version
gcc-6 (SUSE Linux) 6.0.0 20160121 (experimental) [trunk revision 232670]
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.



The result is that kernel crashes when trying to trace leaf function
from modules. The mcount location is replaced with a call (branch)
that does not work without the TOC stuff.

By other words, it seems that the code generated with -mprofile-kernel
option has been buggy in all gcc versions.

I am curious that nobody found this earlier. Do I something wrong,
please?


Best Regards,
Petr
