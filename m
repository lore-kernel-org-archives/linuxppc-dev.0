Message-ID: <005e01bfb36c$5a671c50$1952df8d@SOYANG>
From: "Hyun-Joon Cha" <tachyon@postech.ac.kr>
To: <duncanp@research.canon.com.au>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20000501070254.9A4903C960@elph.research.canon.com.au>
Subject: Re: 8xxrom and fads rom questions.
Date: Mon, 1 May 2000 21:54:13 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you very much for your nice work and careful explanation.

I'm very surprise because of such a fast resonse from this list.

I've started to generate and compile some test code for 8xxrom, but found weird stuff.

So I post this one question for it.

--- A question start.

1. I understood that generally DATA macro is address of RAM start, right?
I've changed it to DATA = 0x20000000 for my 860 board as mem map information is like.

/* HD860II mem map from HD860-UM.pdf
0x00000000 ~ 0x0001ffff : SRAM (CS1)
0x00020000 ~ 0x00200000 : SRAM (CS1)
0xffe00000 ~ 0xffefffff : Flash ROM (CS0)
0xfff00000 ~ 0xfff0ffff : Flash ROM (CS0) -> default OS loader located
0xfff10000 ~ 0xfff1ffff : Flash ROM (CS0)
0xfff20000 ~ 0xffffffff : Flash ROM (CS0)
0x20000000 ~ 0x21000000 : DRAM (CS2)
*/

Address section of the result .s19 file is changed from 0xFFF00000 to 0x1FF00000

/* line 1 to 24 of 8xxrom.elf.s19 for ROMLOAD = 0xFFF00000, DATA = 0x10000 (CONFIG_RPXCLASSIC)
      1 S0110000387878726F6D2E656C662E73313908
      2 S315FFF00000387878524F4D20302E332E3000000000D6
      3 S315FFF0001000000000000000000000000000000000EB
      4 S315FFF0002000000000000000000000000000000000DB
      5 S315FFF0003000000000000000000000000000000000CB
      6 S315FFF0004000000000000000000000000000000000BB
      7 S315FFF0005000000000000000000000000000000000AB
      8 S315FFF00060000000000000000000000000000000009B
      9 S315FFF00070000000000000000000000000000000008B
     10 S315FFF00080000000000000000000000000000000007B
     11 S315FFF00090000000000000000000000000000000006B
     12 S315FFF000A0000000000000000000000000000000005B
     13 S315FFF000B0000000000000000000000000000000004B
     14 S315FFF000C0000000000000000000000000000000003B
     15 S315FFF000D0000000000000000000000000000000002B
     16 S315FFF000E0000000000000000000000000000000001B
     17 S315FFF000F0000000000000000000000000000000000B
     18 S315FFF00100394010027D4001247D5B03A63C20FA2096
     19 S315FFF001107C3E9BA6602130003EA00A007EB08BA6F7
     20 S315FFF001207EB88BA63EA00C007EB08BA67EB88BA6C3
     21 S315FFF001303EA004007EB88BA63EA002007EB08BA642
     22 S315FFF001407C0002E44C00012C3AA000077EBE23A6F9
     23 S315FFF001503AA000007EB523A63C40FFF06042377020
     24 S315FFF001607C5A03A64C0000647C611B787C83237861
*/

/* line 1 to 24, 124 to 147 of 8xxrom.elf.s19 for ROMLOAD = 0xFFF00000, DATA = 0x20000000 (HD860II)
      1 S0110000387878726F6D2E656C662E73313908
      2 S3151FF00000082008000000000077073096EE0E612CDE
      3 S3151FF00010990951BA076DC419706AF48FE963A5354A
      4 S3151FF000209E6495A30EDB883279DCB8A4E0D5E91E71
      5 S3151FF0003097D2D98809B64C2B7EB17CBDE7B82D0770
      6 S3151FF0004090BF1D911DB710646AB020F2F3B97148C5
      7 S3151FF0005084BE41DE1ADAD47D6DDDE4EBF4D4B551FE
      8 S3151FF0006083D385C7136C9856646BA8C0FD62F97A63
      9 S3151FF000708A65C9EC14015C4F63066CD9FA0F3D63B0
     10 S3151FF000808D080DF53B6E20C84C69105ED56041E4B6
     11 S3151FF00090A26771723C03E4D14B04D447D20D85FDA0
     12 S3151FF000A0A50AB56B35B5A8FA42B2986CDBBBC9D6B3
     13 S3151FF000B0ACBCF94032D86CE345DF5C75DCD60DCFAE
     14 S3151FF000C0ABD13D5926D930AC51DE003AC8D7518055
     15 S3151FF000D0BFD0611621B4F4B556B3C423CFBA9599E0
     16 S3151FF000E0B8BDA50F2802B89E5F058808C60CD9B201
     17 S3151FF000F0B10BE9242F6F7C8758684C11C1611DAB7A
     18 S3151FF00100B6662D3D76DC419001DB710698D220BC98
     19 S3151FF00110EFD5102A71B1858906B6B51F9FBFE4A525
     20 S3151FF00120E8B8D4337807C9A20F00F9349609A88E18
     21 S3151FF00130E10E98187F6A0DBB086D3D2D91646C9783
     22 S3151FF00140E6635C016B6B51F41C6C6162856530D89C
     23 S3151FF00150F262004E6C0695ED1B01A57B8208F4C179
     24 S3151FF00160F50FC45765B0D9C612B7E9508BBEB8EABA
...
    124 S3151FF011F000000000000000000000000000000000DA
    125 S3151FF0120000000000000000000000000000000000C9
    126 S3151FF0121000000000000000000000000000000000B9
    127 S3151FF0122000000000000000000000000000000000A9
    128 S3111FF012300000000000000000000000009D
    129 S315FFF00000387878524F4D20302E332E3000000000D6
    130 S315FFF0001000000000000000000000000000000000EB
    131 S315FFF0002000000000000000000000000000000000DB
    132 S315FFF0003000000000000000000000000000000000CB
    133 S315FFF0004000000000000000000000000000000000BB
    134 S315FFF0005000000000000000000000000000000000AB
    135 S315FFF00060000000000000000000000000000000009B
    136 S315FFF00070000000000000000000000000000000008B
    137 S315FFF00080000000000000000000000000000000007B
    138 S315FFF00090000000000000000000000000000000006B
    139 S315FFF000A0000000000000000000000000000000005B
    140 S315FFF000B0000000000000000000000000000000004B
    141 S315FFF000C0000000000000000000000000000000003B
    142 S315FFF000D0000000000000000000000000000000002B
    143 S315FFF000E0000000000000000000000000000000001B
    144 S315FFF000F0000000000000000000000000000000000B
    145 S315FFF00100394010027D4001247D5B03A63C20FA2096
    146 S315FFF001107C3E9BA6602130003EA00A007EB08BA6F7
    147 S315FFF001207EB88BA63EA00C007EB08BA67EB88BA6C3
*/

Address of line 1 to 129 don't match any address of ROMLOAD and DATA.

Why do this happen?

--- A question end.


Again, really thanks to duncan and who have read my messages.

Have a nice day.


----- Original Message -----
From: <duncanp@research.canon.com.au>
To: "???" <tachyon@postech.ac.kr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, May 01, 2000 5:02 PM
Subject: Re: 8xxrom and fads rom questions.


>
> Hi Cha
>
> On  1 May, ??? wrote:
> >
> > Hello.
> >
> > My name is Cha.
> >
> > I'm a newbie in this area, working on porting of  linuxppc-embedded to
> > HD860 board from http://www.headtel.com
>
> Cool.
>
> >
> > Since I planned to use 8xxrom-0.3.0 as a bootloader, I read lots of pdf files related to MPC860 and FADS board.
> >
> > After digging into 8xxrom code, I have many questions as follows.
>
> I've been making a number of changes to 8xxrom recently, and have sent
> the patches to Raphael Bossek (the maintainer). Before you go any
> further, you should apply these, as they change a lot of things, and
> hopefully make it a bit easier to port 8xxrom to new boards. The patches
> are at:
> http://www.s4l.de/duncan-patch.build.gz
> http://www.s4l.de/duncan-patch.cllf.gz
>
> Read the mail I sent Raphael before applying the patches:
> http://www.s4l.de/duncan-20000413.mail
>
>
> >
> > --- Questions START.
> > 1. What's the baud rate and serial port configurations of 8xxrom?
>
> The baud rate is hard-coded to 9600 at the moment in m8xx/serial.c . The
> serial port can be either SMC1 or SMC2 and this is defined config.h .
>
> >
> > 2. What's the meaning of ROMLOAD and DATA macros inf 8xxrom-0.3.0/Make.config
>
> These are used for producing the various images the the bootloader.
> Basically, ROMLOAD is the physical address the bootloader image is
> loaded at. So, for example, if you are programming the image into flash
> over BDM, and flash is mapped to the address 0xfe000000, and you are
> booting from the start of flash, then ROMLOAD would be set to
> 0xfe000000. If you are removing your flash devices and programming them
> with a flash programmer, the value of ROMLOAD does not matter. DATA is
> the address (typically in RAM) that 8xxrom relocates itself to once it
> has started running.
>
> >
> > 3. If ROMLOAD is base address of Flash ROM of FADS board why the value is
> > 0xFE000000 neverthless the memory map of FADS board is as follows:
> >
> > /* Memory map of FADS board from FADS user's manual
> > 0x00000000 ~ : DRAM SIMM
> > 0x02000000 ~ : Empty Space
> > 0x02100000 ~ : BCSR~
> > 0x02108000 ~ : Empty Space
> > 0x02200000 ~ : MPC Internal MAP
> > 0x02208000 ~ : Empty Space
> > 0x02800000 ~ : Flash SIMM
> > 0x03000000 ~ : SDRAM
> > 0x03400000 ~ 0xFFFFFFFF : Empty Space
> > */
>
> The MAP in the FADS user manual is just an example - it can be set to
> whatever you like by programming the ORx adn BRx registers, and the
> IMMR in the case of the internal map. So, 8xxrom sets flash to appear
> at 0xfe000000.
>
> >
> > 4. I've found the sequence of image converting process is like that:
> >
> > /* Image converting sequence of 8xxrom from Makefile
> > ---> 8xxrom -> 8xxrom.elf -> 8xxrom.elf.s19
> >               |
> >                `----> 8xxrom.bin -> 8xxrom.bin.s19
> > */
> >
> > What's the difference between 8xxrom and 8xxrom.elf? (the disassemble result is same)
>
> 8xxrom.elf is and elf image (it has an elf header attached), and also
> has been munged by objcopy according to the arguments 'OBJCPARAM' in
> Make.config .
>
> > What's the difference between 8xxrom.bin and 8xxrom.elf?
>
> 8xxrom.bin is a binary image - that is, there is no elf header, or .bss
> sections.
>
> > Is bintos19 different from "powerpc-linux-objcopy -O srec" command?
>
> Apparently so, although i'm not sure how off the top of my head
>
> > Is mkrombin different from "powerpc-linux-objcopy -O binary" command?
>
> Again, not sure
>
> In case like me you were a bit confused about different object file
> formats, sections and stuff, having a read of the GAS (GNU assembler)
> documention on www.gnu.org is worthwhile.
>
> Which one of 8xxrom, 8xxrom.elf, 8xxrom.bin and 8xxrom.s19 you will end
> up using will depend on the tools you are using to program flash / put
> the bootloader on disk or whatever.
>
>
> >
> > 5. Are there any documentation or README file for 8xrom or fads rom?
> > --- Questions END.
>
> erm, not really ;), but what you should need to do to get your port
> working is:
> - add a new build target (CONFIG_something..), and edit board/board.h
> to add in all the appropriate defines for that board, and the Makefiles.
> - add a new file (something.c) in board/ which contains initialisation
> code for the board - see the existing code as an example.
> - and thats basically it...
>
> Good luck with your port. Please feel free to ask if you have any more
> questions.
>
> Dunk.
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
