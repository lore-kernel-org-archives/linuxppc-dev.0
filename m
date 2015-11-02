Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C1FF1A0290
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 10:49:29 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 3 Nov 2015 09:49:27 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6D6033578047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 10:49:24 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA2NnFCR61669556
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 10:49:24 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA2Nmptm026744
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 10:48:51 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frederic Barrat <frederic.barrat@fr.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] cxl: Fix reference count on struct pid when attaching
In-reply-to: <1446425625.27828.0.camel@ellerman.id.au>
References: <1446122343-26068-1-git-send-email-frederic.barrat@fr.ibm.com>
 <1446425625.27828.0.camel@ellerman.id.au>
Date: Tue, 03 Nov 2015 10:48:27 +1100
Message-Id: <1446507545-sup-9915@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of 2015-11-02 11:53:45 +1100:
> On Thu, 2015-10-29 at 13:39 +0100, Frederic Barrat wrote:
> 
> > When the cxl driver creates a context, it stores the pid of the
> > calling task, incrementing the reference count on the struct
> > pid. Current code mistakenly increments the reference count twice,
> > once through get_task_pid(), once through get_pid(). The reference
> > count is only decremented once on detach, thus the struct pid of the
> > task attaching is never freed. The fix is to simply remove the call to
> > get_pid().
> > 
> > Signed-off-by: Frederic Barrat <frederic.barrat@fr.ibm.com>
> 
> What's the symptom?

Everytime a process attached to a capi device it would reduce the total
number of processes that can be running simultaneously by one.

> Broken since when?
> Forever?
> So should go to stable?
> Starting from which release?

Looks like we managed to introduce the same bug twice (d'oh!), so we
should probably split this into two separate patches:

The bug in file.c has existed forever so the fix for that should go to
stable for 3.18+

The bug in api.c will only need to go in for 4.3 since that is the
release where cxlflash was merged and there weren't any users of that
code before that.

Cheers
-Ian
