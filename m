Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2356C1A051A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 21:39:59 +1100 (AEDT)
Message-ID: <1456223992.3192.0.camel@ellerman.id.au>
Subject: Re: [PATCH] arch/powerpc: use BUILD_BUG() when detect unfit
 {cmp}xchg, size
From: Michael Ellerman <mpe@ellerman.id.au>
To: Boqun Feng <boqun.feng@gmail.com>, Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, open list <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, "'Peter Zijlstra (Intel)\"" <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,  Thomas Gleixner
 <tglx@linutronix.de>
Date: Tue, 23 Feb 2016 21:39:52 +1100
In-Reply-To: <20160223091525.GA2918@fixme-laptop.cn.ibm.com>
References: <56CC1C1C.6030405@linux.vnet.ibm.com>
 <20160223091525.GA2918@fixme-laptop.cn.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-23 at 17:15 +0800, Boqun Feng wrote:
> On Tue, Feb 23, 2016 at 04:45:16PM +0800, Pan Xinhui wrote:
> > From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
> > 
> > diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
> > index d1a8d93..20c0a30 100644
> > --- a/arch/powerpc/include/asm/cmpxchg.h
> > +++ b/arch/powerpc/include/asm/cmpxchg.h
> > @@ -92,12 +93,6 @@ __xchg_u64_local(volatile void *p, unsigned long val)
> >  }
> >  #endif
> >  
> > -/*
> > - * This function doesn't exist, so you'll get a linker error
> > - * if something tries to do an invalid xchg().
> > - */
> > -extern void __xchg_called_with_bad_pointer(void);
> > -
> >  static __always_inline unsigned long
> >  __xchg(volatile void *ptr, unsigned long x, unsigned int size)
> >  {
> > @@ -109,7 +104,7 @@ __xchg(volatile void *ptr, unsigned long x, unsigned int size)
> >  		return __xchg_u64(ptr, x);
> >  #endif
> >  	}
> > -	__xchg_called_with_bad_pointer();
> > +	BUILD_BUG();
> 
> Maybe we can use BUILD_BUG_ON_MSG(1, "Unsupported size for xchg"), which
> could provide more information.

Yes I would prefer there was a message. Please send a v2.

cheers
