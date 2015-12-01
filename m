Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24F3D1A0B84
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 08:00:44 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 14:00:43 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id EBDDF19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 13:48:46 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB1L0erL29032506
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 14:00:40 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB1L0cEa022055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 14:00:39 -0700
Subject: Re: [PATCH v2 5/6] powerpc/pseries: Add CPU dlpar add functionality
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <562FC0C3.7000303@linux.vnet.ibm.com>
 <562FC21F.3050907@linux.vnet.ibm.com>
 <1448514803.9839.9.camel@ellerman.id.au>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <565E0A73.8040806@linux.vnet.ibm.com>
Date: Tue, 1 Dec 2015 15:00:35 -0600
MIME-Version: 1.0
In-Reply-To: <1448514803.9839.9.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/25/2015 11:13 PM, Michael Ellerman wrote:
> On Tue, 2015-10-27 at 13:27 -0500, Nathan Fontenot wrote:
> 
>> Add the ability to hotplug add cpus via rtas hotplug events by either
>> specifying the drc index of the CPU to add, or providing a count of the
>> number of CPUs to add.
> 
> So I just tried running this on my system, without doing anything on the HMC.
> 
> I have:
> 
>   # lsprop /proc/device-tree/cpus/ibm,drc-indexes 
>   /proc/device-tree/cpus/ibm,drc-indexes
>   		 00000002 10000000 10000002
> 
> So I think that says I have two cpus.
> 
> The first one is already added:
> 
>   /proc/device-tree/cpus/PowerPC,POWER6@0/ibm,my-drc-index
>   		 10000000 (268435456)
> 
> But can I add the second one?
> 
>   # echo "cpu add count 1" > dlpar 
>   RTAS: event: 34, Type: Platform Error, Severity: 2
>   pseries-hotplug-cpu: Failed to acquire DRC, rc: -5, drc index: 10000002
>   pseries-hotplug-cpu: CPU hot-add failed, removing any added CPUs
>   -bash: echo: write error: Invalid argument
> 
> 
> Seems not. But I'm not clear why?

The add request is failing because rtas call to acquire the resource is failing.
I have seen this on many systems lately. Previously one could add and remove
CPUs (and memory) by running the drmgr command on an LPAR manually and
everything would work. It seems there are now systems (not sure if its a
firmware or HMC update) that will only allow the rtas call to acquire the 
resource to succeed when the request is initiated from the HMC.

I can provide a patch for drmgr that uses the new sysfs interface so you
can drive the dlpar operations from the hmc.

> 
> Adding by index doesn't work either:
> 
>   # echo "cpu add index 10000002" > dlpar
>   pseries-hotplug-cpu: Failed to acquire DRC, rc: -1, drc index: 989682
>   -bash: echo: write error: Invalid argument
> 
> That's a little confusing, drc index is hex obviously.
> 
>   [root@p6-10-P5-E0 kernel]# echo "cpu add index 0x10000002" > dlpar 
>   RTAS: event: 35, Type: Platform Error, Severity: 2
>   pseries-hotplug-cpu: Failed to acquire DRC, rc: -5, drc index: 10000002
>   -bash: echo: write error: Invalid argument
> 
> 
> So that's probably all PEBKAC, but if we can make it more intutive that would be good.

I wrote the interface to take the drc index value in the format specified, so
without the 0x it assumes decimal. Should be a better error message in this case.

-Nathan
