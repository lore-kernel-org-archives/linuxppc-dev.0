From: Ruedi.Hofer@ascom.ch
Date: Thu, 06 Apr 2000 11:39:11 +0100 (CED)
Subject: Re: PCMCIA support for 860
To: linuxppc-embedded@lists.linuxppc.org
Cc: erammsu@kieraypc01.p.y.ki.era.ericsson.se, kernel@linux01.hasler.ascom.ch
Message-id: <0FSL00IBF9IGAS@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_WgAPYk5icVxAuolE+F/a7Q)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_WgAPYk5icVxAuolE+F/a7Q)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

Kernel boot problem:
Obviousely the kernel was too large. When reduce its size and put some
extensions into modules, it starts up fine.

But there are 2 other problems:

Ethernet Card:

- When I insert a Xircom Ethernet card, it is detected and the modules are loaded.
But somehow it affects the NFS connection in such a bad way, that it looses connection
to the server. Everything gets very slow. When I plug the pc card out, NFS works fine again.

>sh-2.03# cardmgr[30]: initializing socket 0
>cardmgr[30]: socket 0: Xircom CE3-10/100 Fast Ethernet
>cardmgr[30]: executing: 'insmod /lib/modules/2.2.13/pcmcia/xirc2ps_cs.o'
>xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)
>eth1: Xircom: port 0x300, irq 9, hwaddr 00:80:C7:86:E4:DF
>cardmgr[30]: executing: './network start eth1'
>sh-2.03# eth1: media 10BaseT, silicon revision 7
>sh-2.03# cardmgr[30]: + SIOCADDRT: File exists
>sh-2.03# lsmod
>nfs: server 10.1.20.2 not responding, still trying
>nfs: task 1574 can't get a request slot

I guess that too many interrupts knock the system out.

ATA Flash card:

- Even worse with the flash card: The system crashes!

>sh-2.03# cardmgr[42]: initializing socket 0
>cardmgr[42]: socket 0: ATA/IDE Fixed Disk
>cardmgr[42]: executing: 'insmod /lib/modules/2.2.13/pcmcia/ide_cs.o'
>hda: SunDisk SDP3B-40, ATA DISK drive
>Kernel panic: request_irq
>Rebooting in 180 seconds..

- Is the request_irq related to the loaded module or to the IDE stuff in the kernel?
  ('Configure IDE for ATA on PCMCIA' is switched off!)
- Is it right that every occurence of request_irq has to replaced with request_8xxirq?

Ruedi


--Boundary_(ID_WgAPYk5icVxAuolE+F/a7Q)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
