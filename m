Message-ID: <3FB01392.60500@g-house.de>
Date: Mon, 10 Nov 2003 23:39:14 +0100
From: Christian <evil@g-house.de>
MIME-Version: 1.0
To: linas@austin.ibm.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc32 lockups with 2.6
References: <3FA5698A.9000905@g-house.de> <3FAABE62.4090804@g-house.de> <20031110125044.A22030@forte.austin.ibm.com>
In-Reply-To: <20031110125044.A22030@forte.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


linas@austin.ibm.com wrote:
> I'd suggest getting the KDB kernel patches, and then poking around to
> see what the system was doing when it locked up.

kdb, hm, i'll see if i can handle this. would some output from gdb help too?


> What were the stack traces? does it always lock up in the same routine?

the debugger will show, as nothing else showed up and even SysReq was
not working anymore.

> What line of code was it
> executiing when it did that?

last snippet of the "strace ifconfig eth1 192.168.1.1":

ioctl(4, 0x8916, 0x7ffffd78)            = -1 ENODEV (No such device)
dup(2)                                  = 5
fcntl64(5, F_GETFL)                     = 0x2 (flags O_RDWR)
fstat64(5, {st_mode=S_IFCHR|0600, st_rdev=makedev(5, 1), ...}) = 0
ioctl(5, TCGETS, {B38400 opost isig icanon echo ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x30016000
_llseek(5, 0, 0x7ffffb68, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
write(5, "SIOCSIFADDR: No such device\n", 28) = 28
close(5)                                = 0
munmap(0x30016000, 4096)                = 0
ioctl(4, 0x8913, 0x7ffffc98)            = -1 ENODEV (No such device)
write(2, "eth1: ERROR while getting interf"..., 58) = 58
exit(-1)                                = ?

Thanks,
Christian.

--
BOFH excuse #231:

We had to turn off that service to comply with the CDA Bill.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
