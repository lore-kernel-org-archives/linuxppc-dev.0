Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B8DC169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 15:09:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9F520844
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 15:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9F520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pqdz5cl6zDqS3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 02:09:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pqcC3cVqzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 02:07:39 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0TEnwnI074141
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 10:07:37 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qaqtm5gt6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 10:07:36 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 29 Jan 2019 15:07:35 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 29 Jan 2019 15:07:32 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0TF7V4k18088024
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Jan 2019 15:07:31 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE06D112062;
 Tue, 29 Jan 2019 15:07:31 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0AD2112061;
 Tue, 29 Jan 2019 15:07:29 +0000 (GMT)
Received: from [9.85.73.55] (unknown [9.85.73.55])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 29 Jan 2019 15:07:29 +0000 (GMT)
Subject: Re: [PATCH] powerpc/mm: Add _PAGE_SAO to _PAGE_CACHE_CTL mask
To: Reza Arbab <arbab@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1548696702-20686-1-git-send-email-arbab@linux.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 29 Jan 2019 20:37:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548696702-20686-1-git-send-email-arbab@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012915-0040-0000-0000-000004B922D4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010499; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153499; UDB=6.00593882; IPR=6.00933865; 
 MB=3.00025338; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-29 15:07:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012915-0041-0000-0000-000008C43767
Message-Id: <cd1b7bf3-3c35-09bb-e979-d779b9cf7a18@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-29_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290112
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
Cc: Charles Johns <crjohns@us.ibm.com>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/28/19 11:01 PM, Reza Arbab wrote:
> In htab_convert_pte_flags(), _PAGE_CACHE_CTL is used to check for the
> _PAGE_SAO flag:
> 
>    else if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_SAO)
>            rflags |= (HPTE_R_W | HPTE_R_I | HPTE_R_M);
> 
> But, it isn't defined to include that flag:
> 
>    #define _PAGE_CACHE_CTL (_PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
> 
> This happens to work, but only because of the flag values:
> 
>    #define _PAGE_SAO               0x00010 /* Strong access order */
>    #define _PAGE_NON_IDEMPOTENT    0x00020 /* non idempotent memory */
>    #define _PAGE_TOLERANT          0x00030 /* tolerant memory, cache inhibited */
> 
> To prevent any issues if these particulars ever change, add _PAGE_SAO to
> the mask.
> 

Not sure what the fix is about. We set the related hash pte flags via

	if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_TOLERANT)
		rflags |= HPTE_R_I;
	else if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_NON_IDEMPOTENT)
		rflags |= (HPTE_R_I | HPTE_R_G);
	else if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_SAO)
		rflags |= (HPTE_R_W | HPTE_R_I | HPTE_R_M);
	else
		/*
		 * Add memory coherence if cache inhibited is not set
		 */
		rflags |= HPTE_R_M;




> Suggested-by: Charles Johns <crjohns@us.ibm.com>
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 2e6ada2..1d97a28 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -811,7 +811,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>   	return hash__set_pte_at(mm, addr, ptep, pte, percpu);
>   }
>   
> -#define _PAGE_CACHE_CTL	(_PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
> +#define _PAGE_CACHE_CTL	(_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
>   
>   #define pgprot_noncached pgprot_noncached
>   static inline pgprot_t pgprot_noncached(pgprot_t prot)
> 

