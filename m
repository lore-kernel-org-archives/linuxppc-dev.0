Mime-Version: 1.0
Message-Id: <a04320401b7793c091c88@[192.168.10.144]>
Date: Tue, 17 Jul 2001 10:24:59 +0900
To: linuxppc-embedded@lists.linuxppc.org
From: Masahide Tomita <tomita@itl.nyc.co.jp>
Subject: How do I configure kernel for my custom board?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm trying to port the kernel to our custom board, but I can't figure how I
configure the kernel.
I'm using VineLinux (Japanese use oriented version based on RedHat) for
development, and HardHatLinux CDK 1.2 for the target.
Target board has MPC860T and LevelOne 971 Ether port, and some other
devices (which I don't intend to use).

What I tried was:

Install CDK for MBX board (we have MBX860 for reference use)

Made a copy of directory /opt/hardhat/devkit/lsp/mbx8xx as
/opt/hardhat/devkit/lsp/custom.
Made a copy of directory
/opt/hardhat/devkit/lsp/mbx8xx/linux-2.2.14/arch/ppc/mbxboot as
/opt/hardhat/devkit/lsp/custom/linux-2.2.14/arch/ppc/customboot.

In directory ~/custom/linux-2.2.14/ I did
# make config
and I cut almost every options other than Ethernet.

And in the .config file, I added a config option CONFIG_CUSTOM.

After this, if I run "make oldconfig" to use the setup, it stops at
board_configration, and keep asking me "Power_Macintosh? (NEW)".
This is one thing I would like to know that how to add custom board to the
list in configuration procedure.


Ignoring the message (since I already have .config file), I tried to make
kernel.
The another problem is that when I typed "make zImage", I get error message
like below and stop:

fec.c: In function `mii_discover_phy3':
fec.c:666: warning: implicit declaration of function `mii_startup_cmds'
fec.c: In function `mii_discover_phy':
fec.c:672: warning: unused variable `prev_duplex'
fec.c: At top level:
fec.c:691: warning: `mii_startup_cmds' was declared implicitly `extern' and
later `static'
fec.c:666: warning: previous declaration of `mii_startup_cmds'
fec.c:691: warning: type mismatch with previous implicit declaration
fec.c:666: warning: previous implicit declaration of `mii_startup_cmds'
fec.c:691: warning: `mii_startup_cmds' was previously implicitly declared
to return `int'
fec.c: In function `fec_enet_init':
fec.c:1028: structure has no member named `bi_enetaddr'
fec.c:1104: `FEC_INTERRUPT' undeclared (first use in this function)
fec.c:1104: (Each undeclared identifier is reported only once
fec.c:1104: for each function it appears in.)
fec.c: In function `restart_fec':
fec.c:1157: warning: function declaration isn't a prototype
fec.c:1179: `FEC_INTERRUPT' undeclared (first use in this function)
fec.c: At top level:
fec.c:866: warning: `mii_link_interrupt' defined but not used
make[2]: *** [fec.o] error 1
make[1]: *** [first_rule] error 2
make: *** [_dir_arch/ppc/8xx_io] error 2

I'm assuming this file "fec.c" is not working correctly because I choose
Ether on SCC and AMD 971 chip simultaneously.

Maybe I should just edit fec.c referencing fcc_enet.c, but I'm not sure if
I got valid configuration file first, and editing file like fec.c is normal
way to customize the kernel.

Sorry for the messy question, but I'm really messed up.
Thank you for any comment or help, in advance.


--
Masahide Tomita
Engineer
Information Technology Lab.
NAKAYO Telecommunications, INC.
PHONE:+81-3-3414-3321
mailto:tomita@itl.nyc.co.jp

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
