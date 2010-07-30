Return-Path: <jakub@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 5EDE91007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 17:16:54 +1000 (EST)
Date: Fri, 30 Jul 2010 09:19:22 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Adjust arch/powerpc inline asms for recent gcc change
Message-ID: <20100730071922.GQ18378@tyan-ft48-01.lab.bos.redhat.com>
References: <20100625095606.GG12443@tyan-ft48-01.lab.bos.redhat.com>
	<1278569285.28659.76.camel@pasglop>
	<1280473486.2169.2.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1280473486.2169.2.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: Jakub Jelinek <jakub@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 30, 2010 at 05:04:46PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2010-07-08 at 16:08 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2010-06-25 at 11:56 +0200, Jakub Jelinek wrote:
> > 
> > >  static inline void sync(void)
> > > diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> > > index b8f152e..288d8b2 100644
> > > --- a/arch/powerpc/include/asm/atomic.h
> > > +++ b/arch/powerpc/include/asm/atomic.h
> > > @@ -19,14 +19,14 @@ static __inline__ int atomic_read(const atomic_t *v)
> > >  {
> > >  	int t;
> > >  
> > > -	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m"(v->counter));
> > > +	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
> > >  
> > >  	return t;
> > >  }
> > >  
> > 
> > This gives me:
> > 
> > /home/benh/linux-powerpc-test/arch/powerpc/kernel/time.c: In function ‘timer_interrupt’:
> > /home/benh/linux-powerpc-test/arch/powerpc/include/asm/atomic.h:22: error: ‘asm’ operand has impossible constraints
> > make[2]: *** [arch/powerpc/kernel/time.o] Error 1
> > 
> > $ gcc --version
> > gcc (Debian 4.4.4-1) 4.4.4
> 
> Ping :-)
> 
> Do that mean that 4.4.4 doesn't understand your new constraints or are
> we doing something incorrect ?

The constraints weren't new, so in theory everything would work fine.
Except because < and > were so rarely used on many targets before,
there were backend bugs on PowerPC and SPARC at least related to that.
See
http://gcc.gnu.org/PR44707
http://gcc.gnu.org/PR44701
http://gcc.gnu.org/PR44492

So, in short, I'm afraid "m<>" needs to be used only for GCC 4.6+
(and, vendors which backported the inline-asm handling changes
to their older gcc would need to adjust for their gccs too).
When "m<>" isn't used, it just leads to potential code pessimization
in inline-asms that are prepared for handling side-effects.

	Jakub
