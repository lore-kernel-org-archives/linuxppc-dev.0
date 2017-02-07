Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHWLB06d5zDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 15:18:41 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v174IdeI051438
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 23:18:39 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28euphh00t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 23:18:39 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 7 Feb 2017 14:18:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 184F62BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 15:18:32 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v174IND927918482
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 15:18:31 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v174I0lR015772
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 15:18:00 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 5/5] powerpc/mm/hash: Increase VA range to 256TB
In-Reply-To: <1486440373.4850.114.camel@kernel.crashing.org>
References: <1486439333-22162-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1486439333-22162-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1486440373.4850.114.camel@kernel.crashing.org>
Date: Tue, 07 Feb 2017 09:47:41 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgtir5wa.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> That's 48 bits. I would keep the limit at 47 without some explicit
> opt-in by applications. That's what users get on x86 and we know
> some GPUs have limits there.

The idea is to have linux personality values that will limit the
effective address to different memory range. By default max effective
address will be limited to 64TB. Applications can then extend this to
128TB or 512TB. So we will have two personality values PER_LINUX_128TB
and PER_LINUX_512TB ?

-aneesh
