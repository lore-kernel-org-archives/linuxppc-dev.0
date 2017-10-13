Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yD6Yk2HBszDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 23:32:42 +1100 (AEDT)
In-Reply-To: <1507099852-28004-1-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 anju@linux.vnet.ibm.com
Subject: Re: powerpc/perf: Fix for core/nest imc call trace on cpuhotplug
Message-Id: <3yD6Yk1c3Tz9sPr@ozlabs.org>
Date: Fri, 13 Oct 2017 23:32:42 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-10-04 at 06:50:52 UTC, Anju T Sudhakar wrote:
> Nest/core pmu units are enabled only when it is used. A reference count is      
> maintained for the events which uses the nest/core pmu units. Currently in      
> *_imc_counters_release function a WARN() is used for notification of any        
> underflow of ref count.                                                         
>                                                                                 
> The case where event ref count hit a negative value is, when perf session is    
> started, followed by offlining of all cpus in a given core.                     
> i.e. in cpuhotplug offline path ppc_core_imc_cpu_offline() function set the     
> ref->count to zero, if the current cpu which is about to offline is the last    
> cpu in a given core and make an OPAL call to disable the engine in that core.   
> And on perf session termination, perf->destroy (core_imc_counters_release) will 
> first decrement the ref->count for this core and based on the ref->count value  
> an opal call is made to disable the core-imc engine.                            
> Now, since cpuhotplug path already clears the ref->count for core and disabled  
> the engine, perf->destroy() decrementing again at event termination make it     
> negative which in turn fires the WARN_ON. The same happens for nest units.      
>                                                                                 
> Add a check to see if the reference count is alreday zero, before decrementing  
> the count, so that the ref count will not hit a negative value.                 
>                                                                                 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Reviewed-by: Santosh Sivaraj <santosh@fossix.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/0d923820c6db1644c27c2d0a5af892

cheers
