Message-ID: <3A92AC4A.3170A586@mvista.com>
Date: Tue, 20 Feb 2001 09:41:30 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Subodh Nijsure <SNijsure@SkyStream.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Getting SanDisk CompactDisk working on linux-ppc.
References: <B25E2E5A003CD311B61E00902778AF2A0148B71D@SERVER1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Subodh Nijsure wrote:
>
> I got m8xx_pcmcia.c to "work" with Linux version 2.4.2-pre3 that
> I got from bitkeeper.

what do mean by "work"?  did you need to make changes to m8xx_pcmcia for
2.4?

> When I say m8xx_pcmcia works, cardctl ident shows it as
> a Sandisk device in socket 0, and dump_cis show me attached info.

that is fine.

> What I would like to do is mount this device as ide drive, can anybody
> wants to provide pointers to how I can do this?

It already is an ide drive.  In order to mount it, you must put a
filesystem on it.  If you kept the orginal scripts for pcmica-cs, then
the SanDisk is /dev/hde.  the cardmgr should write that info out to the
console or log file.

> /Subodh Nijsure
>
> -----------------------------------
> sh-2.04# cardctl ident
> Socket 0:
>   product info: "SunDisk", "SDP", "5/3 0.6"
>   manfid: 0x0045, 0x0401
>   function: 4 (fixed disk)
> sh-2.04# cardctl status
> Socket 0:
>   5V 16-bit PC Card
>   function 0: [ready], [bat dead], [bat low]
> -----------------------------------
> sh-2.04# dump_cis | more
> Socket 0:
>   dev_info
>     fn_specific 700ns, 2kb
>   common_jedec 0xdf 0x01
>   manfid 0x0045, 0x0401
>   vers_1 4.1, "SunDisk", "SDP", "5/3 0.6"
>   funcid fixed_disk [post]
>   disk_interface [ide]
>   disk_features [silicon] [unique] [single]
>     [sleep] [standby] [idle] [low power]
>   config base 0x0200 mask 0x000f last_index 0x07
>   cftable_entry 0x00 [default]
>     [rdybsy] [mwait] [pwrdown]
>     Vcc Vnom 5V Vmin 4500mV Vmax 5500mV Ipeak 80mA
>     memory 0x0000-0x07ff @ 0x0000
>   cftable_entry 0x00
>     Vcc Vnom 3300mV Ipeak 45mA
>   cftable_entry 0x01 [default]
>     [rdybsy] [pwrdown]
>     Vcc Vnom 5V Vmin 4500mV Vmax 5500mV Ipeak 80mA
>     io 0x0000-0x000f [lines=4] [8bit] [16bit]
>     irq mask 0xffff [level] [pulse] [shared]
>   cftable_entry 0x01
>     Vcc Vnom 3300mV Ipeak 45mA
>   cftable_entry 0x02 [default]
>     [rdybsy] [pwrdown]
>     Vcc Vnom 5V Vmin 4500mV Vmax 5500mV Ipeak 80mA
>     io 0x01f0-0x01f7, 0x03f6-0x03f7 [lines=10] [8bit] [16bit] [range]
>     irq 14 [level] [pulse] [shared]
>   cftable_entry 0x02
>     Vcc Vnom 3300mV Ipeak 45mA
>   cftable_entry 0x03 [default]
>     [rdybsy] [pwrdown]
>     Vcc Vnom 5V Vmin 4500mV Vmax 5500mV Ipeak 80mA
>     io 0x0170-0x0177, 0x0376-0x0377 [lines=10] [8bit] [16bit] [range]
>     irq 14 [level] [pulse] [shared]
>   cftable_entry 0x03
>     Vcc Vnom 3300mV Ipeak 45mA
>   cftable_entry 0x07
> ------------------------------
> sh-2.04# cat /proc/interrupts
>            CPU0
>   1:          0   8xx SIU   Edge      cxe
>   2:          0   8xx SIU   Edge      mii
>   3:        481   8xx SIU   Edge      fec
>   5:      11711   8xx SIU   Edge      cpm
>  13:          0   8xx SIU   Edge      m8xx_pcmcia
>  15:          0   8xx SIU   Edge      tbint
> BAD:          0
> -------------------------------
>
> sh-2.04# cat /proc/devices
> Character devices:
>   1 mem
>   2 pty
>   3 ttyp
>   4 ttyS
>   5 cua
>  10 misc
>  89 i2c
>  90 mtd
> 162 raw
> 254 pcmcia
>
> Block devices:
>   1 ramdisk
>  31 mtdblock
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
