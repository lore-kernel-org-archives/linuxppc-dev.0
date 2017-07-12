Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6qH15TPpzDqgR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 16:46:21 +1000 (AEST)
Message-ID: <1499841964.2865.37.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Hande page faults for bad paste and bad AMO
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <michael.neuling@au1.ibm.com>
Date: Wed, 12 Jul 2017 16:46:04 +1000
In-Reply-To: <8760eyqjb8.fsf@skywalker.in.ibm.com>
References: <1499830007.2865.36.camel@kernel.crashing.org>
 <8760eyqjb8.fsf@skywalker.in.ibm.com>
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

On Wed, 2017-07-12 at 11:37 +0530, Aneesh Kumar K.V wrote:
> > So we need to test those errors early in do_page_fault(),
> > I chose to generate a SIGBUS which is more correct than a SIGSEGV.
> 
> This is true even for hash right ? If so do we want to update
> do_hash_page:
> #ifdef CONFIG_PPC_STD_MMU_64
>         andis.  r0,r4,0xa450            /* weird error? */
>         bne-    handle_page_fault       /* if not, try to insert a HPTE */
> 
> that 0xa450 such that we add these errors and call hand_page_fault in
> case of these DSISR values ?

Correct, I forgot about that one. I'll respin.

Cheers,
Ben.
