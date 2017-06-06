Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whfLD5H7PzDqKY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 14:47:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/kernel: Initialize load_tm on task creation
In-Reply-To: <87k24q11zn.fsf@linkitivity.dja.id.au>
References: <1496673659-18499-1-git-send-email-leitao@debian.org>
 <87k24q11zn.fsf@linkitivity.dja.id.au>
Date: Tue, 06 Jun 2017 14:47:16 +1000
Message-ID: <87efuxracr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Axtens <dja@axtens.net> writes:

> Hi Breno,
>
> Looks good to me.
>
>> Currently tsk->thread.load_tm is not initialized in the task creation
>> and can contain garbage on a new task.
>>
>> This is an undesired behaviour, since it affects the timing to enable
>> and disable the transactional memory laziness (disabling and enabling
>> the MSR TM bit, which affects TM reclaim and recheckpoint in the
>> scheduling process).
>
> Is there any chance this uninitialised memory will leak something
> interesting/sensitive? (Therefore, should this go to stable?)

I'll send it to stable anyway for the original bug it fixes.

cheers
