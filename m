Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CFB61A0942
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 19:17:20 +1100 (AEDT)
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 3 Nov 2015 08:17:17 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3B51917D805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 08:17:29 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA38HEQa13369752
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 08:17:14 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA38HD2I029069
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 01:17:13 -0700
Subject: Re: [PATCH] cxl: Fix reference count on struct pid when attaching
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <1446122343-26068-1-git-send-email-frederic.barrat@fr.ibm.com>
 <1446425625.27828.0.camel@ellerman.id.au>
 <1446507545-sup-9915@delenn.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56386D88.3020206@linux.vnet.ibm.com>
Date: Tue, 3 Nov 2015 09:17:12 +0100
MIME-Version: 1.0
In-Reply-To: <1446507545-sup-9915@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 03/11/2015 00:48, Ian Munsie a écrit :
> Excerpts from Michael Ellerman's message of 2015-11-02 11:53:45 +1100:
>> On Thu, 2015-10-29 at 13:39 +0100, Frederic Barrat wrote:
>>
>>> When the cxl driver creates a context, it stores the pid of the
>>> calling task, incrementing the reference count on the struct
>>> pid. Current code mistakenly increments the reference count twice,
>>> once through get_task_pid(), once through get_pid(). The reference
>>> count is only decremented once on detach, thus the struct pid of the
>>> task attaching is never freed. The fix is to simply remove the call to
>>> get_pid().
>>>
>>> Signed-off-by: Frederic Barrat <frederic.barrat@fr.ibm.com>
>>
>> What's the symptom?
>
> Everytime a process attached to a capi device it would reduce the total
> number of processes that can be running simultaneously by one.
>
>> Broken since when?
>> Forever?
>> So should go to stable?
>> Starting from which release?
>
> Looks like we managed to introduce the same bug twice (d'oh!), so we
> should probably split this into two separate patches:
>
> The bug in file.c has existed forever so the fix for that should go to
> stable for 3.18+
>
> The bug in api.c will only need to go in for 4.3 since that is the
> release where cxlflash was merged and there weren't any users of that
> code before that.


So I'm dropping this patch and will resubmit as 2 separate patches.

   Fred
