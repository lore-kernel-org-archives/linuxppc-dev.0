Return-Path: <B43198@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0124.outbound.protection.outlook.com [65.55.169.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E91561A0889
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 19:36:34 +1100 (AEDT)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 0/3] powerpc: Enable seccomp filter support
Date: Wed, 11 Feb 2015 08:36:15 +0000
Message-ID: <1423643778-32525-1-git-send-email-bogdan.purcareata@freescale.com>
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

v2:
- move setting ENOSYS from syscall entry assembly to do_syscall_trace_enter

Bogdan Purcareata (3):
  powerpc: Don't force ENOSYS as error on syscall fail
  powerpc: Relax secure computing on syscall entry trace
  powerpc: Enable HAVE_ARCH_SECCOMP_FILTER

 arch/powerpc/Kconfig           | 1 +
 arch/powerpc/kernel/entry_32.S | 2 +-
 arch/powerpc/kernel/entry_64.S | 1 -
 arch/powerpc/kernel/ptrace.c   | 8 ++++++--
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.1.4
