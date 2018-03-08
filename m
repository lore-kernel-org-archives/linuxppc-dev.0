Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxXlH3dS9zDqpx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 12:20:56 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w281K6im024898
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2018 20:20:54 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gjth9hp36-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 20:20:53 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 18:20:53 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com
Subject: Re: [PATCH] powerpc/powernv/mce: Don't silently restart the machine
In-Reply-To: <20180308003606.10721-1-bsingharora@gmail.com>
References: <20180308003606.10721-1-bsingharora@gmail.com>
Date: Thu, 08 Mar 2018 12:20:48 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87ina7qs5r.fsf@linux.vnet.ibm.com>
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

This will likely change again, but I can send a patch that changes the
comment (along with the logic of decoding it all and having enough
information to make sensible decisions). But... I kind of don't want to
bikeshed a comment to death :)

I reckon the panic() here is the right thing to do no matter
what.

Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>

-- 
Stewart Smith
OPAL Architect, IBM.
