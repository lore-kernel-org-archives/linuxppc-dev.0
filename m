Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-01.nyroc.rr.com (ms-smtp-01.nyroc.rr.com [24.24.2.55])
	by ozlabs.org (Postfix) with ESMTP id D3ADF67AA0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 19:59:34 +1000 (EST)
Date: Wed, 17 May 2006 05:59:28 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 05/09] robust VM per_cpu module
In-Reply-To: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605170558370.8408@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, benedict.gaster@superh.com,
	sam@ravnborg.org, bjornw@axis.com, kenneth.w.chen@intel.com,
	Ingo Molnar <mingo@elte.hu>, kiran@scalex86.org,
	clameter@sgi.com, Nick Piggin <nickpiggin@yahoo.com.au>,
	grundler@parisc-linux.org, arnd@arndb.de,
	Rusty Russell <rusty@rustcorp.com.au>, starvik@axis.com,
	Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	Chris Zankel <chris@zankel.net>, tony.luck@intel.com,
	Andi Kleen <ak@suse.de>, ralf@linux-mips.org,
	Marc Gauthier <marc@tensilica.com>, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch performs a check on the return value of percpu_modcopy
for the module load.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-test/kernel/module.c
===================================================================
--- linux-2.6.16-test.orig/kernel/module.c	2006-05-17 04:32:28.000000000 -0400
+++ linux-2.6.16-test/kernel/module.c	2006-05-17 04:57:53.000000000 -0400
@@ -1819,8 +1819,11 @@ static struct module *load_module(void _
 	sort_extable(extable, extable + mod->num_exentries);

 	/* Finally, copy percpu area over. */
-	percpu_modcopy(mod->percpu, (void *)sechdrs[pcpuindex].sh_addr,
-		       sechdrs[pcpuindex].sh_size);
+	err = percpu_modcopy(mod->percpu, (void *)sechdrs[pcpuindex].sh_addr,
+			     sechdrs[pcpuindex].sh_size);
+
+	if (err < 0)
+		goto cleanup;

 	add_kallsyms(mod, sechdrs, symindex, strindex, secstrings);
