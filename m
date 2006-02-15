Return-Path: <adhonde@yahoo.com>
Received: from web30711.mail.mud.yahoo.com (web30711.mail.mud.yahoo.com
	[68.142.201.249]) by ozlabs.org (Postfix) with SMTP id 24E6767A00
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2006 02:06:34 +1100 (EST)
Message-ID: <20060215145954.43697.qmail@web30711.mail.mud.yahoo.com>
Date: Wed, 15 Feb 2006 06:59:54 -0800 (PST)
From: Anil Dhonde <adhonde@yahoo.com>
Subject: 8272ads:PCI prefetchable mem access problem
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all:

We have plugged an ATI Radeon video card into a PCI
slot on our powerpc 8272ads evaluation board. The
linux kernel 2.6.15 comes up, detects the card on the
bus, rolls in the ATI Radeon framebuffer driver as it
should. All register/PCI config space access is fine.

The trouble starts when I try to access the 128MByte
video memory on the card. As you can see below, there
are three regions for this card - one pre-fetchable,
one non-prefetchable and one io. The 128MByte region
is flagged prefetchable.

I can:
 - mmap (in userland) or ioremap (in kernel space) the
non-prefetchable region and do what I want to with it
(read/write). User space I use either /proc or /sys
handles and in the kernel my driver does the remapping

I cannot:
 - mmap or remap the prefetchable region though the
calls to ioremap and mmap return success.
 - Kernel ioremap returns success but the powerpc
crashes as soon as I read or write to space that has
just been remapped. 
 - mmap using either /proc or /sys based pci resource
access from user space fails the same way. mmap call
returns success but access cases a bus error.

something that looks suspicious:
cat /proc/iomem below shows that the ATI cards
prefetchable memory does not land up in the
prefetchable region of the PCI map. It lands in the
PCI memory (non-prefetchable region).


what I have tried:
- forcing PREFETCH flags to be NONPREFETCH by hacking
the kernel - this hack didnt work though /proc/pci
reports all pre-fetchables as non-prefetchables
meaning that flags were set properly.

any help/pointers from you guys will be great,

thanks a ton,
a


Platform details:
- powerpc 8272ads board, 64MByte eval board with
kernel 2.6.15 
- ATI Radeon 7000 PCI based card with 128MByte mem

================== log ==============================
~ # cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 1057:18c1 (rev 16).
      Master Capable.  Latency=248.
      Non-prefetchable 32 bit memory at 0x0 [0x1ffff].
      Prefetchable 32 bit memory at 0x0 [0xfffffff].
  Bus  0, device  24, function  0:
    Class 0300: PCI device 1002:5159 (rev 0).
      IRQ 66.
      Master Capable.  Latency=128.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xa8000000
[0xafffffff].
      I/O at 0x1ffff00 [0x1ffffff].
      Non-prefetchable 32 bit memory at 0xa7ff0000
[0xa7ffffff].
~ # ls -l /sys/devices/pci0000\:00/0000\:00\:18.0/
lrwxrwxrwx    1 root     root            0 Jan  1
00:03 bus ->
../../../bus/pci
-r--r--r--    1 root     root         4096 Jan  1
00:03 class
-rw-r--r--    1 root     root          256 Jan  1
00:03 config
-r--r--r--    1 root     root         4096 Jan  1
00:03 device
-r--r--r--    1 root     root         4096 Jan  1
00:03 irq
-r--r--r--    1 root     root         4096 Jan  1
00:03 local_cpus
-r--r--r--    1 root     root         4096 Jan  1
00:03 modalias
-r--r--r--    1 root     root         4096 Jan  1
00:03 resource
-rw-------    1 root     root    134217728 Jan  1
00:03 resource0
-rw-------    1 root     root          256 Jan  1
00:03 resource1
-rw-------    1 root     root        65536 Jan  1
00:03 resource2
-r--------    1 root     root       131072 Jan  1
00:03 rom
-r--r--r--    1 root     root         4096 Jan  1
00:03 subsystem_device
-r--r--r--    1 root     root         4096 Jan  1
00:03 subsystem_vendor
--w-------    1 root     root         4096 Jan  1
00:03 uevent
-r--r--r--    1 root     root         4096 Jan  1
00:03 vendor
~ # cat /proc/iomem
80000000-9fffffff : PCI prefetchable memory
a0000000-afffffff : PCI memory
  a7ff0000-a7ffffff : 0000:00:18.0
  a8000000-afffffff : 0000:00:18.0
~ # cat /proc/ioports
00000000-01ffffff : PCI I/O
  01ffff00-01ffffff : 0000:00:18.0



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
