Message-ID: <009201c06519$e83418d0$1e894b82@pc30>
From: "Nils Hagge" <Nils.Hagge@stud.uni-hannover.de>
To: "Jari Nguyen Trung Thanh" <jari.nguyen@serialsystem.com.sg>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <006c01c0650f$73b65d60$1e894b82@pc30> <976717249.3a3785c2030de@mail.serialsystem.com.sg>
Subject: Re: Kernel panic: No init found.
Date: Wed, 13 Dec 2000 16:32:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jari,

thank for your fast answer. I examined the problem I little bit further,
maybe you find something, that can help me further with this new
piece of information.
> you should see if you have the link sbin -> bin in the target dir or not..
bash-2.03# dir -l
total 100
drwxr-xr-x   2 root     root         8192 Dec  5 02:55 bin
drwxr-xr-x   2 root     root         4096 Dec  5 03:14 boot
drwxr-xr-x   2 root     root         4096 Dec  5 02:54 dev
drwxr-xr-x   6 root     root         4096 Dec 13 07:14 etc
drwxr-xr-x   3 root     root         4096 Dec  5 02:54 home
drwxr-xr-x   3 root     root         4096 Dec  5 02:54 include
-rwxrwxrwx   1 root     root        30344 Dec  8 06:39 init
drwxr-xr-x   4 root     root         4096 Dec  5 02:55 lib
drwxr-xr-x   6 root     root         4096 Dec  5 02:55 man
drwxr-xr-x   2 root     root         4096 Aug  9 21:17 mnt
drwxr-xr-x   3 root     root         4096 Dec  5 02:54 opt
drwxr-xr-x   2 root     root         4096 Aug  9 21:17 proc
lrwxrwxrwx   1 root     root            3 Dec  5 02:54 sbin -> bin
drwxr-xr-x   4 root     root         4096 Dec  5 02:55 share
drwxr-xr-x   2 root     root         4096 Aug  9 21:17 tmp
drwxr-xr-x   5 root     root         4096 Dec  5 02:54 usr
drwxr-xr-x   8 root     root         4096 Dec  5 02:55 var
drwxr-xr-x  10 root     root         4096 Dec  5 02:55 web
Sure. This link exists. But even if it didnt, it should work nevertheless,
if you take a look at the source file....

> the best thing I can show that you should look to the file: /init/main.c
> in your kernel source
....that I nearly know by heart

 if (open("/dev/console", O_RDWR, 0) < 0)
  printk("Warning: unable to open an initial console.\n");

 (void) dup(0);
 (void) dup(0);

 /*
  * We try each of these until one succeeds.
  *
  * The Bourne shell can be used instead of init if we are
  * trying to recover a really broken machine.
  */

 if (execute_command)
  printk("Suchen nach %s ", execute_command),
execve(execute_command,argv_init,envp_init),
                printk("%d\n", errno);
 printk("Suchen nach /sbin/init "),
execve("/sbin/init",argv_init,envp_init),         <---here /sbin/init is
tried to be loaded
        printk("%d\n", (errno));
 printk("Suchen nach /etc/init "), execve("/etc/init",argv_init,envp_init),
<----- /etc/init
 printk("%d\n", (errno));
 printk("Suchen nach /bin/init "), execve("/bin/init",argv_init,envp_init),
<----- /bin/init
 printk("%d\n", (errno));
 printk("Suchen nach /bin/sh "), execve("/bin/sh",argv_init,envp_init),
<----- /bin/sh
 printk("%d\n", (errno));
 panic("No init found.  Try passing init= option to kernel.");
}

I added the "printk" statements in order to see the error codes.
And the output is the following:
[....]
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 36k init
Suchen nach /bin/init 2
Suchen nach /sbin/init 2
Suchen nach /etc/init 2
Suchen nach /bin/init 2
Suchen nach /bin/sh 2
[...]
Thus the error is always no. 2, which is according to
"include/asm-ppc/errno.h" equal to
"No such file or directory".
And this is definitely not true. The files do all exist and are readable and
executable for all (u-g-o).


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
