Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wt0Rs2Q9BzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 19:54:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, ltc-virtual-io@lists.linux.ibm.com
Subject: Re: [PATCH V6 0/2] powerpc/dlpar: Correct display of
 hot-add/hot-remove CPUs and memory
In-Reply-To: <b0e02344-965b-5298-4ef6-3ec67d1200c4@linux.vnet.ibm.com>
References: <b0e02344-965b-5298-4ef6-3ec67d1200c4@linux.vnet.ibm.com>
Date: Wed, 21 Jun 2017 19:54:32 +1000
Message-ID: <8760fpu0mf.fsf@concordia.ellerman.id.au>
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

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> On Power systems with shared configurations of CPUs and memory, there
> are some issues with association of additional CPUs and memory to nodes
> when hot-adding resources.  These patches address some of those problems.
>
> powerpc/hotplug: On systems like PowerPC which allow 'hot-add' of CPU
> or memory resources, it may occur that the new resources are to be
> inserted into nodes that were not used for these resources at bootup.
> In the kernel, any node that is used must be defined and initialized
> at boot.  In order to meet both needs, this patch adds a new kernel
> command line option (numnodes=<int>) for use by the PowerPC
> architecture-specific code that defines the maximum number of nodes
> that the kernel will ever need in its current hardware environment.
> The boot code that initializes nodes for PowerPC will read this value
> and use it to ensure that all of the desired nodes are setup in the
> 'node_possible_map', and elsewhere.
>
> powerpc/numa: Correct the currently broken capability to set the
> topology for shared CPUs in LPARs.  At boot time for shared CPU
> lpars, the topology for each shared CPU is set to node zero, however,
> this is now updated correctly using the Virtual Processor Home Node
> (VPHN) capabilities information provided by the pHyp. The VPHN handling
> in Linux is disabled, if PRRN handling is present.
>
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>
> Michael Bringmann (2):
>   powerpc/hotplug: Add option to define max nodes allowing dynamic
>       growth of resources.
>   powerpc/numa: Update CPU topology when VPHN enabled
> ---
> Changes in V6:
>   -- Reorder some code to better eliminate unused functions in
>        conditional builds.

What changed between yesterday's V6 and this V6?

If you're going to resend, please bump the version number, we have tools
that parse the subject and version, and resending multiple times with
the same number breaks those.

cheers
