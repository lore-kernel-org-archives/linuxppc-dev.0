Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdmzx4rtzzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 17:35:57 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBE6XqoL055742
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 01:35:55 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27auqym697-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 01:35:55 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 13 Dec 2016 23:35:54 -0700
Date: Wed, 14 Dec 2016 12:05:45 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 1/4] powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1481288905.git.ego@linux.vnet.ibm.com>
 <0947ced2f87c68a0a10ede8e1aaf39838a6f8d52.1481288905.git.ego@linux.vnet.ibm.com>
 <f1bc3387-1118-6fd7-8e1b-2e59bfabdad1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f1bc3387-1118-6fd7-8e1b-2e59bfabdad1@gmail.com>
Message-Id: <20161214063545.GA26271@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

On Tue, Dec 13, 2016 at 09:13:26PM +1100, Balbir Singh wrote:
> 
> 
> On 10/12/16 00:32, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> > index 3919332..0a3255b 100644
> > --- a/arch/powerpc/include/asm/cpuidle.h
> > +++ b/arch/powerpc/include/asm/cpuidle.h
> > @@ -21,7 +21,7 @@
> >  
> >  /* Idle state entry routines */
> >  #ifdef	CONFIG_PPC_P7_NAP
> > -#define	IDLE_STATE_ENTER_SEQ(IDLE_INST)				\
> > +#define IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
> >  	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
> >  	std	r0,0(r1);					\
> >  	ptesync;						\
> > @@ -29,6 +29,9 @@
> >  1:	cmpd	cr0,r0,r0;					\
> >  	bne	1b;						\
> >  	IDLE_INST;						\
> > +
> 
> Is the power saving magic sequence the same as before for power 9
> as well?

Yes, this is the same magic sequence for POWER9.

--
Thanks and Regards
gautham.
