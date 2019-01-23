Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C0C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 09:04:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BC420861
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 09:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BC420861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kzqq0cf2zDqMb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 20:04:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kzp23R8MzDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 20:02:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43kzp22JD6z8t7p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 20:02:50 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43kzp21xVhz9s9h; Wed, 23 Jan 2019 20:02:50 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43kzp15GZHz9s9G
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 20:02:49 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0N8x0KD085600
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 04:02:48 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q6mktsmsm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 04:02:48 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 23 Jan 2019 09:02:45 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 23 Jan 2019 09:02:42 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0N92fWb28573838
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Jan 2019 09:02:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7EE411C06E;
 Wed, 23 Jan 2019 09:02:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8838911C050;
 Wed, 23 Jan 2019 09:02:40 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.69.250])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 23 Jan 2019 09:02:40 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/4] powerpc/64s: Add slb_full_bitmap rather than
 hard-coding U32_MAX
In-Reply-To: <20190117121328.13395-2-mpe@ellerman.id.au>
References: <20190117121328.13395-1-mpe@ellerman.id.au>
 <20190117121328.13395-2-mpe@ellerman.id.au>
Date: Wed, 23 Jan 2019 14:32:38 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19012309-0028-0000-0000-0000033CEAFC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012309-0029-0000-0000-000023FA27A7
Message-Id: <871s53d9w1.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-23_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230070
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> The recent rewrite of the SLB code into C included the assumption that
> all CPUs we run on have at least 32 SLB entries. This is currently
> true but a bit fragile as the SLB size is actually defined by the
> device tree and so could theoretically change at any time.
>
> The assumption is encoded in the fact that we use U32_MAX as the value
> for a full SLB bitmap. Instead, calculate what the full bitmap would
> be based on the SLB size we're given and store it. This still requires
> the SLB size to be a power of 2.

So if it is less than 32 we want to make sure we don't allocate an index
above 32. Is this the reason for that radom assert_slb_presence?

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> 

>
> Fixes: 126b11b294d1 ("powerpc/64s/hash: Add SLB allocation status bitmaps")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/slb.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index bc3914d54e26..61450a9cf30d 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -506,9 +506,16 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  	asm volatile("isync" : : : "memory");
>  }
>  
> +static u32 slb_full_bitmap;
> +
>  void slb_set_size(u16 size)
>  {
>  	mmu_slb_size = size;
> +
> +	if (size >= 32)
> +		slb_full_bitmap = U32_MAX;
> +	else
> +		slb_full_bitmap = (1ul << size) - 1;
>  }
>  
>  void slb_initialize(void)
> @@ -611,7 +618,7 @@ static enum slb_index alloc_slb_index(bool kernel)
>  	 * POWER7/8/9 have 32 SLB entries, this could be expanded if a
>  	 * future CPU has more.
>  	 */
> -	if (local_paca->slb_used_bitmap != U32_MAX) {
> +	if (local_paca->slb_used_bitmap != slb_full_bitmap) {
>  		index = ffz(local_paca->slb_used_bitmap);
>  		local_paca->slb_used_bitmap |= 1U << index;
>  		if (kernel)
> -- 
> 2.20.1

