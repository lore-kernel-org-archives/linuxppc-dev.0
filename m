Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkFP94vvvzDqmb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 20:10:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
Subject: Re: [PATCH V12] powerpc/vphn: Update CPU topology when VPHN enabled
In-Reply-To: <ab71f6fe-4afa-16ce-ee95-4f255a4ece44@linux.vnet.ibm.com>
References: <ab71f6fe-4afa-16ce-ee95-4f255a4ece44@linux.vnet.ibm.com>
Date: Fri, 01 Sep 2017 20:10:36 +1000
Message-ID: <87h8wm686b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Thanks for trying to reduce this down to the minimum required.

But ...

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> powerpc/numa: On Power systems with shared configurations of CPUs
> and memory, there are some issues with the association of additional
> CPUs and memory to nodes when hot-adding resources.  This patch
> addresses some of those problems.
>
> First, it corrects the currently broken capability to set the
> topology for shared CPUs in LPARs.  At boot time for shared CPU
> lpars, the topology for each CPU was being set to node zero.  Now
> when numa_update_cpu_topology() is called appropriately, the Virtual
> Processor Home Node (VPHN) capabilities information provided by the
> pHyp allows the appropriate node in the shared configuration to be
> selected for the CPU.

That should be one patch.

> Next, it updates the initialization checks to independently recognize
> PRRN or VPHN support.

And another.

> Next, during hotplug CPU operations, it resets the timer on topology
> update work function to a small value to better ensure that the CPU
> topology is detected and configured sooner.

Another.

> Also, fix an end-of-updates processing problem observed occasionally
> in numa_update_cpu_topology().

And another.


I would have let you get away with lumping it all in together, except
that it doesn't compile when CONFIG_PPC_SPLPAR=3Dn:

  In file included from ../include/linux/topology.h:35:0,
                   from ../include/linux/gfp.h:8,
                   from ../include/linux/irq.h:17,
                   from ../arch/powerpc/include/asm/hardirq.h:5,
                   from ../include/linux/hardirq.h:8,
                   from ../include/linux/interrupt.h:12,
                   from ../arch/powerpc/platforms/pseries/hotplug-cpu.c:24:
  ../arch/powerpc/platforms/pseries/hotplug-cpu.c: In function =E2=80=98dlp=
ar_online_cpu=E2=80=99:
  ../arch/powerpc/include/asm/topology.h:103:38: error: statement with no e=
ffect [-Werror=3Dunused-value]
   #define timed_topology_update(nsecs) 0
                                        ^
  ../arch/powerpc/platforms/pseries/hotplug-cpu.c:366:4: note: in expansion=
 of macro =E2=80=98timed_topology_update=E2=80=99
      timed_topology_update(1);
      ^~~~~~~~~~~~~~~~~~~~~
  ../arch/powerpc/platforms/pseries/hotplug-cpu.c: In function =E2=80=98dlp=
ar_offline_cpu=E2=80=99:
  ../arch/powerpc/include/asm/topology.h:103:38: error: statement with no e=
ffect [-Werror=3Dunused-value]
   #define timed_topology_update(nsecs) 0
                                        ^
  ../arch/powerpc/platforms/pseries/hotplug-cpu.c:533:5: note: in expansion=
 of macro =E2=80=98timed_topology_update=E2=80=99
       timed_topology_update(1);
       ^~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors


So please fix that up, split it, and resend.

I know it would have been fairly easy for me to fix that compiler error,
but it tells me you haven't tested that configuration at all, which is
the bigger problem. Please at least give it a smoke test.

cheers
