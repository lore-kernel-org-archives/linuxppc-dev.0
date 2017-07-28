Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJgFV0V01zDrLT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 17:19:09 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6S7Ilwb007583
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 03:19:07 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2byqnvbe47-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 03:19:07 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Fri, 28 Jul 2017 03:19:06 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Cyril Bur <cyrilbur@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com
Subject: Re: [PATCH V8 1/3] powernv: powercap: Add support for powercap
 framework
In-Reply-To: <1501205974.3324.1.camel@gmail.com>
References: <1501045509-21732-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1501045509-21732-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1501205974.3324.1.camel@gmail.com>
Date: Fri, 28 Jul 2017 17:18:55 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877eyt1128.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cyril Bur <cyrilbur@gmail.com> writes:
> This is more for MPE and Stewart:
> If there is some mutual exclusion that needs to happen, it should be
> done in skiboot. We've had problems in the past with double entering
> skiboot and hard to interpret errors ending up in userspace, this
> solves that but it seems more like a coverup than an actual solution.

Yeah, I'd like us to be in a position where we don't force mutual
exclusion on such things out to the OS.

The real issue this papers over is the async token stuff you're
reworking. There's that, plus for this specific thing, you *could* go
and set a differnt powercap 180 times concurrently and we should do the
right thing in skiboot... but then you're sitting in skiboot rather than
sitting in linux being able to go run some other task on the thread.

-- 
Stewart Smith
OPAL Architect, IBM.
