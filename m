Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS6fz1fCzzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 15:18:03 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS6fy4Zdjz9s1h
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 15:18:02 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L4EOEH104765
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 23:18:00 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r62yrdbf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 23:18:00 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 09:47:56 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3DB6CE0024
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:49:32 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L4Hsvt12582938
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:47:54 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L4HrQJ020458
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 09:47:54 +0530
Subject: Re: [RFC PATCH 5/7] powerpc/book3s: Don't turn on the MSR[ME] bit
 until opal processes the reason.
To: Nicholas Piggin <npiggin@gmail.com>
References: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
 <148764197591.19289.17096730042146758117.stgit@jupiter.in.ibm.com>
 <20170221124728.675af9f9@roar.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 09:47:53 +0530
MIME-Version: 1.0
In-Reply-To: <20170221124728.675af9f9@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <c3a85fbf-29e8-e20d-dc68-6c1f1413d063@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2017 08:17 AM, Nicholas Piggin wrote:
> On Tue, 21 Feb 2017 07:22:56 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> Delay it until we are done with machine_check_early() call. Turn on MSR[ME]
>> once opal is done with processing MCE.
> 
> Why? This seems like quite a regression -- the MCE handler today
> has about 60 instructions and 30 l/st with ME clear.

I understand that this is bit long window. But we are in MCE handling
code and if we hit MCE while doing that we may anyway end up with
recursive MCE interrupts without really be able to recover from it.
Instead lets risk checkstop which would get us rebooted with hostboot
throwing proper error call out.

-Mahesh.
