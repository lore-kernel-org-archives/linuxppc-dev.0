Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C63C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 05:54:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C1020815
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 05:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C1020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L1Dr6JbqzDqgf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 16:54:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L1BQ5CdczDqw1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 16:52:46 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBK5oaAT122822
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 00:52:44 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pg59pr2y6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 00:52:44 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 20 Dec 2018 05:52:42 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Dec 2018 05:52:38 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBK5qbMD17629256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Dec 2018 05:52:37 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75C84AC062;
 Thu, 20 Dec 2018 05:52:37 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61112AC059;
 Thu, 20 Dec 2018 05:52:34 +0000 (GMT)
Received: from [9.85.68.89] (unknown [9.85.68.89])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 20 Dec 2018 05:52:33 +0000 (GMT)
Subject: Re: [PATCH V5 1/3] mm: Add get_user_pages_cma_migrate
To: Alexey Kardashevskiy <aik@ozlabs.ru>, akpm@linux-foundation.org,
 Michal Hocko <mhocko@kernel.org>, mpe@ellerman.id.au, paulus@samba.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20181219034047.16305-1-aneesh.kumar@linux.ibm.com>
 <20181219034047.16305-2-aneesh.kumar@linux.ibm.com>
 <e9c9b68a-a31b-ab59-902a-73401a89f72a@ozlabs.ru>
 <b316eb1c-36dc-49e0-f46f-e610f29b6058@linux.ibm.com>
 <23cae5a6-4370-224c-523c-ab6ee940cf87@ozlabs.ru>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Thu, 20 Dec 2018 11:22:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <23cae5a6-4370-224c-523c-ab6ee940cf87@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18122005-2213-0000-0000-0000032E668E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010253; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01134327; UDB=6.00589763; IPR=6.00914499; 
 MB=3.00024763; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-20 05:52:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122005-2214-0000-0000-00005CAC0B05
Message-Id: <ba05bde5-5ef9-6e96-b15c-cebb9631a84b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-20_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=-1004 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812200048
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

On 12/20/18 11:18 AM, Alexey Kardashevskiy wrote:
> 
> 
> On 20/12/2018 16:22, Aneesh Kumar K.V wrote:
>> On 12/20/18 9:49 AM, Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 19/12/2018 14:40, Aneesh Kumar K.V wrote:
>>>> This helper does a get_user_pages_fast and if it find pages in the
>>>> CMA area
>>>> it will try to migrate them before taking page reference. This makes
>>>> sure that
>>>> we don't keep non-movable pages (due to page reference count) in the
>>>> CMA area.
>>>> Not able to move pages out of CMA area result in CMA allocation
>>>> failures.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>
>>
>> .....
>>>> +         * We did migrate all the pages, Try to get the page
>>>> references again
>>>> +         * migrating any new CMA pages which we failed to isolate
>>>> earlier.
>>>> +         */
>>>> +        drain_allow = true;
>>>> +        goto get_user_again;
>>>
>>>
>>> So it is possible to have pages pinned, then successfully migrated
>>> (migrate_pages() returned 0), then pinned again, then some pages may end
>>> up in CMA again and migrate again and nothing seems to prevent this loop
>>> from being endless. What do I miss?
>>>
>>
>> pages used as target page for migration won't be allocated from CMA region.
> 
> 
> Then migrate_allow should be set to "false" regardless what
> migrate_pages() returned and then I am totally missing the point of this
> goto and going through the loop again even when we know for sure it
> won't do literally anything but checking is_migrate_cma_page() even
> though we know pages won't be allocated from CMA.
> 

Because we might have failed to isolate all the pages in the first attempt.

-aneesh

