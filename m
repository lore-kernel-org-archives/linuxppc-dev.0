Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B60F1A0676
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 03:34:40 +1000 (AEST)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 28 Sep 2015 11:34:38 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 40B1719D8042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 11:25:29 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8SHVUle5046760
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 10:31:30 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8SHYa2r026614
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 11:34:36 -0600
Date: Mon, 28 Sep 2015 10:34:34 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cl@linux.com, gkurz@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH RFC  0/5] powerpc:numa Add serial nid support
Message-ID: <20150928173434.GE48470@linux.vnet.ibm.com>
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27.09.2015 [23:59:08 +0530], Raghavendra K T wrote:
> Problem description:
> Powerpc has sparse node numbering, i.e. on a 4 node system nodes are
> numbered (possibly) as 0,1,16,17. At a lower level, we map the chipid
> got from device tree is naturally mapped (directly) to nid.

chipid is a OPAL concept, I believe, and not documented in PAPR... How
does this work under PowerVM?

> Potential side effect of that is:
> 
> 1) There are several places in kernel that assumes serial node numbering.
> and memory allocations assume that all the nodes from 0-(highest nid)
> exist inturn ending up allocating memory for the nodes that does not exist.
> 
> 2) For virtualization use cases (such as qemu, libvirt, openstack), mapping
> sparse nid of the host system to contiguous nids of guest (numa affinity,
> placement) could be a challenge.
> 
> Possible Solutions:
> 1) Handling the memory allocations is kernel case by case: Though in some
> cases it is easy to achieve, some cases may be intrusive/not trivial. 
> at the end it does not handle side effect (2) above.
> 
> 2) Map the sparse chipid got from device tree to a serial nid at kernel
> level (The idea proposed in this series).
> Pro: It is more natural to handle at kernel level than at lower (OPAL) layer.
> con: The chipid is in device tree no longer the same as nid in kernel

Is there any debugging/logging? Looks like not -- so how does a sysadmin
map from firmware-provided values to the Linux values? That's going to
make debugging of large systems (PowerVM or otherwise) less than
pleasant, it seems? Possibly you could put something in sysfs?

-Nish
