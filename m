Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0115.outbound.protection.outlook.com [157.56.110.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 291AF1A0406
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 19:10:09 +1100 (AEDT)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/3] powerpc: Enable seccomp filter support
Date: Mon, 9 Feb 2015 07:55:13 +0000
Message-ID: <1423468516-8688-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: pmoore@redhat.com, linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 strosake@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the missing pieces in order to enable SECCOMP_FILTER on PowerPC
architectures, and enable this support.

Testing has been pursued using libseccomp with the latest ppc support patches
[1], on Freescale platforms for both ppc and ppc64. ppc64le support is
untested.

[1] https://groups.google.com/forum/#!topic/libseccomp/ktR-bQr1tGw

Bogdan Purcareata (3):
  powerpc: Don't force ENOSYS as error on syscall fail
  powerpc: Relax secure computing on syscall entry trace
  powerpc: Enable HAVE_ARCH_SECCOMP_FILTER

 arch/powerpc/Kconfig           | 1 +
 arch/powerpc/kernel/entry_32.S | 3 ++-
 arch/powerpc/kernel/entry_64.S | 2 +-
 arch/powerpc/kernel/ptrace.c   | 4 +++-
 4 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.1.4
