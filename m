Return-Path: <mead@bnl.gov>
Received: from smtpgateway.bnl.gov (smtpgw.bnl.gov [130.199.3.132])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E89EDDED7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 May 2007 23:13:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: zImage.elf loads but does not start
Date: Tue, 15 May 2007 09:12:53 -0400
Message-ID: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC2F39A4@exchangemb3.bnl.gov>
In-Reply-To: <10621564.post@talk.nabble.com>
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

If you think the networking might be the source of the problem maybe try
to make a very simple root file system using initramfs to see if you can
get the init program (or busybox) working.  =20

Just create a file in that looks something like:

dir /dev 755 0 0
nod /dev/console 644 0 0 c 5 1
nod /dev/ttyS0   644 0 0 c 4 64
dir /proc 755 0 0
dir /sys 755 0 0
file /init usr/busybox 755 0 0

and then tell the kernel about it General_Setup-> Initramfs source
file(s)

It will build the file system into the kernel image.

Also, thanks for the files.=20

Joe
=20

-----Original Message-----
From: linuxppc-embedded-bounces+mead=3Dbnl.gov@ozlabs.org
[mailto:linuxppc-embedded-bounces+mead=3Dbnl.gov@ozlabs.org] On Behalf =
Of
Mirek23
Sent: Tuesday, May 15, 2007 8:09 AM
To: linuxppc-embedded@ozlabs.org
Subject: RE: zImage.elf loads but does not start


>It seems to be that the console works fine and the root file system is
mounted properly via NFS.
>I do not however understand why eldk4.1 init does not work.

I have done some more investigations. My observation is as following:

The eldk4.1/ppc_4xx root file system has the init which is not
statically built. When I removed the lib directory on the NFS
server:/opt/eldk4.1/ppc_4xx/lib the kernel has booted up to the point:

[    9.302101] VFS: Mounted root (nfs filesystem).
[    9.357642] Freeing unused kernel memory: 96k init
[    9.481509] Kernel panic - not syncing: No init found.  Try passing
init=3D
option to kernel.


When the lib directory was present the last printed message was:
[    9.357642] Freeing unused kernel memory: 96k init

I have observed the same behaviour with busybox accessed via NFS.
I have compiled busybox with crosstool-0.43 (gcc-4.0.2 glibc-2.3.2)
because
eldk4.1 crosscompilers failed to compile busybox. When using busybox
mounted via NFS I copied the lib directory from crosstool.
Unfortunately also this time the system hanged at init.

My own version of init which uses printf just to print the string to the
screen runs however fine.

Would somebody have some suggestion what might cause the problem to
properly launch the init command.

Best Regards

Mirek
--
View this message in context:
http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10
621564
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
