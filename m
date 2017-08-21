Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbhVm4Cx8zDqVg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 04:07:44 +1000 (AEST)
Message-ID: <1503334155.2195.17.camel@kernel.crashing.org>
Subject: Re: [v3,3/3] powerpc/mm/cxl: Add the fault handling cpu to mm cpumask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <patch-notifications@ellerman.id.au>, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 21 Aug 2017 09:49:15 -0700
In-Reply-To: <3xbZXv0yxCz9t0F@ozlabs.org>
References: <3xbZXv0yxCz9t0F@ozlabs.org>
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

On Mon, 2017-08-21 at 23:39 +1000, Michael Ellerman wrote:
> On Thu, 2017-07-27 at 06:24:55 UTC, "Aneesh Kumar K.V" wrote:
> > We use mm cpumask for serializing against lockless page table walk. Anybody
> > who is doing a lockless page table walk is expected to disable irq and only
> > cpus in mm cpumask is expected do the lockless walk. This ensure that
> > a THP split can send IPI to only cpus in the mm cpumask, to make sure there
> > are no parallel lockless page table walk.
> > 
> > Add the CAPI fault handling cpu to the mm cpumask so that we can do the lockless
> > page table walk while inserting hash page table entries.
> > 
> > Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/0f4bc0932e51817105fdee77a46680

Do you need barriers between the cpumask set and the walking ?

Cheers,
Ben.
