Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1F1E2B7B99
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 22:12:05 +1000 (EST)
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Gautham R Shenoy <ego@in.ibm.com>
In-Reply-To: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 14:11:41 +0200
Message-Id: <1253016701.5506.73.camel@laptop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org,
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

On Tue, 2009-09-15 at 17:36 +0530, Gautham R Shenoy wrote:
> This patchset contains the offline state driver implemented for
> pSeries. For pSeries, we define three available_hotplug_states. They are:
> 
>         online: The processor is online.
> 
>         offline: This is the the default behaviour when the cpu is offlined
>         even in the absense of this driver. The CPU would call make an
>         rtas_stop_self() call and hand over the CPU back to the resource pool,
>         thereby effectively deallocating that vCPU from the LPAR.
>         NOTE: This would result in a configuration change to the LPAR
>         which is visible to the outside world.
> 
>         inactive: This cedes the vCPU to the hypervisor with a cede latency
>         specifier value 2.
>         NOTE: This option does not result in a configuration change
>         and the vCPU would be still entitled to the LPAR to which it earlier
>         belong to.
> 
> Any feedback on the patchset will be immensely valuable.

I still think its a layering violation... its the hypervisor manager
that should be bothered in what state an off-lined cpu is in. 
