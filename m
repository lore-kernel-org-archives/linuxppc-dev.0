Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A6801A0770
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 18:00:33 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sat, 30 May 2015 04:00:30 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 0750AC90042
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 03:51:35 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4U80RWo60031104
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 08:00:27 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4U80Ro2016637
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 04:00:27 -0400
Message-ID: <55696E17.2030700@linux.vnet.ibm.com>
Date: Sat, 30 May 2015 13:30:23 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: svaidy@linux.vnet.ibm.com
CC: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, anton@samba.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle: powernv/pseries: Decrease the snooze residency
References: <1432902728-31476-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <55686DE5.6010001@linux.vnet.ibm.com>
 <20150530060141.GA19134@dirshya.in.ibm.com>
In-Reply-To: <20150530060141.GA19134@dirshya.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/30/2015 11:31 AM, Vaidyanathan Srinivasan wrote:
> * Preeti U Murthy <preeti@linux.vnet.ibm.com> [2015-05-29 19:17:17]:
> 
> [snip]
> 
>>> +	if (max_idle_state > 1) {
>>> +		snooze_timeout_en = true;
>>> +		snooze_timeout = cpuidle_state_table[1].target_residency *
>>> +				 tb_ticks_per_usec;
>>> +	}
>>
>> Any idea why we don't have snooze defined on the shared lpar configuration ?
> 
> In shared lpar case, spinning in guest context may potentially take
> away cycles from other lpars waiting to run on the same physical cpu.
> 
> So the policy in shared lpar case is to let PowerVM hypervisor know
> immediately that the guest cpu is idle which will allow the hypervisor
> to use the cycles for other tasks/lpars.
> 

Oh Ok! Thanks for the clarification !

Regards
Preeti U Murthy
> --Vaidy
> 
