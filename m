Message-ID: <3CCEA37D.BF5EB743@snom.de>
Date: Tue, 30 Apr 2002 16:00:29 +0200
From: Sven Boehringer <boehringer@snom.de>
Reply-To: boehringer@snom.de
MIME-Version: 1.0
To: "Fend, Matthias" <mfend@harris.com>
Cc: "'Jacky Wang'" <jacky@premierme.com.tw>,
	May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: AW: I need help getting pcmcia working with a FADS board
References: <8D4C69676E66D511A1CB00508BBBB192011C9F03@ranmx1.ran.harris.com>
Content-Type: multipart/mixed;
 boundary="------------2140588A0C068C142A05E56D"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------2140588A0C068C142A05E56D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

i'm still struggling with mpc8xxfads & MPC855T & NE2K-PCMCIA. I patched
the 2.4.18 manually and compiled all the driver options into the kernel
(no modules).

AFAIK the driver doesn't setup the ethernet-device, cause ifconfig eth1
... up says "no such interface".

When i run the "dump_cis" program i get following output:

Socket 0:
  dev_info
    fn_specific 100ns, 16kb
    FLASH 150ns, 60kb
  attr_dev_info
    FLASH 150ns, 4kb
  manfid 0x0149, 0xc1ab
  vers_1 4.1, "Ethernet", "Adapter", "2.0"
  config base 0x0fd0 mask 0x000b last_index 0x06
  cftable_entry 0x00 [default]
    [mwait]
    io 0x0000-0x001f [lines=5] [16bit]
    irq mask 0xbefc [level]
  cftable_entry 0x01
    io 0x0300-0x031f [lines=10] [16bit] [range]
  cftable_entry 0x02
    io 0x0320-0x033f [lines=10] [16bit] [range]
  cftable_entry 0x03
    io 0x0340-0x035f [lines=10] [16bit] [range]
  cftable_entry 0x04
    io 0x0380-0x039f [lines=10] [16bit] [range]
  cftable_entry 0x05
    io 0x0200-0x021f [lines=10] [16bit] [range]
  funcid network_adapter

so far not bad? But when i run "dump_cisreg":

Socket 0 function 0:
  Config register base = 0x0fd0, mask = 0x000b
  read config register: Invalid argument

:-(


Can somebody help me?

Regards,
	Sven


"Fend, Matthias" wrote:
>
> if we talk about  m8xx_pcmcia_kernel-2.4.-19pre6.patch the patch does this:
>
> - add the file m8xx_pcmcia.c into your kernel driver tree ( ...
> /drivers/pcmcia/m8xx_pcmcia.c )
> - add a entry for the new file into Config.in
> - add a entry for the new file into Makefile
>
> thats all
>
> the patch was made from linuxppc_2_4_devel - but you can do these few changes
> manually...
>
> matthias
--------------2140588A0C068C142A05E56D
Content-Type: text/plain; charset=us-ascii;
 name="boot_log_pcmcia_ne2k"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot_log_pcmcia_ne2k"

eth0: FEC ENET Version 0.2, FEC irq 3, MII irq 4, addr 00:04:13:00:00:01
Linux Kernel Card Services 3.1.22
  options:  none
m8xx_pcmcia: Version 0.05, 14-Apr-2002
cs: CardServices(GetCardServicesInfo, 0xc0197f88, 0x00000001)
m8xx_pcmcia: FADS using SLOT_A with IRQ 13.
m8xx_pcmcia: Socket 0: MemWin 0: Base 0xe0000000.
m8xx_pcmcia: Socket 0: MemWin 1: Base 0xe4000000.
m8xx_pcmcia: Socket 0: MemWin 2: Base 0xe8000000.
m8xx_pcmcia: Socket 0: MemWin 3: Base 0xec000000.
m8xx_pcmcia: Socket 0: MemWin 4: Base 0xf0000000.
m8xx_pcmcia: sock_init(0)
m8xx_pcmcia: SetSocket(0, flags 0x000, Vcc 0, Vpp 0, io_irq 0, csc_mask 0x80)
m8xx_pcmcia: SetIOMap(0, 0, 0x00, 0 ns, 0x0000-0x0001)
m8xx_pcmcia: SetIOMap(0, 1, 0x00, 0 ns, 0x0000-0x0001)
m8xx_pcmcia: SetMemMap(0, 0, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR = 0xb8000000.
m8xx_pcmcia: SetMemMap(0, 0, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
m8xx_pcmcia: SetMemMap(0, 1, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
m8xx_pcmcia: Socket 0: Mapped memory window 1 at 0xe4000000, OR = 0xb8000000.
m8xx_pcmcia: SetMemMap(0, 1, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
m8xx_pcmcia: SetMemMap(0, 2, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
m8xx_pcmcia: Socket 0: Mapped memory window 2 at 0xe8000000, OR = 0xb8000000.
m8xx_pcmcia: SetMemMap(0, 2, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
m8xx_pcmcia: SetMemMap(0, 3, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
m8xx_pcmcia: Socket 0: Mapped memory window 3 at 0xec000000, OR = 0xb8000000.
m8xx_pcmcia: SetMemMap(0, 3, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
m8xx_pcmcia: SetMemMap(0, 4, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
m8xx_pcmcia: Socket 0: Mapped memory window 4 at 0xf0000000, OR = 0xb8000000.
m8xx_pcmcia: SetMemMap(0, 4, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
pcnet_cs.c 1.144 2001/11/07 04:06:56 (David Hinds)
cs: CardServices(GetCardServicesInfo, 0xc0197f98, 0x00000001)
After calling CardServices: 0
ds: register_pccard_driver('pcnet_cs')
After calling return_register: 0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
IP-Config: Complete:
      device=eth0, addr=192.168.0.18, mask=255.255.255.0, gw=192.168.0.1,
     host=fads, domain=, nis-domain=intern.snom.de,
     bootserver=192.168.0.9, rootserver=192.168.0.44, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds.c 1.112 2001/10/13 00:08:28 (David Hinds)
m8xx_pcmcia: GetStatus(0) = 0xb1
m8xx_pcmcia: GetStatus(0) = 0xb1
m8xx_pcmcia: SetSocket(0, flags 0x000, Vcc 50, Vpp 50, io_irq 0, csc_mask 0x80)
m8xx_pcmcia: SetSocket(0, flags 0x240, Vcc 50, Vpp 50, io_irq 0, csc_mask 0x80)
m8xx_pcmcia: SetSocket(0, flags 0x200, Vcc 50, Vpp 50, io_irq 0, csc_mask 0x80)
m8xx_pcmcia: GetStatus(0) = 0x1f0
ds: ds_event(0x000004, 0, 0xc01b1660)


--------------2140588A0C068C142A05E56D--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
