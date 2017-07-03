Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1SWR0DV5zDr3V
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 23:23:30 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v63DJHu2082230
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 09:23:28 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bf13vjacp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 09:23:28 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 3 Jul 2017 10:23:26 -0300
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v63DNM9d18415790
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 10:23:22 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v63DNOxP002362
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 10:23:25 -0300
References: <20170629215538.1645-2-bauerman@linux.vnet.ibm.com>
 <3x0nQH2RsPz9sNx@ozlabs.org>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [v3,
 1/8] powerpc/perf/hv-24x7: Fix passing of catalog version number
In-reply-to: <3x0nQH2RsPz9sNx@ozlabs.org>
Date: Mon, 03 Jul 2017 10:23:13 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87shidvem6.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Michael Ellerman <patch-notifications@ellerman.id.au> writes:

> On Thu, 2017-06-29 at 21:55:31 UTC, Thiago Jung Bauermann wrote:
>> H_GET_24X7_CATALOG_PAGE needs to be passed the version number obtained from
>> the first catalog page obtained previously. This is a 64 bit number, but
>> create_events_from_catalog truncates it to 32-bit.
>> 
>> This worked on POWER8, but POWER9 actually uses the upper bits so the call
>> fails with H_P3 because the hypervisor doesn't recognize the version.
>> 
>> This patch also adds the hcall return code to the error message, which is
>> helpful when debugging the problem.
>> 
>> Fixes: 5c5cd7b50259 ("powerpc/perf/hv-24x7: parse catalog and populate sysfs with events")
>> Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>
> Series applied to powerpc next, thanks.
>
> https://git.kernel.org/powerpc/c/12bf85a71000af7419b19b5e909109

Thanks!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
