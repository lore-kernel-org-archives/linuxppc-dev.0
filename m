Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EB281A0483
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 09:46:22 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 4 Nov 2015 08:46:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 13C992CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 09:46:17 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA3Mk8nB1638746
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 09:46:16 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA3MjitX007055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 09:45:44 +1100
Message-ID: <563938FF.7020206@au1.ibm.com>
Date: Wed, 04 Nov 2015 09:45:19 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
CC: stable@vger.kernel.org
Subject: Re: [PATCH] cxl: Fix struct pid leak when attaching a process through
 user API
References: <1446552832-17592-1-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1446552832-17592-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/11/15 23:13, Frederic Barrat wrote:
> When the cxl driver creates a context, it stores the pid of the
> calling task, and mistakenly increments the reference count of the
> struct pid twice, once through get_task_pid(), once through
> get_pid(). The reference count is only decremented once on detach. As
> a result, a struct pid is leaked and it reduces the number of
> processes that can run simultaneously by one.
> The fix is to simply remove the call to get_pid().
>
> There is a separate patch for the kernel API, since it goes to
> different kernel versions.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: <stable@vger.kernel.org> # 3.18+

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
