Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 883511007D3
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2011 03:59:55 +1100 (EST)
Message-ID: <4EB96002.5030605@freescale.com>
Date: Tue, 8 Nov 2011 10:59:46 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <ananth@in.ibm.com>
Subject: Re: [PATCH] powerpc: Export PIR data through sysfs
References: <20111107044750.GB4361@in.ibm.com>
 <4EB812E8.9090107@freescale.com> <20111108065811.GA9109@in.ibm.com>
In-Reply-To: <20111108065811.GA9109@in.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
 mahesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/08/2011 12:58 AM, Ananth N Mavinakayanahalli wrote:
> On Mon, Nov 07, 2011 at 11:18:32AM -0600, Scott Wood wrote:
>> What use does userspace have for this?  If you want to return the
>> currently executing CPU (which unless you're pinned could change as soon
>> as the value is read...), why not just return smp_processor_id() or
>> hard_smp_processor_id()?
> 
> Its not just the current cpu. Decoding PIR can tell you the core id,
> thread id in case of SMT, and this information can be used by userspace
> apps to set affinities, etc.

Wouldn't it make more sense to expose the thread to core mappings in a
general way, not tied to hardware or what thread we're currently running on?

What's the use case for knowing this information only about the current
thread (or rather the state the current thread was in a few moments ago)?

> +#if defined(CONFIG_SMP) && defined(SPRN_PIR)
> +SYSFS_PMCSETUP(pir, SPRN_PIR);
> +static SYSDEV_ATTR(pir, 0400, show_pir, NULL);
> +#endif

This only helps on architectures such as 8xx where you can't build as
SMP -- and I don't think #ifdef SPRN_PIR excludes any builds.

It doesn't help on chips like 750 or e300 where you can run a normal 6xx
SMP build, you just won't have multiple CPUs, and thus won't run things
like the secondary entry code.

-Scott
