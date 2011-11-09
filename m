Return-Path: <ananth@in.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E83451007D8
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2011 15:41:18 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@in.ibm.com>;
 Tue, 8 Nov 2011 21:41:15 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA94fAK3310736
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Nov 2011 21:41:11 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA94fA5W026786
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Nov 2011 21:41:10 -0700
Date: Wed, 9 Nov 2011 10:11:24 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: Export PIR data through sysfs
Message-ID: <20111109044124.GA10961@in.ibm.com>
References: <20111107044750.GB4361@in.ibm.com>
 <4EB812E8.9090107@freescale.com> <20111108065811.GA9109@in.ibm.com>
 <4EB96002.5030605@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EB96002.5030605@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
 mahesh@linux.vnet.ibm.com
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 08, 2011 at 10:59:46AM -0600, Scott Wood wrote:
> On 11/08/2011 12:58 AM, Ananth N Mavinakayanahalli wrote:
> > On Mon, Nov 07, 2011 at 11:18:32AM -0600, Scott Wood wrote:
> >> What use does userspace have for this?  If you want to return the
> >> currently executing CPU (which unless you're pinned could change as soon
> >> as the value is read...), why not just return smp_processor_id() or
> >> hard_smp_processor_id()?
> > 
> > Its not just the current cpu. Decoding PIR can tell you the core id,
> > thread id in case of SMT, and this information can be used by userspace
> > apps to set affinities, etc.
> 
> Wouldn't it make more sense to expose the thread to core mappings in a
> general way, not tied to hardware or what thread we're currently running on?

AFAIK, the information encoding in PIR is platform dependent. There is
no general way to expose this information unless you want have a
per-platform ifdef. Even then, I am not sure if that information will
generally be available or provided.

> What's the use case for knowing this information only about the current
> thread (or rather the state the current thread was in a few moments ago)?

Its not information about the thread but about the cpu. Unless you have
a shared LPAR environment, the data will be consistent and can be used
by applications with knowledge of the platform.

> > +#if defined(CONFIG_SMP) && defined(SPRN_PIR)
> > +SYSFS_PMCSETUP(pir, SPRN_PIR);
> > +static SYSDEV_ATTR(pir, 0400, show_pir, NULL);
> > +#endif
> 
> This only helps on architectures such as 8xx where you can't build as
> SMP -- and I don't think #ifdef SPRN_PIR excludes any builds.
> 
> It doesn't help on chips like 750 or e300 where you can run a normal 6xx
> SMP build, you just won't have multiple CPUs, and thus won't run things
> like the secondary entry code.

Ugh! Booke builds seem to be fun :-)

I think this calls for a CPU_FTR_PIR. What do you suggest?

Ananth
