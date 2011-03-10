Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 24804B6F94
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2011 14:46:10 +1100 (EST)
Subject: Re: [PATCH 17/18] powerpc/smp: Increase vdso_data->processorCount,
	not just decrease it
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1299728467.6272.49.camel@concordia>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
	<1299566250-10516-18-git-send-email-benh@kernel.crashing.org>
	<1299728467.6272.49.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Mar 2011 14:46:01 +1100
Message-ID: <1299728761.22236.467.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-03-10 at 14:41 +1100, Michael Ellerman wrote:
> 
> So the SYSTEM_RUNNING check is to avoid clashing with the logic in
> smp_setup_cpu_maps() I presume:
> 
> arch/powerpc/kernel/setup-common.c:     vdso_data->processorCount = num_present_cpus();
> 
> 
> But why not remove that, and let the increment in start_secondary() do
> all the work?
> 
> With the current code if a cpu is present but fails to come up the count
> will be wrong I think. 

I agree, on the other hand I'm worried about the way that things it
used in lparcfg.c (which looks bogus regardless) and it's not clear
to me what userspace uses it for (I bet some "licencing" stuff :-)

The lparcfg bit looks like something that should turn into counting
possible processors I suppose but it's hard to tell.

Cheers,
Ben.
