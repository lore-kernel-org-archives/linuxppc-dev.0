Date: Tue, 8 Dec 1998 23:07:39 -0500 (EST)
From: Thomas Riemer <triemer@apt4g.a3nyc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [linux-usb] linux on imac (fwd)
Message-ID: <Pine.LNX.3.96.981208230641.12703i-100000@apt4g.a3nyc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Date: Tue, 8 Dec 1998 23:05:22 -0500 (EST)
From: Thomas Riemer <triemer@apt4g.a3nyc.com>
To: linux-usb@peloncho.fis.ucm.es
Subject: Re: [linux-usb] linux on imac

I've been able to compile up and talk to my imac via keyboard...

The combination of stuff that worked was:

linux-pmac-2.1.127.tar.gz
+ uusbd-1207.tar.gz
+ uusbd-imac-981209.patch.gz

It appears that the multiple keyboard stuff is not needed...

FYI - I compiled the usb stuff into the kernel... no modules - seems
to work.

In trying to compile up 2.1.129 - the uusbd stuff has a problem with
the definition of s_node.  Apparently it thinks that s_node should
have a "lock" field.  For the life of me, I'm not seeing why the compiler
croaks - or rather I see why it shouldn't work - I don't understand why
it works for 2.1.127 and not for 2.1.129.

I tried the kbd patches - they do not cleanly apply to 2.1.129...
nor to 2.1.127. But the kbd patch does not seem to be required 
to get the kernel booting.

-Tom
------------------------  Output of make ---------------------------------
------------    2.1.129 patched with uusbd-19981207, + 19981209.patch ----
--------------------------------------------------------------------------
gcc -D__KERNEL__ -I/home/linux/linux-2.1.129/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__SMP__ -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring  -c -o init/main.o init/main.c
/home/linux/linux-2.1.129/include/uusbd/usb-hub.h: In function `usb_hub_status_get':
In file included from /home/linux/linux-2.1.129/include/uusbd/usbd.h:34,
                 from init/main.c:43:
/home/linux/linux-2.1.129/include/uusbd/usb-hub.h:525: structure has no member named `lock'
/home/linux/linux-2.1.129/include/uusbd/usb-hub.h:528: structure has no member named `lock'
/home/linux/linux-2.1.129/include/uusbd/usb-hub.h: In function `usb_port_status_get':
/home/linux/linux-2.1.129/include/uusbd/usb-hub.h:782: structure has no member named `lock'
/home/linux/linux-2.1.129/include/uusbd/usb-hub.h:792: structure has no member named `lock'
make: *** [init/main.o] Error 1

------------------- Relevant Log entries from /var/adm/messages----------------
Dec  8 22:43:26 plato kernel: klogd 1.3-3, log source = /proc/kmsg started.
Dec  8 22:43:27 plato kernel: Loaded 18109 symbols from /usr/src/linux/System.map.
Dec  8 22:43:27 plato kernel: Symbols match kernel version 2.1.127.
Dec  8 22:43:27 plato kernel: Error seeking in /dev/kmem 
Dec  8 22:43:27 plato kernel: Error adding kernel module table entry. 
Dec  8 22:43:27 plato kernel:  index 0
Dec  8 22:43:27 plato kernel: USB-HIDBP: cfg.c:131: Interface 0 of device (0 1) supports HID Boot Protocol Mouse
Dec  8 22:43:27 plato kernel: USB-HUBM: hubm-stch.c:678: Device attachment detected on port 1 of hub 0xc0257e20 (0 -1)
Dec  8 22:43:27 plato kernel: USB-HUBM: khubdd.c:294: Ran out of hub queuing slots [with 5]
Dec  8 22:43:27 plato kernel: USBD: usbd-descr.c:1057: Device 0xc1fab120 (0 2): (no information available)
Dec  8 22:43:27 plato kernel: USB device 2 is a hub on hub 0/0 port 1
Dec  8 22:43:27 plato kernel: USBD: usbd-descr.c:751: Processing USB device 0xc1fab120 (0 2), configuration index 0
Dec  8 22:43:27 plato kernel: USB-HUBM: hubm-stch.c:678: Device attachment detected on port 0 of hub 0xc1fab240 (0 2)
Dec  8 22:43:27 plato kernel: USBD: usbd-descr.c:1053: Device 0xc1fab360 (0 3): Alps Electric M2452
Dec  8 22:43:27 plato kernel: USB device 3 is a Alps Electric M2452 on hub 0/2 port 0
Dec  8 22:43:27 plato kernel: USBD: usbd-descr.c:751: Processing USB device 0xc1fab360 (0 3) 'M2452', configuration index 0
Dec  8 22:43:27 plato kernel: USB-HIDBP: cfg.c:110: Interface 0 of device (0 3) supports HID Keyboard Boot Protocol
Dec  8 22:43:27 plato kernel: scsi : detected total.
Dec  8 22:43:27 plato kernel: PPP: version 2.3.5 (demand dialling)
Dec  8 22:43:27 plato kernel: TCP compression code copyright 1989 Regents of the University of California
Dec  8 22:43:27 plato kernel: PPP line discipline registered.
Dec  8 22:43:27 plato kernel: eth0: BMAC at 00:05:02:e3:65:c3
Dec  8 22:43:27 plato kernel: Partition check:
Dec  8 22:43:27 plato kernel:  hda: hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9
Dec  8 22:43:27 plato kernel: VFS: Mounted root (ext2 filesystem) readonly.
Dec  8 22:43:27 plato kernel: Freeing unused kernel memory: 92k init 32k prep
Dec  8 22:43:27 plato kernel: Adding Swap: 39996k swap-space (priority -1)
Dec  8 22:43:27 plato kernel: AppleTalk 0.18 for Linux NET3.037
Dec  8 22:43:38 plato PAM_pwdb[258]: (login) session opened for user root by (uid=0)
Dec  8 22:43:38 plato PAM_pwdb[258]: ROOT LOGIN ON tty1
Dec  8 22:47:58 plato PAM_pwdb[284]: (login) session opened for user root by (uid=0)
Dec  8 22:47:59 plato PAM_pwdb[284]: ROOT LOGIN ON ttyp0 FROM newton

-----------------------------------------------------------------------
Given enough eyeballs all bugs seem shallow.

On Wed, 9 Dec 1998, Paul Mackerras wrote:

> Some good news for those of you with iMacs:  I have got the keyboard
> and mouse working on my iMac with Inaky's latest snapshot plus some
> modifications.  The patches are in
> ftp://samba.anu.edu.au/pub/linux-pmac/imac/.  There are two files
> there:
> 
> uusbd-imac-981209.patch.gz - patches to the recent uusbd snapshot.
> Note that Inaky and I are still working on merging this stuff back
> into his tree, and not all the issues are resolved yet, so it is all
> liable to change.
> 
> kbd-981208.patch.gz - a patch to the linux kernel source to add
> support for multiple keyboards.  This patch should apply cleanly to
> recent kernels (either the official source or the vger source),
> i.e. 2.1.129 or later.
> 
> I plan to release a precompiled kernel for the iMac along with some
> installation notes soon.
> 
> Have fun!
> 
> Paul.
> --
> -- To unsubscribe from this list: send the line "unsubscribe linux-usb"
> -- in the body of a message to majordomo@peloncho.fis.ucm.es
> 



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
