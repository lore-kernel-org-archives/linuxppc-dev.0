Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXQ6TWmzDqmM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:16 +1100 (AEDT)
Date: Tue, 12 Dec 2017 12:39:12 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: [PATCH] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20171212113912.GA1907@lst.de>
References: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
 <20171005124313.GA25100@lst.de>
 <9f388c9a-8d74-865a-b113-f77322918b39@linux.vnet.ibm.com>
 <20171017144733.GB2136@lst.de>
 <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
 <20171020120739.GA20306@lst.de> <1508547548.5662.2.camel@gmail.com>
 <39bb7180-1adf-4df6-c9ba-c6f92754767f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <39bb7180-1adf-4df6-c9ba-c6f92754767f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

The "Power Architecture 64-Bit ELF V2 ABI" says in section 2.3.2.3:

[...] There are several rules that must be adhered to in order to ensure
reliable and consistent call chain backtracing:

* Before a function calls any other function, it shall establish its
  own stack frame, whose size shall be a multiple of 16 bytes.

 – In instances where a function’s prologue creates a stack frame, the
   back-chain word of the stack frame shall be updated atomically with
   the value of the stack pointer (r1) when a back chain is implemented.
   (This must be supported as default by all ELF V2 ABI-compliant
   environments.)
[...]
 – The function shall save the link register that contains its return
   address in the LR save doubleword of its caller’s stack frame before
   calling another function.

To me this sounds like the equivalent of HAVE_RELIABLE_STACKTRACE.
This patch may be unneccessarily limited to ppc64le, but OTOH the only
user of this flag so far is livepatching, which is only implemented on
PPCs with 64-LE, a.k.a. ELF ABI v2.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c51e6ce42e7a..3e3a6ab2e089 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -218,6 +218,7 @@ config PPC
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE		if SMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RELIABLE_STACKTRACE		if PPC64 && CPU_LITTLE_ENDIAN
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING
