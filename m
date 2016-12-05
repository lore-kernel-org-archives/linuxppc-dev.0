Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXJWL5KxzzDvQd
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 19:55:42 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tXJWL1fWlz9t0v
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Dec 2016 19:55:41 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB58rbhZ139388
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Dec 2016 03:55:39 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 275352nsbn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 05 Dec 2016 03:55:39 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 5 Dec 2016 18:55:37 +1000
Subject: Re: [PATCH RFC 3/3] powerpc/64: Enable use of radix MMU under
 hypervisor on POWER9
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
Date: Mon, 05 Dec 2016 19:55:32 +1100
In-Reply-To: <20161205080435.GC13528@fergus.ozlabs.ibm.com>
References: <20161205080219.GA13528@fergus.ozlabs.ibm.com>
 <20161205080435.GC13528@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1480928132.5297.0.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-12-05 at 19:04 +1100, Paul Mackerras wrote:
> +       vec5 = of_get_flat_dt_prop(chosen, "ibm,architecture-vec-5", &size);
> +       if (!vec5 || size <= OV5_INDX(OV5_MMU_RADIX_300))
> +               return;

Could be bike shedding but shouldn't we first check if
we are in an LPAR and bail out of we are not, then
if we *are* and the above size is too small to contain
the ARCH 3.00 options, also disable radix as obviously
the hypervisor doesn't know about it ?

> +       if (!(vec5[OV5_INDX(OV5_MMU_RADIX_300)] & OV5_FEAT(OV5_MMU_RADIX_300)))
> +               /* Hypervisor doesn't support radix */
> +               cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
> +}
> +
