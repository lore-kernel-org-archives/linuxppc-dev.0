From: duncanp@research.canon.com.au
Date: Mon, 1 May 2000 18:02:55 +1000 (EST)
Subject: Re: 8xxrom and fads rom questions.
To: ??? <tachyon@postech.ac.kr>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <009501bfb2c1$304406a0$1952df8d@SOYANG>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Message-Id: <20000501070254.9A4903C960@elph.research.canon.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Cha

On  1 May, ??? wrote:
>
> Hello.
>
> My name is Cha.
>
> I'm a newbie in this area, working on porting of  linuxppc-embedded to
> HD860 board from http://www.headtel.com

Cool.

>
> Since I planned to use 8xxrom-0.3.0 as a bootloader, I read lots of pdf files related to MPC860 and FADS board.
>
> After digging into 8xxrom code, I have many questions as follows.

I've been making a number of changes to 8xxrom recently, and have sent
the patches to Raphael Bossek (the maintainer). Before you go any
further, you should apply these, as they change a lot of things, and
hopefully make it a bit easier to port 8xxrom to new boards. The patches
are at:
http://www.s4l.de/duncan-patch.build.gz
http://www.s4l.de/duncan-patch.cllf.gz

Read the mail I sent Raphael before applying the patches:
http://www.s4l.de/duncan-20000413.mail


>
> --- Questions START.
> 1. What's the baud rate and serial port configurations of 8xxrom?

The baud rate is hard-coded to 9600 at the moment in m8xx/serial.c . The
serial port can be either SMC1 or SMC2 and this is defined config.h .

>
> 2. What's the meaning of ROMLOAD and DATA macros inf 8xxrom-0.3.0/Make.config

These are used for producing the various images the the bootloader.
Basically, ROMLOAD is the physical address the bootloader image is
loaded at. So, for example, if you are programming the image into flash
over BDM, and flash is mapped to the address 0xfe000000, and you are
booting from the start of flash, then ROMLOAD would be set to
0xfe000000. If you are removing your flash devices and programming them
with a flash programmer, the value of ROMLOAD does not matter. DATA is
the address (typically in RAM) that 8xxrom relocates itself to once it
has started running.

>
> 3. If ROMLOAD is base address of Flash ROM of FADS board why the value is
> 0xFE000000 neverthless the memory map of FADS board is as follows:
>
> /* Memory map of FADS board from FADS user's manual
> 0x00000000 ~ : DRAM SIMM
> 0x02000000 ~ : Empty Space
> 0x02100000 ~ : BCSR~
> 0x02108000 ~ : Empty Space
> 0x02200000 ~ : MPC Internal MAP
> 0x02208000 ~ : Empty Space
> 0x02800000 ~ : Flash SIMM
> 0x03000000 ~ : SDRAM
> 0x03400000 ~ 0xFFFFFFFF : Empty Space
> */

The MAP in the FADS user manual is just an example - it can be set to
whatever you like by programming the ORx adn BRx registers, and the
IMMR in the case of the internal map. So, 8xxrom sets flash to appear
at 0xfe000000.

>
> 4. I've found the sequence of image converting process is like that:
>
> /* Image converting sequence of 8xxrom from Makefile
> ---> 8xxrom -> 8xxrom.elf -> 8xxrom.elf.s19
>               |
>                `----> 8xxrom.bin -> 8xxrom.bin.s19
> */
>
> What's the difference between 8xxrom and 8xxrom.elf? (the disassemble result is same)

8xxrom.elf is and elf image (it has an elf header attached), and also
has been munged by objcopy according to the arguments 'OBJCPARAM' in
Make.config .

> What's the difference between 8xxrom.bin and 8xxrom.elf?

8xxrom.bin is a binary image - that is, there is no elf header, or .bss
sections.

> Is bintos19 different from "powerpc-linux-objcopy -O srec" command?

Apparently so, although i'm not sure how off the top of my head

> Is mkrombin different from "powerpc-linux-objcopy -O binary" command?

Again, not sure

In case like me you were a bit confused about different object file
formats, sections and stuff, having a read of the GAS (GNU assembler)
documention on www.gnu.org is worthwhile.

Which one of 8xxrom, 8xxrom.elf, 8xxrom.bin and 8xxrom.s19 you will end
up using will depend on the tools you are using to program flash / put
the bootloader on disk or whatever.


>
> 5. Are there any documentation or README file for 8xrom or fads rom?
> --- Questions END.

erm, not really ;), but what you should need to do to get your port
working is:
- add a new build target (CONFIG_something..), and edit board/board.h
to add in all the appropriate defines for that board, and the Makefiles.
- add a new file (something.c) in board/ which contains initialisation
code for the board - see the existing code as an example.
- and thats basically it...

Good luck with your port. Please feel free to ask if you have any more
questions.

Dunk.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
