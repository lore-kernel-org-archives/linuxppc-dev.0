Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzXJ80xL3zDr51
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 20:07:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Eryu Guan <eguan@redhat.com>
Cc: tj@kernel.org, Balbir Singh <bsingharora@gmail.com>, liwan@redhat.com,
 "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: kworker with empty task->cpus_allowed (was Re: [v4.12-rc1
 regression] mount ext4 fs results in kernel crash on PPC64le host)
In-Reply-To: <20170629135919.GU23360@eguan.usersys.redhat.com>
References: <20170628083237.GF23360@eguan.usersys.redhat.com>
 <CAKTCnzncEoCC4=p2_ySpNdB6229SbCCqjDCzfpf8XA0xvvzH1g@mail.gmail.com>
 <20170629034122.GI23360@eguan.usersys.redhat.com>
 <CAKTCnzk8VMN0hBi24vEoNPGvvX-s8uhrjMdn7drQVDUdfA_+Ow@mail.gmail.com>
 <20170629100533.GQ23360@eguan.usersys.redhat.com>
 <87efu39he0.fsf@concordia.ellerman.id.au>
 <20170629113933.GT23360@eguan.usersys.redhat.com>
 <878tkb9ewo.fsf@concordia.ellerman.id.au>
 <20170629135919.GU23360@eguan.usersys.redhat.com>
Date: Fri, 30 Jun 2017 20:07:02 +1000
Message-ID: <8760fdrdq1.fsf@concordia.ellerman.id.au>
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

Eryu Guan <eguan@redhat.com> writes:
>
> I have to update the patch a bit to make it compile.

Sure.

>> +	WARN_ON(cpumask_empty(worker->task->cpus_allowed));
>> +	WARN_ON(cpumask_empty(pool->attrs->cpumask));
>
> Seems only the last two WARN_ON were triggered.

OK thanks.

Can you try this patch and see if it changes anything? (with the debug
still applied).

We've been trying to reproduce the bug here but haven't had any luck so far.

cheers

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4640f6d64f8b..b310ecc07e00 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -733,6 +733,8 @@ void __init setup_per_cpu_areas(void)
 	for_each_possible_cpu(cpu) {
                 __per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
 		paca[cpu].data_offset = __per_cpu_offset[cpu];
+
+		set_cpu_numa_node(cpu, numa_cpu_lookup_table[cpu]);
 	}
 }
 #endif
