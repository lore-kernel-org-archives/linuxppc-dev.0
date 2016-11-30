Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tT1fY0nhDzDvrH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 11:35:32 +1100 (AEDT)
Message-ID: <1480466113.3459.2.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 3/7] powerpc/mm: Introduce _PAGE_LARGE software pte bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 Nov 2016 11:35:13 +1100
In-Reply-To: <2b65879e-e0c7-f915-b622-290899e41031@gmail.com>
References: <20161128061704.4914-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161128061704.4914-4-aneesh.kumar@linux.vnet.ibm.com>
 <2b65879e-e0c7-f915-b622-290899e41031@gmail.com>
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

On Wed, 2016-11-30 at 11:14 +1100, Balbir Singh wrote:
> > +#define _RPAGE_RSV1          0x1000000000000000UL
> > +#define _RPAGE_RSV2          0x0800000000000000UL
> > +#define _RPAGE_RSV3          0x0400000000000000UL
> > +#define _RPAGE_RSV4          0x0200000000000000UL
> > +
> 
> We use the top 4 bits and not the _SW bits?

Correct, welcome to the discussion we've been having the last 2 weeks
:-)

We use those bits because we are otherwise short on SW bits (we still
need _PAGE_DEVMAP etc...). We know P9 DD1 is supposed to ignore the
reserved bits so it's a good place holder.

Cheers,
Ben.
