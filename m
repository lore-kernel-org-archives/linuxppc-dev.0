Message-ID: <3755213D.3BB3C8B6@wanadoo.fr>
Date: Wed, 02 Jun 1999 14:19:09 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: Cort Dougan <cort@ppc.kernel.org>
Subject: Bug in vger 2.2.10 and 2.3.4 (Re: Problems with vger 2.3.3/4)
References: <374D8E2A.48871830@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A while ago I reported about boot problems with the vger 2.3.x kernel
after May 22. Now I found that this same bug has crept into the "stable"
tree, starting with 2.2.10 on May 30. After some digging, I found the
culprit. It is the file arch/ppc/mm/init.c, patched (wrongly) as
follows:

root[17]#cvs diff -u -r1.165 -r1.166 arch/ppc/mm/init.c
Index: arch/ppc/mm/init.c
===================================================================
RCS file: /cvs/linux/linux/arch/ppc/mm/init.c,v
retrieving revision 1.165
retrieving revision 1.166
diff -u -r1.165 -r1.166
--- arch/ppc/mm/init.c  1999/05/14 22:37:29     1.165
+++ arch/ppc/mm/init.c  1999/05/22 18:18:30     1.166
@@ -1,5 +1,5 @@
 /*
- *  $Id: init.c,v 1.165 1999/05/14 22:37:29 cort Exp $
+ *  $Id: init.c,v 1.166 1999/05/22 18:18:30 cort Exp $
  *
  *  PowerPC version 
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
@@ -402,7 +402,7 @@
    for (i = 0; i < size; i += PAGE_SIZE)
        map_page(&init_task, v+i, p+i, flags);
 out:
-   return (void *) (v + (p & ~PAGE_MASK));
+   return (void *) (v + (addr & ~PAGE_MASK));
 }
 
 void iounmap(void *addr)

This patch had been proposed on May 21 by R. Oikawa and almost
immediately been corrected, see
http://lists.linuxppc.org/listarcs/linuxppc-user/199905/msg00680.html
Unfortunately, the correction didn't make it into the vger tree. I don't
know if the correction is good, but I never had problems with the
version before the patch.

In addition to the 2 problems mentioned below, I also found that the
2.2.10 kernel writes some vicious binary garbage into my
/var/log/messages file which eventually completely screws up. When
trying to read it, I get IO errors (reading beyond end of device). 

--
Martin

Martin Costabel wrote:
> 
> On my 6400/200, the 2.3.3 (now 2.3.4) kernel from the vger tree has
> problems that started last Sunday:
> 
> The sources checked out on May 21 give a kernel that runs perfectly, but
> starting from updates on May 22 and until right now, two problems showed
> up whose origin I could not identify, although I spent time staring at
> source files and cvs logs and trying things:
> 
> The first one is related to the IDE driver. At boot time, in the
> partition check section, it gives me
>    kernel: Partition check:
>    kernel:  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10
>    kernel:  sdb: sdb1 sdb2 sdb3
>    kernel:  hda:hda: timeout waiting for DMA
>    kernel: hda: irq timeout: status=0x58 { DriveReady SeekComplete
> DataRequest }
>    kernel: hda: DMA disabled
>    kernel: ide0: reset: success
>    atd: atd startup succeeded
>    kernel:  hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10 hda11
> hda12 hda13
>    kernel: VFS: Mounted root (ext2 filesystem) readonly.
> With the May 21 kernel, I get only, like always before,
>    kernel: Partition check:
>    kernel:  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10
>    kernel:  sdb: sdb1 sdb2 sdb3
>    kernel:  hda: hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10
> hda11 hda12 hda13
>    kernel: VFS: Mounted root (ext2 filesystem) readonly.
> The effect of this is that the HD is slower with the newer kernel: I use
> hdparm -p /dev/hda to tune it and usually get 4.35 MB/sec instead of
> 1.88 MB/sec. With the new kernel, it stays at 1.88 MB/sec, whatever I
> try.
> 
> The second problem: I have a one-line script in /etc/rc.d that
> initializes the printer port:
>    stty raw 57600 crtscts -echo < /dev/ttyS1
> With the new kernel, the boot process hangs while trying to execute this
> script, and I have to do a hard reboot. If I comment this line out, the
> boot process succeeds. Afterwards, I can execute the script manually
> without problem.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
