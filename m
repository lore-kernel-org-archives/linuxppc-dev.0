Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBC3n4B4rzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 20:48:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Daniel Black <daniel.black@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Drop lockdep_assert_cpus_held call from
 arch_update_cpu_topology
In-Reply-To: <alpine.DEB.2.20.1710052031590.2398@nanos>
References: <20171005000430.8080-1-bauerman@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710051435530.2083@nanos>
 <87o9pl5u4m.fsf@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710052031590.2398@nanos>
Date: Tue, 10 Oct 2017 20:48:36 +1100
Message-ID: <87o9pfwcy3.fsf@concordia.ellerman.id.au>
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

Thomas Gleixner <tglx@linutronix.de> writes:
...
>
> So no, the lockdep assertion triggers in #1 and #2 because
>
>    #1 does definitely not hold it
>
>    #2 is indirectily protected, but we have no way to express that to lockdep
>
> So yes, it's safe for both cases to remove that assertion.

Thanks for clarifying that.

> If there are other call sites, then they need to be checked. If not, you're
> good.

I also see a call in partition_sched_domains(). The comment there says
"call with hotplug lock held" and I'm sure all callers do so ...

But seriously I think the patch is good because we know there are at
least two callers who are safe but can't hold the lock, so doing an
assert there is definitely wrong.

So I'll apply the patch with a slightly reworked commit message.

cheers
