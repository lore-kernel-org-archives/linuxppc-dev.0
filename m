Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40w4Bc2XT8zDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 16:51:19 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4T6nD6P072431
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 02:51:17 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j91gts0xd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 02:51:17 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 29 May 2018 07:51:14 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc64/module elfv1: Set opd addresses after module
 relocation
Date: Tue, 29 May 2018 12:21:00 +0530
Message-Id: <20180529065100.2017-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

module_frob_arch_sections() is called before the module is moved to its
final location. The function descriptor section addresses we are setting
here are thus invalid. Fix this by processing opd section during 
module_finalize()

Fixes: 5633e85b2c313 ("powerpc64: Add .opd based function descriptor dereference")
Cc: stable@vger.kernel.org # v4.16
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
This can easily be seen by doing:

  $ sudo perf probe -L module_frob_arch_sections | grep -A5 opd
       20  		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".opd")) {
       21  			me->arch.start_opd = sechdrs[i].sh_addr;
       22  			me->arch.end_opd = sechdrs[i].sh_addr +
						     sechdrs[i].sh_size;
			  }

			  /* We don't handle .init for the moment: rename to _init */
       27  		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init")))
  $ sudo perf probe module_frob_arch_sections:27 me-\>arch.start_opd me-\>arch.end_opd
  Added new events:
    probe:module_frob_arch_sections (on module_frob_arch_sections:27 with start_opd=me->arch.start_opd end_opd=me->arch.end_opd)
    probe:module_frob_arch_sections_1 (on module_frob_arch_sections:27 with start_opd=me->arch.start_opd end_opd=me->arch.end_opd)

  You can now use it in all perf tools, such as:

	  perf record -e probe:module_frob_arch_sections_1 -aR sleep 1

  $ sudo perf record -e probe:* modprobe kprobe_example
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.011 MB perf.data (48 samples) ]
  $ sudo perf script
	  modprobe 10463 [001] 311838.332208:   probe:module_frob_arch_sections: (c000000000043b0c) start_opd=0xd000000000910750 end_opd=0xd0000000009107a0
	  modprobe 10463 [001] 311838.332209:   probe:module_frob_arch_sections: (c000000000043b0c) start_opd=0xd000000000910750 end_opd=0xd0000000009107a0
  $ sudo cat /proc/modules | grep kprobe_example
  kprobe_example 3716 0 - Live 0xd000000000970000

With this patch, probing on module_finalize() shows the expected values.


- Naveen


 arch/powerpc/kernel/module.c    | 8 ++++++++
 arch/powerpc/kernel/module_64.c | 5 -----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 3f7ba0f5bf29..fc9fa24cfe05 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -72,6 +72,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 		do_feature_fixups(powerpc_firmware_features,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
+
+#ifdef PPC64_ELF_ABI_v1
+	sect = find_section(hdr, sechdrs, ".opd");
+	if (sect != NULL) {
+		me->arch.start_opd = sect->sh_addr;
+		me->arch.end_opd = sect->sh_addr + sect->sh_size;
+	}
+#endif
 #endif
 
 	sect = find_section(hdr, sechdrs, "__lwsync_fixup");
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index f7667e2ebfcb..a45204b48d56 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -360,11 +360,6 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 		else if (strcmp(secstrings+sechdrs[i].sh_name,"__versions")==0)
 			dedotify_versions((void *)hdr + sechdrs[i].sh_offset,
 					  sechdrs[i].sh_size);
-		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".opd")) {
-			me->arch.start_opd = sechdrs[i].sh_addr;
-			me->arch.end_opd = sechdrs[i].sh_addr +
-					   sechdrs[i].sh_size;
-		}
 
 		/* We don't handle .init for the moment: rename to _init */
 		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init")))
-- 
2.17.0
