Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnYfV653wzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 14:33:22 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5E4SYGS063778
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 00:33:20 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b2stx8rke-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 00:33:19 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 13 Jun 2017 22:33:19 -0600
Date: Tue, 13 Jun 2017 21:33:15 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/8] Support for 24x7 hcall interface version 2
References: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <20170614043315.GA3644@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thiago Jung Bauermann [bauerman@linux.vnet.ibm.com] wrote:
> Hello,
> 
> The hypervisor interface to access 24x7 performance counters (which collect
> performance information from system power on to system power off) has been
> extended in POWER9 adding new fields to the request and result element
> structures.
> 
> Also, results for some domains now return more than one result element and
> those need to be added to get a total count.
> 
> The first two patches fix bugs in the existing code. The following 4
> patches are code improvements and the last two finally implement support
> for the changes in POWER9 described above.
> 
> POWER8 systems only support version 1 of the interface, while POWER9
> systems only support version 2. I tested these patches on POWER8 to verify
> that there are no regressions, and also on POWER9 DD1.
> 
> Thiago Jung Bauermann (8):
>   powerpc/perf/hv-24x7: Fix passing of catalog version number
>   powerpc/perf/hv-24x7: Fix off-by-one error in request_buffer check
>   powerpc/perf/hv-24x7: Properly iterate through results
>   powerpc-perf/hx-24x7: Don't log failed hcall twice
>   powerpc/perf/hv-24x7: Fix return value of hcalls
>   powerpc/perf/hv-24x7: Minor improvements
>   powerpc/perf/hv-24x7: Support v2 of the hypervisor API
>   powerpc/perf/hv-24x7: Aggregate result elements on POWER9 SMT8
> 
>  arch/powerpc/perf/hv-24x7.c            | 255 +++++++++++++++++++++++++--------
>  arch/powerpc/perf/hv-24x7.h            |  70 +++++++--
>  arch/powerpc/platforms/pseries/Kconfig |   2 +-
>  3 files changed, 255 insertions(+), 72 deletions(-)

Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> -- 
> 2.7.4
