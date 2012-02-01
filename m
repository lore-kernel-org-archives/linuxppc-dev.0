Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8541B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 10:17:12 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 1 Feb 2012 16:17:08 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 705ED19D804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 16:16:04 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q11NFpqN060280
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2012 16:15:54 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q11NFpNi007933
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2012 16:15:51 -0700
Date: Wed, 1 Feb 2012 15:15:50 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] powerpc: Define cpus_in_crash only for SMP kernels
Message-ID: <20120201231550.GO2382@linux.vnet.ibm.com>
References: <20120201185510.GA8542@linux.vnet.ibm.com>
 <4F29A072.9050203@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F29A072.9050203@windriver.com>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
 ben@decadent.org.uk
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 01, 2012 at 03:28:34PM -0500, Paul Gortmaker wrote:
> On 12-02-01 01:55 PM, Paul E. McKenney wrote:
> > The variable cpus_in_crash gets a defined-but-not-used warning when
> > CONFIG_SMP=n, so fix by placing the variable under ifdef.
> 
> I think Ben already merged a similar fix.
> 
> http://patchwork.ozlabs.org/patch/136549/
> 
> P.

Linus's tree does now have cpus_in_crash, so agreed.  Sorry for the
noise!

							Thanx, Paul

> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> > index 28be345..eb3384e 100644
> > --- a/arch/powerpc/kernel/crash.c
> > +++ b/arch/powerpc/kernel/crash.c
> > @@ -46,7 +46,9 @@
> >  
> >  /* This keeps a track of which one is the crashing cpu. */
> >  int crashing_cpu = -1;
> > +#ifdef CONFIG_SMP
> >  static atomic_t cpus_in_crash;
> > +#endif /* #ifdef CONFIG_SMP */
> >  static int time_to_dump;
> >  
> >  #define CRASH_HANDLER_MAX 3
> > 
> 
