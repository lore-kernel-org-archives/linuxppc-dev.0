Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9042B2C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 16:24:52 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 12 Dec 2013 22:24:50 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4F6541FF001B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 22:24:24 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
 ESMTP id rBD3Mqjg7733662
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 04:22:52 +0100
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBD5OjR2015441
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 22:24:47 -0700
Message-ID: <52AA9953.9090909@linux.vnet.ibm.com>
Date: Fri, 13 Dec 2013 10:51:23 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] time: Support in tick broadcast framework for archs
 without an external wakeup source
References: <20131213041901.17199.37383.stgit@preeti.in.ibm.com>
 <1386911862.15730.81.camel@pasglop>
In-Reply-To: <1386911862.15730.81.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: peterz@infradead.org, fweisbec@gmail.com, paul.gortmaker@windriver.com,
 paulus@samba.org, mingo@kernel.org, shangw@linux.vnet.ibm.com,
 rafael.j.wysocki@intel.com, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au,
 john.stultz@linaro.org, tglx@linutronix.de, chenhui.zhao@freescale.com,
 deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On 12/13/2013 10:47 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2013-12-13 at 09:49 +0530, Preeti U Murthy wrote:
>> On some architectures, in certain CPU deep idle states the local timers stop.
>> An external clock device is used to wakeup these CPUs. The kernel support for the
>> wakeup of these CPUs is provided by the tick broadcast framework by using the
>> external clock device as the wakeup source.
> 
>> However on architectures like PowerPC there is no external clock device. 
> 
> Minor nit ...
> 
> I wouldn't make this an architectural statement. Some PowerPC's do have
> external clock devices (for example the old MPIC interrupt controller
> had timers). In fact, if we really need it, I'm sure we *could* find
> something somewhere in P8 that could act as a timer, probably hijacking
> a bit of the OCC or similar but at this stage, that's not on the radar.
> 
> So make it an implementation statement. "However, not all
> implementations, such as some PowerPC ones, provide such an external
> timer ...".

Thanks for this information. I will update this going ahead.

Regards
Preeti U Murthy
