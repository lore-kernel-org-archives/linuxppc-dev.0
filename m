Return-Path: <liwp.linux@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 20C69B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 23:13:51 +1000 (EST)
Received: by dajt11 with SMTP id t11so4417472daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 06:13:50 -0700 (PDT)
From: Wanpeng Li <liwp.linux@gmail.com>
To: trivial@kernel.org
Subject: [PATCH 2/7][TRIVIAL][resend] x86/kernel: cleanup some kernel-doc
 warnings
Date: Fri, 15 Jun 2012 21:13:22 +0800
Message-Id: <1339766008-7279-1-git-send-email-liwp.linux@gmail.com>
Cc: Christoph Lameter <cl@linux-foundation.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 Jesse Barnes <jbarnes@virtuousgeek.org>, David Howells <dhowells@redhat.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Gavin Shan <shangw@linux.vnet.ibm.com>, x86@kernel.org,
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
 Wanpeng Li <liwp.linux@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Mel Gorman <mel@csn.ul.ie>, Jason Wessel <jason.wessel@windriver.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>,
 cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 Minchan Kim <minchan@kernel.org>, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wanpeng Li <liwp@linux.vnet.ibm.com>

Warning(arch/x86/kernel/kgdb.c:465): No description found for parameter 'e_vector'
Warning(arch/x86/kernel/kgdb.c:465): No description found for parameter 'remcomInBuffer'
Warning(arch/x86/kernel/kgdb.c:465): No description found for parameter 'remcomOutBuffer'
Warning(arch/x86/kernel/kgdb.c:465): No description found for parameter 'linux_regs'
Warning(arch/x86/kernel/kgdb.c:465): Excess function parameter 'vector' description in 'kgdb_arch_handle_exception'
Warning(arch/x86/kernel/kgdb.c:465): Excess function parameter 'remcom_in_buffer' description in 'kgdb_arch_handle_exception'
Warning(arch/x86/kernel/kgdb.c:465): Excess function parameter 'remcom_out_buffer' description in 'kgdb_arch_handle_exception'
Warning(arch/x86/kernel/kgdb.c:465): Excess function parameter 'regs' description in 'kgdb_arch_handle_exception'
Warning(arch/x86/kernel/uprobes.c:416): No description found for parameter 'auprobe'
Warning(arch/x86/kernel/uprobes.c:416): Excess function parameter 'arch_uprobe' description in 'arch_uprobe_analyze_insn'
Warning(arch/x86/lib/csum-wrappers_64.c:125): No description found for parameter 'sum'
Warning(arch/x86/lib/csum-wrappers_64.c:125): Excess function parameter 'isum' description in 'csum_partial_copy_nocheck'

Signed-off-by: Wanpeng Li <liwp.linux@gmail.com>

---
 arch/x86/kernel/kgdb.c    |    8 ++++----
 arch/x86/kernel/uprobes.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 8bfb614..3f61904 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -444,12 +444,12 @@ void kgdb_roundup_cpus(unsigned long flags)
 
 /**
  *	kgdb_arch_handle_exception - Handle architecture specific GDB packets.
- *	@vector: The error vector of the exception that happened.
+ *	@e_vector: The error vector of the exception that happened.
  *	@signo: The signal number of the exception that happened.
  *	@err_code: The error code of the exception that happened.
- *	@remcom_in_buffer: The buffer of the packet we have read.
- *	@remcom_out_buffer: The buffer of %BUFMAX bytes to write a packet into.
- *	@regs: The &struct pt_regs of the current process.
+ *	@remcomInBuffer: The buffer of the packet we have read.
+ *	@remcomOutBuffer: The buffer of %BUFMAX bytes to write a packet into.
+ *	@linux_regs: The &struct pt_regs of the current process.
  *
  *	This function MUST handle the 'c' and 's' command packets,
  *	as well packets to set / remove a hardware breakpoint, if used.
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index dc4e910..f785a06 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -408,7 +408,7 @@ static int validate_insn_bits(struct arch_uprobe *auprobe, struct mm_struct *mm,
 /**
  * arch_uprobe_analyze_insn - instruction analysis including validity and fixups.
  * @mm: the probed address space.
- * @arch_uprobe: the probepoint information.
+ * @auprobe: the probepoint information.
  * Return 0 on success or a -ve number on error.
  */
 int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm)
-- 
1.7.9.5
