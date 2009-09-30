Return-Path: <randy.dunlap@oracle.com>
Received: from rgminet14.oracle.com (rcsinet14.oracle.com [148.87.113.126])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rcsinet14.oracle.com",
	Issuer "VeriSign Class 3 Secure Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A39F3B7BBB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Oct 2009 04:59:32 +1000 (EST)
Received: from rgminet11.oracle.com (rcsinet11.oracle.com [148.87.113.123])
	by rgminet14.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id
	n8UHWMv5013806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2009 17:32:23 GMT
Date: Wed, 30 Sep 2009 10:31:13 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Subject: Re: [PATCH v3 2/3] cpu: Offline state Framework.
Message-Id: <20090930103113.4361619d.randy.dunlap@oracle.com>
In-Reply-To: <20090915120706.20523.95464.stgit@sofia.in.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<20090915120706.20523.95464.stgit@sofia.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	"Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 15 Sep 2009 17:37:06 +0530 Gautham R Shenoy wrote:

> Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
> ---
>  Documentation/cpu-hotplug.txt |   22 +++++
>  drivers/base/cpu.c            |  181 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/cpu.h           |   10 ++
>  3 files changed, 204 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
> index 9d620c1..dcec06d 100644
> --- a/Documentation/cpu-hotplug.txt
> +++ b/Documentation/cpu-hotplug.txt
> @@ -115,6 +115,28 @@ Just remember the critical section cannot call any
>  function that can sleep or schedule this process away. The preempt_disable()
>  will work as long as stop_machine_run() is used to take a cpu down.
>  
> +CPU-offline states
> +--------------------------------------
> +On architectures which allow the more than one valid state when

                                ^drop "the"

> +the CPU goes offline, the system administrator can decide
> +the state the CPU needs to go to when it is offlined.

s/needs to/should/

> +
> +If the architecture has implemented a cpu-offline driver exposing these
> +multiple offline states, the system administrator can use the following sysfs
> +interfaces to query the available hotplug states and also query and set the
> +current hotplug state for a given cpu:
> +
> +To query the hotplug states, on needs to perform a read on:

                                one

> +/sys/devices/system/cpu/cpu<number>/available_hotplug_states
> +
> +To query or set the current state for a particular CPU,
> +one needs to use the sysfs interface
> +
> +/sys/devices/system/cpu/cpu<number>/current_hotplug_state
> +
> +Writes to the "online" sysfs files are serialized against the writes to the
> +"current_hotplug_state" file.
> +
>  CPU Hotplug - Frequently Asked Questions.
>  
>  Q: How to enable my kernel to support CPU hotplug?


---
~Randy
