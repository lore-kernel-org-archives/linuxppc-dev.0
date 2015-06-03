Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3165D1A06B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 01:36:18 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 21:06:16 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 60CEE125805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 21:08:38 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t53Fa7cx52756652
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 21:06:08 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t53Fa5hq002711
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 21:06:07 +0530
Date: Wed, 3 Jun 2015 21:05:57 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, anton@samba.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cpuidle: powernv/pseries: Decrease the snooze residency
Message-ID: <20150603153557.GA5983@dirshya.in.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
References: <1432902728-31476-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <55686DE5.6010001@linux.vnet.ibm.com>
 <20150530060141.GA19134@dirshya.in.ibm.com>
 <1433036302.4526.15.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1433036302.4526.15.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt <benh@au1.ibm.com> [2015-05-30 20:38:22]:

> On Sat, 2015-05-30 at 11:31 +0530, Vaidyanathan Srinivasan wrote:
> > In shared lpar case, spinning in guest context may potentially take
> > away cycles from other lpars waiting to run on the same physical cpu.
> > 
> > So the policy in shared lpar case is to let PowerVM hypervisor know
> > immediately that the guest cpu is idle which will allow the hypervisor
> > to use the cycles for other tasks/lpars.
> 
> But that will have negative side effects under KVM no ?

Yes, you have a good point.  If one of the thread in the core goes to
cede, it can still come back quickly since the KVM guest context is
not switched yet.  But in single threaded guest, this can force an
unnecessary exit/context switch overhead.

Now that we have fixed the snooze loop to be bounded and exit
predictably, KVM guest should actually use snooze state to improve
latency.

I will test this scenario and enable snooze state for KVM guest.
 
> Suresh mentioned something with his new directed interrupts code that we
> had many cases where the interrupts ended up arriving shortly after we
> exited to host for NAP'ing ...
> 
> Snooze might fix it...

Right.  This scenario is worth experimenting and then introduce snooze
loop for guest.

--Vaidy
