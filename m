Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjHx54LyfzDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 07:01:29 +1000 (AEST)
Message-ID: <1504126871.4974.23.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 1/3] powerpc/mm: Export flush_all_mm()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 andrew.donnellan@au1.ibm.com, clombard@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com
Cc: alistair@popple.id.au
Date: Thu, 31 Aug 2017 07:01:11 +1000
In-Reply-To: <77b082b9-0e6e-ed38-3a4e-af7797990ef3@linux.vnet.ibm.com>
References: <20170830101550.16821-1-fbarrat@linux.vnet.ibm.com>
 <87inh519fl.fsf@concordia.ellerman.id.au>
 <77b082b9-0e6e-ed38-3a4e-af7797990ef3@linux.vnet.ibm.com>
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

On Wed, 2017-08-30 at 15:59 +0200, Frederic Barrat wrote:
> > It's not clear why it makes sense for these to be empty. Either for the
> > general idea of the "flush_all_mm()" API, or for your intended use by
> > CXL.
> 
> I was not too sure what to do for hash, but the idea is that the new 
> flush_all_mm() is really the equivalent of the old flush_tlb_mm() from 
> before Ben's optimizations for radix, and that was/still is an empty 
> operation on hash, so I kept it that way.
> 
> We don't support hash for capi2 yet. Adding it will definitely require 
> some work in that area, as the current approach (use count on the driver 
> and all TLBIs becoming global when the driver is in use) won't hold much 
> longer.

Why not ? It would work fine on hash, but you do need a way to flush
the TLB when decreasing the count indeed and that's missing for hash.

Cheers,
Ben.
