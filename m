Return-Path: <asarai@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wg2Yd4p2KzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 23:51:33 +1000 (AEST)
From: Aleksa Sarai <asarai@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-arch@vger.kernel.org,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Valentin Rothberg <vrothberg@suse.com>, Aleksa Sarai <asarai@suse.de>
Subject: [PATCH v3 0/2] tty: add TIOCGPTPEER ioctl
Date: Sat,  3 Jun 2017 23:51:09 +1000
Message-Id: <20170603135111.5444-1-asarai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes in v3:
  * Defined a compat_ioctl callback for all pty ioctls, since they are
    all 32-bit and 64-bit compatible.
  * Made TIOCGPTPEER support 32-bit userspace.

Aleksa Sarai (2):
  tty: add compat_ioctl callbacks
  tty: add TIOCGPTPEER ioctl

 Makefile                               |  1 +
 arch/alpha/include/uapi/asm/ioctls.h   |  1 +
 arch/mips/include/uapi/asm/ioctls.h    |  1 +
 arch/parisc/include/uapi/asm/ioctls.h  |  1 +
 arch/powerpc/include/uapi/asm/ioctls.h |  1 +
 arch/sh/include/uapi/asm/ioctls.h      |  1 +
 arch/sparc/include/uapi/asm/ioctls.h   |  3 +-
 arch/xtensa/include/uapi/asm/ioctls.h  |  1 +
 drivers/tty/pty.c                      | 93 ++++++++++++++++++++++++++++++++--
 fs/compat_ioctl.c                      |  6 ---
 include/uapi/asm-generic/ioctls.h      |  1 +
 11 files changed, 99 insertions(+), 11 deletions(-)

-- 
2.13.0
