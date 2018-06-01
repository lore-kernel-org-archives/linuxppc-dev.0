Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xsSh4g1tzDr4d
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 14:54:44 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w514sFRS097021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2018 00:54:41 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jaw56vr2s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jun 2018 00:54:41 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 1 Jun 2018 00:54:39 -0400
Date: Fri, 1 Jun 2018 10:24:33 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
Reply-To: ego@linux.vnet.ibm.com
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnz=WhC_vamKPZruEqc04WKpD5ZqZm0zTcCtagRHib6OZPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKTCnz=WhC_vamKPZruEqc04WKpD5ZqZm0zTcCtagRHib6OZPw@mail.gmail.com>
Message-Id: <20180601045433.GA17425@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

Thanks for reviewing the patch!

On Fri, Jun 01, 2018 at 12:51:05AM +1000, Balbir Singh wrote:
> On Thu, May 31, 2018 at 10:15 PM, Gautham R. Shenoy

[..snip..]
> >
> > +static u64 get_snooze_timeout(struct cpuidle_device *dev,
> > +                             struct cpuidle_driver *drv,
> > +                             int index)
> > +{
> > +       int i;
> > +
> > +       if (unlikely(!snooze_timeout_en))
> > +               return default_snooze_timeout;
> > +
> > +       for (i = index + 1; i < drv->state_count; i++) {
> > +               struct cpuidle_state *s = &drv->states[i];
> > +               struct cpuidle_state_usage *su = &dev->states_usage[i];
> > +
> > +               if (s->disabled || su->disable)
> > +                       continue;
> > +
> > +               return s->target_residency * tb_ticks_per_usec;
> 
> Can we ensure this is not prone to overflow?

s->target_residency is an "unsigned int" so can take a maximum value
of UINT_MAX. tb_ticks_per_usec is an "unsigned long" with a value in
the range of 100-1000. The return value is a u64. The product of
s->target_residency and tb_ticks_per_usec should be contained in u64.

Is there a potential case of overflow that I am missing ?

> 
> Otherwise looks good
> 
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

--
Thanks and Regards
gautham.
