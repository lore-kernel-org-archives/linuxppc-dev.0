Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB48BB6FE3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2012 07:22:25 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 31 Mar 2012 15:22:22 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D12003E40049
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 15:22:00 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2VLM0UA194368
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 15:22:00 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2VLLxvn015851
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 15:22:00 -0600
Date: Sat, 31 Mar 2012 14:21:49 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
Message-ID: <20120331212149.GI2450@linux.vnet.ibm.com>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <1333227608.2325.4054.camel@edumazet-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333227608.2325.4054.camel@edumazet-glaptop>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, dhowells@redhat.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-am33-list@redhat.com, linux@arm.linux.org.uk,
 linux-hexagon@vger.kernel.org, x86@kernel.org, jejb@parisc-linux.org,
 cmetcalf@tilera.com, uclinux-dist-devel@blackfin.uclinux.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-m32r@ml.linux-m32r.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 31, 2012 at 11:00:08PM +0200, Eric Dumazet wrote:
> On Sun, 2012-04-01 at 00:33 +0800, Paul E. McKenney wrote:
> > Although there have been numerous complaints about the complexity of
> > parallel programming (especially over the past 5-10 years), the plain
> > truth is that the incremental complexity of parallel programming over
> > that of sequential programming is not as large as is commonly believed.
> > Despite that you might have heard, the mind-numbing complexity of modern
> > computer systems is not due so much to there being multiple CPUs, but
> > rather to there being any CPUs at all.  In short, for the ultimate in
> > computer-system simplicity, the optimal choice is NR_CPUS=0.
> > 
> > This commit therefore limits kernel builds to zero CPUs.  This change
> > has the beneficial side effect of rendering all kernel bugs harmless.
> > Furthermore, this commit enables additional beneficial changes, for
> > example, the removal of those parts of the kernel that are not needed
> > when there are zero CPUs.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> 
> Hmm... I believe you could go one step forward and allow negative values
> as well. Antimatter was proven to exist after all.
> 
> Hint : nr_cpu_ids is an "int", not an "unsigned int"
> 
> Bonus: Existing bugs become "must have" features.

;-) ;-) ;-)

> Of course there is no hurry and this can wait 365 days.

James Bottomley suggested imaginary numbers of CPUs some time back,
and I suppose there is no reason you cannot have fractional numbers of
CPUs, and perhaps irrational numbers as well.  Of course, these last two
would require use of floating-point arithmetic (or something similar)
in the kernel.  So I guess we have at several years worth.  Over to you
for the negative numbers.  ;-)

							Thanx, Paul
