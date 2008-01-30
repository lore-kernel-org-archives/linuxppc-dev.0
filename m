Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDD18DDF6D
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 06:46:31 +1100 (EST)
Date: Wed, 30 Jan 2008 20:46:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: x86/non-x86: percpu, node ids, apic ids x86.git fixup
Message-ID: <20080130194616.GA19426@elte.hu>
References: <200801301414.m0UEEgCC006371@hera.kernel.org>
	<Pine.LNX.4.64.0801301622460.11859@vixen.sonytel.be>
	<47A09F8A.3000309@sgi.com> <20080130161036.GA12293@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757C72@orsmsx424.amr.corp.intel.com>
	<20080130180623.GA24881@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757DEA@orsmsx424.amr.corp.intel.com>
	<47A0CD4B.5040706@sgi.com>
	<1FE6DD409037234FAB833C420AA843EC757F12@orsmsx424.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1FE6DD409037234FAB833C420AA843EC757F12@orsmsx424.amr.corp.intel.com>
Cc: sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Luck, Tony <tony.luck@intel.com> wrote:

> > This is only defined for !__ASSEMBLY__
> 
> Some place in there.  The CONFIG_SMP=n path in ia64 makes quite 
> radical changes ... rather than putting all the per-cpu stuff into the 
> top 64K of address space and providing a per-cpu TLB mapping for that 
> range to a different physical address ... it just makes all the 
> per-cpu stuff link as ordinary variables in .data.  The error messages 
> indicate that some of the new code is unaware of this.

ah, that was the vital clue. The patch below makes the small memory 
model only defined on SMP, and makes the config build/link fine here. 
Does this build and boot on your box?

	Ingo

------------>
Subject: ia64: build fix #3
From: Ingo Molnar <mingo@elte.hu>

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/asm-ia64/percpu.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-x86.q/include/asm-ia64/percpu.h
===================================================================
--- linux-x86.q.orig/include/asm-ia64/percpu.h
+++ linux-x86.q/include/asm-ia64/percpu.h
@@ -15,12 +15,12 @@
 
 #include <linux/threads.h>
 
+#ifdef CONFIG_SMP
+
 #ifdef HAVE_MODEL_SMALL_ATTRIBUTE
 # define PER_CPU_ATTRIBUTES	__attribute__((__model__ (__small__)))
 #endif
 
-#ifdef CONFIG_SMP
-
 #define __my_cpu_offset	__ia64_per_cpu_var(local_per_cpu_offset)
 
 extern void *per_cpu_init(void);
