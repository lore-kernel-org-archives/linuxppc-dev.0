Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tb4nR4nm0zDw8C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 08:17:31 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB9LEtVK039845
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2016 16:17:28 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 277ymhwq09-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Dec 2016 16:17:28 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Sat, 10 Dec 2016 07:17:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A26A92BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 08:17:22 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB9LHMEo5177706
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 08:17:22 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB9LHMkX017907
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 08:17:22 +1100
Subject: Re: [PATCH] powerpc/64: pseudo-NMI/SMP watchdog
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Sat, 10 Dec 2016 08:17:20 +1100
In-Reply-To: <20161209155252.31381-1-npiggin@gmail.com>
References: <20161209155252.31381-1-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1481318240.17253.25.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-12-10 at 01:52 +1000, Nicholas Piggin wrote:
> This does not solve the hardlockup problem completely however,
> because
> interrupts can often become hard disabled when soft disabled for long
> periods. And they can be hard disabled for other reasons.
> 
> To make up for the lack of a periodic true NMI, this also has an SMP
> hard lockup detector where all CPUs can observe lockups on others.
> 
> This still needs a bit more polishing, testing, comments, config
> options, and boot parameters, etc., so it's RFC quality only.

Paulus and I discussed a plan with Balbir to also limit the cases of
hard-disable.

They typically happen as a result of an external interrupt. We could
on P8 and earlier, just fetch the interrupt from the XICS in the
"masked" path and stash it in the PACA. We already have a way to
stash an interrupt there for later processing because KVM sometimes
does it.

That would cause the XICS to elevate the priority effectively masking
subsequent interrupts. We'd have to change the XICS code to use the
same priority for IPIs and externals too though.

For XIVE (P9), we can just poke at the CPU priority register in the TM
area to mask at the PIC level in that case and unmask later.

Cheers,
Ben.
