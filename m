Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSqNM462czDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 23:53:23 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c65so758735pfl.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 06:53:23 -0700 (PDT)
Date: Thu, 10 Aug 2017 23:53:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 10/13] powerpc/64s: idle simplify KVM idle on POWER9
Message-ID: <20170810235251.65f3046a@roar.ozlabs.ibm.com>
In-Reply-To: <87zib7lg3d.fsf@concordia.ellerman.id.au>
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-11-npiggin@gmail.com>
 <87zib7lg3d.fsf@concordia.ellerman.id.au>
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

On Thu, 10 Aug 2017 23:14:46 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > POWER9 CPUs have independent MMU contexts per thread so KVM
> > does not have to bring sibling threads into real-mode when
> > switching MMU mode to guest. This can simplify POWER9 sleep/wake
> > paths and avoids hwsyncs.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/kvm_book3s_asm.h |  4 ++++
> >  arch/powerpc/kernel/idle_book3s.S         |  8 ++-----
> >  arch/powerpc/kvm/book3s_hv.c              | 37 ++++++++++++++++++++++++++-----
> >  arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  8 +++++++  
> 
> This will need to go via, or at least be shared with Paul's tree.
> 
> So if it's possible, splitting it out of this series would be easier.

I agree it's really a KVM patch, but patch 12 depends on this, 
it is a Linux patch. Not sure how you want to handle that?

Thanks,
Nick
