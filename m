Return-Path: <claus.gindhart@kontron.com>
Received: from mail.kontron-modular.com (mail.kontron-modular.com
	[62.159.155.200]) by ozlabs.org (Postfix) with ESMTP id 9527D67A3E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 19:57:06 +1000 (EST)
From: Claus Gindhart <claus.gindhart@kontron-modular.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: regarding lspci
Date: Tue, 11 Jul 2006 11:47:21 +0200
References: <44B36F85.3010703@gmail.com>
In-Reply-To: <44B36F85.3010703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607111147.21820.claus.gindhart@kontron-modular.com>
Cc: ilugc@ae.iitm.ac.in
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rahul,

you need to download the pciutils (e.g. 2.1.11) tarball, and cross compile it 
for PPC.

However, i had to patch the configure script to make it cross-compilable. Here 
is the patch

---------------------------8-<-----------------------------------------------
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
 echo >$c "#define ARCH_`echo $cpu | tr 'a-z' 'A-Z'`"
---------------------------8-<-----------------------------------------------

For the build, i called
export CROSS=$(CROSS_COMPILE)
make HOST=$(ARCH)

However, depending on your environment, it might by slightly different in your 
case.


On Tuesday 11 July 2006 11:29, rahul wrote:
> Hi All
> 
> My target system is  powerpc , linux-2.6.11.
> when i give the lspci in my target system , it says "can't find the 
> command".
> I have seen in the ramdisk directory, i could not see the lspci utility 
> or pci utilities. Even in the busybox i could not find the utility.
> In linux i have enabled the pci support.
> 
> How to get the utility to busybox. I have searched in the net but could 
> not succeed.
> Can anyone please help me in this regard. plz correct me if i am missing 
> some basic configuration .
> 
> Thanks & Regards
> Rahul
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D
Kontron Modular Computers
phone :++49 (0)8341-803-374
ailto:claus.gindhart@kontron-modular.com
http://www.kontron.com

-----BEGIN GEEK CODE BLOCK-----
  Version: 3.1
  GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
  K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
  D-- G e++> h--- !r x+++
------END GEEK CODE BLOCK------
