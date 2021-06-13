Return-Path: <SRS0=g+Gz=LH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CA3C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jun 2021 11:16:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB8761279
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jun 2021 11:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB8761279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G2sTD585sz3bwn
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jun 2021 21:16:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kn/h1c0h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=Kn/h1c0h; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G2sSg5mKgz2xb6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jun 2021 21:15:30 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15DB3QYk028730; Sun, 13 Jun 2021 07:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6Nl5iP9F92OfnPEuSZWUKnMcCt2xSBI/5/GiCuQ5oyE=;
 b=Kn/h1c0hAOHZCbf7D9XZYwWEJsyGOorfgj/DRsAdnx1cyUS2EcT333/VZa5Ni7zMqRK/
 rJ4gvY14DOtuO/pa5KBlFV7wr6BYlFYz+hdy2zQDrYNhH8X8fXzgmD9DuaCIYizY2CU3
 qMomLrrT3rGsZbMzACkfRLM7Nkka57ldVBdodixvraEfNU5vmHO5e38FHJ0QbB6BizgY
 tRihDkpkR9QUo+nF4qCiUuzM/v3+KZQycj13u3iqO7SOxqAAZ8u0ciAZL8r2VlSoo1AP
 JDrNvotnKApQucKPQbKZI5GKfh/wRqCyp/IgmeZxdKcmYsWgonj9k3YlvBgXURqFh7dC Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 395f739pkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Jun 2021 07:13:59 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15DB3QoC028765;
 Sun, 13 Jun 2021 07:13:58 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 395f739pk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Jun 2021 07:13:58 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15DBDugN011370;
 Sun, 13 Jun 2021 11:13:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06ams.nl.ibm.com with ESMTP id 394m6hrfvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Jun 2021 11:13:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 15DBDreK8978770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 13 Jun 2021 11:13:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97A91A4057;
 Sun, 13 Jun 2021 11:13:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A142EA4040;
 Sun, 13 Jun 2021 11:13:51 +0000 (GMT)
Received: from [9.85.68.237] (unknown [9.85.68.237])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 13 Jun 2021 11:13:51 +0000 (GMT)
Subject: Re: [PATCH 5/6] mm/mremap: Use pmd/pud_poplulate to update page table
 entries
To: Matthew Wilcox <willy@infradead.org>
References: <20210610083549.386085-1-aneesh.kumar@linux.ibm.com>
 <20210610083549.386085-6-aneesh.kumar@linux.ibm.com>
 <CAHk-=wi+J+iodze9FtjM3Zi4j4OeS+qqbKxME9QN4roxPEXH9Q@mail.gmail.com>
 <87wnqy9lru.fsf@linux.ibm.com> <YMXi6AZm4fPpPKrH@casper.infradead.org>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <dd2f0d9d-da78-46a4-78cb-c5cfb7df7f16@linux.ibm.com>
Date: Sun, 13 Jun 2021 16:43:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMXi6AZm4fPpPKrH@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V_yA16TUVe1eyYfdHqOn39OE3IhvknMZ
X-Proofpoint-ORIG-GUID: iFlYbDqJufQiVVYWPdU0ky0OjEWGOPKF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-13_04:2021-06-11,
 2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1011
 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106130082
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nick Piggin <npiggin@gmail.com>, Linux-MM <linux-mm@kvack.org>,
 Kalesh Singh <kaleshsingh@google.com>, Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 6/13/21 4:20 PM, Matthew Wilcox wrote:
> On Sun, Jun 13, 2021 at 02:36:13PM +0530, Aneesh Kumar K.V wrote:
>> IIUC the reason why we do have pmd_pgtable() is that pgtable_t type
>> is arch dependent. On some architecture it is pte_t * and on the other
>> struct page *. The reason being highmem and level 4 page table can
>> be located in highmem.
> 
> That is ahistorical.  See 2f569afd9ced9ebec9a6eb3dbf6f83429be0a7b4 --
> we have pgtable_t for the benefit of s390's crazy sub-page page table
> sizes.

That is also true with ppc64. We do sub-page page table size. I was 
trying to explain why it can't be pte_t * everywhere and why we have
it as struct page *.

> 
> Also, please stop numbering page tables upside down.  PTEs are first
> level, not fourth.
> 

POWER ISA do name it the other way. I also see some pages explaining 
levels the other way

https://www.bottomupcs.com/virtual_memory_linux.xhtml

whereas 
https://en.wikipedia.org/wiki/Intel_5-level_paging#/media/File:Page_Tables_(5_levels).svg

I am pretty sure I had commits that explained page table level as I did 
in this thread. I will switch to your suggestion in further discussions. 
May be the best solution is to attribute it with more details like level 
1 (pte_t *)?


-aneesh

