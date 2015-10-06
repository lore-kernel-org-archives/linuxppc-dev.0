Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1082B1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 21:25:46 +1100 (AEDT)
Message-ID: <1444127145.16578.8.camel@ellerman.id.au>
Subject: Re: [PATCH RFC  0/5] powerpc:numa Add serial nid support
From: Michael Ellerman <mpe@ellerman.id.au>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, cl@linux.com,
 nacc@linux.vnet.ibm.com, gkurz@linux.vnet.ibm.com, grant.likely@linaro.org,
 nikunj@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
Date: Tue, 06 Oct 2015 21:25:45 +1100
In-Reply-To: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-09-27 at 23:59 +0530, Raghavendra K T wrote:
> Problem description:
> Powerpc has sparse node numbering, i.e. on a 4 node system nodes are
> numbered (possibly) as 0,1,16,17. At a lower level, we map the chipid
> got from device tree is naturally mapped (directly) to nid.
> 
> Potential side effect of that is:
> 
> 1) There are several places in kernel that assumes serial node numbering.
> and memory allocations assume that all the nodes from 0-(highest nid)
> exist inturn ending up allocating memory for the nodes that does not exist.

Is it several? Or lots?

If it's several, ie. more than two but not lots, then we should probably just
fix those places. Or is that /really/ hard for some reason?

Do we ever get whole nodes hotplugged in under PowerVM? I don't think so, but I
don't remember for sure.

> 2) For virtualization use cases (such as qemu, libvirt, openstack), mapping
> sparse nid of the host system to contiguous nids of guest (numa affinity,
> placement) could be a challenge.

Can you elaborate? That's a bit vague.

> Possible Solutions:
> 1) Handling the memory allocations is kernel case by case: Though in some
> cases it is easy to achieve, some cases may be intrusive/not trivial. 
> at the end it does not handle side effect (2) above.
> 
> 2) Map the sparse chipid got from device tree to a serial nid at kernel
> level (The idea proposed in this series).
> Pro: It is more natural to handle at kernel level than at lower (OPAL) layer.
> con: The chipid is in device tree no longer the same as nid in kernel
> 
> 3) Let the lower layer (OPAL) give the serial node ids after parsing the
> chipid and the associativity etc [ either as a separate item in device tree
> or by compacting the chipid numbers ]
> Pros: kernel, device tree are on same page and less change in kernel
> Con: is it the functionality expected in lower layer

...

> 3) Numactl tests from
> ftp://oss.sgi.com/www/projects/libnuma/download/numactl-2.0.10.tar.gz
> 
> (infact there were more breakage before the patch because of sparse nid
> and memoryless node cases of powerpc)

This is probably the best argument for your series. ie. userspace is dumb and
fixing every broken app that assumes linear node numbering is not feasible.


So on the whole I think the concept is good. This series though is a bit
confusing because of all the renaming etc. etc. Nish made lots of good comments
so I'll wait for a v2 based on those.

cheers
