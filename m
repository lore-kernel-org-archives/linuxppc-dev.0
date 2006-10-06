Return-Path: <olof@lixom.net>
Date: Thu, 5 Oct 2006 21:53:34 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: Simple script to build all configs
Message-ID: <20061005215334.46e813fc@pb15>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeremy asked for it, so I figured more might have use for it. Simple
script to build all defconfigs for an arch.

I use it with ARCH and CROSS_COMPILE set outside of the script, i.e. 
$ ARCH=powerpc ~/bin/buildall


I also pass in TARGET="vmlinux modules" in cases where default targets
don't build (very common on ARCH=ppc).



#!/bin/sh

export CC="ccache gcc"

make mrproper

for config in arch/$ARCH/configs/* ; do
	CONFIG=`basename $config`
	echo -n $ARCH.$CONFIG: ;
	yes "" | make $CONFIG >buildall.log 2>&1
	if make $TARGET -j 5 >>buildall.log 2>&1 ; then
		mv buildall.log $ARCH.$CONFIG.log.passed
		echo "	passed"
	else
		mv buildall.log $ARCH.$CONFIG.log.failed
		echo "	failed"
	fi
done
