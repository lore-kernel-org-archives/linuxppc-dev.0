Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (mail-va3.bigfish.com [216.32.180.10])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7F138B6F83
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 02:48:42 +1100 (EST)
Date: Wed, 9 Nov 2011 09:48:25 -0600
From: Scott Wood <scottwood@freescale.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH] powerpc: Export PIR data through sysfs
Message-ID: <20111109154825.GB7839@schlenkerla.am.freescale.net>
References: <20111107044750.GB4361@in.ibm.com> <4EB812E8.9090107@freescale.com>
 <20111108065811.GA9109@in.ibm.com> <4EB96002.5030605@freescale.com>
 <20111109044124.GA10961@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20111109044124.GA10961@in.ibm.com>
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

On Wed, Nov 09, 2011 at 10:11:24AM +0530, Ananth N Mavinakayanahalli wrote:
> On Tue, Nov 08, 2011 at 10:59:46AM -0600, Scott Wood wrote:
> > On 11/08/2011 12:58 AM, Ananth N Mavinakayanahalli wrote:
> > > On Mon, Nov 07, 2011 at 11:18:32AM -0600, Scott Wood wrote:
> > >> What use does userspace have for this?  If you want to return the
> > >> currently executing CPU (which unless you're pinned could change as soon
> > >> as the value is read...), why not just return smp_processor_id() or
> > >> hard_smp_processor_id()?
> > > 
> > > Its not just the current cpu. Decoding PIR can tell you the core id,
> > > thread id in case of SMT, and this information can be used by userspace
> > > apps to set affinities, etc.
> > 
> > Wouldn't it make more sense to expose the thread to core mappings in a
> > general way, not tied to hardware or what thread we're currently running on?
> 
> AFAIK, the information encoding in PIR is platform dependent. There is
> no general way to expose this information unless you want have a
> per-platform ifdef. Even then, I am not sure if that information will
> generally be available or provided.
> 
> > What's the use case for knowing this information only about the current
> > thread (or rather the state the current thread was in a few moments ago)?
> 
> Its not information about the thread but about the cpu. Unless you have
> a shared LPAR environment, the data will be consistent and can be used
> by applications with knowledge of the platform.

I'm not sure what a "shared LPAR environment" is, but unless you're
pinned there's no guarantee the CPU you're running on once the read()
syscall returns is the same as the one that PIR was read on.  Do you mean
you're expecting this to be run from inside a partition that runs only on
one CPU, and thus whichever thread you'll be migrated to will have the
other data remain the same?

> > > +#if defined(CONFIG_SMP) && defined(SPRN_PIR)
> > > +SYSFS_PMCSETUP(pir, SPRN_PIR);
> > > +static SYSDEV_ATTR(pir, 0400, show_pir, NULL);
> > > +#endif
> > 
> > This only helps on architectures such as 8xx where you can't build as
> > SMP -- and I don't think #ifdef SPRN_PIR excludes any builds.
> > 
> > It doesn't help on chips like 750 or e300 where you can run a normal 6xx
> > SMP build, you just won't have multiple CPUs, and thus won't run things
> > like the secondary entry code.
> 
> Ugh! Booke builds seem to be fun :-)

Those aren't booke.

> I think this calls for a CPU_FTR_PIR. What do you suggest?

Unless someone wants to test what actually happens when you read PIR on
all these CPUs...

What platform is this meant to be useful for?  Perhaps it could just be a
platform-specific sysfs entry?

-Scott
