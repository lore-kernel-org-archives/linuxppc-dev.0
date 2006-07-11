Return-Path: <claus.gindhart@kontron.com>
Received: from mail.kontron-modular.com (mail.e2brain.de [62.159.155.200])
	by ozlabs.org (Postfix) with ESMTP id 4D0BE67A3A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 22:02:02 +1000 (EST)
From: Claus Gindhart <claus.gindhart@kontron-modular.com>
To: rahul <rahul.theraja@gmail.com>
Subject: Re: regarding lspci
Date: Tue, 11 Jul 2006 14:04:24 +0200
References: <44B36F85.3010703@gmail.com>
	<200607111147.21820.claus.gindhart@kontron-modular.com>
	<44B381B7.1030500@gmail.com>
In-Reply-To: <44B381B7.1030500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200607111404.25437.claus.gindhart@kontron-modular.com>
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

Hi Rahul,

Maybe, its better, if you do the modification by hand. This has the advantage, 
that you know, what happens.

Just, search for the following lines
--------------8-<----------------------
sys=`uname -s`
rel=`uname -r`
if [ "$sys" = "AIX" -a -x /usr/bin/oslevel -a -x /usr/sbin/lsattr ]
then
      rel=`/usr/bin/oslevel`
      proc=`/usr/sbin/lsdev -C -c processor -S available -F name | head -1`
      cpu=`/usr/sbin/lsattr -F value -l $proc -a type | sed 's/_.*//'`
else
      cpu=`uname -m | sed 's/^i.86$/i386/;s/^sun4u$/sparc64/'`
fi
echo " $sys/$cpu $rel"
--------------8-<----------------------

Comment them out; they can not work, when cross compiling, because they try to 
detect Kernel version and architecture by using host tools

Then, add the following lines

--------------8-<----------------------
sys=Linux
rel=2.6.13 (or whatever Kernel version you have)
cpu=ppc
--------------8-<----------------------



-- 
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron-modular.com
http://www.kontron.com

-----BEGIN GEEK CODE BLOCK-----
  Version: 3.1
  GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
  K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
  D-- G e++> h--- !r x+++
------END GEEK CODE BLOCK------
