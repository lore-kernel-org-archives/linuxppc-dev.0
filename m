Date: Thu, 23 Aug 2001 03:27:56 -0700
From: Matt Porter <mporter@mvista.com>
To: yah <hay8888@21cn.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: boot on MCP750
Message-ID: <20010823032755.A4596@cx258813-a.chnd1.az.home.com>
References: <Zq989176867389.18785@webmail5.inner-21cn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Zq989176867389.18785@webmail5.inner-21cn.com>; from hay8888@21cn.com on Thu, Aug 23, 2001 at 01:26:10PM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Aug 23, 2001 at 01:26:10PM +0800, yah wrote:
>
> Hi,all.
>   I use MCP750 board and linuxppc_2_4 from penguinppc. I rebuild the kernel,then boot my board,faild. I had used vmlinuz from mvista to boot the board,it's ok. So I don't think it's hardware problem. What's wrong? Pleas give me a hand.Thanks in advance.Following is the boot info.
>
> Linux/PPC load: root=nfs

You'll need to add ip=on here.  Kernel level autoconfig was changed
to default to an implicit "ip=off".  Enable just the DHCP suboption
instead of BOOTP (assuming you are using dhcpd).

> Uncompressing Linux...done.
> Now booting the kernel
> Total memory = 128MB; using 512kB for hash table (at c0280000)
> Linux version 2.4.6-pre2 (root@amy.w-ibeda.com) (gcc version 2.95.2 19991024 (r1

<snip>

> VP_IDE: IDE controller on PCI bus 00 dev 59
> VP_IDE: chipset revision 6
> VP_IDE: 100% native mode on irq 14
>     ide0: BM-DMA at 0xffc0-0xffc7, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xffc8-0xffcf, BIOS settings: hdc:pio, hdd:pio
> hdc: ST310211A, ATA DISK drive
> ide1 at 0xffe0-0xffe7,0xffde on irq 14
> hdc: 16514064 sectors (8455 MB) w/1024KiB Cache, CHS=16383/16/63
> Partition check:
>  hdc:hdc: lost interrupt
> hdc: lost interrupt
> hdc: lost interrupt
> hdc: lost interrupt
> hdc: lost interrupt
> hdc: lost interrupt

Looks like I didn't get some IDE interrupt fixes merged to linuxppc_2_4
from the _devel tree.  In the meantime, you will probably have better
results using the rear transition module's secondary IDE channel running
linuxppc_2_4_devel.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
