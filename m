Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD15E1A0C7E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 19:56:02 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 2 Feb 2015 03:55:59 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8065B38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 03:55:57 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t128tvaT28442878
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Feb 2015 08:55:57 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t128tuBP013941
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Feb 2015 03:55:57 -0500
Message-ID: <54CF3B93.9090507@linux.vnet.ibm.com>
Date: Mon, 02 Feb 2015 14:25:47 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, rafael.j.wysocki@intel.com
Subject: Re: [PATCH V3] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
References: <20150202050821.24581.56186.stgit@preeti.in.ibm.com>
 <1422859164.20278.1.camel@ellerman.id.au>
In-Reply-To: <1422859164.20278.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/2015 12:09 PM, Michael Ellerman wrote:
> On Mon, 2015-02-02 at 10:40 +0530, Preeti U Murthy wrote:
>> The device tree now exposes the residency values for different idle states. Read
>> these values instead of calculating residency from the latency values. The values
>> exposed in the DT are validated for optimal power efficiency. However to maintain
>> compatibility with the older firmware code which does not expose residency
>> values, use default values as a fallback mechanism. While at it, use better
>> APIs to parse the powermgmt device tree node so as to avoid endianness
>> transformation.
>>
>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>> ---
>> Changes from V2: https://lkml.org/lkml/2015/1/27/1054
>> 1. Used APIs to eliminate endianness transformation
> 
> Hi Preeti,
> 
> I thought I was pretty clear when I said you should do that as a follow-up
> patch.
> 
> This is now doing too many things, it's not a single logical change, and it's
> touching code in arch/powerpc and the driver. Which means neither I nor Rafael
> can easily merge it.  
> 
> So please go back to the v2 you had. And then do the of_property_count_u32_elems()
> changes as separate patches.

Yeah I apologize for this; going back to the conversation we had, I
realize that I completely overlooked the part where you suggested it as
a second patch. Sorry for the inconvenience.

Rafael, please ignore the versions sent so far. I shall send out two
patches that are logically separated. V2 of this patch that you were
requested to pick up needs some more fixes; the patch was not freeing
the dynamically allocated data after populating the cpufreq table. Ill
fix all of these in the next posting.

Thanks

Regards
Preeti U Murthy
> 
> cheers
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
