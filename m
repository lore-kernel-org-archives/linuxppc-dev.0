From: miguel.valero@axxessit.no
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Has anybody successfuly run linux-2.6.8-rc2 (or any previous linu	x 2.6
 version) on MPC 82xx ?
Message-ID: <OFBB492AC9.7E084E02-ONC1256EE7.0036A679@axxessit.no>
Date: Thu, 5 Aug 2004 12:04:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have linux-2.6.7 running on both MPC8265 and MPC8280 based custom
boards.

Firstly, I think your problem may be that the u-boot overwrites the linux
image file during decompression, because it is placed too low in memory
(0x200000).
Try first to set your u-boot environment loadaddr higher.

0x400000 works fine for linux-2.6.7, but another thing I see is that your
linux image file is rather large (190c52 hex). My linux-2.6.7 uImage file is f10e9 hex, quite smaller.
Has linux-2.6.8 grown so much ? or are you making the wrong image ? You
should make uImage, I guess you are aware of that.

Miguel





"Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Sent by: owner-linuxppc-embedded@lists.linuxppc.org
05.08.04 10:39


        To:     "'linuxppc-embedded@lists.linuxppc.org'"
<linuxppc-embedded@lists.linuxppc.org>
        cc:     "'mcclintock@freescale.com'" <mcclintock@freescale.com>
        Subject:        Has anybody successfuly run linux-2.6.8-rc2 (or any previous linu       x
2.6 version) on MPC 82xx ?



Hello,

I have been told that the first linux 2.6 version, which should work on
MPC
82xx is linux-6.8-rc2 ...?
So I have cross-compiled "vanilla" linux-2.6.8-rc2 (using Cygwin with
quite
a few patches from Dan Kegel , Martin Schaffner and others to make
cross-compiling work - except for netfilter code, which doesn't
cross-compile on Cygwin and needs to be disabled, which I did) for ppc,
82xx
and created uimage (used mkimage tool from u-boot-1.1.1, which I have
built
also on Cygwin with the latest Yuli Barcohen's patch). I have loaded this
uimage onto PQ2 ADS witn MPC8270 (U-Boot version loaded on the PQ2 ADS
flash
is still 1.0.0.) and tried to run it with "bootm" - but it fails (resets)
immediately after decompressing the image ... and I do not have 82xx
back-end Jtag probe/debugger available to me to see what is happening...

U-Boot 1.0.0 (Jan 30 2004 - 16:09:23)
=> tftpboot 200000 uimagenfs
TFTP from server 172.16.240.200; our IP address is 172.16.119.3
Filename 'uimagenfs'.
Load address: 0x200000
Loading: T
#################################################################
         #################################################################
         #################################################################
         #################################################################
         #############################################################
done
Bytes transferred = 1641554 (190c52 hex)
=>bootm

Has anybody successfuly run linux-2.6.8-rc2 (or previous linux 2.6
version)
on MPC 82xx ?
If so, could you share with me ".config" file used ?

On another more general subject - does Freescale (former Motorola) has a
single focal point person who's charter is to promote Linux board support
on
Motorola development boards (aka Linux czar) - do you have his contact
info
?

I know that there were Linux OS Development Breakout Sessions SNDF (Smart
Networks Developer Forum ) April,  2004 Dallas
http://www.freescale.com/webapp/sps/site/overview.jsp?nodeId=02VS0llCc5pzMP5
51361587974
So somebody should stand behind Linux development activity  at  Freescale/
Motorola (both IBM and HP do have dedicated Linux Labs and people working
strictly on Linux ...) I guess ...

Thanks,
Best Regards,
Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
