Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA3AD1A0770
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 16:02:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Sat, 30 May 2015 16:02:40 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8C7952BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 16:02:36 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4U62RoI38862864
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 16:02:35 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4U62340008737
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 16:02:04 +1000
Date: Sat, 30 May 2015 11:31:41 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, anton@samba.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle: powernv/pseries: Decrease the snooze residency
Message-ID: <20150530060141.GA19134@dirshya.in.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
References: <1432902728-31476-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <55686DE5.6010001@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <55686DE5.6010001@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Preeti U Murthy <preeti@linux.vnet.ibm.com> [2015-05-29 19:17:17]:

[snip]

> > +	if (max_idle_state > 1) {
> > +		snooze_timeout_en = true;
> > +		snooze_timeout = cpuidle_state_table[1].target_residency *
> > +				 tb_ticks_per_usec;
> > +	}
> 
> Any idea why we don't have snooze defined on the shared lpar configuration ?

In shared lpar case, spinning in guest context may potentially take
away cycles from other lpars waiting to run on the same physical cpu.

So the policy in shared lpar case is to let PowerVM hypervisor know
immediately that the guest cpu is idle which will allow the hypervisor
to use the cycles for other tasks/lpars.

--Vaidy
