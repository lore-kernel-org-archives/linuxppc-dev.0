Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGwBK32XWzDqm4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 20:55:21 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id c23so12661195pfe.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 03:55:21 -0700 (PDT)
Date: Tue, 25 Jul 2017 20:55:08 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
Message-ID: <20170725205508.29dba97e@roar.ozlabs.ibm.com>
In-Reply-To: <1500944625.10674.101.camel@kernel.crashing.org>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <20170724212533.195cb92b@roar.ozlabs.ibm.com>
 <1500929926.10674.86.camel@kernel.crashing.org>
 <20170725104445.13010b5e@roar.ozlabs.ibm.com>
 <1500944625.10674.101.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 25 Jul 2017 11:03:45 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2017-07-25 at 10:44 +1000, Nicholas Piggin wrote:
> > The two variants are just cleaner versions of the two variants you
> > already introduced.
> > 
> > static inline bool mm_activate_cpu(struct mm_struct *mm)
> > {
> >     if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next))) {
> >         cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
> > #if CONFIG_PPC_BOOK3S_64
> >         atomic_inc(&mm->context.active_cpus);
> > #endif
> >         smp_mb();
> >         return true;
> >     }
> >     return false;
> > }  
> 
> Well the above is what I originally wrote, which Michael encouraged me
> to turn into a helper ;-) I was removing ifdef's from switch_mm in
> this series...

Well I won't harp on about it if you guys prefer the increment helper.
Just the comment would be good. The rest of the series seems okay to
me.

Thanks,
Nick
