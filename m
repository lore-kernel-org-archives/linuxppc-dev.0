Message-ID: <3992D331.21C3BD9C@apus.co.at>
Date: Thu, 10 Aug 2000 18:07:13 +0200
From: Rene Pachernegg <rene.pachernegg@apus.co.at>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: syscall adressing problem
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I ve been debugging for more then 1 week now and I hope somebody can
help me with my problem.
Kernel: 2.2.14
Hardware: custom ppc740 board, 16MB RAM, flash card slot
                console via custom bus -> rs485 interface card --> pc
Cross-Compiler:
    binutils 2.9.5.0.37
    gcc-core 2.95.2
    glibc 2.1.3
    glibc-2.1.3-ctype-patch
    glibc-crypt-2.1
    glibc-linuxthreads-2.1.3

I cross-compiled the kernel, sysvinit, agetty, login, sash
Everthing works fine with static linking.
Dynamic linking causes the login to be impossible (Executing the dynamic
linked programs is working fine too). The reason is the following:
login calls getpwnam from glibc to read the passwd file into the
passwd-structure. The glibc its is calling a fopen("/etc/passwd"), which
invokes the syscall sys_open in open.c in the kernel.
When I printk the filename parameter in sys_open (even with
get_from_user) it reads just nonsense. So I checked the adress of the
parameter filename in the kernel and in the glibc, where filename
(/etc/passwd) is a const char. The are identical.

Further searching leaded to the following:
    Sometimes fopen or open syscall work well
    Whenever they dont work they are call from the libc.so and the
filename paramter adresses are 0x0fxxxxxx.

It seems to be something with the dynamic linker, but I have no idea
what exactly. I even changed my cross-compile utilities from
    glibc-2.1.2 --> glibc-2.1.3
    binutils-2.9.5.0.24 -> 2.9.5.0.37

regards,
    Rene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
