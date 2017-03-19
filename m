Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vm7cQ5gf9zDqY7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 16:56:22 +1100 (AEDT)
Message-ID: <1489902933.2504.21.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv/cpuidle: Pass correct drv->cpumask for
 registration
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Michael Neuling
 <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Sun, 19 Mar 2017 16:55:33 +1100
In-Reply-To: <20170317180550.9931-1-svaidy@linux.vnet.ibm.com>
References: <20170317180550.9931-1-svaidy@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-17 at 23:35 +0530, Vaidyanathan Srinivasan wrote:
> +       /*
> +        * On PowerNV platform cpu_present may be less that cpu_possible
> +        * in cases where firmware detects the cpu, but it is not available
> +        * for OS.  Such CPUs are not hotplugable at runtime on PowerNV
> +        * platform and hence sysfs files are not created for those.
> +        * Generic topology_init() would skip creating sysfs directories
> +        * for cpus that are not present and not hotplugable later at
> +        * runtime.
> +        *
> + 

I wouldn't assume that they can't later be hotplugged. We need that fix
now as it's hitting machines today but we'll need to improve all that
code and the topology code to deal with hotplugging gracefully.

Cheers,
Ben.
