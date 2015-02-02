Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA1A11A0AF2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 17:39:24 +1100 (AEDT)
Message-ID: <1422859164.20278.1.camel@ellerman.id.au>
Subject: Re: [PATCH V3] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
From: Michael Ellerman <mpe@ellerman.id.au>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Mon, 02 Feb 2015 17:39:24 +1100
In-Reply-To: <20150202050821.24581.56186.stgit@preeti.in.ibm.com>
References: <20150202050821.24581.56186.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: stewart@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-02 at 10:40 +0530, Preeti U Murthy wrote:
> The device tree now exposes the residency values for different idle states. Read
> these values instead of calculating residency from the latency values. The values
> exposed in the DT are validated for optimal power efficiency. However to maintain
> compatibility with the older firmware code which does not expose residency
> values, use default values as a fallback mechanism. While at it, use better
> APIs to parse the powermgmt device tree node so as to avoid endianness
> transformation.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> Changes from V2: https://lkml.org/lkml/2015/1/27/1054
> 1. Used APIs to eliminate endianness transformation

Hi Preeti,

I thought I was pretty clear when I said you should do that as a follow-up
patch.

This is now doing too many things, it's not a single logical change, and it's
touching code in arch/powerpc and the driver. Which means neither I nor Rafael
can easily merge it.  

So please go back to the v2 you had. And then do the of_property_count_u32_elems()
changes as separate patches.

cheers
