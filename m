Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbpbw3R3hzDqlN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jun 2016 05:41:13 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, David Laight <David.Laight@aculab.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "anton@samba.org" <anton@samba.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] cpuidle: Fix last_residency division
Date: Fri, 24 Jun 2016 21:43:13 +0200
Message-ID: <3748080.8f21OXxXix@wuerfel>
In-Reply-To: <576D595F.9090001@linux.vnet.ibm.com>
References: <1466756638-2362-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <14940457.SEYBmqcunj@wuerfel> <576D595F.9090001@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, June 24, 2016 9:31:35 PM CEST Shreyas B Prabhu wrote:
> > If those functions are called less often than cpuidle_enter_state(),
> > we could just move the division there. Since the divisor is constant,
> > do_div() can convert it into a multiply and shift, or we could use
> > your the code you suggest above, or use a 32-bit division most of
> > the time:
> > 
> >       if (diff <= UINT_MAX)
> >               diff_32 = (u32)diff / NSECS_PER_USEC;
> >       else
> >               diff_32 = div_u64(diff, NSECS_PER_USEC;
> > 
> > which gcc itself will turn into a multiplication or series of
> > shifts on CPUs on which that is faster.
> >
> I'm not sure which division method of the three suggested here to use.
> Does anyone have a strong preference?
> 

It depends on how accurate we want it and how long we expect
the times to be. The optimization for the 4.2 second cutoff
for doing a 32-bit division only makes sense if the majority
of the sleep times are below that.

	Arnd
