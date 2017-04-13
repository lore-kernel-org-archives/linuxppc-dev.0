Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3bs03XCczDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 20:00:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powernv:idle: Use correct IDLE_THREAD_BITS in POWER8/9
In-Reply-To: <1492065380.4624.50.camel@neuling.org>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
 <1b89d07b1a7ea140501a86b1ed246c5af1b0ce83.1491996797.git.ego@linux.vnet.ibm.com>
 <1492065380.4624.50.camel@neuling.org>
Date: Thu, 13 Apr 2017 20:00:47 +1000
Message-ID: <87bms0aapc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> On Wed, 2017-04-12 at 17:16 +0530, Gautham R. Shenoy wrote:
>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> 
>> This patch ensures that POWER8 and POWER9 processors use the correct
>> value of IDLE_THREAD_BITS as POWER8 has 8 threads per core and hence
>> the IDLE_THREAD_BITS should be 0xFF while POWER9 has only 4 threads
>> per core and hence the IDLE_THREAD_BITS should be 0xF.
>
> Why don't we derive this from the device tree rather than hard wiring it per cpu
> type?

Right.

In fact we already have threads_per_core which is exactly that.

cheers
