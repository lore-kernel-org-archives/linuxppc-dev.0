From: "Ramzi Maalouf" <maalouf@pyxsys.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: insmod fails HardHat Linux on a Walnut eval kit
Date: Wed, 17 Jan 2001 12:32:48 -0500
Message-ID: <HLEMJIMPGFPIGKHADMOIOECACAAA.maalouf@pyxsys.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello -
	I created a hello world module, cross-compiled, and then ran insmod.
Insmod causes a segmentation fault.  I ran the strace and this is the
output.  Has anybody has any similiar problems, what did you do ?

-ramzi


execve("/bin/insmod", ["insmod", "fred.o"], [/* 14 vars */]) = 0
brk(0)                                  = 0x100173f8
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or
directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=4258241, ...}) = 0
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\2\'"..., 4096) =
4096
mmap(0xfee3000, 1100504, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfee3000
mprotect(0xffca000, 154328, PROT_NONE)  = 0
mmap(0xffd3000, 98304, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0xe0000) = 0xffd3000
mmap(0xffeb000, 19160, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffeb000
close(3)                                = 0
getpid()                                = 104
brk(0)                                  = 0x100173f8
brk(0x10017418)                         = 0x10017418
brk(0)                                  = 0x10017418
brk(0x10018000)                         = 0x10018000
open("fred.o", O_RDONLY)                = 3
SYS_197(0x3, 0x7ffffb58, 0x7ffffb58, 0, 0) = -1 ENOSYS (Function not
implemented)
fstat(3, {st_mode=S_IFREG|0644, st_size=708, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30014000
_llseek(0x3, 0, 0, 0x7ffffbc8, 0)       = 0
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\1\0\24\0\0\0\1\0\0\0"..., 4096) =
708_llseek(0x3, 0, 0x2c4, 0x7ffffa50, 0)   = 0
_llseek(0x3, 0, 0x2c4, 0x7ffffa50, 0)   = 0
_llseek(0x3, 0, 0x2c4, 0x7ffffa50, 0)   = 0
brk(0)                                  = 0x10018000
brk(0x10019000)                         = 0x10019000
_llseek(0x3, 0, 0x2c4, 0x7ffffa50, 0)   = 0
_llseek(0x3, 0, 0x2c4, 0x7ffffa50, 0)   = 0
_llseek(0x3, 0, 0x2c4, 0x7ffffa50, 0)   = 0
uname({sys="Linux", node="140.249.0.247", ...}) = 0
query_module(NULL, 0, NULL, 0)          = 0
query_module(NULL, QM_MODULES, { /* 0 entries */ }, 0) = 0
brk(0)                                  = 0x10019000
brk(0x1001e000)                         = 0x1001e000
query_module(NULL, QM_SYMBOLS, 0x10018218, 16384, 28914) = -1 ENOSPC (No
space left on device)
brk(0)                                  = 0x1001e000
brk(0x10026000)                         = 0x10026000
query_module(NULL, QM_SYMBOLS, { /* 856 entries */ }, 856) = 0
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
