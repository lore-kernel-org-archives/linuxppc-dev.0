Return-Path: <srs0=o+9r=7q=au1.ibm.com=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWGhQ4LgSzDqYN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:30:46 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xWGhQ3wvSz8t59
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:30:46 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xWGhQ08Tgz9t2y
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2017 23:30:45 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7EDTEQu047407
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2017 09:30:43 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cb3qg7n2c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2017 09:30:43 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 14 Aug 2017 23:30:40 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7EDUcRu41287822
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2017 23:30:38 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7EDUbQC016248
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2017 23:30:38 +1000
Subject: Re: [PATCH v6 14/17] powerpc: Add support for setting SPRN_TIDR
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Neuling <mikey@neuling.org>, Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, apopple@au1.ibm.com, oohall@gmail.com
Date: Mon, 14 Aug 2017 23:30:35 +1000
In-Reply-To: <1502694131.9844.7.camel@neuling.org>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-15-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502694131.9844.7.camel@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1502717435.4493.29.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-14 at 17:02 +1000, Michael Neuling wrote:
> > +/*
> > + * We need to assign an unique thread id to each thread in a process. This
> > + * thread id is intended to be used with the Fast Thread-wakeup (aka Core-
> > + * to-core wakeup) mechanism being implemented on top of Virtual Accelerator
> > + * Switchboard (VAS).
> > + *
> > + * To get a unique thread-id per process we could simply use task_pid_nr()
> > + * but the problem is that task_pid_nr() is not yet available for the thread
> > + * when copy_thread() is called. Fixing that would require changing more
> > + * intrusive arch-neutral code in code path in copy_process()?.
> > + *
> > + * Further, to assign unique thread ids within each process, we need an
> > + * atomic field (or an IDR) in task_struct, which again intrudes into the
> > + * arch-neutral code.
> 
> Really?
> 
> > + * So try to assign globally unique thraed ids for now.
> 
> Yuck!

Also CAPI has size limits for the TIDR afaik

Ben.
