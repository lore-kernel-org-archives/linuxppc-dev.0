Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 2EFDEDDF42
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 22:33:00 +1000 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Andrew Morton <akpm@linux-foundation.org>, paulus@samba.org,
	xfs-masters@oss.sgi.com
Subject: Re: 2.6.22-rc6-mm1
Date: Fri, 29 Jun 2007 14:32:09 +0200
References: <20070628034321.38c9f12b.akpm@linux-foundation.org>
In-Reply-To: <20070628034321.38c9f12b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706291432.10128.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, xfs@oss.sgi.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

	allmodconfig on powerpc (iMac g3) fails due to
git-kgdb.patch. allmodconfig defaults should be changed?

  CC      arch/powerpc/kernel/kgdb.o
arch/powerpc/kernel/kgdb.c:485:2: error: #error Both XMON and KGDB selected 
in .config. Unselect one of them.
make[1]: *** [arch/powerpc/kernel/kgdb.o] Blad 1
make: *** [arch/powerpc/kernel] Blad 2

anyway after unselecting XMON we can see:

  CC [M]  fs/xfs/linux-2.6/xfs_ioctl32.o
fs/xfs/linux-2.6/xfs_ioctl32.c: In function 'xfs_ioc_bulkstat_compat':
fs/xfs/linux-2.6/xfs_ioctl32.c:334: error: 'xfs_inumbers_fmt_compat' 
undeclared (first use in this function)
fs/xfs/linux-2.6/xfs_ioctl32.c:334: error: (Each undeclared identifier is 
reported only once
fs/xfs/linux-2.6/xfs_ioctl32.c:334: error: for each function it appears in.)
make[2]: *** [fs/xfs/linux-2.6/xfs_ioctl32.o] Blad 1
make[1]: *** [fs/xfs] Blad 2

This is just allmodconfig - not a .config that's used daily by users but I'm 
used to compiling the kernel using it anyway 8)

Regards,

	Mariusz
