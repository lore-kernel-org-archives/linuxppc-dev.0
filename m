Return-Path: <mead@bnl.gov>
Received: from smtpgateway.bnl.gov (smtpgw.bnl.gov [130.199.3.132])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 750B1DDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 May 2007 02:05:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: zImage.elf loads but does not start
Date: Thu, 10 May 2007 12:05:25 -0400
Message-ID: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC2F391B@exchangemb3.bnl.gov>
In-Reply-To: <10409434.post@talk.nabble.com>
From: "Mead, Joseph" <mead@bnl.gov>
To: "Mirek23" <miroslaw.dach@psi.ch>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mirek,

I am facing the same exact problem.   I am using the ML403 with standard
UART but using initramfs to generate the root file system.   My root
file system contains the /dev/console node and a simple init file that
basically just tries to print out something.   I can tell it is finding
my /dev/console because I don't get the kernel warning : "Unable to open
an initial console"   (If I remove the /dev/console node I get the
warning)=20

My init program is just a simple hello world program (built statically)

printf("Hello World")
sleep(10)

I can tell that the program is running because after exactly 10seconds I
get a kernel panic, which indicates the end of the program, however I
can never see any messages from user space.


I also tried a statically built version of busybox as my init file but
still get no output.


my filesystem is built from the following file (using initramfs
functionality, which creates the root file system from this file)

dir /dev 755 0 0
nod /dev/console 644 0 0 c 5 1
nod /dev/ttyS0   644 0 0 c 4 64
dir /proc 755 0 0
dir /sys 755 0 0
file /init usr/busybox 755 0 0


I received one bit of information to check my interrrupt lines, but I
see Grant replied that the serial console is polled, so the interrupt
line is probably not the problem.


Please let me know if you make any progress...
Joe


=20

-----Original Message-----
From: linuxppc-embedded-bounces+mead=3Dbnl.gov@ozlabs.org
[mailto:linuxppc-embedded-bounces+mead=3Dbnl.gov@ozlabs.org] On Behalf =
Of
Mirek23
Sent: Thursday, May 10, 2007 4:45 AM
To: linuxppc-embedded@ozlabs.org
Subject: RE: zImage.elf loads but does not start


Thank you for all of the advices.
I did more study on that problem but still without the success.

1. I did redd the ELDK manual and I have invoked :
ELDK_FIXOWNER
ELDK_MAKEDEV

in the "dev" directory there were created many nodes like that:

crw-rw-rw-    1 root     root       5,   1 May  8 15:42 console
crw-rw-rw-    1 root     root       4,  64 May  8 15:42 ttyS0

In the kernel command line configuration I have the entry :
CONFIG_CMDLINE=3D"console=3DttyUL0,9600 root=3D/dev/nfs rw nfsroo ...

so I have created by hand the node:
crw-rw-rw-    1 root     root     204, 187 May  8 15:44 ttyUL0

Unfortunately the kernel boots to the point:

[    9.130834] Looking up port of RPC 100003/2 on 129.129.130.106
[    9.207363] Looking up port of RPC 100005/1 on 129.129.130.106
[    9.303794] VFS: Mounted root (nfs filesystem).
[    9.359316] Freeing unused kernel memory: 96k init

and after that it hangs.

I have made some modifications to the kernel init/main.c file. In that
file I have inserted the printk statements to see how far the kernel
goes. It seems to be that the last thing it does it executes the
sbin/init command and it hangs.

Instead of the sbin/init I have tried to execute other commands like
bin/echo this_is_text_string and bin/echo this_is_test >>
/var/log/messages

the modification looks like (init/main.c):
before modification:
        printk("test 3\n");
        run_init_process("/sbin/init");
        printk("test 4\n");
after modification
        printk("test 3\n");
        run_init_process("/bin/echo ala");
        run_init_process("/bin/echo buba >> /var/log/messages");
        printk("test 4\n");



In both cases the last thing which was printed is "test 3"
The /var/log/messages remains empty.

I thought that it might be the uart_lite driver is the source of the
problem. I rebuild the kernel configuring it for the standard UART
driver instead of the uart_lite.
This time my command line looks like:
CONFIG_CMDLINE=3D"console=3DttyS0,9600 root=3D/dev/nfs rw nfsroo ...

When booting the kernel configured with the UART  I see anything printed
on the screen so it is even worse than before.

Do you have any suggestions.

Best Regards

Mirek



Charles Krinke wrote:
>=20
> I find this usually happens when /dev/tty, /dev/console or /dev/ttyS0=20
> are not setup properly. That is, they are files instead of nodes. This

> menas you have mounted the root filesystem and init is running on that

> root filesystem.
>=20
> Charles
>=20
>=20
> -----Original Message-----
> From: linuxppc-embedded-bounces+ckrinke=3Distor.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+ckrinke=3Distor.com@ozlabs.org] On=20
> Behalf Of Adrian Craine
> Sent: Tuesday, May 08, 2007 2:50 PM
> To: Leonid
> Cc: linuxppc-embedded@ozlabs.org; Mirek23
> Subject: Re: zImage.elf loads but does not start
>=20
> Leonid wrote:
>> rootpath=3D
>> [    9.130834] Looking up port of RPC 100003/2 on 129.129.130.106
>> [    9.207363] Looking up port of RPC 100005/1 on 129.129.130.106
>> [    9.303794] VFS: Mounted root (nfs filesystem).
>> [    9.359316] Freeing unused kernel memory: 96k init
>> [    9.422162] Warning: unable to open an initial console.
>>
>>  =20
> The exact device node this requires is /dev/console c 5 1 That should=20
> solve your issue.
>=20
> Cheers,
>              Adrian.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

--
View this message in context:
http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10
409434
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
