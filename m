Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 73F7EDDE37
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 08:41:19 +1000 (EST)
Date: Tue, 24 Jul 2007 17:41:05 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: "do section mismatch check on full vmlinux" breaks powerpc build
Message-ID: <20070724224105.GG951@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello-

2.6.23-rc1 breaks the build for 64-bit powerpc for me (using
maple_defconfig):

  LD      vmlinux.o
powerpc64-unknown-linux-gnu-ld: dynreloc miscount for
kernel/built-in.o, section .opd
powerpc64-unknown-linux-gnu-ld: can not edit opd Bad value
make: *** [vmlinux.o] Error 1

This is on a i386 host with:
powerpc64-unknown-linux-gnu-gcc (GCC) 4.1.2
GNU ld version 2.16.1

Reverting the following commit fixes it:

commit 741f98fe298a73c9d47ed53703c1279a29718581
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Tue Jul 17 10:54:06 2007 +0200

    kbuild: do section mismatch check on full vmlinux


However, I see a possibly related binutils patch:
http://article.gmane.org/gmane.comp.gnu.binutils/33650

Will there be a kbuild fix for this or should I update my binutils?
