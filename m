Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPvrH41YCzDskQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 03:02:39 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58GxTXl029298
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 13:02:37 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m3x4hv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 13:02:37 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 9 Jun 2016 03:02:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C82F23578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 03:02:11 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151] (may be
 forged))
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u58H26er917842
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jun 2016 03:02:06 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u58H1Wu8000874
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jun 2016 03:01:32 +1000
Date: Wed, 08 Jun 2016 22:31:20 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@au1.ibm.com, mpe@ellerman.id.au
CC: ego@linux.vnet.ibm.com, mikey@neuling.org, maddy@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 08/11] powerpc/powernv: Add platform support for stop
 instruction
References: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464871141-11568-9-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465165718.4274.20.camel@au1.ibm.com>
In-Reply-To: <1465165718.4274.20.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <57584F60.7010504@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Sorry for the delayed response.

On 06/06/2016 03:58 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2016-06-02 at 07:38 -0500, Shreyas B. Prabhu wrote:
>> @@ -61,8 +72,13 @@ save_sprs_to_stack:
>>          * Note all register i.e per-core, per-subcore or per-thread is saved
>>          * here since any thread in the core might wake up first
>>          */
>> +BEGIN_FTR_SECTION
>> +       mfspr   r3,SPRN_PTCR
>> +       std     r3,_PTCR(r1)
>> +FTR_SECTION_ELSE
>>         mfspr   r3,SPRN_SDR1
>>         std     r3,_SDR1(r1)
>> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
> 
> This is the only new SPR we care about in P9 ?
> 
After reviewing ISA again, I've identified LMRR, LMSER and ASDR also
need to be restored. I've fixed this in v6.

Thanks,
Shreyas
