Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBMGq65w9zDr67
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 02:58:43 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id a7so36626568pfj.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 08:58:43 -0700 (PDT)
Date: Wed, 11 Oct 2017 01:58:28 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Vasant Hegde
 <hegdevasant@linux.vnet.ibm.com>, Stewart Smith
 <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc/powernv: Avoid the secondary hold spinloop
 for OPAL boot
Message-ID: <20171011015828.03f4aacc@roar.ozlabs.ibm.com>
In-Reply-To: <20171010214357.2b6694fa@roar.ozlabs.ibm.com>
References: <20171006061005.29891-1-npiggin@gmail.com>
 <20171006061005.29891-2-npiggin@gmail.com>
 <87efqbw93h.fsf@concordia.ellerman.id.au>
 <20171010214357.2b6694fa@roar.ozlabs.ibm.com>
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

On Tue, 10 Oct 2017 21:44:15 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Tue, 10 Oct 2017 22:11:46 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Nicholas Piggin <npiggin@gmail.com> writes:
> >   
> > > OPAL boot does not insert secondaries at 0x60 to wait at the secondary
> > > hold spinloop. Instead it keeps them held in firmware until the
> > > opal_start_cpu call is made, which directs them where the caller
> > > specifies. Linux inserts them into generic_secondary_smp_init(), which
> > > is after the secondary hold spinloop (they go on to spin at the per-CPU
> > > paca loops, but that is another step).
> > >
> > > So avoid waiting on this spinloop when booting with OPAL firmware.
> > > It always just times out.
> > >
> > > This saves 100ms boot time on bare metal, and 10s of seconds when
> > > booting the simulator in SMP.    
> > 
> > Oh nice, that's real facepalm territory.
> > 
> > It'd be neater if we just inserted them at 0x60, but the sequence is
> > wrong.
> > 
> > Can we fix it just by making spinning_secondaries zero on OPAL?  
> 
> I had a look at that, but generic_secondary_smp_init() still
> decrements it, so it would underflow which I thought was
> uglier.
> 
> I actually have to look a bit further, because KVM guests are
> also having the loop time out too by the looks.

Ahh okay, pseries is using the start-cpu RTAS call to enter at
generic_secondary_smp_init() as well. So we can take it out for
pseries as well.

Thanks,
Nick
