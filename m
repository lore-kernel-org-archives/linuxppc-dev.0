Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DEA98DDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 May 2007 23:29:00 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Hp2Vt-0001TB-FE
	for linuxppc-embedded@ozlabs.org; Fri, 18 May 2007 06:28:57 -0700
Message-ID: <10682140.post@talk.nabble.com>
Date: Fri, 18 May 2007 06:28:57 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: RE: zImage.elf loads but does not start
In-Reply-To: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC2F39A4@exchangemb3.bnl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10079346.post@talk.nabble.com> <10142161.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C0159BAAE@ehost011-3.exch011.intermedia.net>
	<10165159.post@talk.nabble.com> <10323147.post@talk.nabble.com>
	<463B5422.6030105@ru.mvista.com> <10372619.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C017019FD@ehost011-3.exch011.intermedia.net>
	<4640F08E.5040608@nec.com.au>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C06A207@MERCURY.inside.istor.com>
	<10409434.post@talk.nabble.com>
	<D1AFFAE2CC4BD54CA4C1543CFF4A4FCC2F391B@exchangemb3.bnl.gov>
	<10429898.post@talk.nabble.com> <10621564.post@talk.nabble.com>
	<D1AFFAE2CC4BD54CA4C1543CFF4A4FCC2F39A4@exchangemb3.bnl.gov>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Joe,

I have done this what you have suggested:

I have built statically busybox. During compilation of the busy box I have
go a warning that static build is buggy
but I have built the statically linked binary anyhow.

After that I have created the file:

dir /dev 755 0 0
nod /dev/console 644 0 0 c 5 1
nod /dev/ttyUL0    644 0 0 c 208  187
dir /proc 755 0 0
dir /sys 755 0 0
file /init /myrootfs/busybox 755 0 0

Next I have run the program 

usr/gen_init_cpio myList > myList.cpio

I have set in the .config CONFIG_INITRAMFS_SOURCE="myInit.cpio"
I have modified the CONFIG_CMDLINE="console=ttyUL0,9600"

I have built successfully the kernel and loaded it to my board. 
When I have tried to boot the kernel I got as following:

---------------------------------------------------------------------------------------------------------
loaded at:     00400000 0052C138                                                                                                                                                     
board data at: 0052A120 0052A138                                                                                                                                                     
relocated to:  00404040 00404058                                                                                                                                                     
zimage at:     00404DCD 00529D69                                                                                                                                                     
avail ram:     0052D000 04000000                                                                                                                                                     
                                                                                                                                                                                     
Linux/PPC load: console=ttyUL0,9600                                                                                                                                                  
Uncompressing Linux...done.                                                                                                                                                          
Now booting the kernel    

---------------------------------------------------------------------------
And the kernel did not start.

I have also tried various options:
console=ttyUL0,9600 root=/dev/initrd rw rdinit=/init
or 
console=ttyUL0,9600 root=/dev/ram0 rw rdinit=/init

Nothing helped.

I have also done the experiment:

I have set in the .config CONFIG_INITRAMFS_SOURCE=""
I have modified the CONFIG_CMDLINE="console=ttyUL0,9600"

When I have rebuilt the kernel it started to boot up to the point to mount
nfs and it failed.

Any idea why it did not boot with initramfs build in?

The kernel size with simple initramfs is 1.4 MB and without initramfs 1.1
MB.


Best Regards

Mirek






Mead, Joseph wrote:
> 
> Hi Mirek,
> 
> If you think the networking might be the source of the problem maybe try
> to make a very simple root file system using initramfs to see if you can
> get the init program (or busybox) working.   
> 
> Just create a file in that looks something like:
> 
> dir /dev 755 0 0
> nod /dev/console 644 0 0 c 5 1
> nod /dev/ttyS0   644 0 0 c 4 64
> dir /proc 755 0 0
> dir /sys 755 0 0
> file /init usr/busybox 755 0 0
> 
> and then tell the kernel about it General_Setup-> Initramfs source
> file(s)
> 
> It will build the file system into the kernel image.
> 
> Also, thanks for the files. 
> 
> Joe
>  
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+mead=bnl.gov@ozlabs.org
> [mailto:linuxppc-embedded-bounces+mead=bnl.gov@ozlabs.org] On Behalf Of
> Mirek23
> Sent: Tuesday, May 15, 2007 8:09 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: RE: zImage.elf loads but does not start
> 
> 
>>It seems to be that the console works fine and the root file system is
> mounted properly via NFS.
>>I do not however understand why eldk4.1 init does not work.
> 
> I have done some more investigations. My observation is as following:
> 
> The eldk4.1/ppc_4xx root file system has the init which is not
> statically built. When I removed the lib directory on the NFS
> server:/opt/eldk4.1/ppc_4xx/lib the kernel has booted up to the point:
> 
> [    9.302101] VFS: Mounted root (nfs filesystem).
> [    9.357642] Freeing unused kernel memory: 96k init
> [    9.481509] Kernel panic - not syncing: No init found.  Try passing
> init=
> option to kernel.
> 
> 
> When the lib directory was present the last printed message was:
> [    9.357642] Freeing unused kernel memory: 96k init
> 
> I have observed the same behaviour with busybox accessed via NFS.
> I have compiled busybox with crosstool-0.43 (gcc-4.0.2 glibc-2.3.2)
> because
> eldk4.1 crosscompilers failed to compile busybox. When using busybox
> mounted via NFS I copied the lib directory from crosstool.
> Unfortunately also this time the system hanged at init.
> 
> My own version of init which uses printf just to print the string to the
> screen runs however fine.
> 
> Would somebody have some suggestion what might cause the problem to
> properly launch the init command.
> 
> Best Regards
> 
> Mirek
> --
> View this message in context:
> http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10
> 621564
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10682140
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
