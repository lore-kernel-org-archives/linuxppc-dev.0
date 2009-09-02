Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep17-int.chello.at (viefep17-int.chello.at [62.179.121.37])
	by bilbo.ozlabs.org (Postfix) with ESMTP id A3989B7BD7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 15:38:49 +1000 (EST)
Subject: Re: [PATCH v2 0/2] cpu: pseries: Offline state framework.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Gautham R Shenoy <ego@in.ibm.com>
In-Reply-To: <20090828095741.10641.32053.stgit@sofia.in.ibm.com>
References: <20090828095741.10641.32053.stgit@sofia.in.ibm.com>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 07:33:31 +0200
Message-Id: <1251869611.7547.38.camel@twins>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linuxppc-dev@lists.ozlabs.org, "Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-08-28 at 15:30 +0530, Gautham R Shenoy wrote:
> Hi,
> 
> This is the version 2 of the patch series to provide a cpu-offline framework
> that enables the administrators choose the state the offline CPU must be put
> into when multiple such states are exposed by the underlying architecture.
> 
> Version 1 of the Patch can be found here:
> http://lkml.org/lkml/2009/8/6/236
> 
> The patch-series exposes the following sysfs tunables to
> allow the system-adminstrator to choose the state of a CPU:
> 
> To query the available hotplug states, one needs to read the sysfs tunable:
> 	/sys/devices/system/cpu/cpu<number>/available_hotplug_states
> To query or set the current state, on needs to read/write the sysfs tunable:
> 	/sys/devices/system/cpu/cpu<number>/current_states
> 
> The patchset ensures that the writes to the "current_state" sysfs file are
> serialized against the writes to the "online" file.
> 
> This patchset also contains the offline state driver implemented for
> pSeries. For pSeries, we define three available_hotplug_states. They are:
> 
> 	online: The processor is online.
> 
> 	deallocate: This is the the default behaviour when the cpu is offlined
> 	even in the absense of this driver. The CPU would call make an
> 	rtas_stop_self() call and hand over the CPU back to the resource pool,
> 	thereby effectively deallocating that vCPU from the LPAR.
> 	NOTE: This would result in a configuration change to the LPAR
> 	which is visible to the outside world.
> 
> 	deactivate: This cedes the vCPU to the hypervisor which
> 	in turn can put the vCPU time to the best use.
> 	NOTE: This option DOES NOT result in a configuration change
> 	and the vCPU would be still entitled to the LPAR to which it earlier
> 	belong to.
> 
> Awaiting your feedback.

I'm still thinking this is a bad idea.

The OS should only know about online/offline.

Use the hypervisor interface to deal with the cpu once its offline.

That is, I think this interface you propose is a layering violation.
