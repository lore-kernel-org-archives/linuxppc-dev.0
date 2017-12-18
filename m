Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0ZLy1Q9VzDqZC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 19:43:38 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBI8cjgQ001390
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 03:43:36 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ex69as1ym-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 03:43:35 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 03:43:34 -0500
Date: Mon, 18 Dec 2017 14:13:29 +0530
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
Subject: Re: [v3 PATCH 3/3] powernv-cpufreq: Treat pstates as opaque 8-bit
 values
Reply-To: ego@linux.vnet.ibm.com
References: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com>
 <1513148261-21097-4-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnz=qMNECSSfVGXNfN9JfxAZUB86-dwtx1ZCicmj7b7Kweg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKTCnz=qMNECSSfVGXNfN9JfxAZUB86-dwtx1ZCicmj7b7Kweg@mail.gmail.com>
Message-Id: <20171218084329.GB28881@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

On Sun, Dec 17, 2017 at 02:17:02PM +1100, Balbir Singh wrote:
> On Wed, Dec 13, 2017 at 5:57 PM, Gautham R. Shenoy
[..snip..]
> >
> > -static inline int extract_pstate(u64 pmsr_val, unsigned int shift)
> > +static inline u8 extract_pstate(u64 pmsr_val, unsigned int shift)
> >  {
> > -       int ret = ((pmsr_val >> shift) & 0xFF);
> > -
> > -       if (!ret)
> > -               return ret;
> > -
> > -       return (pstate_sign_prefix | ret);
> > +       return ((pmsr_val >> shift) & 0xFF);
> >  }
> 
> So we just added this and moved from an int to u8. I was going to ask
> if we still need an int in patch1, but I thought the driver dealt with
> just integers because of the larger framework.

The larger framework is with respect to the device tree which defines
pstates as 32-bit integers (I am not aware of the reasons for this
choice, but perhaps device-tree doesn't have a s8/u8 type?!). The
driver still knows that pstates are only 8-bits wide because of the
PMSR,PMCR definitions. Before this patch, the driver was still doing
the conversions from 8-bit to int and vice-versa every time. With this
patch, we do it only once, i.e at the initialization. After that we
treat pstates as 8-bit integers. 


> 
> Balbir Singh.
> 
