Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70D9C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 11:37:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F246620651
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 11:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F246620651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43f7Nw3BFpzDqfP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 22:27:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43f7M65jzvzDqdc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 22:26:10 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0FBO7B8082572
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 06:26:07 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q1dmeaxpy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 06:26:07 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 15 Jan 2019 11:26:07 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 15 Jan 2019 11:26:02 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0FBQ10P23986220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Jan 2019 11:26:01 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CACFFAE05C;
 Tue, 15 Jan 2019 11:26:01 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3970AE060;
 Tue, 15 Jan 2019 11:25:58 +0000 (GMT)
Received: from [9.85.74.182] (unknown [9.85.74.182])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 15 Jan 2019 11:25:58 +0000 (GMT)
Subject: Re: [PATCH V7 5/5] testing
To: akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au
References: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com>
 <20190114095438.32470-7-aneesh.kumar@linux.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 15 Jan 2019 16:55:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190114095438.32470-7-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011511-0072-0000-0000-000003EA0EE1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010410; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01146788; UDB=6.00597313; IPR=6.00927080; 
 MB=3.00025134; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-15 11:26:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011511-0073-0000-0000-00004AD11BE4
Message-Id: <bd6b4237-064d-0059-3b2c-1f14cdf466f2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-15_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901150097
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

You can ignore this one.

On 1/14/19 3:24 PM, Aneesh Kumar K.V wrote:
> ---
>   mm/gup.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 6e8152594e83..91849c39931a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1226,7 +1226,7 @@ static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
>   		 * be pinning these entries, we might as well move them out
>   		 * of the CMA zone if possible.
>   		 */
> -		if (is_migrate_cma_page(pages[i])) {
> +		if (true || is_migrate_cma_page(pages[i])) {
>   
>   			struct page *head = compound_head(pages[i]);
>   
> @@ -1256,6 +1256,7 @@ static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
>   		for (i = 0; i < nr_pages; i++)
>   			put_page(pages[i]);
>   
> +		pr_emerg("migrating nr_pages");
>   		if (migrate_pages(&cma_page_list, new_non_cma_page,
>   				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
>   			/*
> @@ -1274,10 +1275,11 @@ static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
>   		nr_pages = get_user_pages(start, nr_pages, gup_flags, pages, vmas);
>   		if ((nr_pages > 0) && migrate_allow) {
>   			drain_allow = true;
> -			goto check_again;
> +			//goto check_again;
>   		}
>   	}
>   
> +	pr_emerg("Returning with %ld\n", nr_pages);
>   	return nr_pages;
>   }
>   #else
> 

