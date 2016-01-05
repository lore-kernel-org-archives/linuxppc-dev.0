Return-Path: <schwidefsky@de.ibm.com>
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E01371A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jan 2016 19:03:13 +1100 (AEDT)
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <schwidefsky@de.ibm.com>;
 Tue, 5 Jan 2016 08:03:09 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1FD0F2190068
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jan 2016 08:02:56 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u058364R655840
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jan 2016 08:03:06 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u05735K6016463
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jan 2016 00:03:07 -0700
Date: Tue, 5 Jan 2016 09:03:01 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper
 <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin"
 <hpa@zytor.com>, David Miller <davem@davemloft.net>,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Heiko
 Carstens <heiko.carstens@de.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Andrey Konovalov <andreyknvl@google.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 06/32] s390: reuse asm-generic/barrier.h
Message-ID: <20160105090301.3f9939be@mschwide>
In-Reply-To: <20160104224135-mutt-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-7-git-send-email-mst@redhat.com>
 <20160104132042.GW6344@twins.programming.kicks-ass.net>
 <20160104160339.25101b5d@mschwide>
 <20160104224135-mutt-send-email-mst@redhat.com>
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

On Mon, 4 Jan 2016 22:42:44 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jan 04, 2016 at 04:03:39PM +0100, Martin Schwidefsky wrote:
> > On Mon, 4 Jan 2016 14:20:42 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Thu, Dec 31, 2015 at 09:06:30PM +0200, Michael S. Tsirkin wrote:
> > > > On s390 read_barrier_depends, smp_read_barrier_depends
> > > > smp_store_mb(), smp_mb__before_atomic and smp_mb__after_atomic match the
> > > > asm-generic variants exactly. Drop the local definitions and pull in
> > > > asm-generic/barrier.h instead.
> > > > 
> > > > This is in preparation to refactoring this code area.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  arch/s390/include/asm/barrier.h | 10 ++--------
> > > >  1 file changed, 2 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
> > > > index 7ffd0b1..c358c31 100644
> > > > --- a/arch/s390/include/asm/barrier.h
> > > > +++ b/arch/s390/include/asm/barrier.h
> > > > @@ -30,14 +30,6 @@
> > > >  #define smp_rmb()			rmb()
> > > >  #define smp_wmb()			wmb()
> > > >  
> > > > -#define read_barrier_depends()		do { } while (0)
> > > > -#define smp_read_barrier_depends()	do { } while (0)
> > > > -
> > > > -#define smp_mb__before_atomic()		smp_mb()
> > > > -#define smp_mb__after_atomic()		smp_mb()
> > > 
> > > As per:
> > > 
> > >   lkml.kernel.org/r/20150921112252.3c2937e1@mschwide
> > > 
> > > s390 should change this to barrier() instead of smp_mb() and hence
> > > should not use the generic versions.
> >  
> > Yes, we wanted to simplify this. Thanks for the reminder, I'll queue
> > a patch.
> 
> Could you base on my patchset maybe, to avoid conflicts,
> and I'll merge it?
> Or if it's just replacing these 2 with barrier() I can do this
> myself easily.

Probably the easiest solution if you do the patch yourself and
include it in your patch set. 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
