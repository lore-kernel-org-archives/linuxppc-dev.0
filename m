Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdYG54bP1zDrKG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 04:48:13 +1000 (AEST)
Message-ID: <1503600479.3814.19.camel@kernel.crashing.org>
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Date: Thu, 24 Aug 2017 11:47:59 -0700
In-Reply-To: <e1833071-11e0-2cd1-0ec2-f8653a4e6b6c@linux.vnet.ibm.com>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <ad84e763-a30f-04f7-f1d0-ccd72c0d4dd4@linux.vnet.ibm.com>
 <1503336930.2195.20.camel@kernel.crashing.org>
 <e1833071-11e0-2cd1-0ec2-f8653a4e6b6c@linux.vnet.ibm.com>
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

On Thu, 2017-08-24 at 18:40 +0200, Frederic Barrat wrote:
> 
> The decrementing part is giving me troubles, and I think it makes sense: 
> if I decrement the counter when detaching the context from the capi 
> card, then the next TLBIs for the memory context may be back to local. 

Yes, you need to flush the CAPI TLB first.

> So when the process exits, the NPU wouldn't get the associated TLBIs, 
> which spells trouble the next time the same memory context ID is reused. 
> I believe this the cause of the problem I'm seeing. As soon as I keep 
> the TLBIs global, even after I detach from the capi adapter, everything 
> is fine.
> 
> Does it sound right?
> 
> So to keep the checks minimal in mm_is_thread_local(), to just checking 
> the active_cpus count, I'm thinking of introducing a "copro enabled" bit 
> on the context, so that we can increment active_cpus only once. And 
> never decrement it.

You can decrement if you flush. Don't you have MMIOs to do directed
flushes ?

Cheers,
Ben.
