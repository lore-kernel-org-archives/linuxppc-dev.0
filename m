Message-ID: <01C156FF.63187140.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: initrd offset in zImage getting mis-aligned?
Date: Wed, 17 Oct 2001 11:32:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am porting a version of Redhat's embedded linux kernel to
a new custom designed bd with the mpc860.  I am using a
local RAM disk on this new bd.

The zImage (boot loader + zipped KERNEL + zipped RAM disk)
is downloaded into RAM, starts the BOOT loader,
unzips the kernel to 0x0000.0000, executes the initial kernel
code, unzips the RAM disk, starts booting the
kernel code, and then tarnsfers control to the app.

I can modify any of the stuff in the initrd, /sbin/init or
/sbin/app, for example, and the app runs.

But, if I modify the boot loader code or the kernel code,
then there may or may not be a problem loading initrd.
It's as though that adding or deleting code such as a printk()
from these cause the initrd to be moved forward or backward
and possibly losing alignment in the zImage, thus causing the
gunzip to bomb.  I used to get, after the compressed initrd was
located, error msgs such as "invalid compressed image".  But
by merely adding a printk() to start_kernel(), for instance, the
compressed initrd is located un unzipped and code execution is
allowed to continue on to the app.

Thanks,

Steven Vacca
Valcom, Inc.
Roanoke, Virginia

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
