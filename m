Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 1827CDE76F
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 07:18:02 +1000 (EST)
Date: Mon, 28 Jul 2008 17:14:08 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Simon Horman <horms@verge.net.au>
Subject: [PATCH 4/5] powerpc: Define elfcorehdr_addr in arch dependent section
Message-ID: <20080728211408.GD9985@redhat.com>
References: <20080727234529.GM6175@verge.net.au>
	<20080728015117.GA12055@verge.net.au>
	<20080728024526.GB3334@verge.net.au>
	<20080728034007.GA30450@verge.net.au>
	<20080728211025.GA9985@redhat.com>
	<20080728211156.GB9985@redhat.com>
	<20080728211314.GC9985@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080728211314.GC9985@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Terry Loftin <terry.loftin@hp.com>,
	Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



o Move elfcorehdr_addr definition in arch dependent crash dump file. This is
  equivalent to defining elfcorehdr_addr under CONFIG_CRASH_DUMP instead of
  CONFIG_PROC_VMCORE. This is needed by is_kdump_kernel() which can be
  used irrespective of the fact whether CONFIG_PROC_VMCORE is enabled or
  not.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---

 arch/powerpc/kernel/crash_dump.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff -puN arch/powerpc/kernel/crash_dump.c~fix-elfcorehdr_addr-parsing-ppc64 arch/powerpc/kernel/crash_dump.c
--- linux-2.6.27-pre-rc1/arch/powerpc/kernel/crash_dump.c~fix-elfcorehdr_addr-parsing-ppc64	2008-07-28 12:14:22.000000000 -0400
+++ linux-2.6.27-pre-rc1-root/arch/powerpc/kernel/crash_dump.c	2008-07-28 12:14:22.000000000 -0400
@@ -27,6 +27,9 @@
 #define DBG(fmt...)
 #endif
 
+/* Stores the physical address of elf header of crash image. */
+unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
+
 void __init reserve_kdump_trampoline(void)
 {
 	lmb_reserve(0, KDUMP_RESERVE_LIMIT);
@@ -66,7 +69,11 @@ void __init setup_kdump_trampoline(void)
 	DBG(" <- setup_kdump_trampoline()\n");
 }
 
-#ifdef CONFIG_PROC_VMCORE
+/*
+ * Note: elfcorehdr_addr is not just limited to vmcore. It is also used by
+ * is_kdump_kernel() to determine if we are booting after a panic. Hence
+ * ifdef it under CONFIG_CRASH_DUMP and not CONFIG_PROC_VMCORE.
+ */
 static int __init parse_elfcorehdr(char *p)
 {
 	if (p)
@@ -75,7 +82,6 @@ static int __init parse_elfcorehdr(char 
 	return 1;
 }
 __setup("elfcorehdr=", parse_elfcorehdr);
-#endif
 
 static int __init parse_savemaxmem(char *p)
 {
_
