Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wt0p36ltNzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 20:10:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, John Allen <jallen@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] powerpc: Only obtain cpu_hotplug_lock if called by rtasd
In-Reply-To: <1497996510-4032-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1497996510-4032-1-git-send-email-bauerman@linux.vnet.ibm.com>
Date: Wed, 21 Jun 2017 20:10:18 +1000
Message-ID: <8737attzw5.fsf@concordia.ellerman.id.au>
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

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Calling arch_update_cpu_topology from a CPU hotplug state machine callback
> hits a deadlock because the function tries to get a read lock on
> cpu_hotplug_lock while the state machine still holds a write lock on it.
>
> Since all callers of arch_update_cpu_topology except rtasd already hold
> cpu_hotplug_lock, this patch changes the function to use
> stop_machine_cpuslocked and creates a separate function for rtasd which
> still tries to obtain the lock.
>
> Michael Bringmann investigated the bug and provided a detailed analysis
> of the deadlock on this previous RFC for an alternate solution:
>
> https://patchwork.ozlabs.org/patch/771293/

Do we know when this broke? Or has it never worked?

Should it go to stable? (can't in its current form AFAICS)

> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>
> Notes:
>     This patch applies on tip/smp/hotplug, it should probably be carried there.

stop_machine_cpuslocked() doesn't exist in mainline so I think it has to
be carried there right?

cheers
