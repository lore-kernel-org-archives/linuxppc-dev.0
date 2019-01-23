Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F9C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 09:11:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF58320861
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 09:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF58320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43l00V4ygQzDqJq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 20:11:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kzyf1x2wzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 20:10:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43kzyf0n6tz8wTh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 20:10:18 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43kzyf0hl8z9sN6; Wed, 23 Jan 2019 20:10:18 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 43kzyd3v7Sz9s9h
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 20:10:17 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0N99CUh058352
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 04:10:15 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q6jnhxhcy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 04:10:15 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 23 Jan 2019 09:10:13 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 23 Jan 2019 09:10:10 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0N9A98E721238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Jan 2019 09:10:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BC2F4C04A;
 Wed, 23 Jan 2019 09:10:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C58E4C050;
 Wed, 23 Jan 2019 09:10:08 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.69.250])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 23 Jan 2019 09:10:07 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/4] powerpc/64s: Support shrinking the SLB for debugging
In-Reply-To: <20190117121328.13395-4-mpe@ellerman.id.au>
References: <20190117121328.13395-1-mpe@ellerman.id.au>
 <20190117121328.13395-4-mpe@ellerman.id.au>
Date: Wed, 23 Jan 2019 14:40:06 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19012309-0028-0000-0000-0000033CEBD0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012309-0029-0000-0000-000023FA287F
Message-Id: <87va2fbuz5.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-23_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230071
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

> On machines with 1TB segments and a 32-entry SLB it's quite hard to
> cause sufficient SLB pressure to trigger bugs caused due to badly
> timed SLB faults.
>
> We have seen this in the past and a few years ago added the
> disable_1tb_segments command line option to force the use of 256MB
> segments. However even this allows some bugs to slip through testing
> if the SLB entry in question was recently accessed.
>
> So add a new command line parameter for debugging which shrinks the
> SLB to the minimum size we can support. Currently that size is 3, two
> bolted SLBs and 1 for dynamic use. This creates the maximal SLB
> pressure while still allowing the kernel to operate.
>

Should we put this within DEBUG_VM? 

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> 


> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/slb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 61450a9cf30d..0f33e28f97da 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -506,10 +506,24 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  	asm volatile("isync" : : : "memory");
>  }
>  
> +static bool shrink_slb = false;
> +
> +static int __init parse_shrink_slb(char *p)
> +{
> +	shrink_slb = true;
> +	slb_set_size(0);

Why do we need call slb_set_size(0) here? htab_dt_scan_seg_sizes should 
find the shirnk_slb = true?

> +
> +	return 0;
> +}
> +early_param("shrink_slb", parse_shrink_slb);
> +
>  static u32 slb_full_bitmap;
>  
>  void slb_set_size(u16 size)
>  {
> +	if (shrink_slb)
> +		size = SLB_NUM_BOLTED + 1;
> +
>  	mmu_slb_size = size;
>  
>  	if (size >= 32)
> -- 
> 2.20.1

-aneesh

