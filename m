Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xy1WL5l1YzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 23:56:46 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id i23so1227243pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 06:56:46 -0700 (PDT)
Date: Wed, 20 Sep 2017 23:56:27 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] powerpc/64s: idle ESL=0 stop can avoid MSR and
 save/restore overhead
Message-ID: <20170920235627.3413797f@roar.ozlabs.ibm.com>
In-Reply-To: <87k21i69lu.fsf@concordia.ellerman.id.au>
References: <20170825043036.18236-1-npiggin@gmail.com>
 <20170825043036.18236-5-npiggin@gmail.com>
 <87pobd1em0.fsf@concordia.ellerman.id.au>
 <20170830221045.6fd10787@roar.ozlabs.ibm.com>
 <87k21i69lu.fsf@concordia.ellerman.id.au>
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

On Fri, 01 Sep 2017 19:39:41 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Wed, 30 Aug 2017 21:25:59 +1000
> > Michael Ellerman <mpe@ellerman.id.au> wrote:
> >  
> >> Nicholas Piggin <npiggin@gmail.com> writes:
> >>   
> >> > When stop is executed with EC=ESL=0, it appears to execute like a
> >> > normal instruction (resuming from NIP when woken by interrupt).
> >> > So all the save/restore handling can be avoided completely. In
> >> > particular NV GPRs do not have to be saved, and MSR does not have
> >> > to be switched back to kernel MSR.
> >> >
> >> > So move the test for "lite" sleep states out to power9_idle_stop.
> >> >
> >> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> >> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> > ---
> >> >  arch/powerpc/kernel/idle_book3s.S | 35 ++++++++++++++++++++++++-----------
> >> >  1 file changed, 24 insertions(+), 11 deletions(-)    
> >> 
> >> This is blowing up for me on mambo:  
> >
> > Oh this is a known bug in mambo that does not match the hardware.
> >
> > You need >= Mambo.7.8.21, or this firmware patch to work around
> > the issue for old mambos.  
> 
> As discussed elsewhere this still breaks on new mambo with more than one
> CPU. So I've dropped it for now.

This now seems to be properly fixed in mambo with commit 11783550ee11.

Skiboot also has a patch merged which disables the problematic state on
mambo so older versions won't crash.

d2a24406a49 ("idle: disable stop*_lite POWER9 idle states for Mambo platform")

So this could be re-applied now.

Thanks,
Nick
