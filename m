Return-Path: <ivica@asist-traffic.com>
Received: from mta1.siol.net (pegasus.siol.net [193.189.160.40])
	by ozlabs.org (Postfix) with ESMTP id 2083D67AC2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Feb 2005 21:46:09 +1100 (EST)
Message-ID: <4209E9E2.30208@asist-traffic.com>
Date: Wed, 09 Feb 2005 11:45:54 +0100
From: Babarovic Ivica <ivica@asist-traffic.com>
MIME-Version: 1.0
To: Vlad L <vllv_lst@yahoo.com>, linuxppc-embedded@ozlabs.org
References: <20050203141050.38170.qmail@web90004.mail.scd.yahoo.com>
In-Reply-To: <20050203141050.38170.qmail@web90004.mail.scd.yahoo.com>
Content-Type: multipart/mixed; boundary="------------050201030106000506080207"
Subject: Re: Kernel 2.6.10 on the MPC5200
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
--------------050201030106000506080207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Vlad L wrote:

>Hello,
>
>I am new in this list.
>We should run Linux Kernel 2.6.10 on the Light5200
>board (MPC5200).
>  
>
Try this kernel: http://246tnt.com/mpc52xx/
It works for me.

>Please, direct me to links were can I download GCC
>(and others) and Kernel, which are good point to start
>from.
>  
>
There is a tool out there:
http://kegel.com/crosstool/current/doc/crosstool-howto.html
Read about it. You will basically need to change a couple of files
to generate your cross compiler environment.
I'll attach my files.

I also use another tool for my basic file system layout.
It's called buildroot. You can find it on busybox pages.
http://www.uclibc.org/cgi-bin/cvsweb/buildroot/
But it looks like this page is not accessible now.

>Thanks in advance.
>Vlad.
>
>
>	
>		
>__________________________________ 
>Do you Yahoo!? 
>Yahoo! Mail - You care about security. So do we. 
>http://promotions.yahoo.com/new_mail
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>
>  
>


--------------050201030106000506080207
Content-Type: text/plain;
 name="demo-ppc603e.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="demo-ppc603e.sh"

#!/bin/sh
set -ex
TARBALLS_DIR=$HOME/src/mpc5200_binar/build-tools/downloads
RESULT_TOP=$HOME/src/mpc5200_binar/tools
export TARBALLS_DIR RESULT_TOP
GCC_LANGUAGES="c,c++"
export GCC_LANGUAGES

# Really, you should do the mkdir before running this,
# and chown /opt/crosstool to yourself so you don't need to run as root.
mkdir -p $RESULT_TOP

# Build the toolchain.  Takes a couple hours and a couple gigabytes.
#eval `cat powerpc-604.dat gcc-3.4.0-glibc-2.3.2.dat` sh all.sh --builduserland --notest
 eval `cat powerpc-603e.dat gcc-3.4.1-glibc-2.3.3.dat`  sh all.sh --notest
#eval `cat powerpc-604.dat gcc-3.4.1-glibc-20040827.dat` sh all.sh --notest

echo Done.

--------------050201030106000506080207
Content-Type: text/plain;
 name="powerpc-603e.dat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powerpc-603e.dat"

TARGET=powerpc-603e-linux-gnu
TARGET_CFLAGS="-O -mcpu=603e"
GCC_EXTRA_CONFIG="--with-cpu=603e --enable-cxx-flags=-mcpu=603e"

--------------050201030106000506080207--
