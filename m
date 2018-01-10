Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGjXY1d8szF0gQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 19:55:56 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0A8tMU9056920
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 03:55:54 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fddf9we3g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 03:55:54 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 10 Jan 2018 01:55:53 -0700
Date: Wed, 10 Jan 2018 14:25:45 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Abhishek <huntbag@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 linux-pm@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [v3 PATCH 2/3] powernv-cpufreq: Fix pstate_to_idx() to handle
 non-continguous pstates
Reply-To: ego@linux.vnet.ibm.com
References: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnz=jrvbizrzUx1tDxMg__4coJHoxSXOS+K+zXQVAM=WF-g@mail.gmail.com>
 <20171218083820.GA28881@in.ibm.com>
 <3110289.BbUpyYVBQa@aspire.rjw.lan>
 <CAKTCnznuf1jwWZEqi+og8LyayfzMwGYRUXhK4+zfbSYDfexyRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKTCnznuf1jwWZEqi+og8LyayfzMwGYRUXhK4+zfbSYDfexyRA@mail.gmail.com>
Message-Id: <20180110085545.GA13666@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rafael,

On Wed, Jan 03, 2018 at 11:47:58PM +1100, Balbir Singh wrote:
> On Wed, Jan 3, 2018 at 11:07 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, December 18, 2017 9:38:20 AM CET Gautham R Shenoy wrote:
> >> Hi Balbir,
> >>
> >> On Sun, Dec 17, 2017 at 02:15:25PM +1100, Balbir Singh wrote:
> >> > On Wed, Dec 13, 2017 at 5:57 PM, Gautham R. Shenoy
> >> > <ego@linux.vnet.ibm.com> wrote:
> >> > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >> > >
> >> > > The code in powernv-cpufreq, makes the following two assumptions which
> >> > > are not guaranteed by the device-tree bindings:
> >> > >
> >> > >     1) Pstate ids are continguous: This is used in pstate_to_idx() to
> >> > >        obtain the reverse map from a pstate to it's corresponding
> >> > >        entry into the cpufreq frequency table.
> >> > >
> >> > >     2) Every Pstate should always lie between the max and the min
> >> > >        pstates that are explicitly reported in the device tree: This
> >> > >        is used to determine whether a pstate reported by the PMSR is
> >> > >        out of bounds.
> >> > >
> >> > > Both these assumptions are unwarranted and can change on future
> >> > > platforms.
> >> >
> >> > While this is a good thing, I wonder if it is worth the complexity. Pstates
> >> > are contiguous because they define transitions in incremental value
> >> > of change in frequency and I can't see how this can be broken in the
> >> > future?
> >>
> >> In the future, we can have the OPAL firmware give us a smaller set of
> >> pstates instead of expose every one of them. As it stands today, for
> >> most of the workloads, we will need at best 20-30 pstates and not
> >> beyond that.
> >
> > I'm not sure about the status here.
> >
> > Is this good to go as is or is it going to be updated?
> >
> 
> I have no major objections, except some of the added complexity, but
> Gautham makes a point that this is refactoring for the future

I have tested this across POWER8 and POWER9. The additional complexity
introduced by the second patch is required for the future when we are
going to reduce the number of pstates.


> 
> Balbir Singh.
> 
--
Thanks and Regards
gautham.
