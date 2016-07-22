Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwsHH6g7QzDqTg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 23:40:59 +1000 (AEST)
Message-ID: <1469194843.8568.179.camel@kernel.crashing.org>
Subject: Re: [for-4.8, 1/2] powerpc/mm: Switch user slb fault handling to
 translation enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Fri, 22 Jul 2016 23:40:43 +1000
In-Reply-To: <20160722223738.62a27fed@roar.ozlabs.ibm.com>
References: <1468402850-6052-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160722223738.62a27fed@roar.ozlabs.ibm.com>
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

On Fri, 2016-07-22 at 22:37 +1000, Nicholas Piggin wrote:
> > We also handle fault with proper stack initialized. This enable us
> to
> > callout to C in fault handling routines. We don't do this for
> kernel
> > mapping, because of the possibility of taking recursive fault if
> > kernel stack in not yet mapped by an slb entry.
> > 
> > This enable us to handle Power9 slb fault better. We will add
> bolted
> > entries for the entire kernel mapping in segment table and user slb
> > entries we take fault and insert on demand. With translation on, we
> > should be able to access segment table from fault handler.
> 
> What does this cost on P8? Is that a problem? Might need to do
> feature bits.

Also what is the need ?

The segment table is only for Nest MMU clients, we should probably
handle it separately.

Cheers,
Ben.
