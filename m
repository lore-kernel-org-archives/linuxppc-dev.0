From: "Conor O'Gorman" <conor.ogorman@virtualaccess.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: hints on read() - EFAULT problem
Date: Fri, 9 Feb 2001 16:24:46 -0000
Message-ID: <NDBBIBBPELJMGDCMPCLAIEMDCHAA.conor.ogorman@virtualaccess.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I've got a custom board with an 860, montavista build tools, and kernel
2.4.0 test2.

When running ttcp in receive mode I get an IO error. According to strace
there is a problem with read()'ing from the socket, see console log below.

I thought it had something to do with copy_to_user() so I added a printk()
that shows 'to', 'from' and 'n' vars in '[', ']' brackets. The same straced
read() with printk output:

read(4, [10018000|c0f89852|000005a8]0x10018000, 8192)               = -1
EFAULT (Bad address)

Any hints, tips on the problem? I note the 'from' kernel address above is
only short aligned. Is the memory setup bad? I don't get the problem for
ttcp transmit, but it does showup doing an 'ls -l' on an nfs mounted root
filesys. But not a simple 'ls'.

Thanks
Conor



console log (probably a mess due to my email client.
-------------------------------------------------------------------
execve("/bin/ttcp", ["ttcp", "-r", "-s"], [/* 11 vars */]) = 0
brk(0)                                  = 0x100165d8
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or
directory)
open("/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux/lib/libc.so.6",
O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=4193386, ...}) = 0
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\2&l"..., 4096) =
4096
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30014000
mmap(0xfee7000, 1083704, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfee7000
mprotect(0xffca000, 153912, PROT_NONE)  = 0
mmap(0xffd7000, 81920, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0xe0000) = 0xffd7000
mmap(0xffeb000, 18744, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffeb000
close(3)                                = 0
getpid()                                = 7
brk(0)                                  = 0x100165d8
brk(0x1001c5f0)                         = 0x1001c5f0
brk(0)                                  = 0x1001c5f0
brk(0x1001d000)                         = 0x1001d000
fstat(1, [7ffff518|c061bdf8|00000048]{st_mode=S_IFCHR|0600,
st_rdev=makedev(5, 1), ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30015000
ioctl(1, TCGETS, 0x7ffff418)            = 0
write(1, "ttcp-r: buflen=8192, nbuf=2048, "..., 62ttcp-r: buflen=8192,
nbuf=2048, align=16384/0, port=5001  tcp
) = 62
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
write(2, "ttcp-r: socket\n", 15ttcp-r: socket
)        = 15
bind(3, {sin_family=AF_UNSPEC, {sa_family=0,
sa_data="\23\211\0\0\0\0\0\0\0\0\0\0\0\0"}, 16) = 0
rt_sigaction(SIGPIPE, {0x10000bc0, [], SA_RESTART},
[7ffffbb8|c061be48|00000014]{SIG_DFL}, 8) = 0
listen(3, 0)                            = 0
accept(3, {sin_family=AF_INET, sin_port=htons(1363),
sin_addr=inet_addr("10.1.1.60")}}, [16]) = 4
getpeername(4, {sin_family=AF_INET, sin_port=htons(1363),
sin_addr=inet_addr("10.1.1.60")}}, [16]) = 0
write(2, "ttcp-r: accept from 10.1.1.60\n", 30ttcp-r: accept from 10.1.1.60
) = 30
gettimeofday({4292222560, 448362}, NULL) = 0
getrusage(RUSAGE_SELF, {ru_utime={0, 30000}, ru_stime={0, 50000}, ...}) = 0
read(4, [10018000|c0f89852|000005a8]0x10018000, 8192)               = -1
EFAULT (Bad address)
write(2, "ttcp-r: ", 8ttcp-r: )                 = 8
write(2, "IO: Bad address\n", 16IO: Bad address
)       = 16
write(2, "errno=14\n", 9errno=14
)               = 9
munmap(0x30015000, 4096)                = 0
exit(1)                                 = ?
-------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
