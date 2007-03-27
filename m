Return-Path: <kryn@in2p3.fr>
Received: from ccimap.in2p3.fr (ccimap.in2p3.fr [134.158.69.6])
	by ozlabs.org (Postfix) with ESMTP id 7DC39DDEDB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Mar 2007 21:05:38 +1000 (EST)
Message-ID: <4608DF55.90508@in2p3.fr>
Date: Tue, 27 Mar 2007 11:09:41 +0200
From: Didier Kryn <kryn@in2p3.fr>
MIME-Version: 1.0
To: Konstantin Boyanov <kkboyanov@gmail.com>
Subject: Re: Reading and writing from/to VME device
References: <929bf310703260814q18957942s218d56bed8fb4009@mail.gmail.com>
In-Reply-To: <929bf310703260814q18957942s218d56bed8fb4009@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Hi Konstantin,
    I am new to this board, and, by chance I am just starting this week=20
my first test wit the VME on this board (I have however more than 20=20
years of VME experience). Your whole logic is mainly OK.  My driver uses =

slightly different device names but it seems very similar and the API=20
uses the same structures. I just noticed three things which bother me:
    1) You declare outWinCfg and use later in the code outWinCfgADC. I=20
guess the compiler will complain, unless I missed something. I guess=20
this is not the file you actually compiled.
    2) Why do you specify MAP_SHARED in the mmap() call ? I sort of=20
understood that the philosophy of this driver was all against sharing.=20
Maybe it works, but I wouldn't try it the first time.
    3) I think it is an error to declare your data pointer as a u_char=20
*. If you configure your interface for D16, you must perform D16 access. =

For example, you might do the following:

unsigned short *rdPtr;
=2E..
rdPtr =3D (unsigned short *)mmap(...);
    for(i=3D0;i<0x50;i++){
       printf("# Read at VME address %x =3D %x\n", i*sizeof(*rdPtr),=20
rdPtr[i] );
    }

I like using sizeof() instead of 2 because it remains valid if you=20
convert your code for D32.
If you want to perform D8 access, you should configure your window=20
accordingly. Beware that there are 2 kinds of D8 transfers, which make=20
them more complicated and, for that reason mostly abandonned. IIRC, the=20
VITA standard for CR/CSR defines 1byte data words at even addresses so=20
as to transfer them as D16. Therefore you should transfer them as short=20
and then mask the high order byte. I don't know what the high order byte =

will be in case of successfull transfer. If it is 0, then it is fine,=20
because, since a bus error would set all bits to 1, you can check=20
immediately the sucess of the transfer.

    Hope this helps.
    Didier

Konstantin Boyanov a =E9crit :
> Hi list,
>
> I'm using the MVME6100 board with the Motorola driver for linux v3.5=20
> (kernel 2.6.15). I try to access the CSR registers of an ADC board, in =

> order to configure it as to be able to access its memory, on the VME=20
> bus using one of the outbound windows defined by the driver. As I am=20
> new to the whole VME stuff, I'm getting into trouble to find out when=20
> I'm actually reading something on the VME, i.e. which addresses respond=
=2E
> I'm trying the following schema (source code @ EOM):
>
> 1. open() and ioctl() one of the /dev/vme_m* devices, which I assume=20
> is corresponding to an outbound window (at least I try to configure it =

> as one),
> 2. then mmap() a memory area to hold the contents of the /dev/vme_m*=20
> device file
> 3. and finally doing incrementation of the pointer returned by mmap()=20
> and dereferencing it in the hope that I'll read something, which in=20
> most cases is 0xFF
>
> In fact my code is very similar to test code that comes with the=20
> driver and also with a sample code I found in this thread=20
> ->http://ozlabs.org/pipermail/linuxppc-dev/1999-May/001906.html=20
> <http://ozlabs.org/pipermail/linuxppc-dev/1999-May/001906.html>
> I've tried to do a read() on the opened /dev/vme_m* device but I only=20
> succeed in reading 0 bytes, and when I try to read in chunks from the=20
> VME bus i get errno 22 on reads like read(fd, buffer, 1024) for example=
=2E
>
> I don't know if my strategy is correct in the first place but that's=20
> what I came up with.
> When I try to run one of the test applications that came with the=20
> driver (the "testout" one) I get an errno =3D 29 (Illegal seek?! ) on=20
> the read() operations.
> So my question is whether I make the right steps in reading an address =

> on the VME bus. I know I'm missing something, so I'll be glad to get=20
> some directions as to how to be sure whether I'm reading something=20
> from the VME bus and where I'm able to write.
>
> Best regards,
> Konstantin
> ________________________________
>
> #include <stdio.h>
> #include <string.h>
> #include <errno.h>
> #include <sys/ioctl.h>
> #include <unistd.h>
> #include "vmedrv.h"
>
> int main(int argc, char* argv[])
> {
>     vmeOutWindowCfg_t outWinCfg;
>     vmeOutWindowCfg_t outWinGet;
>
>     int fdOut, status, i, j;
>     unsigned int  n;
>     u_char *rdPtr, *getPtr;
>
>     if(getMyVmeInfo()){
>       printf("getMyVmeInfo failed.\n");
>       exit (1);
>     }
>
>     fdOut =3D open("/dev/vme_m0", O_RDWR);
>     perror("open");
>     if(fdOut < 0){
>       printf("Opening /dev/vme_m0 failed. Errno =3D %d\n", errno);
>     }
>
>     memset(&outWinCfgADC, 0, sizeof(vmeOutWindowCfg_t));
>     perror("memset");
>
>     outWinCfgADC.windowNbr           =3D 0;
>     outWinCfgADC.windowEnable     =3D 1;
>     outWinCfgADC.wrPostEnable      =3D 0;
>     outWinCfgADC.userAccessType  =3D VME_SUPER;
>     outWinCfgADC.dataAccessType  =3D VME_DATA;
>     outWinCfgADC.windowSizeL        =3D 0x200000;
>     outWinCfgADC.xferProtocol         =3D VME_SCT;
>     outWinCfgADC.addrSpace           =3D VME_A24;
>     outWinCfgADC.maxDataWidth     =3D VME_D16;
>
>     status =3D ioctl(fdOut, VME_IOCTL_SET_OUTBOUND, &outWinCfgADC);
>     perror("ioctl");
>     if(status < 0){
>         printf("*** ioctl set on outWinCfgADC failed. Errno =3D %d\n", =

> errno);
>         exit (1);
>     }
>     memset(&outWinGetADC, 0, sizeof(vmeOutWindowCfg_t));
>     outWinGetADC.windowNbr =3D 0;
>
>     status =3D ioctl(fdOut, VME_IOCTL_GET_OUTBOUND, &outWinGetADC);
>     perror("ioctl");
>     if(status < 0){
>         printf("*** ioctl get on outWinGetADC failed. Errno =3D %d\n", =

> errno);
>         exit (1);
>     }
>
>     /*
>      * Check wheather the get and set configurations are the same
>      */
>
>     getPtr =3D (u_char *) mmap(0, outWinCfgADC.windowSizeL,=20
> PROT_READ|PROT_WRITE, MAP_SHARED, fdOut, 0);
>     perror("mmap");
>     printf("# Start of outbound win in virtual address space of the=20
> process: %p\n", getPtr);
>
>     rdPtr =3D getPtr;
>
>     for(i=3D0;i<0x100;i++){
>        printf("# Read at address %x =3D %x\n", rdPtr, *rdPtr);
>        rdPtr++;
>     }
>
>     status =3D close(fdOut);
>     if(status !=3D 0){
>         printf("*** close() failed. Errno =3D %d\n", errno);
>         exit (1);
>     }
>   =20
>     return 0;
> }
>
> __________________________________
> Part of the output:
>
> mmap: Illegal seek
> # Start of outbound win in virtual address space of the process:=20
> 0x30029000
> # Read at address 30029000 =3D ff
> # Read at address 30029001 =3D ff
> # Read at address 30029002 =3D ff
> # Read at address 30029003 =3D ff
> # Read at address 30029004 =3D ff
> # Read at address 30029005 =3D ff
> # Read at address 30029006 =3D ff
> # Read at address 30029007 =3D ff
> # Read at address 30029008 =3D ff
> # Read at address 30029009 =3D ff
> # Read at address 3002900a =3D ff
> # Read at address 3002900b =3D ff
>
> and etc.
> -----------------------------------------------------------------------=
-
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
