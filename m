Return-Path: <ivica@asist-traffic.com>
Received: from mta1.siol.net (pegasus.siol.net [193.189.160.40])
	by ozlabs.org (Postfix) with ESMTP id E8B3B2BF0B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Nov 2004 06:26:10 +1100 (EST)
Received: from edge1.siol.net ([10.10.10.210]) by mta1.siol.net with ESMTP
	id <20041125152439.BLYD25958.mta1.siol.net@edge1.siol.net>
	for <linuxppc-embedded@ozlabs.org>; Thu, 25 Nov 2004 16:24:39 +0100
Received: from linux.asist ([193.95.241.43]) by edge1.siol.net with ESMTP
	id <20041125152439.XDNG21750.edge1.siol.net@linux.asist>
	for <linuxppc-embedded@ozlabs.org>; Thu, 25 Nov 2004 16:24:39 +0100
Received: from [192.168.254.58] (unknown [192.168.254.58])
	by linux.asist (Postfix) with ESMTP id D6748644A9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Nov 2004 16:24:32 +0100 (CET)
Message-ID: <41A5F930.3080104@asist-traffic.com>
Date: Thu, 25 Nov 2004 16:24:32 +0100
From: ivica@asist-traffic.com
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="------------090305070305020609070400"
Subject: MPC5200 toolchain test
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
--------------090305070305020609070400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greeting!

I have a MPC5200 based custom board with preloaded u-boot.
My job is to create some sort of development environment, build
linux kernel and userland environment and in the end test the hardware
before larger series are built.
So far I managed to create GNU toolchain for it with crostool from
Dan Kegel. Everything was built without any problems. Of course,
I wanted to test this toolchain so I wanted to compile a simple
hello_world program load it into the memory of my MPC5200 board
and run it. So far I've failed. I admit. I don't know how to compile
a program to run without the OS. But I have some clues. I think it
needs to be linked properly so all the things OS does for you are inserted
into the binary image that is supposed to get executed. I need some detail
understanding on this.

Anyhow I want to do this before I compile kernel. Since I'm talking
about the kernel let me ask you what kernel you suggest for MPC5200?
The latest 2.6.10-rc or the one Sylvain Munaut is maintaining?

Next ... I would like to create a development environment that is totally
"closed" from my system and I want all the crosstools in it. This way
I could ensure none of my native tools are conflicting with cross 
development.
I keep hearing about jails and sanboxes but I don't know what they mean.
Ok maybe I really need to google it out here but I'm beat. I'm googling
three days already. :D
Any tips on creating these kind of environments would be greatly 
appreciated.

I will attach scripts which I used to create toolchain. I hope I did it 
correctly.

My sources of documentation are google, IRC and these two books:
Building Embedded Linux, Karim Yaghmour
Programming Embeded Systems, Michael Barr

TIA,
Ivica

--------------090305070305020609070400
Content-Type: text/plain;
 name="demo-ppc603e.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="demo-ppc603e.sh"

#!/bin/sh
set -ex
TARBALLS_DIR=$HOME/tmp/downloads
RESULT_TOP=/opt/MPC5200-crosstools
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

--------------090305070305020609070400
Content-Type: text/plain;
 name="powerpc-603e.dat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powerpc-603e.dat"

TARGET=powerpc-603e-linux-gnu
TARGET_CFLAGS="-O -mcpu=603e"
GCC_EXTRA_CONFIG="--with-cpu=603e --enable-cxx-flags=-mcpu=603e"

--------------090305070305020609070400--
