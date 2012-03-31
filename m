Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1FE4B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2012 02:54:21 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 31 Mar 2012 10:54:16 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 564F61FF0048
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 10:54:13 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2VGsDl7144676
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 10:54:13 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2VGsBSO008773
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 10:54:13 -0600
Date: Sat, 31 Mar 2012 09:54:01 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
Message-ID: <20120331165401.GD2450@linux.vnet.ibm.com>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <CAMuHMdWTB+_AtqM6JixY=Oo_zmzX_dNxnivpARBYSbPJzp4t6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAMuHMdWTB+_AtqM6JixY=Oo_zmzX_dNxnivpARBYSbPJzp4t6A@mail.gmail.com>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, dhowells@redhat.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-am33-list@redhat.com, linux@arm.linux.org.uk,
 linux-hexagon@vger.kernel.org, x86@kernel.org, jejb@parisc-linux.org,
 cmetcalf@tilera.com, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 uclinux-dist-devel@blackfin.uclinux.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-m32r@ml.linux-m32r.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux390@de.ibm.com,
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

On Sat, Mar 31, 2012 at 06:40:30PM +0200, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Sat, Mar 31, 2012 at 18:33, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > Although there have been numerous complaints about the complexity of
> > parallel programming (especially over the past 5-10 years), the plain
> > truth is that the incremental complexity of parallel programming over
> > that of sequential programming is not as large as is commonly believed.
> > Despite that you might have heard, the mind-numbing complexity of modern
> > computer systems is not due so much to there being multiple CPUs, but
> > rather to there being any CPUs at all.  In short, for the ultimate in
> > computer-system simplicity, the optimal choice is NR_CPUS=0.
> >
> > This commit therefore limits kernel builds to zero CPUs.  This change
> > has the beneficial side effect of rendering all kernel bugs harmless.
> > Furthermore, this commit enables additional beneficial changes, for
> > example, the removal of those parts of the kernel that are not needed
> > when there are zero CPUs.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >
> >  alpha/Kconfig                     |   11 ++++++-----
> >  arm/Kconfig                       |    6 +++---
> >  blackfin/Kconfig                  |    3 ++-
> >  hexagon/Kconfig                   |    9 +++++----
> >  ia64/Kconfig                      |    9 +++++----
> >  m32r/Kconfig                      |   10 ++++++----
> >  mips/Kconfig                      |   21 +++++++++++----------
> >  mn10300/Kconfig                   |    3 ++-
> >  parisc/Kconfig                    |    6 +++---
> >  powerpc/platforms/Kconfig.cputype |    8 ++++----
> >  s390/Kconfig                      |   12 +++++++-----
> >  sh/Kconfig                        |   11 ++++++-----
> >  sparc/Kconfig                     |    8 ++++----
> >  tile/Kconfig                      |    9 +++++----
> >  x86/Kconfig                       |   16 +++++++++-------
> >  15 files changed, 78 insertions(+), 64 deletions(-)
> 
> You forgot to fix half of the architectures, a.o. m68k?

I must confess that I fixed only the SMP-capable architectures.

I of course would welcome additions for UP-only architectures.

							Thanx, Paul
