Return-Path: <e139499@metu.edu.tr>
Received: from mail.metu.edu.tr (likya.general.services.metu.edu.tr
	[144.122.144.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F588B7D2F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Feb 2010 20:04:31 +1100 (EST)
Received: from metu.edu.tr (allianoi.general.services.metu.edu.tr
	[144.122.144.182])
	by mail.metu.edu.tr (Postfix) with ESMTP id 0803340014
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Feb 2010 10:54:45 +0200 (EET)
Message-ID: <20100202105444.52796zhe2s5fvgic@horde.metu.edu.tr>
Date: Tue, 02 Feb 2010 10:54:44 +0200
From: Eda Ercan <e139499@metu.edu.tr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Locale issue
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am trying to setlocale on ppc, but due to memory shortage, the  
locale package is not installed completely- only the related files are  
copied. There may be a missing file but I cannot find which is.

int main()
{
     if ( setlocale(LC_COLLATE,"tr_TR") == NULL )
         printf("could not set locale\n");
     return 0;
}

setlocale does not work and the code prints the err message. strace  
output is as follows. I cannot understand why it is trying to open
"/usr/lib/locale/tr/LC_COLLATE" after finding  
"/usr/lib/locale/tr_TR/LC_COLLATE".
Does anybody have an idea??



execve("./m", ["m"], [/* 8 vars */])    = 0
uname({sys="Linux", node="z1", ...})    = 0
brk(0)                                  = 0x10010a4c
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,  
0) = 0x30015000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or  
directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or  
directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\300"...,  
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1299948, ...}) = 0
mmap(0xfea1000, 1370752, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfea1000
mprotect(0xffd8000, 96896, PROT_NONE)   = 0
mmap(0xffe1000, 49152, PROT_READ|PROT_WRITE|PROT_EXEC,  
MAP_PRIVATE|MAP_FIXED, 3, 0x130000) = 0xffe1000
mmap(0xffed000, 10880, PROT_READ|PROT_WRITE|PROT_EXEC,  
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffed000
close(3)                                = 0
brk(0)                                  = 0x10010a4c
brk(0x10011a4c)                         = 0x10011a4c
brk(0x10012000)                         = 0x10012000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = -1  
ENOENT (No such file or directory)
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2601, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,  
0) = 0x30016000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2601
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x30016000, 4096)                = 0
open("/usr/lib/locale/tr_TR/LC_COLLATE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=22471, ...}) = 0
mmap(NULL, 22471, PROT_READ, MAP_PRIVATE, 3, 0) = 0x30016000
close(3)                                = 0
munmap(0x30016000, 22471)               = 0
open("/usr/lib/locale/tr/LC_COLLATE", O_RDONLY) = -1 ENOENT (No such  
file or directory)
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(3, 0), ...}) = 0
ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,  
0) = 0x30016000
write(1, "could not set locale\n", 21could not set locale
)  = 21
munmap(0x30016000, 4096)                = 0
exit(0)                                 = ?


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
