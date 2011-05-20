Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3977B71A3
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 23:57:47 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4KDkFV6005516
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 07:46:15 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p4KDvcdg159672
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 07:57:39 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4KDvc4F030276
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 07:57:38 -0600
Date: Fri, 20 May 2011 09:58:45 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20110520135845.GG25179@zod.rchland.ibm.com>
References: <1305777978.7481.37.camel@pasglop>
	<20110520132328.GA5785@riccoc20.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110520132328.GA5785@riccoc20.at.omicron.at>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 20, 2011 at 03:23:29PM +0200, Richard Cochran wrote:
>When I try to build 'next' (now at 208b3a4c), it does not compile due
>to a change from the following commit.
>
>> Benjamin Herrenschmidt (1):
>>       powerpc/smp: Make start_secondary_resume available to all CPU variants
>
>I would appreciate your help in getting this fixed...

Could you try the patch below?

Commit 69e3cea8d5fd526 introduced start_secondary_resume to misc_32.S,
however it uses a 64-bit instruction which is not valid on 32-bit
platforms.  Use 'stw' instead.

Reported-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---

diff --git a/arch/powerpc/kernel/misc_32.S
b/arch/powerpc/kernel/misc_32.S
index 402560e..998a100 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -700,7 +700,7 @@ _GLOBAL(start_secondary_resume)
	rlwinm  r1,r1,0,0,(31-THREAD_SHIFT)     /* current_thread_info() */
	addi    r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
	li      r3,0
-	std     r3,0(r1)                /* Zero the stack frame pointer */
+	stw     r3,0(r1)                /* Zero the stack frame pointer */
	bl      start_secondary
	b       .
 #endif /* CONFIG_SMP */
