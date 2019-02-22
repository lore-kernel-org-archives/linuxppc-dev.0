Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E4C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:26:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E832075C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E832075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Ztl6qrBzDql5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 02:26:23 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Zp82rZvzDqpB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 02:22:24 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MFLe5j134420
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 10:22:22 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qthrsf623-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 10:22:20 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 22 Feb 2019 15:21:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 15:21:37 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MFLaBv21823680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Feb 2019 15:21:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1D25AE045;
 Fri, 22 Feb 2019 15:21:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C882AE055;
 Fri, 22 Feb 2019 15:21:35 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.39.126])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 15:21:34 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 Q)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] powerpc/mm: Handle mmap_min_addr correctly in
 get_unmapped_area callback
In-Reply-To: <87k1hwavji.fsf@concordia.ellerman.id.au>
References: <20190215081647.24876-1-aneesh.kumar@linux.ibm.com>
 <87k1hwavji.fsf@concordia.ellerman.id.au>
Date: Fri, 22 Feb 2019 20:51:00 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19022215-4275-0000-0000-00000312B891
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022215-4276-0000-0000-00003820F081
Message-Id: <877edr7stf.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=537 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220108
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
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
>> After we ALIGN up the address we need to make sure we didn't overflow
>> and resulted in zero address. In that case, we need to make sure that
>> the returned address is greater than mmap_min_addr.
>>
>> Also when doing top-down search the low_limit is not PAGE_SIZE but rather
>> max(PAGE_SIZE, mmap_min_addr). This handle cases in which mmap_min_addr >
>> PAGE_SIZE.
>>
>> This fixes selftest va_128TBswitch --run-hugetlb reporting failures when
>> run as non root user for
>>
>> mmap(-1, MAP_HUGETLB)
>> mmap(-1, MAP_HUGETLB)
>>
>> We also avoid the first mmap(-1, MAP_HUGETLB) returning NULL address as mmap address
>> with this change
>
> So we think this is not a security issue, because it only affects
> whether we choose an address below mmap_min_addr, not whether we
> actually allow that address to be mapped.
>
> ie. there are existing capability checks to prevent a user mapping below
> mmap_min_addr and those will still be honoured even without this fix.
>
> However there is a bug in that a non-root user requesting address -1
> will be given address 0 which will then fail, whereas they should have
> been given something else that would have succeeded.
>
> Did I get that all right?

Correct

>> CC: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
> Seems like this should have a Fixes: tag?

I guess the hugetlb is 

Fixes: 484837601d4d ("powerpc/mm: Add radix support for hugetlb")

The slice related fix is possibly

Fixes: fba2369e6ceb ("mm: use vm_unmapped_area() on powerpc architecture")

This introduced info.low_limit which we are fixing in the patch. But
a similar logic was present even before via.

Fixes: d0f13e3c20b6 ("[POWERPC] Introduce address space "slices"")

-aneesh

