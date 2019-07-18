Return-Path: <SRS0=Nz1t=VP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3055EC7618F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 21:27:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B99208C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 21:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B99208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45qRzk02sCzDqDy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 07:27:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45qRxV5lVMzDqgB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2019 07:25:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 45qRxT6ClRz8vpL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2019 07:25:17 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 45qRxT5C0pz9sDQ; Fri, 19 Jul 2019 07:25:17 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=cclaudio@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45qRxT1fmnz9s3l
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Jul 2019 07:25:16 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6ILLwqD130878
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jul 2019 17:25:13 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ttw9s7x19-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jul 2019 17:25:13 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cclaudio@linux.ibm.com>;
 Thu, 18 Jul 2019 22:25:12 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 18 Jul 2019 22:25:09 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6ILP7GC57672144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2019 21:25:07 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 980A7BE04F;
 Thu, 18 Jul 2019 21:25:07 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9DAEBE051;
 Thu, 18 Jul 2019 21:25:04 +0000 (GMT)
Received: from [9.18.235.170] (unknown [9.18.235.170])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jul 2019 21:25:04 +0000 (GMT)
Subject: Re: [PATCH v4 4/8] KVM: PPC: Ultravisor: Use UV_WRITE_PATE ucall to
 register a PATE
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20190628200825.31049-1-cclaudio@linux.ibm.com>
 <20190628200825.31049-5-cclaudio@linux.ibm.com>
 <87ims8g24r.fsf@concordia.ellerman.id.au>
From: Claudio Carvalho <cclaudio@linux.ibm.com>
Date: Thu, 18 Jul 2019 18:25:03 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <87ims8g24r.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19071821-8235-0000-0000-00000EBB3CCE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011454; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01234095; UDB=6.00650321; IPR=6.01015423; 
 MB=3.00027786; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-18 21:25:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071821-8236-0000-0000-00004674B8FB
Message-Id: <6688060f-3744-cae5-635e-f1ee3ff48c19@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-18_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180218
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 Ryan Grimm <grimm@linux.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Bauermann <bauerman@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 7/11/19 9:57 AM, Michael Ellerman wrote:
>
>>  
>>  static pmd_t *get_pmd_from_cache(struct mm_struct *mm)
>> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
>> index 8904aa1243d8..da6a6b76a040 100644
>> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
>> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
>> @@ -656,8 +656,10 @@ void radix__early_init_mmu_secondary(void)
>>  		lpcr = mfspr(SPRN_LPCR);
>>  		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
>>  
>> -		mtspr(SPRN_PTCR,
>> -		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
>> +		if (!firmware_has_feature(FW_FEATURE_ULTRAVISOR))
>> +			mtspr(SPRN_PTCR, __pa(partition_tb) |
>> +			      (PATB_SIZE_SHIFT - 12));
>> +
>>  		radix_init_amor();
>>  	}
>>  
>> @@ -673,7 +675,8 @@ void radix__mmu_cleanup_all(void)
>>  	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
>>  		lpcr = mfspr(SPRN_LPCR);
>>  		mtspr(SPRN_LPCR, lpcr & ~LPCR_UPRT);
>> -		mtspr(SPRN_PTCR, 0);
>> +		if (!firmware_has_feature(FW_FEATURE_ULTRAVISOR))
>> +			mtspr(SPRN_PTCR, 0);
>>  		powernv_set_nmmu_ptcr(0);
>>  		radix__flush_tlb_all();
>>  	}
> There's four of these case where we skip touching the PTCR, which is
> right on the borderline of warranting an accessor. I guess we can do it
> as a cleanup later.

I agree.

Since the kernel doesn't need to access a big number of ultravisor
privileged registers, maybe we can define mtspr_<reg> and mfspr_<reg>
inline functions that in ultravisor.h that skip touching the register if an
ultravisor is present and and the register is ultravisor privileged. Thus,
we don't need to replicate comments and that also would make it easier for
developers to know what are the ultravisor privileged registers.

Something like this:

--- a/arch/powerpc/include/asm/ultravisor.h
+++ b/arch/powerpc/include/asm/ultravisor.h
@@ -10,10 +10,21 @@
 
 #include <asm/ultravisor-api.h>
 #include <asm/asm-prototypes.h>
+#include <asm/reg.h>
 
 int early_init_dt_scan_ultravisor(unsigned long node, const char *uname,
                                  int depth, void *data);
 
+static inline void mtspr_ptcr(unsigned long val)
+{
+       /*
+        * If the ultravisor firmware is present, it maintains the partition
+        * table. PTCR becomes ultravisor privileged only for writing.
+        */
+       if (!firmware_has_feature(FW_FEATURE_ULTRAVISOR))
+               mtspr(SPRN_PTCR, val);
+}
+
 static inline int uv_register_pate(u64 lpid, u64 dw0, u64 dw1)
 {
        return ucall_norets(UV_WRITE_PATE, lpid, dw0, dw1);
diff --git a/arch/powerpc/mm/book3s64/pgtable.c
b/arch/powerpc/mm/book3s64/pgtable.c
index e1bbc48e730f..25156f9dfde8 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -220,7 +220,7 @@ void __init mmu_partition_table_init(void)
         * 64 K size.
         */
        ptcr = __pa(partition_tb) | (PATB_SIZE_SHIFT - 12);
-       mtspr(SPRN_PTCR, ptcr);
+       mtspr_ptcr(ptcr);
        powernv_set_nmmu_ptcr(ptcr);
 }

What do you think?
An alternative could be to change the mtspr() and mfspr() macros as we
proposed in the v1, but access to non-ultravisor privileged registers would
be performance impacted because we always would need to check if the
register is one of the few ultravisor registers that the kernel needs to
access.

Thanks,
Claudio


> cheers
>

