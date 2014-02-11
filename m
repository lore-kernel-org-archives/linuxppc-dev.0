Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9B0C32C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 19:15:33 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 11 Feb 2014 13:45:29 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id DBC65E0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 13:48:44 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1B8FLSC51708126
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 13:45:21 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1B8FOjv013644
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 13:45:25 +0530
Date: Tue, 11 Feb 2014 13:45:24 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] powerpc/spufs: Remove MAX_USER_PRIO define
Message-ID: <20140211081524.GA8278@linux.vnet.ibm.com>
References: <1392098717.689604.970589769393.1.gpush@pablo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1392098717.689604.970589769393.1.gpush@pablo>
Cc: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Jeremy Kerr <jk@ozlabs.org> [2014-02-11 14:05:17]:

> Current ppc64_defconfig fails with:
> 
>  arch/powerpc/platforms/cell/spufs/sched.c:86:0: error: "MAX_USER_PRIO" redefined [-Werror]
>  cc1: all warnings being treated as errors
> 
> 6b6350f1 introduced a generic MAX_USER_PRIO macro to sched/prio.h, which
> is causing the conflit. Use that one instead of our own.

you can also use DEFAULT_PRIO from sched/prio.h instead of NORMAL_PRIO.

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 49318385d4fa..014979db2018 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -64,11 +64,6 @@ static struct timer_list spusched_timer;
 static struct timer_list spuloadavg_timer;
 
 /*
- * Priority of a normal, non-rt, non-niced'd process (aka nice level 0).
- */
-#define NORMAL_PRIO		120
-
-/*
  * Frequency of the spu scheduler tick.  By default we do one SPU scheduler
  * tick for every 10 CPU scheduler ticks.
  */
@@ -97,7 +92,7 @@ static struct timer_list spuloadavg_timer;
  */
 void spu_set_timeslice(struct spu_context *ctx)
 {
-	if (ctx->prio < NORMAL_PRIO)
+	if (ctx->prio < DEFAULT_PRIO)
 		ctx->time_slice = SCALE_PRIO(DEF_SPU_TIMESLICE * 4, ctx->prio);
 	else
 		ctx->time_slice = SCALE_PRIO(DEF_SPU_TIMESLICE, ctx->prio);

Thanks,
Kamalesh.
