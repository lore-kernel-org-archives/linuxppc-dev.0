Return-Path: <ilopez@albatros-sl.es>
Received: from sina-sl.es (unknown [82.198.120.42])
	by ozlabs.org (Postfix) with ESMTP id B97212BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Nov 2004 04:55:28 +1100 (EST)
Date: Wed, 24 Nov 2004 18:23:10 +0100
Message-ID: <42A622EB18325843894BB8E1040E3DF502283F@sinaexchf>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
From: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
To: <linuxppc-embedded@ozlabs.org>
Subject: Pthread dynamic linking problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.

We're using use ELDK 3.0 with kernel linuxppc_2_4_devel from DENX CVS on =
a Lite5200 board.
The problem arises linking a program with a library using fopen and the =
pthread lib dynamically. My program gets stucked when doing a fopen =
call. This doesn't happen if the linking is static (against .a).
Here are an example library and program that show this problem:

* The main program is:

//
// cositas.cpp
//
#include <stdio.h>
#include <pthread.h>

void Polopos(char *fname);

int main(int argc, char **argv)
{
  pthread_t th;
=09
	// Do things
	Polopos("/etc/AVMRecorder.conf");

  return 0;
}

* The library it uses along with pthread lib is:

//=20
// acasitos.cpp
//
#include <stdio.h>

void Polopos(char *foo)
{
	fprintf(stderr, "Opening file %s...\n", foo);
	FILE* cositas =3D fopen(foo, "rt");
	fprintf(stderr, "...file %s open\n", foo);
	fprintf(stderr, "Closing file %s...\n", foo);
	fclose(cositas);
	fprintf(stderr, "...file %s closed\n", foo);
}

* To build the shared lib I issue the following commands:

 @ /usr/local/ppc_82xx/bin/ppc_82xx-g++ -c -o acasitos.o =
-I/usr/local/ppc_82xx/local/include acasitos.cpp
 @ /usr/local/ppc_82xx/bin/ppc_82xx-ld -o libacasitos.so acasitos.o

* And for the final binary:

 @ /usr/local/ppc_82xx/bin/ppc_82xx-g++ -o cositas -L. =
-I/usr/local/ppc_82xx/local/include -lpthread -lacasitos cositas.cpp


* The output for the program is:

 Opening file /etc/AVMRecorder.conf...

* The output of strace is:

execve("./cositas", ["./cositas"], [/* 20 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"localhost", ...}) =3D 0
brk(0)                                  =3D 0x10011c68
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or =
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D11995, ...}) =3D 0
mmap(NULL, 11995, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x30015000
close(3)                                =3D 0
open("/lib/libpthread.so.0", O_RDONLY)  =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0@\374"..., =
1024) =3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D1416528, ...}) =3D 0
mmap(0xff8f000, 395776, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0xff8f000
mprotect(0xff9d000, 338432, PROT_NONE)  =3D 0
mmap(0xff9f000, 69632, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED, 3, 0) =3D 0xff9f000
mmap(0xffb0000, 260608, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0xffb0000
close(3)                                =3D 0
open("/usr/local/lib/libacasitos.so", O_RDONLY) =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\4"..., =
1024) =3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D3141, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x30018000
mmap(0xff6e000, 67136, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0xff6e000
mprotect(0xff6f000, 63040, PROT_NONE)   =3D 0
mmap(0xff7e000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED, 3, 0) =3D 0xff7e000
close(3)                                =3D 0
open("/usr/lib/libstdc++.so.5", O_RDONLY) =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\4C\250"..., =
1024) =3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D809956, ...}) =3D 0
mmap(0xfe82000, 898616, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0xfe82000
mprotect(0xff35000, 165432, PROT_NONE)  =3D 0
mmap(0xff42000, 86016, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED, 3, 0xb0000) =3D 0xff42000
mmap(0xff57000, 26168, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0xff57000
close(3)                                =3D 0
open("/lib/libm.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\242"..., =
1024) =3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D497740, ...}) =3D 0
mmap(0xfdec000, 545232, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0xfdec000
mprotect(0xfe5f000, 74192, PROT_NONE)   =3D 0
mmap(0xfe6c000, 20480, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED, 3, 0x70000) =3D 0xfe6c000
mmap(0xfe71000, 464, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0xfe71000
close(3)                                =3D 0
open("/lib/libc.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\300"..., =
1024) =3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D1363888, ...}) =3D 0
mmap(0xfc8d000, 1370128, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0xfc8d000
mprotect(0xfdc4000, 96272, PROT_NONE)   =3D 0
mmap(0xfdcd000, 49152, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED, 3, 0x130000) =3D 0xfdcd000
mmap(0xfdd9000, 10256, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0xfdd9000
close(3)                                =3D 0
mprotect(0xfc8d000, 1273856, PROT_READ|PROT_WRITE) =3D 0
mprotect(0xfc8d000, 1273856, PROT_READ|PROT_EXEC) =3D 0
mprotect(0xff6e000, 4096, PROT_READ|PROT_WRITE) =3D 0
mprotect(0xff6e000, 4096, PROT_READ|PROT_EXEC) =3D 0
munmap(0x30015000, 11995)               =3D 0
getpid()                                =3D 1212
rt_sigaction(SIGRTMIN, {0xff97690, [], 0}, NULL, 8) =3D 0
rt_sigaction(SIGRT_1, {0xff97548, [], 0}, NULL, 8) =3D 0
rt_sigaction(SIGRT_2, {0xff976c8, [], 0}, NULL, 8) =3D 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) =3D 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0x7ffff898, 33, (nil), 0}) =3D 0
brk(0)                                  =3D 0x10011c68
brk(0x10012c68)                         =3D 0x10012c68
brk(0x10013000)                         =3D 0x10013000
write(2, "Opening file /etc/AVMRecorde"..., 42Opening file =
/etc/AVMRecorder.conf...
) =3D 42
rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) =3D 0
rt_sigsuspend([] <unfinished ...>


It remains in the last line until I Ctrl-C the program.

Thanks in advance
