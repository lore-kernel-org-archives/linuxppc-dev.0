Message-ID: <025001c058aa$4f870ff0$0503a8c0@vp.mrsl.com>
From: "Tim Moloney" <moloney@mrsl.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Learning about kernel modules
Date: Mon, 27 Nov 2000 14:43:26 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If this list is not the best place for this, please me point me to
a better place.

I have just finished reading the "Linux Kernel Module Programming
Guide" (http://http://linuxdoc.org/LDP/lkmpg/mpg.html") and have
started working with the example code.  It appears that the example
code for the  2.2.x kernel used in the book does not work properly
with the 2.2.18 kernel.  Is there a later version of this document
or another document that explains the differences needed to get the
source to compile cleanly?


Examples of compiler errors and warnings:

Chapter 1 (single source file)

  gcc -Wall -DMODULE -D__KERNEL__ -DLINUX -c hello.c
  hello.c: In function `init_module':
  hello.c:26: warning: implicit declaration of function
`printk_Rsmp_dd132261'

Chapter 1 (multiple source files)

  gcc -Wall -DMODULE -D__KERNEL__ -DLINUX -c start.c
  start.c: In function `init_module':
  start.c:27: warning: implicit declaration of function
    `printk_Rsmp_dd132261'
  gcc -Wall -DMODULE -D__KERNEL__ -DLINUX -c stop.c
  stop.c: In function `cleanup_module':
  stop.c:35: warning: implicit declaration of function
    `printk_Rsmp_dd132261'
  ld -m elf32ppc -r -o hello.o start.o stop.o

Chapter 2

  gcc -Wall -DMODULE -D__KERNEL__ -DLINUX -c chardev.c
  In file included from /usr/include/linux/tqueue.h:18,
                   from /usr/include/linux/tty.h:23,
                   from /usr/include/linux/sched.h:21,
                   from /usr/include/asm/uaccess.h:5,
                   from chardev.c:41:
  /usr/include/asm/spinlock.h:21: warning: `spin_trylock' redefined
  /usr/include/linux/modules/ppc_ksyms.ver:194: warning: this is the
    location of the previous definition
  In file included from /usr/include/linux/fs.h:168,
                   from chardev.c:20:
  /usr/include/asm/semaphore.h: In function `down':
  /usr/include/asm/semaphore.h:38: warning: implicit declaration of
    function `atomic_dec_return_Rsmp_5713b1a2'
  /usr/include/asm/semaphore.h: In function `up':
  /usr/include/asm/semaphore.h:69: warning: implicit declaration of
    function `atomic_inc_return_Rsmp_1f3d9f34'
  In file included from /usr/include/asm/uaccess.h:5,
                   from chardev.c:41:
  /usr/include/linux/sched.h: In function `mmget':
  /usr/include/linux/sched.h:644: warning: implicit declaration of
    function `atomic_inc_Rsmp_b51eea26'
  chardev.c: In function `device_open':
  chardev.c:86: warning: implicit declaration of function
    `printk_Rsmp_dd132261'
  chardev.c:121: warning: implicit declaration of function
    `sprintf_Rsmp_3c2c5af5'
  chardev.c: In function `device_release':
  chardev.c:170: warning: implicit declaration of function
    `atomic_dec_Rsmp_d8330e33'

  bash> insmod chardev.o
  chardev.o: unresolved symbol __put_user_bad


Thanks.

Tim Moloney

ManTech Real-time Systems Laboratory
2015 Cattlemen Road
Sarasota, FL  34232
(941) 377-6775 x208


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
