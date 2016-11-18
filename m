Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tL1Cs1yLNzDw0M
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 01:51:37 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tL1Cr3Hx5z9t87
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2016 01:51:36 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAIEmnAp093920
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 09:51:34 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26t2p9bca3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 09:51:34 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 18 Nov 2016 09:51:32 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/13] powerpc/64: Provide functions for accessing POWER9
 partition table
In-Reply-To: <1479454122-26994-3-git-send-email-paulus@ozlabs.org>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-3-git-send-email-paulus@ozlabs.org>
Date: Fri, 18 Nov 2016 19:57:30 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tsgoobx.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:
 +
> +	/* Global flush of TLBs and partition table caches for this lpid */
> +	asm volatile("ptesync");
> +	asm volatile(PPC_TLBIE_5(%0,%1,2,0,0) : : "r"(0x800), "r" (lpid));
> +	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
> +}


It would be nice to convert that 0x800 to a documented IS value or better use
radix__flush_tlb_pid() ?

-aneesh
