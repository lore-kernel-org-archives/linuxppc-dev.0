Return-Path: <benh@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 500A01A3304
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:40:51 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Sun, 31 May 2015 11:40:49 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E7C17357804F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:40:46 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4V1dNQ6196960
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:39:32 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4V1cxNF014941
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:38:59 +1000
Message-ID: <1433036302.4526.15.camel@au1.ibm.com>
Subject: Re: [PATCH] cpuidle: powernv/pseries: Decrease the snooze residency
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: svaidy@linux.vnet.ibm.com
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, anton@samba.org, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Sat, 30 May 2015 20:38:22 -0500
In-Reply-To: <20150530060141.GA19134@dirshya.in.ibm.com>
References: <1432902728-31476-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <55686DE5.6010001@linux.vnet.ibm.com>
 <20150530060141.GA19134@dirshya.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-05-30 at 11:31 +0530, Vaidyanathan Srinivasan wrote:
> In shared lpar case, spinning in guest context may potentially take
> away cycles from other lpars waiting to run on the same physical cpu.
> 
> So the policy in shared lpar case is to let PowerVM hypervisor know
> immediately that the guest cpu is idle which will allow the hypervisor
> to use the cycles for other tasks/lpars.

But that will have negative side effects under KVM no ?

Suresh mentioned something with his new directed interrupts code that we
had many cases where the interrupts ended up arriving shortly after we
exited to host for NAP'ing ...

Snooze might fix it...

Ben.
