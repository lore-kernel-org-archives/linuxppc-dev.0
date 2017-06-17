Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wqM4k4zjMzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 12:43:49 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u62so2951337pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 19:43:49 -0700 (PDT)
Date: Sat, 17 Jun 2017 12:43:25 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Don Zickus <dzickus@redhat.com>, Babu Moger <babu.moger@oracle.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/5] watchdog: introduce arch_touch_nmi_watchdog()
Message-ID: <20170617124325.58ad25cb@roar.ozlabs.ibm.com>
In-Reply-To: <20170616112117.a33b1096985a786777bc8b54@linux-foundation.org>
References: <20170616065715.18390-1-npiggin@gmail.com>
 <20170616065715.18390-3-npiggin@gmail.com>
 <20170616112117.a33b1096985a786777bc8b54@linux-foundation.org>
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

On Fri, 16 Jun 2017 11:21:17 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 16 Jun 2017 16:57:12 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > For architectures that define HAVE_NMI_WATCHDOG, instead of having
> > them provide the complete touch_nmi_watchdog() function, just have
> > them provide arch_touch_nmi_watchdog().
> > 
> > This gives the generic code more flexibility in implementing this
> > function, and arch implementations don't miss out on touching the
> > softlockup watchdog or other generic details.
> > 
> > ...
> >
> > --- a/arch/blackfin/include/asm/nmi.h
> > +++ b/arch/blackfin/include/asm/nmi.h
> > @@ -9,4 +9,6 @@
> >  
> >  #include <linux/nmi.h>
> >  
> > +extern void arch_touch_nmi_watchdog(void);  
> 
> Do we actually need to add this to the arch header files...

[snip]

> > +#if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
> > +extern void arch_touch_nmi_watchdog(void);
> > +#else
> > +static inline void arch_touch_nmi_watchdog(void) {}
> > +#endif
> > +  
> 
> given that we have a global declaration here?

Probably not. I think it was a holdover from an earlier version where
I tried to let the arch declare it (one of the little embedded ones
had a comment somewhere saying it would be nice if they could make it
inline).

There was some difficulty with it, so yes let's remove these and do
that next time.

Thanks,
Nick
