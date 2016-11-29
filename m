Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSY6H3qM5zDvt3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 17:09:26 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAT655It034417
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 01:09:23 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27143kg7s5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 01:09:23 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 29 Nov 2016 01:09:23 -0500
Date: Tue, 29 Nov 2016 11:39:11 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 skiboot@lists.ozlabs.org
Subject: Re: [PATCH v3 2/3] cpuidle:powernv: Add helper function to populate
 powernv idle states.
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1478760806.git.ego@linux.vnet.ibm.com>
 <9c2b5cae68b54ec5dcb2651f352f740f1d09051c.1478760806.git.ego@linux.vnet.ibm.com>
 <87vavettkb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vavettkb.fsf@concordia.ellerman.id.au>
Message-Id: <20161129060911.GA30454@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Wed, Nov 23, 2016 at 08:49:08PM +1100, Michael Ellerman wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> 
> > diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> > index 7fe442c..9240e08 100644
> > --- a/drivers/cpuidle/cpuidle-powernv.c
> > +++ b/drivers/cpuidle/cpuidle-powernv.c
> > @@ -243,28 +262,31 @@ static int powernv_add_idle_states(void)
> >  		 */
> >  		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
> >  			continue;
> > +		/*
> > +		 * Firmware passes residency and latency values in ns.
> > +		 * cpuidle expects it in us.
> > +		 */
> > +		exit_latency = ((unsigned int)latency_ns[i]) / 1000;
> > +		target_residency = (!rc) ? ((unsigned int)residency_ns[i]) : 0;
> > +		target_residency /= 1000;
> 
> Urk.
> 
> Can you just do it normally:
> 
> 		if (rc == 0)
> 			target_residency = (unsigned int)residency_ns[i] / 1000;

Wrote this in a non-standard manner since the normal way would exceed
80 chars.

> 
> I also don't see why you need the cast?

It is a remnant from the previous code. But I see your point, the cast
is redundant, and removing it will make it possible to implement this
in the normal manner without checkpatch warning about it.

> 
> cheers
> 

--
Thanks and Regards
gautham.
