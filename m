Return-Path: <SRS0=7pvk=WC=start.ca=wilsons@srs.perfora.net>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	by ozlabs.org (Postfix) with ESMTP id AE5A0B70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 11:39:14 +1100 (EST)
From: Stephen Wilson <wilsons@start.ca>
To: x86@kernel.org
Subject: [PATCH 1/5] x86: add context tag to mark mm when running a task in
	32-bit compatibility mode
Date: Tue,  8 Mar 2011 19:31:57 -0500
Message-Id: <1299630721-4337-2-git-send-email-wilsons@start.ca>
In-Reply-To: <1299630721-4337-1-git-send-email-wilsons@start.ca>
References: <1299630721-4337-1-git-send-email-wilsons@start.ca>
Cc: linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, Stephen Wilson <wilsons@start.ca>,
	linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Michel Lespinasse <walken@google.com>, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This tag is intended to mirror the thread info TIF_IA32 flag.  Will be used to
identify mm's which support 32 bit tasks running in compatibility mode without
requiring a reference to the task itself.

Signed-off-by: Stephen Wilson <wilsons@start.ca>
---
 arch/x86/include/asm/mmu.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 80a1dee..8a2e5b4 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -13,6 +13,12 @@ typedef struct {
 	int size;
 	struct mutex lock;
 	void *vdso;
+
+#ifdef CONFIG_X86_64
+	/* True if mm supports a task running in 32 bit compatibility mode. */
+	unsigned short compat;
+#endif
+
 } mm_context_t;
 
 #ifdef CONFIG_SMP
-- 
1.7.3.5
