To: Cindy Peters <cinpet@adaptivemicro.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA/IDE transfer rates 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 Aug 2001 10:27:31 CDT."
             <41EDEC3C1B88D51186EB00A0C9CFADF702FA44@AMWMAIL>
Date: Wed, 15 Aug 2001 21:37:52 +0200
Message-Id: <20010815193757.C0F4210CBA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <41EDEC3C1B88D51186EB00A0C9CFADF702FA44@AMWMAIL> you wrote:
>
> Does anyone know approximately what the transfer rates (peak and
> sustainable)  would be for a PCMCIA/IDE hard disk on an MPC823?

As Dan Malek  already  pointed  out,  all  implementations  that  are
available  to  the  public  so  far suffer from the fact that they're
using PIO.

Here some real-world example:

PPCBoot 1.0.4 (Aug  7 2001 - 00:05:44)

CPU:   PPC823EZTnnB2 at 66 MHz: 16 kB I-Cache 8 kB D-Cache
       Watchdog enabled
DRAM:  16 MB
FLASH: 16 MB
KEYBD: Version 1.0
PCMCIA: 5.0V card found: ARGOSY PnPIDE D5
Bus 0: OK
  Device 0: Model: IBM-DKLA-24320 Firm: KL4AA43A Ser#: YD2YD246800
            Type: Hard Disk
            Capacity: 4126.10 MB = 4.0 GB (8452080 x 512)
...
Linux version 2.4.4 (wd@denx.denx.de) (gcc version 2.95.2 19991024 (release)) #2 Tue Aug 7 00:17:59 MEST 2001
...
Card ID: ARGOSY PnPIDE D5
hda: probing with STATUS(0x50) instead of ALTSTATUS(0x00)
hda: IBM-DKLA-24320, ATA DISK drive
ide0 at 0xc7006320-0xc7006327,0xc3006106 on irq 13
hda: 8452080 sectors (4327 MB) w/460KiB Cache, CHS=8944/15/63
Partition check:
 hda: hda1 hda2 hda3 hda4
...
root@fast:/# bonnie -d /mnt -s 250 -m MPC823E
File '/mnt/bonnie.87', size: 262144000
Writing with putc()...done
Rewriting...done
Writing intelligently...done
Reading with getc()...done
Reading intelligently...done
Seeker 1...Seeker 2...Seeker 3...start 'em...done...done...done...
              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
MPC823E   250   534 90.4  3028 68.6  1533 64.4   542 97.6  3316 94.5  45.2  4.5


Note that this is a normal 2.5" disk drive usually used in laptops  -
quite  slow.  You get somewhat better results with a faster 3.5" disk
drive.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"There are three principal ways to lose money: wine, women, and engi-
neers. While the first two are more pleasant, the third is by far the
more certain."                           - Baron Rothschild, ca. 1800

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
