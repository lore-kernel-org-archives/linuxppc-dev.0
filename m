Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0ZF35SwJzDsFn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 19:38:31 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBI8XvIm137844
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 03:38:29 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ex6g803nt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 03:38:28 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 03:38:28 -0500
Date: Mon, 18 Dec 2017 14:08:20 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, huntbag@linux.vnet.ibm.com,
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
 <1513148261-21097-3-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnz=jrvbizrzUx1tDxMg__4coJHoxSXOS+K+zXQVAM=WF-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKTCnz=jrvbizrzUx1tDxMg__4coJHoxSXOS+K+zXQVAM=WF-g@mail.gmail.com>
Message-Id: <20171218083820.GA28881@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

On Sun, Dec 17, 2017 at 02:15:25PM +1100, Balbir Singh wrote:
> On Wed, Dec 13, 2017 at 5:57 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > The code in powernv-cpufreq, makes the following two assumptions which
> > are not guaranteed by the device-tree bindings:
> >
> >     1) Pstate ids are continguous: This is used in pstate_to_idx() to
> >        obtain the reverse map from a pstate to it's corresponding
> >        entry into the cpufreq frequency table.
> >
> >     2) Every Pstate should always lie between the max and the min
> >        pstates that are explicitly reported in the device tree: This
> >        is used to determine whether a pstate reported by the PMSR is
> >        out of bounds.
> >
> > Both these assumptions are unwarranted and can change on future
> > platforms.
> 
> While this is a good thing, I wonder if it is worth the complexity. Pstates
> are contiguous because they define transitions in incremental value
> of change in frequency and I can't see how this can be broken in the
> future?

In the future, we can have the OPAL firmware give us a smaller set of
pstates instead of expose every one of them. As it stands today, for
most of the workloads, we will need at best 20-30 pstates and not
beyond that.


> 
> Balbir Singh.
> 

--
Thanks and Regards
gautham.
