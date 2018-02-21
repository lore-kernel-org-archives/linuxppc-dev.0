Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmQBZ32cvzF0lW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 15:54:30 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1L4sRRf066999
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 23:54:28 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g901yudu4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 23:54:26 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 20 Feb 2018 21:54:25 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com
Subject: Re: [RFC] powerpc/powernv/mce: Don't silently restart the machine
In-Reply-To: <20180221010111.30517-1-bsingharora@gmail.com>
References: <20180221010111.30517-1-bsingharora@gmail.com>
Date: Wed, 21 Feb 2018 15:54:20 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vaeruemb.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:
> On MCE the current code will restart the machine with
> ppc_md.restart(). This case was extremely unlikely since
> prior to that a skiboot call is made and that resulted in
> a checkstop for analysis.
>
> With newer skiboots, on P9 we don't checkstop the box by
> default, instead we return back to the kernel to extract
> useful information at the time of the MCE. While we still
> get this information, this patch converts the restart to
> a panic(), so that if configured a dump can be taken and
> we can track and probably debug the potential issue causing
> the MCE.

I agree with the patch, although I'd be nervous stating that skiboot is
going to keep this behaviour. In *theory* we should only ever get a
platform error when there's actually something that isn't the kernel's
fault.

Like any firmware promise though, it's slightly less reliable than one
from a politician.

I'd say that in this case deferring to policy on what to do in event of
panic() is the right thing.

-- 
Stewart Smith
OPAL Architect, IBM.
