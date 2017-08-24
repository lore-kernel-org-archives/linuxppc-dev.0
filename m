Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdPjS6KVfzDqXw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 23:07:56 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7OD4etH061286
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 09:07:54 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chvsm8qsd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 09:07:53 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 23:07:51 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7OD7m0c38994008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 23:07:48 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7OD7e2W015173
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 23:07:40 +1000
Date: Thu, 24 Aug 2017 18:37:42 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/powernv/idle: Round up latency and residency
 values
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170823185841.25286-1-svaidy@linux.vnet.ibm.com>
 <877extw98c.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <877extw98c.fsf@concordia.ellerman.id.au>
Message-Id: <20170824130742.GA29369@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2017-08-24 20:28:19]:

> Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> writes:
> 
> > On PowerNV platforms, firmware provides exit latency and
> > target residency for each of the idle states in nano
> > seconds.  Cpuidle framework expects the values in micro
> > seconds.  Round up to nearest micro seconds to avoid errors
> > in cases where the values are defined as fractional micro
> > seconds.
> >
> > Default idle state of 'snooze' has exit latency of zero.  If
> > other states have fractional micro second exit latency, they
> > would get rounded down to zero micro second and make cpuidle
> > framework choose deeper idle state when snooze loop is the
> > right choice.
> >
> > Reported-by: Anton Blanchard <anton@samba.org>
> > Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> 
> This sounds like a fairly bad bug, does it need a Fixes / Cc stable tag?

Yes, we will need this on stable kernel that runs on POWER9.  On older
platforms the latencies are larger and hence no impact :)

I will post to stable after this fix hits your -next tree.

--Vaidy
