Return-Path: <SRS0=klx1=BW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050FCC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 01:34:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C6A20855
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 01:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l7Ap9AqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C6A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BRC1J5VJNzDqSV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 11:34:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=l7Ap9AqZ; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BRByL4M6mzDqM0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 11:32:10 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07C14cxh161435; Tue, 11 Aug 2020 21:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=I4qtB9+LHAbpKxC5mIwLAQ9l94ozMMxS83XQjzgujiw=;
 b=l7Ap9AqZmiRNmWkznTyBYEiP3XOjmvCXwt6OMe8agUDlhe1pyse0wq4sy8EQw+3qFvA+
 F2vPLokihN/givNreuN/5PLozr0qmeI4ee0l4cfcLf/hIWC7fj2VXpm+sGLnMlZpx9Pj
 P7Hl3WbnPe+NDQ6aMwCDv9Kz4r65g4oHThCUgzXPcQwtAwEUf20fiEDY2Qj1RmGRIKos
 Ps3Da4h6FxHRngfhmB3bUOokWAzWKHXGD9bqTGmBM7PpBKfH/yQCYcoP2d+/Cr0GxMEm
 6GxoR7i+Da2WqcpbKsthbPL9PXHQ78HsECVPfENDcbyKKBDYWN/RevCiFH+8k6t+LwcC /Q== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32urdph97b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2020 21:32:04 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07C1UF1H021449;
 Wed, 12 Aug 2020 01:32:03 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma05wdc.us.ibm.com with ESMTP id 32skp95u6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2020 01:32:03 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07C1W2Lu24707430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2020 01:32:02 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9408E6A057;
 Wed, 12 Aug 2020 01:32:02 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51DE46A054;
 Wed, 12 Aug 2020 01:32:02 +0000 (GMT)
Received: from localhost (unknown [9.65.223.18])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2020 01:32:01 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: explicitly reschedule during drmem_lmb
 list traversal
In-Reply-To: <87imdqz2sg.fsf@linux.ibm.com>
References: <20200728173741.717372-1-nathanl@linux.ibm.com>
 <bd9225f2-40c9-0460-ba45-c29c920b5f91@linux.ibm.com>
 <878sf31m8k.fsf@linux.ibm.com> <87lfj16cql.fsf@mpe.ellerman.id.au>
 <875za511z6.fsf@linux.ibm.com> <87ft974yf7.fsf@mpe.ellerman.id.au>
 <87365723m0.fsf@linux.ibm.com> <87tuxl1ant.fsf@mpe.ellerman.id.au>
 <87imdqz2sg.fsf@linux.ibm.com>
Date: Tue, 11 Aug 2020 20:32:01 -0500
Message-ID: <87d03wzm26.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-11_15:2020-08-11,
 2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008120001
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
Cc: tyreld@linux.ibm.com, cheloha@linux.ibm.com,
 Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Lynch <nathanl@linux.ibm.com> writes:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> One thought, which I possibly should not put in writing, is that we
>> could use the alignment of the pointer as a poor man's substitute for a
>> counter, eg:
>>
>> +static inline struct drmem_lmb *drmem_lmb_next(struct drmem_lmb *lmb)
>> +{
>> +	if (lmb % PAGE_SIZE == 0)
>> +		cond_resched();
>> +
>> +	return ++lmb;
>> +}
>>
>> I think the lmbs are allocated in a block, so I think that will work.
>> Maybe PAGE_SIZE is not the right size to use, but you get the idea.
>>
>> Gross I know, but might be OK as short term solution?
>
> OK, looking into this.

To follow up:

I wasn't able to measure more than ~1% difference in DLPAR memory
performance with my original version of this, but that was on a
relatively small configuration - hundreds of elements in the array as
opposed to thousands. I took an educated guess at an appropriate
interval and posted v2:

https://lore.kernel.org/linuxppc-dev/20200812012005.1919255-1-nathanl@linux.ibm.com/
