Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x83Zc0V8ZzDqg2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 17:04:07 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6E6xMlK096597
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 03:04:04 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bpdvhxt9h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 03:04:04 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 14 Jul 2017 17:04:01 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6E73xmm27263050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 17:03:59 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6E73x7w023015
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 17:03:59 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com
Subject: Re: [PATCH 1/4] powerpc/mm/radix: Don't iterate all sets when
 flushing the PWC
In-Reply-To: <1500013316.2865.72.camel@kernel.crashing.org>
References: <20170714015258.7933-1-benh@kernel.crashing.org>
 <87379zr2wt.fsf@skywalker.in.ibm.com>
 <1500013316.2865.72.camel@kernel.crashing.org>
Date: Fri, 14 Jul 2017 12:33:57 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87shhzpkiq.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2017-07-14 at 11:11 +0530, Aneesh Kumar K.V wrote:
>> With the current code, we use tlbiel_pwc() for doing a pwc flush.
>> and that does what is done this patch. May be we can update this patch
>> such that we drop tlbiel_pwc and switch all those instance to
>> tlbiel_pid(pid, RIC_FLUSH_PWC) ?
>> 
>> You already do this in a later patch.
>
> Right, I do it in a later latch and I prefer to keep it this way, to
> avoid doing too many changes in a single patch.

The commit message do indicate that we don't do flushing correctly for
PWC flush with the current code. That is not correct. May be update the
commit message then ?

-aneesh
