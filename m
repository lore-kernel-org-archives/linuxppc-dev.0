Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3syfLK0C87zDvNf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 13:35:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 jiangshanlai@gmail.com, akpm@linux-foundation.org, kernel-team@fb.com,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
In-Reply-To: <cdbc6901-9183-c2ff-1690-e909381c7956@gmail.com>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
 <20161014150757.GA11102@mtj.duckdns.org>
 <87eg3fcge5.fsf@concordia.ellerman.id.au>
 <cdbc6901-9183-c2ff-1690-e909381c7956@gmail.com>
Date: Tue, 18 Oct 2016 13:35:02 +1100
Message-ID: <871szecrl5.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:
> On 17/10/16 23:24, Michael Ellerman wrote:
>> That happened because we haven't yet called set_cpu_numa_node() for the non-boot
>> cpus, because that happens in smp_prepare_cpus(), and
>> workqueue_init_early() is called much earlier than that.
>> 
>> This doesn't trigger on x86 because it does set_cpu_numa_node() in
>> setup_per_cpu_areas(), which is called prior to workqueue_init_early().
>> 
>> We can (should) probably do the same on powerpc, I'll look at that
>> tomorrow. But other arches may have a similar problem, and at the very
>> least we need to document that workqueue_init_early() relies on
>> cpu_to_node() working.
>
> Don't we do the setup cpu->node mapings in initmem_init()?
> Ideally we have setup_arch->intmem_init->numa_setup_cpu

That sets up numa_cpu_lookup_table, which is a powerpc only data
structure.

But it doesn't setup the percpu numa_node variables, used by
cpu_to_node(), because percpu areas are not setup yet.

cheers
