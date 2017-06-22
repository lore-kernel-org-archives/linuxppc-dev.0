Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtNsr4d9jzDr3V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 11:14:56 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5M1Dhnh138392
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 21:14:54 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7vn7b98y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 21:14:54 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 22:14:51 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5M1EnIm49872932
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 22:14:49 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5LMEnrH029281
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 19:14:49 -0300
References: <1497996510-4032-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <8737attzw5.fsf@concordia.ellerman.id.au>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 John Allen <jallen@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] powerpc: Only obtain cpu_hotplug_lock if called by rtasd
In-reply-to: <8737attzw5.fsf@concordia.ellerman.id.au>
Date: Wed, 21 Jun 2017 22:14:41 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h8z8g6wu.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Michael Ellerman <mpe@ellerman.id.au> writes:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>
>> Calling arch_update_cpu_topology from a CPU hotplug state machine callback
>> hits a deadlock because the function tries to get a read lock on
>> cpu_hotplug_lock while the state machine still holds a write lock on it.
>>
>> Since all callers of arch_update_cpu_topology except rtasd already hold
>> cpu_hotplug_lock, this patch changes the function to use
>> stop_machine_cpuslocked and creates a separate function for rtasd which
>> still tries to obtain the lock.
>>
>> Michael Bringmann investigated the bug and provided a detailed analysis
>> of the deadlock on this previous RFC for an alternate solution:
>>
>> https://patchwork.ozlabs.org/patch/771293/
>
> Do we know when this broke? Or has it never worked?

It's been broken since at least v4.4, I think. I don't know about
earlier versions.

> Should it go to stable? (can't in its current form AFAICS)

It's not hard to backport both this patch and commit fe5595c07400
("stop_machine: Provide stop_machine_cpuslocked()") from branch
smp/hotplug in tip.git for stable.

Since rtasd only started calling arch_update_cpu_topology since v4.11,
for earlier versions this patch can be simplified to making that
function call stop_machine_cpuslocked unconditionally instead of
defining a separate function.

>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>> ---
>>
>> Notes:
>>     This patch applies on tip/smp/hotplug, it should probably be carried there.
>
> stop_machine_cpuslocked() doesn't exist in mainline so I think it has to
> be carried there right?

Yes. I said "probably" because I don't know if you want to wait
until that branch is merged so that you can carry this patch in your
tree.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
