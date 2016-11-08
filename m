Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCZHd03nczDvYZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 14:17:32 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA83DeiO070387
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 22:17:30 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26k2j9y9nx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 22:17:30 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 22:17:29 -0500
Date: Tue, 8 Nov 2016 08:47:20 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] ppc: cpufreq: disable preemption while checking CPU
 throttling state
Reply-To: ego@linux.vnet.ibm.com
References: <1478257718-14923-1-git-send-email-kda@linux-powerpc.org>
 <87fun3n3lt.fsf@concordia.ellerman.id.au>
 <CAOJe8K1Cb_UH+yRb8_hYB3T9i8EqteS_nTgWWNcA-EtZvm-wNg@mail.gmail.com>
 <87k2celt30.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k2celt30.fsf@concordia.ellerman.id.au>
Message-Id: <20161108031720.GB24936@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Tue, Nov 08, 2016 at 11:21:23AM +1100, Michael Ellerman wrote:
> Denis Kirjanov <kda@linux-powerpc.org> writes:
> > On 11/7/16, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> Denis Kirjanov <kda@linux-powerpc.org> writes:
> >>>     [   67.700897] BUG: using smp_processor_id() in preemptible [00000000] code: cat/7343
> >>>     [   67.700988] caller is .powernv_cpufreq_throttle_check+0x2c/0x710
> >>
> >> When did this break?
> >
> > I think that problem exists since commit
> > 09a972d1620934142d30cfda455ffe429af751c4 ("cpufreq: powernv: Report
> > cpu frequency throttling") but I can be wrong
> 
> Yep that looks right to me, thanks.
> 
> Gautham, how bad is the bug here, do we want to send this to stable?

Not so bad that it needs to be sent to stable immediately.

On CONFIG_PREEMPT enabled systems, if task executing
powernv_cpufreq_throttle_check can be switched to a CPU on a different
chip, then we will end up incorrectly attributing the throttle
statistics of the new chip to the chip where it previously ran. These
throttle statistics aren't used inside the kernel for any computation,
but are reported to the user via /sysfs for them to account for any
variance during a benchmark run.

It would be good to include this in the 4.9 fixes though. 

> 
> cheers
> 
