Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMM4T68RJzF0bB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 09:21:13 +1100 (AEDT)
Date: Thu, 18 Jan 2018 09:21:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the powerpc tree with the powerpc-fixes
 tree
Message-ID: <20180118092112.0e46a25c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/kernel/setup-common.c

between commit:

  349524bc0da6 ("powerpc: Don't preempt_disable() in show_cpuinfo()")

from the powerpc-fixes tree and commit:

  f5f563012a70 ("powerpc: Make newline in cpuinfo unconditional")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/kernel/setup-common.c
index 3f33869c6486,24da91768133..000000000000
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@@ -346,10 -354,10 +346,7 @@@ static int show_cpuinfo(struct seq_fil
  		   loops_per_jiffy / (500000/HZ),
  		   (loops_per_jiffy / (5000/HZ)) % 100);
  #endif
- 
- #ifdef CONFIG_SMP
  	seq_printf(m, "\n");
- #endif
 -
 -	preempt_enable();
 -
  	/* If this is the last cpu, print the summary */
  	if (cpumask_next(cpu_id, cpu_online_mask) >= nr_cpu_ids)
  		show_cpuinfo_summary(m);
