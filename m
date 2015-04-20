Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFB291A0BE0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 05:59:12 +1000 (AEST)
Date: Mon, 20 Apr 2015 21:59:01 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 01/11] linux/time64.h:Introduce the 'struct itimerspec64'
 for 64bit
In-Reply-To: <alpine.DEB.2.11.1504202112130.13914@nanos>
Message-ID: <alpine.DEB.2.11.1504202154430.13914@nanos>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <1429509459-17068-2-git-send-email-baolin.wang@linaro.org>
 <alpine.DEB.2.11.1504202112130.13914@nanos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pang.xunlei@linaro.org, peterz@infradead.org, heiko.carstens@de.ibm.com,
 paulus@samba.org, cl@linux.com, heenasirwani@gmail.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, y2038@lists.linaro.org,
 rafael.j.wysocki@intel.com, ahh@google.com, fweisbec@gmail.com, pjt@google.com,
 riel@redhat.com, arnd@arndb.de, richardcochran@gmail.com,
 schwidefsky@de.ibm.com, john.stultz@linaro.org, rth@twiddle.net,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, tj@kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 20 Apr 2015, Thomas Gleixner wrote:
> On Mon, 20 Apr 2015, Baolin Wang wrote:
> > This patch introduces the 'struct itimerspec64' for 64bit to replace itimerspec,
> > and also introduces the conversion methods: itimerspec64_to_itimerspec() and
> > itimerspec_to_itimerspec64(), that makes itimerspec to ready for 2038 year.
> > 
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  include/linux/time64.h |   13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/include/linux/time64.h b/include/linux/time64.h
> > index a383147..3647bdd 100644
> > --- a/include/linux/time64.h
> > +++ b/include/linux/time64.h
> > @@ -18,6 +18,11 @@ struct timespec64 {
> >  };
> >  #endif
> >  
> > +struct itimerspec64 {
> > +	struct timespec64 it_interval;  /* timer period */
> > +	struct timespec64 it_value;     /* timer expiration */
> > +};

Aside of the macro mess. This really wants to be conditional on 64/32
but in the same way as we have the different implementations for
timespec64.

Your patch enforces a useless conversion from and to itimerspec64 even
on 64 bit because the compiler cannot map the types.

Sigh. timespec64 is a proper guidance here.

Thanks,

	tglx
