Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 699EBDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 17:49:06 +1000 (EST)
To: Oliver Rutsch <orutsch@sympatec.com>,
	"Mustafa Cayir" <mustafa.cayir@bte.mam.gov.tr>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: STK5200 pci_enable_device problem
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 29 Aug 2007 08:02:51 +0200."
	<46D50C0B.80402@sympatec.com>
Date: Wed, 29 Aug 2007 09:49:02 +0200
Sender: wd@denx.de
Message-Id: <20070829074902.7634024044@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <46D50C0B.80402@sympatec.com> you wrote:
> 
> > i build Linux-2.6.22-gbcfc8d37 kernel lastest kernel from denx git for 
> > the board (STK5200 with TQM5200-AB).
> > ELDK 4.1 version is used.
> > 
> > make mrproper
> > export ARCH=powerpc
> > make tqm5200_defconfig
> > make uImage
> > 
> > It hangs on after  following line
> >   Uncompressing Kernel Image ... OK

Probably it does not hang, but you just don't see any console output.
Eventually  you  just  forgot  to  set  the  correct  console  device
(/dev/ttyPSC0) or console speed.

Also, you need a recent version of U-Boot (for  example  99c2fdab  or
later).

Try something like this:

=> tftp 200000 /tftpboot/tqm5200/uImage
=> tftp 400000 /tftpboot/tqm5200/tqm5200.dtb
=> setenv bootargs root=/dev/nfs rw nfsroot=192.168.1.1:/opt/eldk/ppc_6xx ip=192.168.160.4:192.168.1.1:::tqm5200:eth0:off console=ttyPSC0,115200
=> bootm 200000 - 400000
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.22-gab27a987
   Created:      2007-08-05   8:24:43 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1454249 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using flat device tree at 0x400000
Using tqm5200 machine description
Linux version 2.6.22-gab27a987 (wd@pollux.denx.de) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #1 Sun Aug 5 10:24:37 MEST 2007
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
early_node_map[1] active PFN ranges
    0:        0 ->    16384
Built 1 zonelists.  Total pages: 16256
Kernel command line: root=/dev/nfs rw nfsroot=192.168.1.1:/opt/eldk/ppc_6xx ip=192.168.160.4:192.168.1.1:::tqm5200:eth0:off panic=1 console=ttyPSC0,115200
MPC52xx PIC is up and running!
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 61704k/65536k available (2872k kernel code, 3772k reserved, 132k data, 142k bss, 156k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
MPC52xx BestComm inited
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
...

etc.


> I encountered exactly the same problem. Using U-Boot 1.2 with Kernel 
> Linux-2.6.22-gef92f1d7 and a TQM5200S-BD module on the STK52000. I tried 
> to modify some kernel settings but it always stopped booting at the 
> "Uncompressing Kernel Image ... OK" line.

Please note that the device tree we have at the  moment  is  for  the
TQM5200 only and does not include support for the TQM5200S.

But probably you just had the same problem - missing or  bad  console
device specification.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
That's their goal, remember, a goal that's really contrary to that of
the programmer or administrator. We just want to get our  jobs  done.
$Bill  just  wants  to  become  $$Bill. These aren't even marginallly
congruent.
         -- Tom Christiansen in <6jhtqk$qls$1@csnews.cs.colorado.edu>
