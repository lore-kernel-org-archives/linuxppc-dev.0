Message-Id: <5.1.1.6.0.20030609103205.02541bc0@dns.struinfo.it>
Date: Mon, 09 Jun 2003 11:20:19 +0200
To: linuxppc-embedded@lists.linuxppc.org
From: llandre <r&d@wawnet.biz>
Subject: Initial ramdisk, linuxrc script and handle_initrd function
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using the kernel 2.4.21-pre5 with the ELDK on a PPC405EP. I use an
initial ramdisk stored in Flash (simple-ramdisk downloaded from Denx's FTP
site). U-Boot loader loads correctly both the kernel image and the ramdisk
image. Everything works fine until the following code in prepare_namespace
(init/do_mounts.c):

         if (mount_initrd) {
                 if (initrd_load() && ROOT_DEV != MKDEV(RAMDISK_MAJOR, 0)) {
                         handle_initrd();
                         goto out;
                 }

ROOT_DEV has been set to 0x100 because the command line includes
root=/dev/ram and so the handle_initrd function is not invoked. Thus the
/linuxrc script is not executed.
Why do ROOT_DEV and MKDEV(RAMDISK_MAJOR, 0) need to be different in order
to execute /linuxrc?
Am I missing some parameters?
Any help is appreciated.

Thanks in advance.


llandre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
