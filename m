MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: Compiling assembler file with ppc_405-gcc
Date: Mon, 14 Jun 2004 12:15:06 +0100
Message-ID: <85E6ED5B5EC32F439702305CC417E12D9E2A7D@email.3il.fr>
From: =?Windows-1252?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <John.Kerl@Avnet.com>, <wd@denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I tried a lot of things this morning but my problem remains in a different way.
With your help I decided to do this:

Changes:
========
  --> I renamed my assembler file ppcsiafn.s with ppcsiafn.S and I reported it in my Makefile
  --> I have susppressed a lot ok compilation option and now I only have:
      CFLAGS_AS = -gdwarf -mcpu=405 -nostdinc -Wall -D__KERNEL__
                  -D__ASSEMBLY__ $(ALLINCLUDE) -O0
      [ALLINCLUDE contains the paths that I need]
  --> I've included in this file:
         #include <linux/config.h>
         #include <asm/processor.h>
         #include <asm/cache.h>
         #include <asm-ppc/ppc_asm.h>
         #include "ppcbslit.h"

         [ppcbslit.h is a file which is supposed to contain a lot of #define
          that I need in many files of my project. At the beggining of this
          file, I have included:
              #include <stdio.h>
              #include <string.h>
              #include <sys/types.h>
              #include <sys/stat.h>
              #include <fcntl.h>
              #include <sys/ioctl.h>
              #include <unistd.h>
              #include <linux/ctype.h>                      ]

Results:
========
   --> I don't know why but the #include of my assembler file are now
       considered (a compilation option maybe... -x assembler??)
   --> But now there is the following problem ; I got hundreds of errors.
       I report below a little part of them:
/opt/hardhat/devkit/ppc/405/target/usr/include/stdio.h: Assembler messages:
/opt/hardhat/devkit/ppc/405/target/usr/include/stdio.h:30: Error: Unrecognized opcode: `__begin_decls'
/home/jgarcia/Desktop/kernel/ssc/StdLib/local/stddef.h:201: Error: Unrecognized opcode: `typedef'
/opt/hardhat/devkit/ppc/405/target/usr/include/bits/stat.h:38: Error: Unrecognized opcode: `__dev_t'
/home/jgarcia/Desktop/kernel/ssc/basic/services/include/ppcbslit.h:164: Error: Unrecognized opcode: `int'
/opt/hardhat/devkit/ppc/405/target/usr/include/unistd.h:688: Error: Unrecognized opcode: `extern'

  --> I found a way to prevent those errors... I put all my #define that I need in my assembler file. But you'll understand that it's a very restrictive way of programming and I'd like to find a better solution cause I'm talkin' about a hundred of #define...so...


One more time tks a lot for helping the newbie that I am !



> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Kerl,
> John
> Sent: Friday, June 11, 2004 9:44 AM
> To: Garcia Jérémie; linuxppc-embedded@lists.linuxppc.org
> Subject: RE: Compiling assembler file with ppc_405-gcc
>
>
>
> Unsupported relocation against r6 means, the assembler expects
> a bare "6" & needs the #define r6 6.  This is in ppc_asm.tmpl,
> included by ppc_asm.h, which you have.
>
> The file extension should be .S, not .s.
>
> Here is what I use:
>
> *     .S file has #include "ppc_asm.h"
> *     Assemble command is
>       ppc_8xx-gcc -c -D__ASSEMBLY__
> -I/path/to/arch/ppc/kernel whatever.S
>
>
> > -----Original Message-----
> > From: owner-linuxppc-embedded@lists.linuxppc.org
> > [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On
> Behalf Of Garcia
> > Jérémie
> > Sent: Friday, June 11, 2004 9:28 AM
> > To: linuxppc-embedded@lists.linuxppc.org
> > Subject: Compiling assembler file with ppc_405-gcc
> >
> >
> >
> > Hi everybody,
> > although I'm a newbie in Linux developement and even more in
> > LinuxPPC development, I have to work on a Linux PPC assembler
> > based application.
> > In order to achieve this, I need to compile an assembler file
> > (ppcsiafn.s) which now gives nightmares ...
> > Below this line you can dicover this file:
> >
> > >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>
> > /*DESCRIPTION
> > This module contains chip-dependent routines written in
> > assembly language.
> > */
> >
> > #include <linux/config.h>
> > #include <asm/processor.h>
> > #include <asm/cache.h>
> > #include <asm-ppc/ppc_asm.h>
> >
> > #define _ASMLANGUAGE
> >
> > .globl sidma_AsDmaRegSet_F
> > .globl sidma_AsDmaRegGet_F
> > .globl AsfnDmapolGet
> > [etc...  ]
> >
> > .text
> >
> > /*************************************************************
> > ******************
> > * sidmai_AsDmaRegSet_F(reg, val) --> Set specified "reg" with
> > value "val"
> > *
> > * Return : N/A
> > *
> > * void sidma_AsDmaRegSet_F(uLong reg, uLong val)
> > */
> > sidma_AsDmaRegSet_F:
> >        mflr r5
> >        bl next_inst
> >        next_inst:
> >        mflr r6
> >       add r6,r6,r3
> >       addi r6,r6,20
> >
> > [etc...  ]
> >
> > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> > <<<<<<<<<<<<<<<<<<
> >
> > To compile this, I use the following lines in a makefile:
> > >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> > >>>>>>>>>>
> > AS = ppc_405-gcc
> > CFLAGS_AS = -gdwarf -mcpu=405 -mstrict-align -nostdinc
> > -fvolatile -fno-builtin -fno-for-scope -P -x assembler -
> > D__KERNEL__ -DCPU=PPC405 -DPRJ_BUILD $(ALLINCLUDE)
> > -I$(SRC_PATH)/basic/services/include
> > -I$(SRC_PATH)/basic/ascii/include
> > -I$(SRC_PATH)/basic/hdwctl/include
> > -I$(SRC_PATH)/basic/core/include
> > -I$(SRC_PATH)/basic/hscx/include
> > -I$(SRC_PATH)/basic/enet/include -I$(SRC_PATH)/eq/include
> > -I$(SRC_PATH)/pzm/include -I$(SRC_PATH)/startup/init
> > -I$(SRC_PATH)/startup/maint -O0 -DEQ_CODE
> > ppcsiafn.o:
> >       $(AS) $(CFLAGS_AS) -c
> > $(SRC_PATH)/startup/init/ppcsiafn.s -o ppcsiafn.o
> >
> > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> > <<<<<<<<<
> >
> > nb: don't worry the CFLAGS_AS is on a single line in my makefile
> >
> > All that things to get the following compilation result:
> > >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> > >>>>>>>>>
> > $> make all
> > /home/jgarcia/Desktop/kernel/ssc/startup/init/ppcsiafn.s:
> > Assembler messages:
> > /home/jgarcia/Desktop/kernel/ssc/startup/init/ppcsiafn.s:83:
> > Error: unsupported relocation against r5
> > /home/jgarcia/Desktop/kernel/ssc/startup/init/ppcsiafn.s:86:
> > Error: unsupported relocation against r6
> > /home/jgarcia/Desktop/kernel/ssc/startup/init/ppcsiafn.s:87:
> > Error: unsupported relocation against r6
> > /home/jgarcia/Desktop/kernel/ssc/startup/init/ppcsiafn.s:87:
> > Error: unsupported relocation against r6
> > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> > <<<<<<<<<<
> >
> > After a lot of tests, here are my conclusions: the different
> > "#include" are not considered by the compiler. Indeed, I
> > tried to introduce compilation errors in the different ".h"
> > files --> no difference in the result
> > If I suppress the # in the #include --> the compiler tells me
> > that is not a valid op code
> > So I guess that but I don't know why : the character "#" is
> > understood as a comment (equivalent to /* ...*/).
> >
> > To conclude : is there a specific compil option to give to
> > gcc for it to understand the #include command?
> > I checked the different linux assembler file and the #include
> > is used. So why am I not able to use it?
> >
> > Thanks for your help !
> >
> >
> >   Jérémie
> >
> >
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
