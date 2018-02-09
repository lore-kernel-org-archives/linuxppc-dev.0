Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd1Yt02KczF17Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 15:00:33 +1100 (AEDT)
In-Reply-To: <151699561194.20320.12952014708209986173.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [RESEND,
 V2] powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove
Message-Id: <3zd1Ys4JMGz9s7M@ozlabs.org>
Date: Fri,  9 Feb 2018 15:00:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-01-26 at 19:41:59 UTC, Nathan Fontenot wrote:
> When DLPAR removing a CPU, the unmapping of the cpu from a node in
> unmap_cpu_from_node() should also invalidate the CPUs entry in the
> numa_cpu_lookup_table. There is not a guarantee that on a subsequent
> DLPAR add of the CPU the associativity will be the same and thus
> could be in a different node. Invalidating the entry in the
> numa_cpu_lookup_table causes the associativity to be read from the
> device tree at the time of the add.
> 
> The current behavior of not invalidating the CPUs entry in the
> numa_cpu_lookup_table can result in scenarios where the the topology
> layout of CPUs in the partition does not match the device tree
> or the topology reported by the HMC.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1d9a090783bef19fe8cdec878620d2

cheers
