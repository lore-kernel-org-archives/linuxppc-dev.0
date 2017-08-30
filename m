Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj4952FbqzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 22:11:05 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id t3so4926247pgt.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 05:11:05 -0700 (PDT)
Date: Wed, 30 Aug 2017 22:10:45 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] powerpc/64s: idle ESL=0 stop can avoid MSR and
 save/restore overhead
Message-ID: <20170830221045.6fd10787@roar.ozlabs.ibm.com>
In-Reply-To: <87pobd1em0.fsf@concordia.ellerman.id.au>
References: <20170825043036.18236-1-npiggin@gmail.com>
 <20170825043036.18236-5-npiggin@gmail.com>
 <87pobd1em0.fsf@concordia.ellerman.id.au>
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

On Wed, 30 Aug 2017 21:25:59 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > When stop is executed with EC=ESL=0, it appears to execute like a
> > normal instruction (resuming from NIP when woken by interrupt).
> > So all the save/restore handling can be avoided completely. In
> > particular NV GPRs do not have to be saved, and MSR does not have
> > to be switched back to kernel MSR.
> >
> > So move the test for "lite" sleep states out to power9_idle_stop.
> >
> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/kernel/idle_book3s.S | 35 ++++++++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 11 deletions(-)  
> 
> This is blowing up for me on mambo:

Oh this is a known bug in mambo that does not match the hardware.

You need >= Mambo.7.8.21, or this firmware patch to work around
the issue for old mambos.

mambo.git 58d3162f4d6204fc077ff4a6ba47e4d1e19d5120

https://lists.ozlabs.org/pipermail/skiboot/2017-August/008768.html

Thanks,
Nick
