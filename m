Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7CA1DDDFB9
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 07:31:46 +1100 (EST)
Date: Wed, 14 Nov 2007 14:32:48 -0600
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [REPOST] script to build all defconfigs
Message-ID: <20071114203248.GA2895@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've been asked to post the script again, might as well update with the
latest version.

See below. I normally use this as:

$ CROSS_COMPILE= ARCH=powerpc TARGET="vmlinux modules" buildall

modules won't build on some of the embedded platforms though, so you'll
have to weed out those build errors by hand, or do:

$ CROSS_COMPILE= ARCH=powerpc TARGET=vmlinux buildall


---

#!/bin/bash

#export CC="ccache gcc"

echo -n cleaning:
make $O -ks mrproper
echo "  done"

for config in arch/$ARCH/configs/* allnoconfig allmodconfig allyesconfig ; do
	CONFIG=`basename $config`
	echo -n $ARCH.$CONFIG: ;
	yes "" | make $O $CONFIG >buildall.log 2>&1
	if time make $O $TARGET -ksj 5 >>buildall.log 2>&1 ; then
		mv buildall.log $ARCH.$CONFIG.log.passed
		echo "	passed"
	else
		mv buildall.log $ARCH.$CONFIG.log.failed
		echo "	failed"
	fi
done
