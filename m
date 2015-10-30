Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8F2A1A01F2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 11:31:29 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 30 Oct 2015 10:31:27 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CC39E3578047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 11:31:24 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9U0V2gg19726390
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 11:31:10 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9U0UqFa001348
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 11:30:52 +1100
Message-ID: <5632BA46.8010309@au1.ibm.com>
Date: Fri, 30 Oct 2015 11:31:02 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Frederic Barrat <frederic.barrat@fr.ibm.com>, linuxppc-dev@lists.ozlabs.org
CC: imunsie@au1.ibm.com
Subject: Re: [PATCH] cxl: Fix reference count on struct pid when attaching
References: <1446122343-26068-1-git-send-email-frederic.barrat@fr.ibm.com>
In-Reply-To: <1446122343-26068-1-git-send-email-frederic.barrat@fr.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29/10/15 23:39, Frederic Barrat wrote:
> When the cxl driver creates a context, it stores the pid of the
> calling task, incrementing the reference count on the struct
> pid. Current code mistakenly increments the reference count twice,
> once through get_task_pid(), once through get_pid(). The reference
> count is only decremented once on detach, thus the struct pid of the
> task attaching is never freed. The fix is to simply remove the call to
> get_pid().
>
> Signed-off-by: Frederic Barrat <frederic.barrat@fr.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
