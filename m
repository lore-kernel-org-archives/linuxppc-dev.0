Message-ID: <0B0A39652BB0D411BCCF00508B9512EC08AEB42D@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: "'Joe Hamman'" <joe.hamman@embeddedspecialties.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8260 configuration
Date: Mon, 7 Oct 2002 09:39:34 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for your help.

But it seems that commands such as "CF MMU LINUX" etc could not
be recognized as legitimate commands for visionICE2 I am using ?
Is that some kind of add-ons ?

Thanks.

Bo


-----Original Message-----
From: Joe Hamman [mailto:joe.hamman@embeddedspecialties.com]
Sent: Wednesday, October 02, 2002 4:40 PM
To: Yu Bo-BOYU1; 'Flavio Pereira'
Cc: linuxppc embedded
Subject: RE: 8260 configuration


To debug Linux with the visionICE or visionPROBE you need to tell the tool
that the MMU is translating.  Here are the commands I use:

BKM>CF MMU LINUX
BKM>CF MMUA C0000000 0 FF000000

Use the CF MMUL to list the translation table entries in the tool.

Convert the .elf file to generate a symbol file (.ab), set the source path
in the debugger, and you can debug all the code through init().

You can try to get WindRiver to help, but they're not too keen on helping
non-vxWorks customers.

Joe


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Yu
Bo-BOYU1
Sent: Wednesday, October 02, 2002 1:10 PM
To: 'Flavio Pereira'
Cc: linuxppc embedded
Subject: RE: 8260 configuration



Thanks for your info.

I modified est8260.h to map immr to 0xf800_0000. And the serial
port did print out some unreadable stuff and I am very encouraged
by this. My serial port setup is the minimal: 9600/8+1/no parity/no flow.
Is this correct ? After I halt the processor, I read SRR0 register
showing 0xc0153C90. Apparently this is above the 0xc000_0000 that you
indicated. Is that true 0xc000_0000 is the virtual address as we
only have 64M sdram on the board starting 0.

[DOC3 Boot]: @

boot device          : dbg
unit number          : 0
processor number     : 0
host name            : host
file name            : zImage
inet on ethernet (e) : 10.0.0.25:0xffffff00
host inet (h)        : 10.0.0.1
user (u)             : vx
ftp password (pw)    : vx
flags (f)            : 0x0
target name (tn)     : doc3

Attached TCP/IP interface to dbg0.
Attaching network interface lo0... done.
Loading... 619152
Starting at 0x400000...

óÈçô÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷




>BKM>GO
>RUN>
>RUN>halt
>BKM>dr srr0
 SRR0    = C0153C90
>BKM>GO
>RUN>
>RUN>halt
>BKM>dr srr0
 SRR0    = C0153C7C
>BKM>GO
>RUN>
>RUN>


Thanks.
Bo

-----Original Message-----
From: Flavio Pereira [mailto:fpereira@azisa.com]
Sent: Wednesday, October 02, 2002 2:23 AM
To: Yu Bo-BOYU1
Cc: linuxppc embedded
Subject: RE: 8260 configuration


Hi Bo

1. Yes the IMMR needs to be configured at least above 0xC0000000. The
kernel executes code at 0xC0000000, and an IMMR lower that this will
cause the kernel to crash as soon as it starts executing code. I
recommend that you stay with the default value 0xF0000000.

2. The start address is fixed to 0x0

3. ?

4. No, not that I know of.

5. Try getting ELDK from the Denx site. (www.denx.de)



-----Original Message-----
From: Yu Bo-BOYU1 [mailto:Bo.Yu@motorola.com]
Sent: Wednesday, October 02, 2002 3:08 AM
To: linuxppc embedded
Subject: 8260 configuration


I am new to embedded linux but I had good experience in vxWorks.
Right now I had a custom 8260 board with SMC1 connected to serial
port and FCC3 for fast ethernet. I would like to try running linux on
this
custom board. I downloaded the latest monta vista preview kit 2.1
as my base release.

I had boot code ( with vxWorks and it is based on EST8260 bsp) in my
custom
board
already. I decide to download the linux object via tftp. But I have the
following
questions:

1. Do I have to configure IMMR as 0xF0000_0000 or higher. The default
configuration
    in our boot is 0x0F00_0000 ? Is this a hard requirement or not ? If
so,
why can't linux
    init code do so by writing to IMMR+0x101a8 ?

2. How to specify the start address where linux runs when I build the
zImage
?

3. When I make xconfig, what configuration I must have in order to run ?
I
certainly
   do not need VGA/HARD DISK/PCI (this board does not have pci devices).

4. Is there any good website/paper/documentation about linux for 8260
platform.

5. Can anyone access ftp.leo.org to get ELDK ? I can ping it but I
cannot
ftp it today.

Thanks.

Bo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
