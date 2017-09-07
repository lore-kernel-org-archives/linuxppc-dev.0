Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnpcW6sMMzDqG3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 15:17:47 +1000 (AEST)
Date: Thu, 7 Sep 2017 15:17:41 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 bharata@linux.vnet.ibm.com, arbab@linux.vnet.ibm.com, npiggin@gmail.com,
 mikey@neuling.org, cyrilbur@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Increase memory block size to 1GB on
 radix
Message-ID: <20170907151741.41ee33a8@kryten>
In-Reply-To: <ab33351f-1d52-2e55-8aeb-32813ca52e94@linux.vnet.ibm.com>
References: <20170907050551.4632-1-anton@ozlabs.org>
 <ab33351f-1d52-2e55-8aeb-32813ca52e94@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> There is a similar issue being worked on w.r.t pseries.
> 
> https://lkml.kernel.org/r/1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com
> 
> The question is should we map these regions ? ie, we need to tell the 
> kernel memory region that we would like to hot unplug later so that
> we avoid doing kernel allocations from that. If we do that, then we
> can possibly map them via 2M size ?

But all of memory on PowerNV should be able to be hot unplugged, so
there are two options as I see it - either increase the memory block
size, or map everything with 2MB pages. 

Anton
