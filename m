Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33D742C00A6
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Dec 2013 19:22:01 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 13 Dec 2013 13:51:57 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DC12E394004E
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Dec 2013 13:51:52 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBD8LiGe5636358
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Dec 2013 13:51:45 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBD8LkDO014742
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Dec 2013 13:51:47 +0530
Message-ID: <52AAC356.1000308@linux.vnet.ibm.com>
Date: Fri, 13 Dec 2013 13:50:38 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V4 09/10] power8,
 perf: Change BHRB branch filter configuration
References: <20131209062147.51F822C00C5@ozlabs.org>
In-Reply-To: <20131209062147.51F822C00C5@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org, acme@ghostprotocols.net,
 sukadev@linux.vnet.ibm.com, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/2013 11:51 AM, Michael Ellerman wrote:
> 
> As I said in my comments on version 3 which you ignored:
> 
>     I think it would be clearer if we actually checked for the possibilities we
>     allow and let everything else fall through, eg:
> 
> Â Â Â Â Â Â Â Â /* Ignore user/kernel/hv bits */
> Â Â Â Â Â Â Â Â branch_sample_type &= ~PERF_SAMPLE_BRANCH_PLM_ALL;
> 
> Â Â Â Â Â Â Â Â if (branch_sample_type == PERF_SAMPLE_BRANCH_ANY)
> Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â return 0;
> 
> Â Â Â Â Â Â Â Â if (branch_sample_type == PERF_SAMPLE_BRANCH_ANY_CALL)
> Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â return POWER8_MMCRA_IFM1;
> Â 
> Â Â Â Â Â Â Â Â if (branch_sample_type == PERF_SAMPLE_BRANCH_COND)
> Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â return POWER8_MMCRA_IFM3;
> Â Â Â Â Â Â Â Â 
> Â Â Â Â Â Â Â Â return -1;
> 

Hey Michael,

This patch only adds support for the PERF_SAMPLE_BRANCH_COND filter, if the
over all code flow does not clearly suggest that all combinations of any of
these HW filters are invalid, then we can go with one more patch to clean
that up before or after this patch but not here in this patch. Finally the
code section here will look something like this. Does it sound good ?

static u64 power8_bhrb_filter_map(u64 branch_sample_type)
{
        u64 pmu_bhrb_filter = 0;

        /* BHRB and regular PMU events share the same privilege state
         * filter configuration. BHRB is always recorded along with a
         * regular PMU event. As the privilege state filter is handled
         * in the basic PMC configuration of the accompanying regular
         * PMU event, we ignore any separate BHRB specific request.
         */

        /* Ignore user, kernel, hv bits */
        branch_sample_type &= ~PERF_SAMPLE_BRANCH_PLM_ALL;

        if (branch_sample_type == PERF_SAMPLE_BRANCH_ANY)
                return pmu_bhrb_filter;


        if (branch_sample_type == PERF_SAMPLE_BRANCH_ANY_CALL) {
                pmu_bhrb_filter |= POWER8_MMCRA_IFM1;
                return pmu_bhrb_filter;
        }

        if (branch_sample_type == PERF_SAMPLE_BRANCH_COND) {
                pmu_bhrb_filter |= POWER8_MMCRA_IFM3;
                return pmu_bhrb_filter;
        }

        /* Every thing else is unsupported */
        return -1;
}
