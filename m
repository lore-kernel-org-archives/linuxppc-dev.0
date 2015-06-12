Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39C1A1A07BD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2015 01:06:51 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 12 Jun 2015 11:06:49 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 48070C90073
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 10:57:53 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5CF6kaK59899950
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 15:06:46 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5CF6j6C018960
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 11:06:45 -0400
Date: Fri, 12 Jun 2015 08:06:43 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Add devices only from
 buses which belong to PE
Message-ID: <20150612150643.GA55122@linux.vnet.ibm.com>
References: <1434089957-27135-1-git-send-email-aik@ozlabs.ru>
 <20150612064703.GA17776@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150612064703.GA17776@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12.06.2015 [16:47:03 +1000], Gavin Shan wrote:
> On Fri, Jun 12, 2015 at 04:19:17PM +1000, Alexey Kardashevskiy wrote:
> >The existing code puts all devices from a root PE to the same IOMMU group.
> >However it is a possible situation when subordinate buses belong to
> >separate PEs, in this case devices from these subordinate buses
> >should be added to lower level PE rather to the root PE.
> >
> >This limits pnv_ioda_setup_bus_dma() invocation to only PEs which own
> >all subordinate buses.
> >
> >Suggested-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Alexey, I think it's good candidate for stable.

Why? This commit message doesn't imply there is a serious bug just a
"possible" (does that mean theoretical?) situtation and the following:

> >This would be nice to have together with the DDW patchset.
> >This does not fix anything DDW patchset did, it fixes IOMMU
> >groups management which is essential for the whole feature to work.

implies it is both related and independent of DDW?

-Nish
