Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnsMS4MTVzDqZ5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 17:21:40 +1000 (AEST)
Message-ID: <1504768881.12628.23.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Increase memory block size to 1GB on
 radix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, bharata@linux.vnet.ibm.com,
 arbab@linux.vnet.ibm.com, npiggin@gmail.com, mikey@neuling.org,
 cyrilbur@gmail.com, linuxppc-dev@lists.ozlabs.org
Date: Thu, 07 Sep 2017 17:21:21 +1000
In-Reply-To: <20170907151741.41ee33a8@kryten>
References: <20170907050551.4632-1-anton@ozlabs.org>
 <ab33351f-1d52-2e55-8aeb-32813ca52e94@linux.vnet.ibm.com>
 <20170907151741.41ee33a8@kryten>
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

On Thu, 2017-09-07 at 15:17 +1000, Anton Blanchard wrote:
> Hi,
> 
> > There is a similar issue being worked on w.r.t pseries.
> > 
> > https://lkml.kernel.org/r/1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com
> > 
> > The question is should we map these regions ? ie, we need to tell the 
> > kernel memory region that we would like to hot unplug later so that
> > we avoid doing kernel allocations from that. If we do that, then we
> > can possibly map them via 2M size ?
> 
> But all of memory on PowerNV should be able to be hot unplugged, so
> there are two options as I see it - either increase the memory block
> size, or map everything with 2MB pages. 

Or be smarter and map with 1G when blocks of 1G are available and break
down to 2M where necessary, it shouldn't be too hard.

Cheers,
Ben.
