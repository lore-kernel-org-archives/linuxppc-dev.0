Return-Path: <neerajg@cdac.in>
Received: from mx2.cdac.in (mx2.cdac.in [203.199.132.25])
	by ozlabs.org (Postfix) with ESMTP id CFDA9DDF17
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 01:20:47 +1000 (EST)
Received: from mailhub.cdac.in (mailhub [196.1.109.254])by mailhub.cdac.in
	(8.13.4/8.13.4) with ESMTP id m6HFKckd013340for
	<linuxppc-embedded@ozlabs.org>; Thu, 17 Jul 2008 20:50:38 +0530
Message-ID: <487F63E8.2010303@cdac.in>
Date: Thu, 17 Jul 2008 20:53:20 +0530
From: Neeraj Garg <neerajg@cdac.in>
MIME-Version: 1.0
To: Ron Sass <rsass@uncc.edu>
Subject: Re: Booting ML405 (Kernel panic - not syncing: No init found)
References: <48744475.2080605@cdac.in> <20080709143318.GB26524@secretlab.ca>	 
	<20080709160659.EE3F6E28065@mail118-va3.bigfish.com>
	<487C4326.9000000@cdac.in>
	<200807161447.m6GElde4032109@rsass-homer.uncc.edu>
In-Reply-To: <200807161447.m6GElde4032109@rsass-homer.uncc.edu>
Content-Type: multipart/alternative;
	boundary=------------020904050309060302080008
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020904050309060302080008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I changed the owner of the busybox, and used chmod as you told me for 
bin/busybox but its permission are -rwsrwxr-x not srwxrwxr-x-r.

--for compiling helloworld I used $powerpc-405-linux-gnu-gcc -static 
helloworld.c -o helloworld

--For ramdisk creation I followed the following steps:

mkdir tmp/initrd
dd if=/dev/zero of=images/initrd.img bs=1k count=8192
/sbin/mke2fs -F -v -m0 images/initrd.img
mount -o loop images/initrd.img tmp/initrd
cp -av ramdisk/* tmp/initrd

//here ramdisk holds directory structure.. I copied directory structure 
from git, linux support ...but I changed lib and bin contents (bin
contents with busybox-1.10.3 installation, and lib contents with lib of 
my cross-compiler setup ,crosstool-0.28-rc35)

umount tmp/initrd
gzip < images/initrd.img > images/ramdisk.image.gz

----For making directory structure of ramdisk I followed following steps
for file in libc libcrypt libdl libm libpthread libresolv libutil
do
cp $file-*.so /home/neeraj/kerneldev/rootfs0.1/lib
cp -d $file.so.[*0-9] /home/neeraj/kerneldev/rootfs0.1/lib
done
cp -d ld*.so* /home/neeraj/kerneldev/rootfs0.1/lib

----And in menuconfig I selected filesystem as ramdisk with following 
settings
<*>   RAM block device support 
(16)    Default number of RAM disks
(32768) Default RAM disk size (kbytes) 

// I think here can be the issue

-------------------------------------------------------------------
Neeraj Garg




Ron Sass wrote:
> Hmmm... I think you've got a problem with your ramdisk.  There are
> a couple of issues but these alone don't explain your helloworld test.
>
> 1.  busybox should be set to root not neeraj 
> 2.  you need to setuid busybox for some apps to run
>     (chmod 4775 bin/busybox so that it is srwxrwxr-x-r)
> 3.  I would be wary of Yaghmour's text... it is a little dated
>     and if I remember correctly, he uses some regular expressions
>     to copy "just" the libraries you need to lib; but with
>     newer versions of gcc/glibc these regular expressions
>     don't catch everything
>
> Two questions:
>
> Can you tell me exactly what your cross-compile command-line looks
> like?  How are compiling helloworld?
>
> How are you creating the ramdisk?  How do you go from directory
> structure to ramdisk.image.gz?
>
> Ron
>
>   
>> Hi,
>>
>> --Ron,Permissions are -rwxrwxr-x for all and owner is neeraj itself. And 
>> shared libraries are present in lib/ . Now I have placed helloworld.elf 
>> (using printf to print helloworld, and linked with -static option) in 
>> bin/ and changed init=/bin/helloworld , again it says cannot execute 
>> /bin/helloworld.
>>
>> --John, we are using our custom hardware board, not exactly ML405 but 
>> its more or less similar to ML405, so I cannot use bit file provided for 
>> ML405. Till now we were using xilkernel, but now onward we are planning 
>> to use Linux. For serial console I have no option other than uartlite. 
>> This is how I compiled kernel :
>>
>> 1) make ARCH=ppc ml405_defconfig
>> 2) patched kernel src with EDK(10.1) , so as to change xparameter.h, and 
>> later made some changed in arch/ppc/boot/simple/embed_config.c and 
>> xparameters.h file.
>> 3) make ARCH=ppc menuconfig , and selected uartlite to be console and 
>> ramdisk as file system.
>> 4) Created ramdisk (as per Building embedded linux, Karim Yaghmour, 
>> however major and minor number for device nodes is similar to ramdisk 
>> provided at git.xilinx.com)
>> 5) I have placed this ramdisk in arch/ppc/boot/images
>> 6) And then issued $make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- 
>> zImge.initrd
>>
>>
>> --I have downloaded   ELDK4.1 and installed it. And when I compile 
>> simple helloworld.c using cross compiler, it says unresolved symbol 
>> 'printf' . Is there anything else to install with ELDK ?
>>
>>
>> -------------------------------------------------------------------
>> Neeraj Garg
>>
>>
>>
>> In addition to what John wrote, I would also investigate your ramdisk.
>> I would be sure to check that you have the permissions/owner set correctly
>> on bin/busybox.  Also, I would double check that, if you compiled busybox
>> with shared libraries, the shared libraries are in the right place
>> on your ramdisk.
>>
>>
>> Ron
>>
>>  >
>>  > Hi,
>>  >
>>  > Yes I am using ARCH=ppc (actual line is $make ARCH=ppc
>>  > CROSS_COMPILE=powerpc-405-linux-gnu- zImage.initrd ) for this I have
>>  > placed ramdisk.image.gz in arch/ppc/boot/images. In case of ARCH=powerpc
>>  > I cannot find processor type 405 , in make menuconfig. Thats why i am
>>  > using ARCH=ppc.
>>  >
>>
>> --------------060307000300070002040802
>> Content-Type: text/html; charset=ISO-8859-1
>> Content-Transfer-Encoding: 7bit
>>
>> <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
>> <html>
>> <head>
>>   <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
>> </head>
>> <body bgcolor="#ffffff" text="#000000">
>> Hi,<br>
>> <br>
>> --Ron,Permissions are -rwxrwxr-x for all and owner is neeraj itself.
>> And shared libraries are present in lib/ . Now I have placed
>> helloworld.elf (using printf to print helloworld, and linked with
>> -static option) in bin/ and changed init=/bin/helloworld , again it
>> says cannot execute /bin/helloworld. <br>
>> <br>
>> --John, we are using our custom hardware board, not exactly ML405 but
>> its more or less similar to ML405, so I cannot use bit file provided
>> for ML405. Till now we were using xilkernel, but now onward we are
>> planning to use Linux. For serial console I have no option other than
>> uartlite. This is how I compiled kernel :<br>
>> <br>
>> 1) make ARCH=ppc ml405_defconfig<br>
>> 2) patched kernel src with EDK(10.1) , so as to change xparameter.h,
>> and later made some changed in arch/ppc/boot/simple/embed_config.c and
>> xparameters.h file.<br>
>> 3) make ARCH=ppc menuconfig , and selected uartlite to be console and
>> ramdisk as file system.<br>
>> 4) Created ramdisk (as per Building embedded linux, Karim Yaghmour,
>> however major and minor number for device nodes is similar to ramdisk
>> provided at git.xilinx.com)<br>
>> 5) I have placed this ramdisk in arch/ppc/boot/images<br>
>> 6) And then issued $make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu-
>> zImge.initrd<br>
>> <br>
>> <br>
>> --I have downloaded &nbsp; ELDK4.1 and installed it. And when I compile
>> simple helloworld.c using cross compiler, it says unresolved symbol
>> 'printf' . Is there anything else to install with ELDK ?<br>
>> <br>
>> <br>
>> <div class="moz-signature">
>> <pre>-------------------------------------------------------------------
>> Neeraj Garg
>> </pre>
>> </div>
>> <br>
>> <br>
>> In addition to what John wrote, I would also investigate your ramdisk.
>> <br>
>> I would be sure to check that you have the permissions/owner set
>> correctly
>> <br>
>> on bin/busybox. &nbsp;Also, I would double check that, if you compiled
>> busybox
>> <br>
>> with shared libraries, the shared libraries are in the right place
>> <br>
>> on your ramdisk.<br>
>> <br>
>> <br>
>> Ron
>> <br>
>> <br>
>> &gt; <br>
>> &gt; Hi,
>> <br>
>> &gt; <br>
>> &gt; Yes I am using ARCH=ppc (actual line is $make ARCH=ppc <br>
>> &gt; CROSS_COMPILE=powerpc-405-linux-gnu- zImage.initrd ) for this I
>> have <br>
>> &gt; placed ramdisk.image.gz in arch/ppc/boot/images. In case of
>> ARCH=powerpc <br>
>> &gt; I cannot find processor type 405 , in make menuconfig. Thats why i
>> am <br>
>> &gt; using ARCH=ppc.
>> <br>
>> &gt; <br>
>> <font color="navy" face="Arial" size="2"><span
>>  style="font-size: 10pt; font-family: Arial; color: navy;"></span></font>
>> </body>
>> </html>
>>
>> --------------060307000300070002040802--
>>
>>
>> --===============0970715627==
>> Content-Type: text/plain; charset="us-ascii"
>> MIME-Version: 1.0
>> Content-Transfer-Encoding: 7bit
>> Content-Disposition: inline
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> --===============0970715627==--
>>
>>     

--------------020904050309060302080008
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi,<br>
<br>
I changed the owner of the busybox, and used chmod as you told me for
bin/busybox but its permission are -rwsrwxr-x not srwxrwxr-x-r.<br>
<br>
--for compiling helloworld I used $powerpc-405-linux-gnu-gcc -static
helloworld.c -o helloworld<br>
<br>
--For ramdisk creation I followed the following steps:<br>
<br>
mkdir tmp/initrd<br>
dd if=/dev/zero of=images/initrd.img bs=1k count=8192<br>
/sbin/mke2fs -F -v -m0 images/initrd.img<br>
mount -o loop images/initrd.img tmp/initrd<br>
cp -av ramdisk/* tmp/initrd <br>
<br>
//here ramdisk holds directory structure.. I copied directory structure
from git, linux support ...but I changed lib and bin contents (bin <br>
contents with busybox-1.10.3 installation, and lib contents with lib of
my cross-compiler setup ,crosstool-0.28-rc35)<br>
<br>
umount tmp/initrd<br>
gzip &lt; images/initrd.img &gt; images/ramdisk.image.gz<br>
<br>
----For making directory structure of ramdisk I followed following steps<br>
for file in libc libcrypt libdl libm libpthread libresolv libutil<br>
do<br>
cp $file-*.so /home/neeraj/kerneldev/rootfs0.1/lib<br>
cp -d $file.so.[*0-9] /home/neeraj/kerneldev/rootfs0.1/lib<br>
done<br>
cp -d ld*.so* /home/neeraj/kerneldev/rootfs0.1/lib<br>
<br>
----And in menuconfig I selected filesystem as ramdisk with following
settings<br>
&lt;*&gt;&nbsp;&nbsp; RAM block device support&nbsp; <br>
(16)&nbsp;&nbsp;&nbsp; Default number of RAM disks <br>
(32768) Default RAM disk size (kbytes)&nbsp; <br>
<br>
// I think here can be the issue<br>
<br>
<div class="moz-signature">
<pre><!-- img src="file:///E:/htdg.jpg" border="0" alt="C-DAC"-->-------------------------------------------------------------------
Neeraj Garg

</pre>
</div>
<br>
<br>
Ron Sass wrote:
<blockquote cite="mid200807161447.m6GElde4032109@rsass-homer.uncc.edu"
 type="cite">
  <pre wrap="">Hmmm... I think you've got a problem with your ramdisk.  There are
a couple of issues but these alone don't explain your helloworld test.

1.  busybox should be set to root not neeraj 
2.  you need to setuid busybox for some apps to run
    (chmod 4775 bin/busybox so that it is srwxrwxr-x-r)
3.  I would be wary of Yaghmour's text... it is a little dated
    and if I remember correctly, he uses some regular expressions
    to copy "just" the libraries you need to lib; but with
    newer versions of gcc/glibc these regular expressions
    don't catch everything

Two questions:

Can you tell me exactly what your cross-compile command-line looks
like?  How are compiling helloworld?

How are you creating the ramdisk?  How do you go from directory
structure to ramdisk.image.gz?

Ron

  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi,

--Ron,Permissions are -rwxrwxr-x for all and owner is neeraj itself. And 
shared libraries are present in lib/ . Now I have placed helloworld.elf 
(using printf to print helloworld, and linked with -static option) in 
bin/ and changed init=/bin/helloworld , again it says cannot execute 
/bin/helloworld.

--John, we are using our custom hardware board, not exactly ML405 but 
its more or less similar to ML405, so I cannot use bit file provided for 
ML405. Till now we were using xilkernel, but now onward we are planning 
to use Linux. For serial console I have no option other than uartlite. 
This is how I compiled kernel :

1) make ARCH=ppc ml405_defconfig
2) patched kernel src with EDK(10.1) , so as to change xparameter.h, and 
later made some changed in arch/ppc/boot/simple/embed_config.c and 
xparameters.h file.
3) make ARCH=ppc menuconfig , and selected uartlite to be console and 
ramdisk as file system.
4) Created ramdisk (as per Building embedded linux, Karim Yaghmour, 
however major and minor number for device nodes is similar to ramdisk 
provided at git.xilinx.com)
5) I have placed this ramdisk in arch/ppc/boot/images
6) And then issued $make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- 
zImge.initrd


--I have downloaded   ELDK4.1 and installed it. And when I compile 
simple helloworld.c using cross compiler, it says unresolved symbol 
'printf' . Is there anything else to install with ELDK ?


-------------------------------------------------------------------
Neeraj Garg



In addition to what John wrote, I would also investigate your ramdisk.
I would be sure to check that you have the permissions/owner set correctly
on bin/busybox.  Also, I would double check that, if you compiled busybox
with shared libraries, the shared libraries are in the right place
on your ramdisk.


Ron

 &gt;
 &gt; Hi,
 &gt;
 &gt; Yes I am using ARCH=ppc (actual line is $make ARCH=ppc
 &gt; CROSS_COMPILE=powerpc-405-linux-gnu- zImage.initrd ) for this I have
 &gt; placed ramdisk.image.gz in arch/ppc/boot/images. In case of ARCH=powerpc
 &gt; I cannot find processor type 405 , in make menuconfig. Thats why i am
 &gt; using ARCH=ppc.
 &gt;

--------------060307000300070002040802
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"&gt;
&lt;html&gt;
&lt;head&gt;
  &lt;meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type"&gt;
&lt;/head&gt;
&lt;body bgcolor="#ffffff" text="#000000"&gt;
Hi,&lt;br&gt;
&lt;br&gt;
--Ron,Permissions are -rwxrwxr-x for all and owner is neeraj itself.
And shared libraries are present in lib/ . Now I have placed
helloworld.elf (using printf to print helloworld, and linked with
-static option) in bin/ and changed init=/bin/helloworld , again it
says cannot execute /bin/helloworld. &lt;br&gt;
&lt;br&gt;
--John, we are using our custom hardware board, not exactly ML405 but
its more or less similar to ML405, so I cannot use bit file provided
for ML405. Till now we were using xilkernel, but now onward we are
planning to use Linux. For serial console I have no option other than
uartlite. This is how I compiled kernel :&lt;br&gt;
&lt;br&gt;
1) make ARCH=ppc ml405_defconfig&lt;br&gt;
2) patched kernel src with EDK(10.1) , so as to change xparameter.h,
and later made some changed in arch/ppc/boot/simple/embed_config.c and
xparameters.h file.&lt;br&gt;
3) make ARCH=ppc menuconfig , and selected uartlite to be console and
ramdisk as file system.&lt;br&gt;
4) Created ramdisk (as per Building embedded linux, Karim Yaghmour,
however major and minor number for device nodes is similar to ramdisk
provided at git.xilinx.com)&lt;br&gt;
5) I have placed this ramdisk in arch/ppc/boot/images&lt;br&gt;
6) And then issued $make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu-
zImge.initrd&lt;br&gt;
&lt;br&gt;
&lt;br&gt;
--I have downloaded &amp;nbsp; ELDK4.1 and installed it. And when I compile
simple helloworld.c using cross compiler, it says unresolved symbol
'printf' . Is there anything else to install with ELDK ?&lt;br&gt;
&lt;br&gt;
&lt;br&gt;
&lt;div class="moz-signature"&gt;
&lt;pre&gt;-------------------------------------------------------------------
Neeraj Garg
&lt;/pre&gt;
&lt;/div&gt;
&lt;br&gt;
&lt;br&gt;
In addition to what John wrote, I would also investigate your ramdisk.
&lt;br&gt;
I would be sure to check that you have the permissions/owner set
correctly
&lt;br&gt;
on bin/busybox. &amp;nbsp;Also, I would double check that, if you compiled
busybox
&lt;br&gt;
with shared libraries, the shared libraries are in the right place
&lt;br&gt;
on your ramdisk.&lt;br&gt;
&lt;br&gt;
&lt;br&gt;
Ron
&lt;br&gt;
&lt;br&gt;
&amp;gt; &lt;br&gt;
&amp;gt; Hi,
&lt;br&gt;
&amp;gt; &lt;br&gt;
&amp;gt; Yes I am using ARCH=ppc (actual line is $make ARCH=ppc &lt;br&gt;
&amp;gt; CROSS_COMPILE=powerpc-405-linux-gnu- zImage.initrd ) for this I
have &lt;br&gt;
&amp;gt; placed ramdisk.image.gz in arch/ppc/boot/images. In case of
ARCH=powerpc &lt;br&gt;
&amp;gt; I cannot find processor type 405 , in make menuconfig. Thats why i
am &lt;br&gt;
&amp;gt; using ARCH=ppc.
&lt;br&gt;
&amp;gt; &lt;br&gt;
&lt;font color="navy" face="Arial" size="2"&gt;&lt;span
 style="font-size: 10pt; font-family: Arial; color: navy;"&gt;&lt;/span&gt;&lt;/font&gt;
&lt;/body&gt;
&lt;/html&gt;

--------------060307000300070002040802--


--===============0970715627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>
--===============0970715627==--

    </pre>
  </blockquote>
</blockquote>
</body>
</html>

--------------020904050309060302080008--
