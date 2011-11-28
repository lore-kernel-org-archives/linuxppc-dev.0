Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 844A7B70C3
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2011 22:03:53 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Mon, 28 Nov 2011 10:50:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pASB3Sv95300308
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2011 22:03:28 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pASB3SaN028297
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2011 22:03:28 +1100
Message-ID: <4ED36A7D.9070308@linux.vnet.ibm.com>
Date: Mon, 28 Nov 2011 16:33:25 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 4/4] cpuidle: (POWER) Handle power_save=off
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>	<20111117112906.9191.54050.stgit@localhost6.localdomain6>
 <1322435233.23348.19.camel@pasglop>
In-Reply-To: <1322435233.23348.19.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/28/2011 04:37 AM, Benjamin Herrenschmidt wrote:

> On Thu, 2011-11-17 at 16:59 +0530, Deepthi Dharwar wrote:
>> This patch makes pseries_idle_driver not to be registered when
>> power_save=off kernel boot option is specified. The
>> boot_option_idle_override variable used here is similar to
>> its usage on x86.
> 
> Quick Q. With your changes, the CPU will never get into idle at all
> until cpuidle initializes and the driver loads.
> 
> That means not only much later in the boot process, but potentially
> never if the distro has the driver as a module and fails to load it, or
> similar.
> 
> Can't that be an issue ? Shouldn't we keep at least one of the basic
> idle functions as a fallback ?
> 


On an LPAR if cpuidle is disabled, ppc_md.power_save is still set to
cpuidle_idle_call by default here. This would result in calling of
cpuidle_idle_call repeatedly, only for the call to return -ENODEV. The
default idle is never executed.
This would be a major design flaw. No fallback idle routine.

We propose to fix this by checking the return value of
ppc_md.power_save() call from void to int.
Right now return value is void, but if we change this to int, this
would solve two problems. One being removing the cast to a function
pointer in the prev patch and this design flaw stated above.

So by checking the return value of ppc_md.power_save(), we can invoke
the default idle on failure. But my only concern is about the effects of
changing the ppc_md.power_save() to return int on other powerpc
architectures. Would it be a good idea to change the return type to int
which would help us flag an error and fallback to default idle?

> Cheers,

> Ben.
> 
> 


Regards,
Deepthi
