Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBwcB1MZkzDr69
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 01:00:42 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id b85so2453093pfj.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 07:00:41 -0700 (PDT)
Date: Thu, 12 Oct 2017 00:00:26 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Vasant Hegde
 <hegdevasant@linux.vnet.ibm.com>, Stewart Smith
 <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc/powernv: Avoid the secondary hold spinloop
 for OPAL boot
Message-ID: <20171012000026.044e5a9b@roar.ozlabs.ibm.com>
In-Reply-To: <874lr5zzz8.fsf@concordia.ellerman.id.au>
References: <20171006061005.29891-1-npiggin@gmail.com>
 <20171006061005.29891-2-npiggin@gmail.com>
 <87efqbw93h.fsf@concordia.ellerman.id.au>
 <20171010214357.2b6694fa@roar.ozlabs.ibm.com>
 <20171011015828.03f4aacc@roar.ozlabs.ibm.com>
 <20171011045216.5108425b@roar.ozlabs.ibm.com>
 <874lr5zzz8.fsf@concordia.ellerman.id.au>
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

On Wed, 11 Oct 2017 22:27:23 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Wed, 11 Oct 2017 01:58:28 +1000
> > Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> >  
> >> Ahh okay, pseries is using the start-cpu RTAS call to enter at
> >> generic_secondary_smp_init() as well. So we can take it out for
> >> pseries as well.  
> >
> > This patch seems to do the trick for pseries guests too:
> >
> > powerpc/64s: Avoid waiting for secondary hold spinloop if it is not used
> >
> > OPAL and some RTAS boot does not insert secondaries at 0x60 to wait at
> > the secondary hold spinloop. Instead they are started later, at
> > generic_secondary_smp_init(), which is after the secondary hold
> > spinloop.
> >
> > Avoid waiting on this spinloop when booting with OPAL firmware, or
> > when the RTAS boot does not use this loop. This wait always times
> > out in those cases.
> >
> > This saves 100ms boot time on bare metal (10s of seconds of real time
> > when booting on the simulator in SMP), and 100ms on modern pseries
> > guests.  
> 
> My instinct was to say "huh, that's not how it works on pseries!".
> 
> But then I see this was all changed in:
> 
>   dbe78b401186 ("powerpc/pseries: Do not start secondaries in Open Firmware") (Sep 2013)
> 
> 
> So that is where my confusion comes from. Most of the code and comments
> still talk about secondaries coming in at 0x60, but that's really only
> on "legacy" machines.
> 
> I guess I can merge this, but really this code needs a proper cleanup. I
> dislike all this platform specific knowledge ending up in setup_64.c.
> 
> If we had an smp_ops->spinning_secondaries() that tells the spin
> loop how many secondaries to wait for, it could all go in platform code
> I think.

Yeah, not sure how best to do it. What I wanted to do was just increment
spinning_secondaries in prom_init as we inserted them to 0x60 (or the
0x100 for pmac or whatever). But prom_init doesn't like referencing outside
variables so there goes that.

> 
> The check for use_spinloop() would just become a short-circuit check of
> spinning_secondaries == 0.

Yeah maybe that would be enough. I don't know if half that setup_arch
could be per-platformirized, including smp_release_cpus().

> 
> The other issue is kexec. IIRC when we kexec on pseries we don't return
> the CPUs to RTAS, so then they *are* spinning at 0x60. But maybe that's
> changed since I last looked at it too :)

Oh I might have forgotten to test that on pseries, so I'll try that.

Thanks,
Nick
