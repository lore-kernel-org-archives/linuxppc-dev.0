Date: Tue, 18 Jul 2000 10:36:11 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux-2.4.0-test4 - problems in memory management?
Message-ID: <Pine.LNX.4.21.0007172015350.356-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

If I boot Linux-2.4.0-test4 on RPX/Lite and try to "cat" a file I'm
getting a "Bad address" error for some files. Writing, executing and
low-level reading are Ok. In fact, I have to use "init=/bin/sh" to boot
the kernel, since init from Busybox cannot even read /etc/inittab

This is a minimal test program (which is the result of subsequent
"unrolling" and simplification of libc internals):
=======================
#include <stdio.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#define BUF_SIZE 0x10000

int main(int argc, char **argv)
{
	int fd;
	char *p;
	fd = open (argv[1], O_RDONLY);
	p = (char *) mmap(0, BUF_SIZE, PROT_READ | PROT_WRITE,
		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
//	*(p) = 0;
	perror("point1");
	read (fd, p, BUF_SIZE);
	perror("point2");
	exit (0);
}
=======================

This program always works on existing regular files on Linux/PPC (G3,
kernel 2.2.14) and RPX/Lite with the Montavista kernel 2.2.13-7.

However, it fails on some (maybe all) regular files if Linux-2.4.0-test4
is used. It fails on NFS and procfs, but not on character devices:

# t1 /dev/zero
point1: Success
point2: Success
# t1 /proc/version
point1: Success
point2: Bad address
# t1 /bin/sh
point1: Success
point2: Bad address

If I uncomment "*(p) = 0;" it works on all files, but it's a workaround,
not a solution.

The same results have been reproduced with Linux-2.4.0-test5-pre1

Regards,
Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
