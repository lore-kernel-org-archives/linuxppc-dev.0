Message-ID: <37432B57.A586055C@wanadoo.fr>
Date: Wed, 19 May 1999 23:21:27 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: Andreas Bogk <andreas@andreas.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.3 compile error on ppc
References: <Pine.LNX.3.96L.990519131538.1355C-100000@unix47.andrew.cmu.edu> <m31zgd0w4t.fsf@soma.andreas.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The real culprit in this story is the following broken (or incomplete)
patch that got into the kernel.org kernel version 2.2.8. Fortunately it
did not make its way into the vger tree. (This is from patch-2.2.8):

diff -u --recursive --new-file v2.2.7/linux/arch/ppc/kernel/syscalls.c
linux/arch/ppc/kernel/syscalls.c
--- v2.2.7/linux/arch/ppc/kernel/syscalls.c	Mon Oct  5 13:13:36 1998
+++ linux/arch/ppc/kernel/syscalls.c	Sat May  8 11:14:01 1999
@@ -205,12 +205,15 @@
 
 	lock_kernel();
 	if (!(flags & MAP_ANONYMOUS)) {
-		if (fd >= NR_OPEN || !(file = current->files->fd[fd]))
+		file = fget(fd);
+		if (!file)
 			goto out;
 	}
 	
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 	ret = do_mmap(file, addr, len, prot, flags, offset);
+	if (file)
+		fput(file);
 out:
 	unlock_kernel();
 	return ret;

--
Martin

Andreas Bogk wrote:
> 
> Hollis R Blanchard <hollis+@andrew.cmu.edu> writes:
> 
> > be broken for us for a little. Were you having problems with 2.2.x?
> 
> There is a problem with 2.2.9, and here's the patch:
> 
> diff -r -u linux-2.2.9/arch/ppc/kernel/syscalls.c linux/arch/ppc/kernel/syscalls.c
> --- linux-2.2.9/arch/ppc/kernel/syscalls.c      Sat May  8 20:14:01 1999
> +++ linux/arch/ppc/kernel/syscalls.c    Wed May 19 18:36:23 1999
> @@ -30,6 +30,7 @@
>  #include <linux/shm.h>
>  #include <linux/stat.h>
>  #include <linux/mman.h>
> +#include <linux/file.h>
>  #include <linux/sys.h>
>  #include <linux/ipc.h>
>  #include <linux/utsname.h>
> 
> I wonder why such trivial problems creep into so-called stable
> releases of the Linux kernel again and again. Does nobody care that on
> i386, you just go to ftp.kernel.org and download the latest version
> and it just works, whereas on PowerPC you have to find out:
> 
> - what CVS is
> - what vger is
> - what CVS tags are
> - which tag the one is which gives you a stable version ?
> 
> I don't care that the development kernel breaks on PPC. But that the
> official stable kernel breaks is a huge problem.

It seems that version-2.2.8 suffered from quite a lot of broken patches,
not only for the ppc architecture. 

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
