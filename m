Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3Mlt3g5QzDqfS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 13:54:49 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u723s1fJ056856
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 23:54:47 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24gre1x2d2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 23:54:46 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 13:54:44 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ED2612CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 13:54:40 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u723seBU28835914
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 13:54:40 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u723serI006068
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 13:54:40 +1000
Date: Tue, 2 Aug 2016 13:54:39 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, benh@kernel.crashing.org, ruscur@russell.cc
Subject: Re: [PATCH] powerpc/powernv: Fix BE PE number to
 opal_pci_eeh_freeze_clear()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1470034990-18860-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <87k2g0oj8t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k2g0oj8t.fsf@concordia.ellerman.id.au>
Message-Id: <20160802035439.GA6568@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 01, 2016 at 08:50:58PM +1000, Michael Ellerman wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> The PE number (@frozen_pe_no), filled by opal_pci_next_error() is
>> in big-endian format. Frozen PE number in CPU-endian should be passed
>> to opal_pci_eeh_freeze_clear() when clearing the frozen state if the
>> PE is invalid one.
>>
>> This passes CPU-endian PE number to opal_pci_eeh_freeze_clear() and
>> it should be part of commit <0f36db77643b> ("powerpc/eeh: Fix wrong
>> printed PE number").
>
>Which commit added the broken usage?
>
>Looks like 2a485ad7c88d ("powerpc/powernv: Drop PHB operation
>next_error()") ?
>
>> Cc: stable@vger.kernel.org # v4.3+
>> Suggested-by: Paul Mackerras <paulus@samba.org>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>> index 86544ea..75363d9 100644
>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>> @@ -1538,7 +1538,7 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
>>  
>>  				/* Try best to clear it */
>>  				opal_pci_eeh_freeze_clear(phb->opal_id,
>> -					frozen_pe_no,
>> +					be64_to_cpu(frozen_pe_no),
>
>Sparse knew about this:
>
>  arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41: warning: incorrect type in argument 2 (different base types)
>  arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41:    expected unsigned long long [unsigned] [usertype] pe_number
>  arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41:    got restricted __be64 [addressable] [usertype] frozen_pe_no
>
>And finds some other problems in that file:
>
>  arch/powerpc/platforms/powernv/eeh-powernv.c:875:23: warning: constant 0x8000000000000000 is so big it is unsigned long
>  arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: warning: restricted __be16 degrades to integer
>

Michael, please ignore this one. A updated version will be included in the
series fixing the warning reported from sparse on PowerNV PCI related files.
I will post the series shortly.

Thanks,
Gavin

>cheers
>
