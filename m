Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4EB95681B8
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 09:13:19 +1100 (EST)
Date: Tue, 10 Jan 2006 23:13:14 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org, arndb@de.ibm.com
Message-ID: <20060110221313.GA24246@suse.de>
References: <200601091916.k09JGMJY004116@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200601091916.k09JGMJY004116@hera.kernel.org>
Subject: Re: [PATCH] powerpc: fix large nvram access
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Jan 09, Linux Kernel Mailing List wrote:

> tree da8f883f72d08f9534e9eca3bba662413b9bd865
> parent d52771fce4e774fa786097d34412a057d487c697
> author Arnd Bergmann <arnd@arndb.de> Fri, 09 Dec 2005 19:21:44 +0100
> committer Paul Mackerras <paulus@samba.org> Mon, 09 Jan 2006 14:53:31 +1100
> 
> [PATCH] powerpc: fix large nvram access
> 
> /dev/nvram uses the user-provided read/write size
> for kmalloc, which fails, if a large number is passed.
> This will always use a single page at most, which
> can be expected to succeed.
> 
> Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> 
>  arch/powerpc/kernel/nvram_64.c |  114 +++++++++++++++++++----------------------

this change breaks my nvsetenv binary on JS20.

(none):/# mount proc ; nvsetenv
Error reading /dev/nvram: Success
(none):/# strace -f nvsetenv
execve("/sbin/nvsetenv", ["nvsetenv"], [/* 61 vars */]) = 0
brk(0)                                  = 0x10014000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fe0000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=171714, ...}) = 0
mmap(NULL, 171714, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7fb6000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\325"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1569515, ...}) = 0
mmap(0xfe99000, 1401836, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xfe99000
madvise(0xfe99000, 1401836, MADV_SEQUENTIAL|0x1) = 0
mprotect(0xffd8000, 65536, PROT_NONE)   = 0
mmap(0xffe8000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13f000) = 0xffe8000
mmap(0xffed000, 9196, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffed000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fb5000
mprotect(0xffe8000, 4096, PROT_READ)    = 0
munmap(0xf7fb6000, 171714)              = 0
brk(0)                                  = 0x10014000
brk(0x10035000)                         = 0x10035000
open("/proc/device-tree/compatible", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=13, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fdf000
read(3, "IBM,1234-123\0", 1024)         = 13
read(3, "", 1024)                       = 0
close(3)                                = 0
munmap(0xf7fdf000, 4096)                = 0
open("/dev/nvram", O_RDONLY)            = 3
read(3, "P\347\0\34of-config\0\0\0", 16) = 16
lseek(3, 432, SEEK_CUR)                 = 448
read(3, "p\375\2\0common\0\0\0\0\0\0", 16) = 16
read(3, "ibm,fw-phandle-enable?=false\0lit"..., 8176) = 4096
dup(2)                                  = 4
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
fstat64(4, {st_mode=S_IFCHR|0600, st_rdev=makedev(5, 1), ...}) = 0
ioctl(4, TCGETS, {B38400 opost isig icanon echo ...}) = 0
mmap(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fc0000
_llseek(4, 0, 0xffd63fd8, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
write(4, "Error reading /dev/nvram: Succes"..., 34Error reading /dev/nvram: Success
) = 34
close(4)                                = 0
munmap(0xf7fc0000, 131072)              = 0
exit_group(1)                           = ?
(none):/# 


-- 
short story of a lazy sysadmin:
 alias appserv=wotan
