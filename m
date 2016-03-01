Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6E0C1A06C2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 21:08:40 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 69431140BA3
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 21:08:40 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 1 Mar 2016 20:08:40 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6E21F2BB0059
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 21:08:36 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u21A8SoS47120596
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Mar 2016 21:08:36 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u21A83Jx027068
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Mar 2016 21:08:03 +1100
Date: Tue, 1 Mar 2016 15:37:39 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: Re: [PATCH v2 2/8] powerpc/module: Only try to generate the
 ftrace_caller() stub once
Message-ID: <20160301100738.GB13436@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1456737989-8755-1-git-send-email-mpe@ellerman.id.au>
 <1456737989-8755-2-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1456737989-8755-2-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2016-02-29 20:26:23]:

> Currently we generate the module stub for ftrace_caller() at the bottom
> of apply_relocate_add(). However apply_relocate_add() is potentially
> called more than once per module, which means we will try to generate
> the ftrace_caller() stub multiple times.
> 
> Although the current code deals with that correctly, ie. it only
> generates a stub the first time, it would be clearer to only try to
> generate the stub once.
> 
> Note also on first reading it may appear that we generate a different
> stub for each section that requires relocation, but that is not the
> case. The code in stub_for_addr() that searches for an existing stub
> uses sechdrs[me->arch.stubs_section], ie. the single stub section for
> this module.
> 
> A cleaner approach is to only generate the ftrace_caller() stub once,
> from module_finalize(). Although the original code didn't check to see
> if the stub was actually generated correctly, it seems prudent to add a
> check, so do that. And an additional benefit is we can clean the ifdefs
> up a little.
> 
> Finally we must propagate the const'ness of some of the pointers passed
> to module_finalize(), but that is also an improvement.
> 
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
> Reviewed-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---


with !CONFIG_DYNAMIC_FTRACE, build breaks

arch/powerpc/kernel/module_64.c:491:13: error: ‘squash_toc_save_inst’ used but never defined [-Werror]
 static void squash_toc_save_inst(const char *name, unsigned long addr);
             ^
cc1: all warnings being treated as errors

moving squash_toc_save_inst() definition to #else part
of #ifdef CONFIG_DYNAMIC_FTRACE helps.

 arch/powerpc/kernel/module_64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index c9c75ceb7ed3..def0b9a013c9 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -774,8 +774,6 @@ static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module
 	return (unsigned long)entry;
 }
 #else
-static void squash_toc_save_inst(const char *name, unsigned long addr) { }
-
 static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module *me)
 {
 	return stub_for_addr(sechdrs, (unsigned long)ftrace_caller, me);
@@ -792,4 +790,8 @@ int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs)
 
 	return 0;
 }
+
+#else
+static void squash_toc_save_inst(const char *name, unsigned long addr) { }
+
 #endif
-- 
2.6.0.rc1
