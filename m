Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zT8nT331QzDr2v
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 19:58:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RESEND V2 ] powerpc/numa: Invalidate numa_cpu_lookup_table
 on cpu remove
In-Reply-To: <151699561194.20320.12952014708209986173.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <151699561194.20320.12952014708209986173.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Date: Sat, 27 Jan 2018 19:58:18 +1100
Message-ID: <87po5v3cgl.fsf@concordia.ellerman.id.au>
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

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:

> When DLPAR removing a CPU, the unmapping of the cpu from a node in
> unmap_cpu_from_node() should also invalidate the CPUs entry in the
> numa_cpu_lookup_table. There is not a guarantee that on a subsequent
> DLPAR add of the CPU the associativity will be the same and thus
> could be in a different node. Invalidating the entry in the
> numa_cpu_lookup_table causes the associativity to be read from the
> device tree at the time of the add.

This last part seems to contradict the change log of commit d4edc5b6c480
("powerpc: Fix the setup of CPU-to-Node mappings during CPU online"),
which seems to say that we shouldn't be looking at the device tree.

Can you explain to me what I'm missing?

Also when did this break, always? Which commit should I mark this as
fixing?

cheers
