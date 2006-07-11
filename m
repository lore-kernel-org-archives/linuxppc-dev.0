Return-Path: <rahul.theraja@gmail.com>
Received: from predator.gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 73F0E67B22
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 20:47:34 +1000 (EST)
Received: from predator.gdatech.co.in (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id D522C1242E2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 16:17:09 +0530 (IST)
Received: from predator.gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Propel SE relay 1.0.0.3430
	$Rev$) id r67b161709-01-2
	for linuxppc-embedded@ozlabs.org; Tue, 11 Jul 2006 16:17:09 +0530
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 340351242DC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 16:17:09 +0530 (IST)
Message-ID: <44B381B7.1030500@gmail.com>
Date: Tue, 11 Jul 2006 16:17:19 +0530
From: rahul <rahul.theraja@gmail.com>
MIME-Version: 1.0
To: Claus Gindhart <claus.gindhart@kontron-modular.com>
Subject: Re: regarding lspci
References: <44B36F85.3010703@gmail.com>
	<200607111147.21820.claus.gindhart@kontron-modular.com>
In-Reply-To: <200607111147.21820.claus.gindhart@kontron-modular.com>
Content-Type: multipart/alternative;
	boundary="------------090607030309010704000007"
Cc: ilugc@ae.iitm.ac.in, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090607030309010704000007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Claus.Gindhart

I am facing some problem in applying the patch.

I have copied the pacth to a file "patch-pciutils"

[root@localhost pciutils-2.1.11]# file patch-pciutils
patch-pciutils: 'diff' output text
[root@localhost pciutils-2.1.11]#
when i gave the command :
[root@localhost pciutils-2.1.11]# patch -p1 patch-pciutils
.
.
Nothing happens even after 3/4 minutes...so i am stopping it by ctrl+c.
None of the files are edited.

In the patch u sent , let me know wether it is complete one or configure 
file is left as it is after the lines
c=config.h
echo >$c "#define ARCH_`echo $cpu | tr 'a-z' 'A-Z'`"

Thanks & Regards
Rahul

 




Claus Gindhart wrote:

>Rahul,
>
>you need to download the pciutils (e.g. 2.1.11) tarball, and cross compile it 
>for PPC.
>
>However, i had to patch the configure script to make it cross-compilable. Here 
>is the patch
>
>---------------------------8-<-----------------------------------------------
>diff -Nurd pciutils-2.1.11.ori/lib/configure pciutils-2.1.11/lib/configure
>--- pciutils-2.1.11.ori/lib/configure   2003-01-04 13:29:23.000000000 +0100
>+++ pciutils-2.1.11/lib/configure       2006-05-29 11:08:00.000000000 +0200
>@@ -12,17 +12,20 @@
> echo_n "Configuring libpci for your system..."
> sharedir=${1:-/usr/share}
> version=${2:-0.0}
>-sys=`uname -s`
>-rel=`uname -r`
>-if [ "$sys" = "AIX" -a -x /usr/bin/oslevel -a -x /usr/sbin/lsattr ]
>-then
>-       rel=`/usr/bin/oslevel`
>-       proc=`/usr/sbin/lsdev -C -c processor -S available -F name | head -1`
>-       cpu=`/usr/sbin/lsattr -F value -l $proc -a type | sed 's/_.*//'`
>-else
>-       cpu=`uname -m | sed 's/^i.86$/i386/;s/^sun4u$/sparc64/'`
>-fi
>-echo " $sys/$cpu $rel"
>+sys=Linux
>+rel=2.6.13
>+cpu=ppc
>+#sys=`uname -s`
>+#rel=`uname -r`
>+#if [ "$sys" = "AIX" -a -x /usr/bin/oslevel -a -x /usr/sbin/lsattr ]
>+#then
>+#      rel=`/usr/bin/oslevel`
>+#      proc=`/usr/sbin/lsdev -C -c processor -S available -F name | head -1`
>+#      cpu=`/usr/sbin/lsattr -F value -l $proc -a type | sed 's/_.*//'`
>+#else
>+#      cpu=`uname -m | sed 's/^i.86$/i386/;s/^sun4u$/sparc64/'`
>+#fi
>+#echo " $sys/$cpu $rel"
> 
> c=config.h
> echo >$c "#define ARCH_`echo $cpu | tr 'a-z' 'A-Z'`"
>---------------------------8-<-----------------------------------------------
>
>For the build, i called
>export CROSS=$(CROSS_COMPILE)
>make HOST=$(ARCH)
>
>However, depending on your environment, it might by slightly different in your 
>case.
>
>
>On Tuesday 11 July 2006 11:29, rahul wrote:
>  
>
>>Hi All
>>
>>My target system is  powerpc , linux-2.6.11.
>>when i give the lspci in my target system , it says "can't find the 
>>command".
>>I have seen in the ramdisk directory, i could not see the lspci utility 
>>or pci utilities. Even in the busybox i could not find the utility.
>>In linux i have enabled the pci support.
>>
>>How to get the utility to busybox. I have searched in the net but could 
>>not succeed.
>>Can anyone please help me in this regard. plz correct me if i am missing 
>>some basic configuration .
>>
>>Thanks & Regards
>>Rahul
>>_______________________________________________
>>Linuxppc-embedded mailing list
>>Linuxppc-embedded@ozlabs.org
>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>    
>>
>
>  
>


--------------090607030309010704000007
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Claus.Gindhart<br>
<br>
I am facing some problem in applying the patch.<br>
<br>
I have copied the pacth to a file "patch-pciutils"<br>
<br>
[root@localhost pciutils-2.1.11]# file patch-pciutils<br>
patch-pciutils: 'diff' output text<br>
[root@localhost pciutils-2.1.11]#<br>
when i gave the command :<br>
[root@localhost pciutils-2.1.11]# patch -p1 patch-pciutils<br>
.<br>
.<br>
Nothing happens even after 3/4 minutes...so i am stopping it by ctrl+c.<br>
None of the files are edited.<br>
<br>
In the patch u sent , let me know wether it is complete one or
configure file is left as it is after the lines<br>
c=config.h<br>
echo &gt;$c "#define ARCH_`echo $cpu | tr 'a-z' 'A-Z'`"<br>
<br>
Thanks &amp; Regards<br>
Rahul<br>
<br>
&nbsp;<br>
<br>
<br>
<br>
<br>
Claus Gindhart wrote:
<blockquote
 cite="mid200607111147.21820.claus.gindhart@kontron-modular.com"
 type="cite">
  <pre wrap="">Rahul,

you need to download the pciutils (e.g. 2.1.11) tarball, and cross compile it 
for PPC.

However, i had to patch the configure script to make it cross-compilable. Here 
is the patch

---------------------------8-&lt;-----------------------------------------------
diff -Nurd pciutils-2.1.11.ori/lib/configure pciutils-2.1.11/lib/configure
--- pciutils-2.1.11.ori/lib/configure   2003-01-04 13:29:23.000000000 +0100
+++ pciutils-2.1.11/lib/configure       2006-05-29 11:08:00.000000000 +0200
@@ -12,17 +12,20 @@
 echo_n "Configuring libpci for your system..."
 sharedir=${1:-/usr/share}
 version=${2:-0.0}
-sys=`uname -s`
-rel=`uname -r`
-if [ "$sys" = "AIX" -a -x /usr/bin/oslevel -a -x /usr/sbin/lsattr ]
-then
-       rel=`/usr/bin/oslevel`
-       proc=`/usr/sbin/lsdev -C -c processor -S available -F name | head -1`
-       cpu=`/usr/sbin/lsattr -F value -l $proc -a type | sed 's/_.*//'`
-else
-       cpu=`uname -m | sed 's/^i.86$/i386/;s/^sun4u$/sparc64/'`
-fi
-echo " $sys/$cpu $rel"
+sys=Linux
+rel=2.6.13
+cpu=ppc
+#sys=`uname -s`
+#rel=`uname -r`
+#if [ "$sys" = "AIX" -a -x /usr/bin/oslevel -a -x /usr/sbin/lsattr ]
+#then
+#      rel=`/usr/bin/oslevel`
+#      proc=`/usr/sbin/lsdev -C -c processor -S available -F name | head -1`
+#      cpu=`/usr/sbin/lsattr -F value -l $proc -a type | sed 's/_.*//'`
+#else
+#      cpu=`uname -m | sed 's/^i.86$/i386/;s/^sun4u$/sparc64/'`
+#fi
+#echo " $sys/$cpu $rel"
 
 c=config.h
 echo &gt;$c "#define ARCH_`echo $cpu | tr 'a-z' 'A-Z'`"
---------------------------8-&lt;-----------------------------------------------

For the build, i called
export CROSS=$(CROSS_COMPILE)
make HOST=$(ARCH)

However, depending on your environment, it might by slightly different in your 
case.


On Tuesday 11 July 2006 11:29, rahul wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi All

My target system is  powerpc , linux-2.6.11.
when i give the lspci in my target system , it says "can't find the 
command".
I have seen in the ramdisk directory, i could not see the lspci utility 
or pci utilities. Even in the busybox i could not find the utility.
In linux i have enabled the pci support.

How to get the utility to busybox. I have searched in the net but could 
not succeed.
Can anyone please help me in this regard. plz correct me if i am missing 
some basic configuration .

Thanks &amp; Regards
Rahul
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
</blockquote>
<br>
</body>
</html>

--------------090607030309010704000007--
