Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxwb02kbmzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 14:14:04 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v34491tp091760
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:13:53 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29m0j416vf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 00:13:52 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 09:43:49 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v344DlId15466646
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 09:43:47 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v344Dj55013145
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 09:43:46 +0530
Date: Tue, 4 Apr 2017 09:43:43 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, ego@linux.vnet.ibm.com,
 rjw@rjwysocki.net, daniel.lezcano@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] cpuidle: powernv: Don't bounce between low and very
 low thread priority
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170403215414.16951-1-anton@ozlabs.org>
 <20170404095207.28fc5229@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170404095207.28fc5229@roar.ozlabs.ibm.com>
Message-Id: <20170404041343.GE21029@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nicholas Piggin <npiggin@gmail.com> [2017-04-04 09:52:07]:

> On Tue,  4 Apr 2017 07:54:12 +1000
> Anton Blanchard <anton@ozlabs.org> wrote:
> 
> > From: Anton Blanchard <anton@samba.org>
> > 
> > The core of snooze_loop() continually bounces between low and very
> > low thread priority. Changing thread priorities is an expensive
> > operation that can negatively impact other threads on a core.
> > 
> > All CPUs that can run PowerNV support very low priority, so we can
> > avoid the change completely.
> 
> This looks good. I have HMT_lowest() which does alt feature patching
> we can use for pseries and default idle code.

Alternatively, if we are going to set priority only once in various
other places, HMT_low(); HMT_very_low(); should not add to extra
cycles.  Let me code that up.

--Vaidy

 
