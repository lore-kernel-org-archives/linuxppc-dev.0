Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYSNk4lWjzDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 07:54:14 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v21KsB28013675
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 15:54:11 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28wxr8n6qg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 15:54:11 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Wed, 1 Mar 2017 13:54:03 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 3FC6419D8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 13:53:11 -0700 (MST)
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v21Ks0V811272696
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 13:54:00 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05FDD6E03F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 13:54:00 -0700 (MST)
Received: from oc1087654862.ibm.com (unknown [9.85.163.123])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id B26986E038
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 13:53:59 -0700 (MST)
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH v2] powerpc: A new cache geometry aux vectors
References: <1486016558.4850.30.camel@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
From: Paul Clarke <pc@us.ibm.com>
Date: Wed, 1 Mar 2017 14:53:58 -0600
MIME-Version: 1.0
In-Reply-To: <1486016558.4850.30.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <67e56596-05a7-5f3d-8125-a4e0194f1b7c@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/2017 12:22 AM, Benjamin Herrenschmidt wrote:
> This adds AUX vectors for the L1I,D, L2 and L3 cache levels
> providing for each cache level the size of the cache in bytes
> and the geometry (line size and number of ways).
>
> We chose to not use the existing alpha/sh definition which
> packs all the information in a single entry per cache level as
> it is too restricted to represent some of the geometries used
> on POWER.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> v2. Remove some leftovers and fix 32-bit build
>
> Paul, can you test & ack this please ? It replaces the last patch of
> my previous series (the rest is identical).

Sorry for the delay on this, I totally missed this e-mail until this week.

I tested this with the Power Functional Simulator (a.k.a. Mambo), with a fairly recent 4.9 kernel from the powerpc git tree.

Using Mambo-P8, I see what I expect for cache line size, but associativity is 0:
AT_L1I_CACHESIZE: 32768 (0x8000)
AT_L1I_CACHEGEOMETRY: associativity 0; line size 128
AT_L1D_CACHESIZE: 32768 (0x8000)
AT_L1D_CACHEGEOMETRY: associativity 0; line size 128
AT_L2_CACHESIZE: 524288 (0x80000)
AT_L2_CACHEGEOMETRY: associativity 0; line size 128
AT_L3_CACHESIZE: 8388608 (0x800000)
AT_L3_CACHEGEOMETRY: associativity 0; line size 128

...shouldn't associativity be 8 for all levels?

Using Mambo-P9, I don't get any cache sizes, and only L1 geometries, and no associativity:
AT_L1I_CACHEGEOMETRY: associativity 0; line size 128
AT_L1D_CACHEGEOMETRY: associativity 0; line size 128

PC
