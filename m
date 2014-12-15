Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 267F81A0212
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 16 Dec 2014 00:51:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8FD252BB0067
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:01 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBFEp1Uf29753584
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:01 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBFEp0m6004563
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:01 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mpe@ellerman.id.au
Subject: [PATCHv2 3/8] perf probe powerpc: Fix symbol fixup issues due to ELF
 type
Date: Mon, 15 Dec 2014 20:20:33 +0530
Message-Id: <a31f3cfd0841bea8e615ebd6f8f0ec5a0d1f1eaa.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If using the symbol table, symbol addresses are not being fixed up
properly, resulting in probes being placed at wrong addresses:

  # perf probe do_fork
  Added new event:
    probe:do_fork        (on do_fork)

  You can now use it in all perf tools, such as:

	  perf record -e probe:do_fork -aR sleep 1

  # cat /sys/kernel/debug/tracing/kprobe_events
  p:probe/do_fork _text+635952
  # printf "%x" 635952
  9b430
  # grep do_fork /boot/System.map
  c0000000000ab430 T .do_fork

Fix by checking for ELF type ET_DYN used by ppc64 kernels.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/util/symbol-elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 06fcd1b..7ac4e4c 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -683,7 +683,8 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 						     NULL) != NULL);
 	} else {
 		ss->adjust_symbols = ehdr.e_type == ET_EXEC ||
-				     ehdr.e_type == ET_REL;
+				     ehdr.e_type == ET_REL ||
+				     ehdr.e_type == ET_DYN;
 	}
 
 	ss->name   = strdup(name);
-- 
2.1.3
