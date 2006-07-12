Return-Path: <urwithsudheer@gmail.com>
Received: from predator.gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 2761667B71
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 17:10:58 +1000 (EST)
Received: from predator.gdatech.co.in (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id C11241242E0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 12:40:23 +0530 (IST)
Received: from predator.gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Propel SE relay 1.0.0.3430
	$Rev$) id r67c124022-02-2
	for linuxppc-embedded@ozlabs.org; Wed, 12 Jul 2006 12:40:23 +0530
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 8AE3A1242DC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 12:40:22 +0530 (IST)
Message-ID: <44B4A06C.2010508@gmail.com>
Date: Wed, 12 Jul 2006 12:40:36 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: Claus Gindhart <claus.gindhart@kontron-modular.com>
Subject: Re: regarding lspci
References: <44B36F85.3010703@gmail.com>	<200607111147.21820.claus.gindhart@kontron-modular.com>	<44B381B7.1030500@gmail.com>
	<200607111404.25437.claus.gindhart@kontron-modular.com>
In-Reply-To: <200607111404.25437.claus.gindhart@kontron-modular.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org, ilugc@ae.iitm.ac.in
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Claus.Gindhart

Thanks for patch.
I have tried the same and could do it.
I have modified the lib/configure file manually and gave the following 
command
#make  CC=powerpc-linux-gcc
I could get the lspci, setpci commands.
Need to test this with my target board. Let you know after testing.


But when i tried with applying patch directly.. i got the following error:
[root@localhost pciutils-2.1.11]# patch -p1 < patch-pciutils
patching file lib/configure
Hunk #1 FAILED at 12.
1 out of 1 hunk FAILED -- saving rejects to file lib/configure.rej
[root@localhost pciutils-2.1.11]#
I have just copy pasted the patch from my mail and tried.

Thanks & Regards
Sudheer


Claus Gindhart wrote:

>Hi Rahul,
>
>Maybe, its better, if you do the modification by hand. This has the advantage, 
>that you know, what happens.
>
>Just, search for the following lines
>--------------8-<----------------------
>sys=`uname -s`
>rel=`uname -r`
>if [ "$sys" = "AIX" -a -x /usr/bin/oslevel -a -x /usr/sbin/lsattr ]
>then
>      rel=`/usr/bin/oslevel`
>      proc=`/usr/sbin/lsdev -C -c processor -S available -F name | head -1`
>      cpu=`/usr/sbin/lsattr -F value -l $proc -a type | sed 's/_.*//'`
>else
>      cpu=`uname -m | sed 's/^i.86$/i386/;s/^sun4u$/sparc64/'`
>fi
>echo " $sys/$cpu $rel"
>--------------8-<----------------------
>
>Comment them out; they can not work, when cross compiling, because they try to 
>detect Kernel version and architecture by using host tools
>
>Then, add the following lines
>
>--------------8-<----------------------
>sys=Linux
>rel=2.6.13 (or whatever Kernel version you have)
>cpu=ppc
>--------------8-<----------------------
>
>
>
>  
>
