Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0Znt2l2WzDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 20:03:30 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBI8t3tY129028
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 04:03:27 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ex6es97mf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 04:03:27 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 02:03:26 -0700
Date: Mon, 18 Dec 2017 14:33:19 +0530
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
Subject: Re: [v3 PATCH 1/3] powernv-cpufreq: Add helper to extract pstate
 from PMSR
Reply-To: ego@linux.vnet.ibm.com
References: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com>
 <1513148261-21097-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnzn9TskuPQavjkNZTjy+ff-BxSOsBkLvmb7+unH3O_3KKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKTCnzn9TskuPQavjkNZTjy+ff-BxSOsBkLvmb7+unH3O_3KKg@mail.gmail.com>
Message-Id: <20171218090319.GC28881@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

On Sun, Dec 17, 2017 at 02:04:03PM +1100, Balbir Singh wrote:
> On Wed, Dec 13, 2017 at 5:57 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > On POWERNV platform, the fields for pstates in the Power Management
> > Status Register (PMSR) and the Power Management Control Register
> > (PMCR) are 8-bits wide. On POWER8 the pstates are negatively numbered
> > while on POWER9 they are positively numbered.
> >
> > The device-tree exports pstates as 32-bit entries. The device-tree
> > implementation sign-extends the 8-bit pstate values to obtain the
> > corresponding 32-bit entry.
> >
> > Eg: On POWER8, a pstate value 0x82 [-126] is represented in the
> > device-tree as 0xfffffff82 while on POWER9, the same value 0x82 [130]
> > is represented in the device-tree as 0x00000082.
> >
> > The powernv-cpufreq driver implementation represents pstates using the
> > integer type. In multiple places in the driver, the code interprets
> > the pstates extracted from the PMSR as a signed byte and assigns it to
> > a integer variable to get the sign-extention.
> >
> > On POWER9 platforms which have greater than 128 pstates, this results
> > in the driver performing incorrect sign-extention, and thereby
> > treating a legitimate pstate (say 130) as an invalid pstates (since it
> > is interpreted as -126).
> >
> > This patch fixes the issue by implementing a helper function to
> > extract Pstates from PMSR register, and correctly sign-extend it to be
> > consistent with the values provided by the device-tree.
> >
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> 
> This looks better

Thanks for the Review.

> 
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> 
> Balbir Singh
> 
