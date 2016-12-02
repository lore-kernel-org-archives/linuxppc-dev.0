Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVlHX35g9zDvy8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 06:55:04 +1100 (AEDT)
Message-ID: <1480708489.3947.3.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>, yanjiang.jin@windriver.com,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jinyanjiang@gmail.com
Date: Fri, 02 Dec 2016 13:54:49 -0600
In-Reply-To: <874m2n7yrf.fsf@concordia.ellerman.id.au>
References: <1479704219-21403-1-git-send-email-yanjiang.jin@windriver.com>
 <874m2n7yrf.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc: cputime: fix a compile warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-12-02 at 15:15 +1100, Michael Ellerman wrote:
> yanjiang.jin@windriver.com writes:
> 
> > 
> > diff --git a/arch/powerpc/include/asm/cputime.h
> > b/arch/powerpc/include/asm/cputime.h
> > index 4f60db0..4423e97 100644
> > --- a/arch/powerpc/include/asm/cputime.h
> > +++ b/arch/powerpc/include/asm/cputime.h
> > @@ -228,7 +228,8 @@ static inline cputime_t clock_t_to_cputime(const
> > unsigned long clk)
> >  	return (__force cputime_t) ct;
> >  }
> >  
> > -#define cputime64_to_clock_t(ct)	cputime_to_clock_t((cputime_t)(ct
> > ))
> > +#define cputime64_to_clock_t(ct)	\
> > +	(__force u64)(cputime_to_clock_t((cputime_t)(ct)))
> Given the name of the function is "cputime64 to clock_t", surely we
> should be returning a clock_t ?

That was my initial reaction but it seems that this function has meant "return
a u64 that is otherwise like clock_t" since before the beginning of git
history.  Both generic implementations return u64, including
jiffies_64_to_clock_t which does so explicitly.

-Scott
