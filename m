Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 6ACADB70D4
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2010 13:42:59 +1100 (EST)
Subject: Re: Oops in trace_hardirqs_on (powerpc)
From: Steven Rostedt <rostedt@goodmis.org>
To: =?ISO-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
In-Reply-To: <20101219132705.GE6615@alea.gnuu.de>
References: <20100806233157.GA7117@alea.gnuu.de>
	<1285184671.26872.127.camel@gandalf.stny.rr.com>
	<20100927125037.GA4497@alea.gnuu.de> <1285639094.2989.1.camel@frodo>
	<20101219132705.GE6615@alea.gnuu.de>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Wed, 22 Dec 2010 21:42:56 -0500
Message-ID: <1293072176.22802.6.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-12-19 at 14:27 +0100, Jörg Sommer wrote:
> Hi Steven,
> 

> Did you've fixed this problem? The bug report is still marked as open.
> https://bugzilla.kernel.org/show_bug.cgi?id=16573
> 

I just posted a patch to that BZ. I have it here below too. Could you
see if it fixes you problem. I only fixed the one place that you
reported, it may need more fixes (and in that case a macro to do the
work).

I hit the same bug on my ppc64 box, and have a fix for that, that I'll
post to LKML tomorrow.

-- Steve

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index ed4aeb9..915cc03 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -879,7 +879,18 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 	 */
 	andi.	r10,r9,MSR_EE
 	beq	1f
+	/*
+	 * Since the ftrace irqsoff latency trace checks CALLER_ADDR1,
+	 * which is the stack frame here, we need to force a stack frame
+	 * in case we came from user space.
+	 */
+	stwu	r1,-32(r1)
+	mflr	r0
+	stw	r0,4(r1)
+	stwu	r1,-32(r1)
 	bl	trace_hardirqs_on
+	lwz	r1,0(r1)
+	lwz	r1,0(r1)
 	lwz	r9,_MSR(r1)
 1:
 #endif /* CONFIG_TRACE_IRQFLAGS */
