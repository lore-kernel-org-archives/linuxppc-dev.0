Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3dyH5GwPzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:35:35 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DBXZ7D073880
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 07:35:21 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sw2at3qg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 07:35:21 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 05:35:20 -0600
Date: Thu, 13 Apr 2017 17:05:13 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powernv:idle: Use correct IDLE_THREAD_BITS in POWER8/9
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
 <1b89d07b1a7ea140501a86b1ed246c5af1b0ce83.1491996797.git.ego@linux.vnet.ibm.com>
 <1492065380.4624.50.camel@neuling.org>
 <87bms0aapc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87bms0aapc.fsf@concordia.ellerman.id.au>
Message-Id: <20170413113513.GA2425@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 13, 2017 at 08:00:47PM +1000, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
> 
> > On Wed, 2017-04-12 at 17:16 +0530, Gautham R. Shenoy wrote:
> >> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >> 
> >> This patch ensures that POWER8 and POWER9 processors use the correct
> >> value of IDLE_THREAD_BITS as POWER8 has 8 threads per core and hence
> >> the IDLE_THREAD_BITS should be 0xFF while POWER9 has only 4 threads
> >> per core and hence the IDLE_THREAD_BITS should be 0xF.
> >
> > Why don't we derive this from the device tree rather than hard wiring it per cpu
> > type?
> 
> Right.
> 
> In fact we already have threads_per_core which is exactly that.

Ok. I will convert IDLE_THREAD_BITS to a variable instead of a
macro so that the variable holds the value
(1 << threads_per_core) - 1.



> 
> cheers
> 
