Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31DE81A09D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 09:24:44 +1100 (AEDT)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 28 Jan 2015 15:24:41 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id AB59519D801C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 15:15:48 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0SMOkkj33947760
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 15:24:46 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0SMObDO030936
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 15:24:37 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH V2] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
In-Reply-To: <54C8B0E6.5080406@linux.vnet.ibm.com>
References: <20150128021044.11166.81418.stgit@preeti.in.ibm.com>
 <m3wq47w9jj.fsf@oc8180480414.ibm.com> <54C8B0E6.5080406@linux.vnet.ibm.com>
Date: Thu, 29 Jan 2015 09:24:33 +1100
Message-ID: <m3oapiwnku.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Preeti U Murthy <preeti@linux.vnet.ibm.com> writes:
> On 01/28/2015 02:45 PM, Stewart Smith wrote:
>> Preeti U Murthy <preeti@linux.vnet.ibm.com> writes:
>>> The device tree now exposes the residency values for different idle states. Read
>>> these values instead of calculating residency from the latency values. The values
>>> exposed in the DT are validated for optimal power efficiency. However to maintain
>>> compatibility with the older firmware code which does not expose residency
>>> values, use default values as a fallback mechanism. While at it, handle some
>>> cleanups.
>> 
>> From a "I just merged the patch that exports these values from firmware"
>> point of view, using them and falling back looks good.
>> 
>> (I find the hardcoding of snooze in the driver a bit odd, as is the
>
> Snooze is the only software defined idle state, the rest are platform
> specific. The first idle state is usually associated with some sort of a
> polling operation and each architecture has a variant to this. This is
> why we end up hard-coding this idle state in the driver as far as my
> understanding goes.

At least in the PowerISA 2.07 I could only see that lowering priority
would give priority to other threads in the core, I couldn't find
anything saying that or 31,31,31 would end up saving any power... but I
could be looking in the wrong place too.

Basically, I was wanting to check that it's actually written down and
architected somewhere that this is the case and it isn't something too
P7/P8 specific.
