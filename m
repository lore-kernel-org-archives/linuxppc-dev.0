Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02BBD1A0C2A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 20:50:45 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 28 Jan 2015 02:50:43 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8073F3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 02:50:40 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t0S9oeka34734198
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 02:50:40 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0S9odms011435
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 02:50:40 -0700
Message-ID: <54C8B0E6.5080406@linux.vnet.ibm.com>
Date: Wed, 28 Jan 2015 15:20:30 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH V2] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
References: <20150128021044.11166.81418.stgit@preeti.in.ibm.com>
 <m3wq47w9jj.fsf@oc8180480414.ibm.com>
In-Reply-To: <m3wq47w9jj.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: rafael.j.wysocki@intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/28/2015 02:45 PM, Stewart Smith wrote:
> Preeti U Murthy <preeti@linux.vnet.ibm.com> writes:
>> The device tree now exposes the residency values for different idle states. Read
>> these values instead of calculating residency from the latency values. The values
>> exposed in the DT are validated for optimal power efficiency. However to maintain
>> compatibility with the older firmware code which does not expose residency
>> values, use default values as a fallback mechanism. While at it, handle some
>> cleanups.
> 
> From a "I just merged the patch that exports these values from firmware"
> point of view, using them and falling back looks good.
> 
> (I find the hardcoding of snooze in the driver a bit odd, as is the

Snooze is the only software defined idle state, the rest are platform
specific. The first idle state is usually associated with some sort of a
polling operation and each architecture has a variant to this. This is
why we end up hard-coding this idle state in the driver as far as my
understanding goes.

> hardcoding of max power states to 8 - which could bite us in the future

Hmm.. not sure about this. Need to check.

> if a future processor has more states... but these aren't problems with
> this patch)
> 
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Thanks!

Regards
Preeti U Murthy
> 
