Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E168CB704B
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2012 10:46:52 +1000 (EST)
Message-ID: <1334105211.2984.5.camel@pasglop>
Subject: Re: [PATCH 03/12] powerpc: Rework runlatch code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Wed, 11 Apr 2012 10:46:51 +1000
In-Reply-To: <m2vcldamh2.fsf@igel.home>
References: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
 <1330680922-6894-4-git-send-email-benh__48089.0872575857$1330681158$gmane$org@kernel.crashing.org>
 <m2vcldamh2.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-04-05 at 23:38 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > This moves the inlines into system.h and changes the runlatch
> > code to use the thread local flags (non-atomic) rather than
> > the TIF flags (atomic) to keep track of the latch state.
> >
> > The code to turn it back on in an asynchronous interrupt is
> > now simplified and partially inlined.
> 
> This breaks the X server in that it no longer receives SIGIO signals.

I think I found my st00pid bug, can you try this patch ?

>From fae2e0fb24c61ca68c98d854a34732549ebc1854 Mon Sep 17 00:00:00 2001
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Apr 2012 10:42:15 +1000
Subject: [PATCH] powerpc: Fix typo in runlatch code

Commit fe1952fc0afb9a2e4c79f103c08aef5d13db1873
"powerpc: Rework runlatch code" has a nasty typo
where it uses "TLF_RUNLATCH" instead of "_TLF_RUNLATCH"
(bit number instead of bit mask), causing some flags to
be potentially lost such as _TLF_RESTORE_SIGMASK

(Brown paper bag for me ! We should be able to make
that break at compile time with a bit of magic, any
volunteer ?)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/process.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index f88698c..4937c96 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1235,7 +1235,7 @@ void __ppc64_runlatch_on(void)
 	ctrl |= CTRL_RUNLATCH;
 	mtspr(SPRN_CTRLT, ctrl);
 
-	ti->local_flags |= TLF_RUNLATCH;
+	ti->local_flags |= _TLF_RUNLATCH;
 }
 
 /* Called with hard IRQs off */
@@ -1244,7 +1244,7 @@ void __ppc64_runlatch_off(void)
 	struct thread_info *ti = current_thread_info();
 	unsigned long ctrl;
 
-	ti->local_flags &= ~TLF_RUNLATCH;
+	ti->local_flags &= ~_TLF_RUNLATCH;
 
 	ctrl = mfspr(SPRN_CTRLF);
 	ctrl &= ~CTRL_RUNLATCH;
-- 
1.7.9.5
