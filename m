Message-ID: <387D7A4B.FCA07105@huawei.com.cn>
Date: Thu, 13 Jan 2000 15:10:03 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compile Applications for 860 on x86
References: <386C150F.22B1A3D0@huawei.com.cn> <386ABF52.922267E9@ctam.com.au> <38701F3A.FAD6263E@huawei.com.cn> <386ADE53.D3411F6A@ctam.com.au> <38704D0B.94438516@huawei.com.cn> <386AFFC5.E0134DB8@ctam.com.au> <38708C86.2CD58E66@huawei.com.cn> <387142DF.7A3025D0@ctam.com.au> <38715DAE.B6CBC772@huawei.com.cn> <3871572F.FA4E7842@ctam.com.au> <38717C52.ECF1AFFD@huawei.com.cn> <3871953B.345DDA23@ctam.com.au> <38754F28.B6B4CE70@huawei.com.cn> <38754419.20D95C5A@ctam.com.au> <3876A6E5.3488738B@huawei.com.cn> <3876C6FD.794BD1BF@ctam.com.au> <387A87DF.4ED23CA6@huawei.com.cn> <387A81F3.702B29A2@ctam.com.au> <387C4D8D.9C058F1C@huawei.com.cn> <387D3212.A4E9904F@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




Brendan J Simon wrote:

> dony wrote:
>
> >       I want to cross-compile a very simple test program which have only one line:
> >
> >              printf("jsut a test.");
>
> I used puts("Brendan was here") as it is much simpler, but printf should work as well.
>
> >  But  the powerpc-linux-gcc seems to complain I lack of "crt1.o".
> > So what other tools I need to cross-compile my application except the powerpc-linux-*?
> > Thanks  very much.
> > dony
>
> I have crt1.o, crti.o and crtn.o in $prefix/$target/lib.  Initially they were put there
> when I unpacked the rpm files from the yellowdog distribution.  I was following some
> instructions from Kai Ruottu when I was trying to get my cross-compiler built.  I think
> I built glibc libraries from the source afterwards which should have replaced those ones
> but I'm not sure.
> Have you built glibc yet ?

Yes but failed. I following the following steps:

##################################
Cross Development for Linux/PPC

LibC
Get
ftp://sourceware.cygnus.com/pub/glibc/glibc-2.1.tar.gz
ftp://sourceware.cygnus.com/pub/glibc/glibc-linuxthreads-2.1.tar.gz
ftp://ftp.funet.fi/pub/gnu/funet/glibc-crypt-2.1.tar.gz
Build
ln -sf $CVS_LINUX_TOP/include/asm /usr/local/powerpc-linux/include/asm
ln -sf $CVS_LINUX_TOP/include/linux /usr/local/powerpc-linux/include/linux
tar zxf glibc-2.1.tar.gz
cd glibc-2.1
tar zxf ../glibc-crypt-2.1.tar.gz
tar zxf ../glibc-linuxthreads-2.1.tar.gz
mkdir build
cd build
CC=powerpc-linux-gcc AR=powerpc-linux-ar RANLIB=powerpc-linux-ranlib ../configure
--host=powerpc-linux --with-headers=$CVS_LINUX_TOP/include
--enable-add-ons=crypt,linuxthreads --prefix=/usr/local/powerpc-linux
make
make install
############################################

All except the last step are right. When I do "make install" , I get the following error:

########################################
../sysdeps/unix/sysv/linux/i386/profil-counter.h: In function `profil_counter':
In file included from ../sysdeps/unix/sysv/linux/powerpc/profil-counter.h:2,
                 from ../sysdeps/posix/profil.c:54,
                 from ../sysdeps/unix/sysv/linux/profil.c:3:
../sysdeps/unix/sysv/linux/i386/profil-counter.h:26: structure has no member named `regs'
../sysdeps/posix/profil.c:39: warning: inlining failed in call to `profil_count'
../sysdeps/unix/sysv/linux/i386/profil-counter.h:26: warning: called from here
make[2]: *** [/usr/local/powerpc-linux/glibc-2.1/build/gmon/profil.o] Error 1
make[2]: Leaving directory `/usr/local/powerpc-linux/glibc-2.1/gmon'
make[1]: *** [gmon/subdir_lib] Error 2
make[1]: Leaving directory `/usr/local/powerpc-linux/glibc-2.1'
make: *** [install] Error 2
################################

Since the glibc package is very very large, locating the file where errors occur (ie, where
struct singcontext is defined?) is a bit difficult.
Do you have any experience?

dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
