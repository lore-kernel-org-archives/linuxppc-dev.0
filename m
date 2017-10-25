Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMXcL37GPzDqlT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 01:30:42 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id b6so108584pfh.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 07:30:42 -0700 (PDT)
Date: Thu, 26 Oct 2017 00:30:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64: set DSCR default initially from SPR
Message-ID: <20171026003020.6ff970cf@roar.ozlabs.ibm.com>
In-Reply-To: <874lqn1r89.fsf@concordia.ellerman.id.au>
References: <20171024114444.13933-1-npiggin@gmail.com>
 <874lqn1r89.fsf@concordia.ellerman.id.au>
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

On Wed, 25 Oct 2017 12:01:10 +0200
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Take the DSCR value set by firmware as the dscr_default value,
> > rather than zero.
> >
> > POWER9 recommends DSCR default to a non-zero value.
> >
> > From: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > This has a problem that OS which set the DSCR to non-default
> > then kexec to Linux will be used as our default. I send a
> > corresponding patch to skiboot which resets SPRs in opal_reinit_cpus
> > which will make this do the right thing in that case.  
> 
> That doesn't work for pseries etc.
> 
> We should reset it in the kexec down path.

Okay I'll add that too. We should have a hypercall to reset all
the state for us like opal_reinit_cpus I reckon, but restoring
it before kexec isn't a bad idea even if we had such a thing.

Thanks,
Nick
