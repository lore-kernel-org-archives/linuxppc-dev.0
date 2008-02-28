Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7B0D1DDE20
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 00:38:05 +1100 (EST)
Date: Thu, 28 Feb 2008 14:37:18 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: undefined references to __udivdi3 on powerpc
Message-ID: <20080228133718.GA8383@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


While debugging __divdi3 calls in drivers/crypto/hifn_795x.c (due to the
ndelay() delay call with a s64), I found even more breakage of that
sort. This is after a allnoconfig with ARCH=powerpc in 2.6.25-rc3,
plus CONFIG_MODULES=y and CONFIG_CRYPTO_DEV_HIFN_795X=y:

  LD      .tmp_vmlinux1
  kernel/built-in.o: In function `update_xtime_cache':
  (.text+0x221a0): undefined reference to `__umoddi3'
  kernel/built-in.o: In function `update_xtime_cache':
  (.text+0x221c0): undefined reference to `__udivdi3'
  kernel/built-in.o: In function `getnstimeofday':
  (.text+0x22330): undefined reference to `__umoddi3'
  kernel/built-in.o: In function `getnstimeofday':
  (.text+0x22350): undefined reference to `__udivdi3'
  kernel/built-in.o: In function `timekeeping_resume':
  timekeeping.c:(.text+0x226a0): undefined reference to `__udivdi3'
  timekeeping.c:(.text+0x22778): undefined reference to `__umoddi3'
  timekeeping.c:(.text+0x22798): undefined reference to `__udivdi3'
  kernel/built-in.o: In function `update_wall_time':
  (.text+0x22c7c): undefined reference to `__umoddi3'
  kernel/built-in.o: In function `update_wall_time':
  (.text+0x22c9c): undefined reference to `__udivdi3'
  kernel/built-in.o: In function `update_wall_time':
  (.text+0x230f8): undefined reference to `__umoddi3'
  kernel/built-in.o: In function `update_wall_time':
  (.text+0x23118): undefined reference to `__udivdi3'
  kernel/built-in.o: In function `do_settimeofday':
  (.text+0x23520): undefined reference to `__udivdi3'
  kernel/built-in.o: In function `timekeeping_init':
  (.init.text+0x1870): undefined reference to `__udivdi3'
  make[1]: *** [.tmp_vmlinux1] Error 1

But its not a regression, 2.6.24 allnoconfig does not link either on
powerpc32. 

How can this be fixed?

Olaf
