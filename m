Return-Path: <luto@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40pWd86NzJzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 16:06:36 +1000 (AEST)
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BFE1E2086C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 06:06:33 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id a137-v6so8150698wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 23:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <53828769-23c4-b2e3-cf59-239936819c3e@redhat.com>
 <20180519011947.GJ5479@ram.oc3035372033.ibm.com>
 <CALCETrWMP9kTmAFCR0WHR3YP93gLSzgxhfnb0ma_0q=PCuSdQA@mail.gmail.com>
 <20180519202747.GK5479@ram.oc3035372033.ibm.com>
 <CALCETrVz9otkOQAxVkz6HtuMwjAeY6mMuLgFK_o0M0kbkUznwg@mail.gmail.com>
 <20180520060425.GL5479@ram.oc3035372033.ibm.com>
In-Reply-To: <20180520060425.GL5479@ram.oc3035372033.ibm.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 19 May 2018 23:06:20 -0700
Message-ID: <CALCETrVvQkphypn10A_rkX35DNqi29MJcXYRpRiCFNm02VYz2g@mail.gmail.com>
Subject: Re: pkeys on POWER: Access rights not reset on execve
To: linuxram@us.ibm.com
Cc: Andrew Lutomirski <luto@kernel.org>, Florian Weimer <fweimer@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>,
 Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 19, 2018 at 11:04 PM Ram Pai <linuxram@us.ibm.com> wrote:

> On Sat, May 19, 2018 at 04:47:23PM -0700, Andy Lutomirski wrote: > On
Sat, May 19, 2018 at 1:28 PM Ram Pai <linuxram@us.ibm.com> wrote:

> ...snip...
> >
> > So is it possible for two threads to each call pkey_alloc() and end up
with
> > the same key?  If so, it seems entirely broken.

> No. Two threads cannot allocate the same key; just like x86.

> > If not, then how do you
> > intend for a multithreaded application to usefully allocate a new key?
> > Regardless, it seems like the current behavior on POWER is very
difficult
> > to work with.  Can you give an example of a use case for which POWER's
> > behavior makes sense?
> >
> > For the use cases I've imagined, POWER's behavior does not make sense.
> >   x86's is not ideal but is still better.  Here are my two example use
cases:
> >
> > 1. A crypto library.  Suppose I'm writing a TLS-terminating server, and
I
> > want it to be resistant to Heartbleed-like bugs.  I could store my
private
> > keys protected by mprotect_key() and arrange for all threads and signal
> > handlers to have PKRU/AMR values that prevent any access to the memory.
> > When an explicit call is made to sign with the key, I would temporarily
> > change PKRU/AMR to allow access, compute the signature, and change
PKRU/AMR
> > back.  On x86 right now, this works nicely.  On POWER, it doesn't,
because
> > any thread started before my pkey_alloc() call can access the protected
> > memory, as can any signal handler.
> >
> > 2. A database using mmap() (with persistent memory or otherwise).  It
would
> > be nice to be resistant to accidental corruption due to stray writes.  I
> > would do more or less the same thing as (1), except that I would want
> > threads that are not actively writing to the database to be able the
> > protected memory.  On x86, I need to manually convince threads that may
> > have been started before my pkey_alloc() call as well as signal
handlers to
> > update their PKRU values.  On POWER, as in example (1), the error goes
the
> > other direction -- if I fail to propagate the AMR bits to all threads,
> > writes are not blocked.

> I see the problem from an application's point of view, on powerpc.  If
> the key allocated in one thread is not activated on all threads
> (existing one and future one), than other threads will not be able
> to modify the key's permissions. Hence they will not be able to control
> access/write to pages to which the key is associated.

> As Florian suggested, I should enable the key's bit in the UAMOR value
> corresponding to existing threads, when a new key is allocated.

> Now, looking at the implementation for x86, I see that sys_mpkey_alloc()
> makes no attempt to modify anything of any other thread. How
> does it manage to activate the key on any other thread? Is this
> magic done by the hardware?

x86 has no equivalent concept to UAMOR.  There are 16 keys no matter what.

--Andy
