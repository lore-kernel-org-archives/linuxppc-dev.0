Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x234.google.com (mail-pg0-x234.google.com
 [IPv6:2607:f8b0:400e:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400vvh0tBPzDrRX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 23:54:55 +1100 (AEDT)
Received: by mail-pg0-x234.google.com with SMTP id i14so7908809pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 05:54:55 -0700 (PDT)
Date: Tue, 13 Mar 2018 22:54:38 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/14] powerpc/64s: allocate lppacas individually
Message-ID: <20180313225438.0c853b89@roar.ozlabs.ibm.com>
In-Reply-To: <87woygf8qd.fsf@concordia.ellerman.id.au>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-4-npiggin@gmail.com>
 <87woygf8qd.fsf@concordia.ellerman.id.au>
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

On Tue, 13 Mar 2018 23:41:46 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
> > index eeb13429d685..3fe126796975 100644
> > --- a/arch/powerpc/platforms/pseries/kexec.c
> > +++ b/arch/powerpc/platforms/pseries/kexec.c
> > @@ -23,7 +23,12 @@
> >  
> >  void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
> >  {
> > -	/* Don't risk a hypervisor call if we're crashing */
> > +	/*
> > +	 * Don't risk a hypervisor call if we're crashing
> > +	 * XXX: Why? The hypervisor is not crashing. It might be better
> > +	 * to at least attempt unregister to avoid the hypervisor stepping
> > +	 * on our memory.
> > +	 */  
> 
> Because every extra line of code we run in the crashed kernel is another
> opportunity to screw up and not make it into the kdump kernel.
> 
> For example the hcalls we do to unregister the VPA might trigger hcall
> tracing which runs a bunch of code and might trip up on something. We
> could modify those hcalls to not be traced, but then we can't trace them
> in normal operation.

We really make no other hcalls in a crash? I didn't think of that.

> 
> And the hypervisor might continue to write to the VPA, but that's OK
> because it's the VPA of the crashing kernel, the kdump kernel runs in a
> separate reserved memory region.

Well that takes care of that concern.

> Possibly we could fix the hcall tracing issues etc, but this code has
> not given us any problems for quite a while (~13 years) - ie. there
> seems to be no issue with re-registering the VPAs etc. in the kdump
> kernel.

No I think it's okay then, if you could drop that hunk...

Thanks,
Nick
