Date: Wed, 23 Aug 2000 21:21:18 -0700
From: Daniel Jacobowitz <drow@false.org>
To: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: strange PCI resource behaviour in 2.4
Message-ID: <20000823212118.A18375@false.org>
References: <39A47457.EB8AC497@amberdata.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39A47457.EB8AC497@amberdata.demon.co.uk>; from davidm@amberdata.demon.co.uk on Thu, Aug 24, 2000 at 02:03:19AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 24, 2000 at 02:03:19AM +0100, David Monro wrote:
>
> Hi,
>
> I'm seeing a strange problem with the PCI code on 2.4. What is happening
> is that the PCI code seems to be detecting a memory region on my pcnet32
> chip, but leaving it at 0x0:
>
> prozac:~# lspci -v -vv -s 0c
> 00:0c.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet
> LANCE] (rev 16)
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 15
> 	Region 0: I/O ports at 1000200 [disabled] [size=32]
> 	Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [disabled]
> [size=32]
> 	Expansion ROM at <unassigned> [disabled] [size=64K]
>
> (On a 2.2 kernel, Region 1 and the Expansion ROM simply aren't there,
> presumably bacuse the firmware doesn't enable them.)

How recent a 2.4?  There was a bug very like this in 2.4.0test6
affecting all architectures as far as i know.  It was resolved in the
latest 2.4.0-test7 prepatch.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
