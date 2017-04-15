Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w4rSR2bY6zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Apr 2017 20:32:23 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id i5so18093626pfc.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Apr 2017 03:32:23 -0700 (PDT)
Date: Sat, 15 Apr 2017 20:31:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/64s: Use relon prolog for
 EXC_VIRT_OOL_MASKABLE_HV handlers
Message-ID: <20170415203157.779872d1@roar.ozlabs.ibm.com>
In-Reply-To: <877f2o8mdw.fsf@concordia.ellerman.id.au>
References: <20170413094548.10616-1-npiggin@gmail.com>
 <877f2o8mdw.fsf@concordia.ellerman.id.au>
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

On Thu, 13 Apr 2017 23:31:23 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Hypervisor Virtualization and Directed Hypervisor Doorbell interrupt
> > handlers use the macro EXC_VIRT_OOL_MASKABLE_HV for their relocation-on
> > handlers, which calls MASKABLE_RELON_EXCEPTION_HV_OOL, which uses the
> > real mode interrupt prolog.
> >
> > Use the RELON variant instead to reduce overhead.
> >
> > Fixes: 1707dd1613 ("powerpc: Save CFAR before branching in interrupt entry paths")
> > Cc: Paul Mackerras <paulus@samba.org>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >
> > I was hesitant about using the Fixes: tag on this one because it's not
> > a correctness bug as far as I can see.  
> 
> Fixes can just mean "if you have this other commit you'll most likely
> want this one too".
> 
> You can clarify the degree of Fixness in the change log, which then
> allows a backporter to decide if they want it or not.
> 
> In this case I think it's entirely right, this is a fairly unfortunate
> bug from a performance point of view if I'm reading it right.

Okay, makes sense. For POWER8 it only affects doorbell IPIs. Context switch
microbenchmark between threads with snooze disabled (which causes IPI) gets
about 3% faster, about 370 cycles. Should be more important on POWER9 with
global doorbells and HVI for host interrupts.

Thanks,
Nick
