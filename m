Subject: Re: pcmcia microdrive support on 2.4.21-rev5 for arctic2
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFDE2F5CD3.5BAB6AAA-ON87256CF7.0051250D-85256CF7.0051C351@us.ibm.com>
From: John F Davis <johndavi@us.ibm.com>
Date: Fri, 28 Mar 2003 09:52:46 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello David,

You indeed are correct again.  I made the change to the pcmcia config file
and it now associates the ide-cs.o with the microdrive.  However, I still
have problems.  It outputs the following message:
ide-cs: Get NextTuple: No more items
ide-cs: Get NextTuple: No more items

Also:
"fdisk /dev/hda"  Says "unable to open /dev/hda"

I also don't see ide in the /proc/devices file.  This sounds like a
problem.

Thanks again.

JD

Below is more detailed info:

# insmod pcmcia_core
Using /lib/modules/2.4.21-pre5/pcmcia/pcmcia_core.o
Linux Kernel Card Services 3.1.22
  options:  [pm]
# insmod pccf_4xx
Using /lib/modules/2.4.21-pre5/pcmcia/pccf_4xx.o
Warning: loading pccf_4xx will taint the kernel:pccf_4xx.c $Revision: 1.3 $
$Date
  S:22:41 $ (Eric Van Hensbergen)
ee http://www.tux.org/lkml/#export-tainted for information about tainted
modules
# insmod ds
Using /lib/modules/2.4.21-pre5/pcmcia/ds.o
# cardmgr -v
cardmgr[28]: watching 1 sockets
# cardmgr[29]: starting, version is 3.2.4

# cardmgr[29]: initializing socket 0
cardmgr[29]: socket 0: ATA/IDE Fixed Disk
cardmgr[29]:   product info: "IBM", "microdrive"
cardmgr[29]:   manfid: 0x00a4, 0x0000  function: 4 (fixed disk)
cardmgr[29]: executing: 'modprobe ide-cs'
cardmgr[29]: + Using /lib/modules/2.4.21-pre5/pcmcia/pcmcia_core.o
cardmgr[29]: + Using /lib/modules/2.4.21-pre5/pcmcia/ds.o
cardmgr[29]: + Using /lib/modules/2.4.21-pre5/pcmcia/pcmcia_core.o
cardmgr[29]: + Using /lib/modules/2.4.21-pre5/kernel/drivers/ideide-cs:
/legacy/s

cardmgr[29]: get dev info on socket 0 failed: Resource temporarily
unavailable

# cat /etc/pcmcia/config
device "ide-cs"
  class "ide" module "ide-cs"


#
# ATA/IDE fixed disk devices
#
card "ATA/IDE Fixed Disk"
  function fixed_disk
  bind "ide-cs"

# cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
 13 input
 29 fb
 89 i2c
 90 mtd
128 ptm
136 pts
162 raw
254 pcmcia

Block devices:
  1 ramdisk
  7 loop
 31 mtdblock
 93 nftl

# ls -l /dev/hda*
brw-r--r--    1 0        0          3,   0 Mar 26  2003 /dev/hda
lrwxrwxrwx    1 0        0               3 Mar 19  2003 /dev/hda0 -> hda
brw-r--r--    1 0        0          3,   1 Mar 26  2003 /dev/hda1
brw-r--r--    1 0        0          3,   2 Feb 22  2003 /dev/hda2

# cat /proc/ide/drivers
ide-disk version 1.16







|---------+----------------------------->
|         |           David Gibson      |
|         |           <david@gibson.drop|
|         |           bear.id.au>       |
|         |                             |
|         |           03/27/2003 08:06  |
|         |           PM                |
|         |                             |
|---------+----------------------------->
  >------------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                              |
  |       To:       John F Davis/Raleigh/IBM@ibmus                                                                               |
  |       cc:       linuxppc-embedded@lists.linuxppc.org                                                                         |
  |       Subject:  Re: pcmcia microdrive support on 2.4.21-rev5 for arctic2                                                     |
  |                                                                                                                              |
  >------------------------------------------------------------------------------------------------------------------------------|




On Thu, Mar 27, 2003 at 06:29:33PM -0500, John F Davis wrote:
>
> Hello
>
> I am trying to get my microdrive working with 2.4.21.rev5.  I have the
> following config options set:
> CONFIG_PCMCIA=m
> CONFIG_PCMCIA_PCCF_4xx=m
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDECS=m
>
> I can insmod pcmcia_core, pccf_4xx, and ds.
>
> I built the latest pcmcia package from sourceforge in order to get
cardmgr.
>
> When I insert my microdrive, it says "insmod ide_cs.o" no module by that
> name found.
> I indeed do not have this module in my tree.  What's the deal?

In recent kernels the name of the module has changed to ide-cs.o

--
David Gibson                  | For every complex problem there is a
david@gibson.dropbear.id.au   | solution which is simple, neat and
    | wrong.
 http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
