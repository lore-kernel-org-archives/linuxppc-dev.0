Message-ID: <39D0F7EB.C0415571@relog.ch>
Date: Tue, 26 Sep 2000 21:24:27 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: rshapiro@bbn.com
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
References: <14798.23332.833379.615321@esb.bbn.com>
	 <Pine.LNX.4.10.10009251101410.28773-100000@opal.biophys.uni-duesseldorf.de> <14800.62277.193434.173634@esb.bbn.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


R Shapiro wrote:
>
> Michael Schmitz writes:
>  > > 3.  On the same machine, the ati driver I built yesterday hoses linux
>  > > completely and doesn't leave a core file.
>  >
>  > Does the X server complain about PCI resource conflicts when run as X
>  > --probeonly? Anything about PCI problems in the server log?
>
> "startx -- -probeonly" also crashes linux when the ati drivers are
> selected.
>
> Here's the log, which ends somewhat abruptly.

[...]

> (--) PCI: (0:13:0) ATI Mach64 GI rev 92, Mem @ 0x84000000/24, 0x81801000/12, I/O @ 0x0400/8
> (--) PCI: (0:15:0) ATI Mach64 GI rev 92, Mem @ 0x83000000/24, 0x81800000/12, I/O @ 0x0400/8
> (--) PCI: (0:18:0) ATI Mach64 GT rev 154, Mem @ 0x82000000/24, I/O @ 0x0400/8

[...]

> (--) ATI(0): VideoRam: 1 kByte (EDO)

That's quite little VRAM :)

Do you have an atyfb for each head? If so, try also passing the "fbdev" option
with the devices for the ati driver.


> The final two lines reject the two modes I generated with fbset.  Both are
> considered ok by the fbdev driver.

[...]

> (II) ATI(0): Maximum clock: 120.00 MHz
> (WW) ATI(0): Mode "1152x870" deleted (bad mode clock/interlace/doublescan)
> (WW) ATI(0): Mode "1280x1024" deleted (bad mode clock/interlace/doublescan)

Are the modes below 120 MHz? Have you tried uncommenting your mode definitions
so that is uses internal modes?


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
