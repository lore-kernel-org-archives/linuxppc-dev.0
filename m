Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EA6C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 04:52:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AAE206BF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 04:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AAE206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r1qk4qQZzDqfS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 14:52:02 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r1p42HJwzDqcq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 14:50:35 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3Q4k6hk129921
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 00:50:32 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s3rjy5fja-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 00:50:31 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 26 Apr 2019 05:50:29 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 26 Apr 2019 05:50:26 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3Q4oP5056295446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2019 04:50:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B747B42047;
 Fri, 26 Apr 2019 04:50:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65A6E4203F;
 Fri, 26 Apr 2019 04:50:24 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.193.89.254])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 26 Apr 2019 04:50:24 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, npiggin@gmail.com,
 paulus@samba.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3 5/6] powerpc/mm: Reduce memory usage for mm_context_t
 for radix
In-Reply-To: <76af2dbb-96bb-d5e6-fe65-a8ca87e2e268@c-s.fr>
References: <20190417130351.3805-1-aneesh.kumar@linux.ibm.com>
 <20190417130351.3805-6-aneesh.kumar@linux.ibm.com>
 <76af2dbb-96bb-d5e6-fe65-a8ca87e2e268@c-s.fr>
Date: Fri, 26 Apr 2019 10:20:19 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 19042604-0008-0000-0000-000002E049EF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042604-0009-0000-0000-0000224CA5E9
Message-Id: <87imv1bcac.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-26_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260034
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 17/04/2019 =C3=A0 15:03, Aneesh Kumar K.V a =C3=A9crit=C2=A0:
>> Currently, our mm_context_t on book3s64 include all hash specific
>> context details like slice mask and subpage protection details. We
>> can skip allocating these with radix translation. This will help us to s=
ave
>> 8K per mm_context with radix translation.
>>=20
>> With the patch applied we have
>>=20
>> sizeof(mm_context_t)  =3D 136
>> sizeof(struct hash_mm_context)  =3D 8288
>>=20
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/book3s/64/mmu-hash.h | 33 ++++++++++++-
>>   arch/powerpc/include/asm/book3s/64/mmu.h      | 49 +++++--------------
>>   arch/powerpc/kernel/setup-common.c            |  6 +++
>>   arch/powerpc/mm/hash_utils_64.c               |  4 +-
>>   arch/powerpc/mm/mmu_context_book3s64.c        | 16 +++++-
>>   5 files changed, 68 insertions(+), 40 deletions(-)
>>=20
>
> [...]
>
>> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/se=
tup-common.c
>> index a07de8608484..21b1ce200b22 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -947,6 +947,12 @@ void __init setup_arch(char **cmdline_p)
>>   	init_mm.end_data =3D (unsigned long) _edata;
>>   	init_mm.brk =3D klimit;
>>=20=20=20
>> +#ifdef CONFIG_PPC_MM_SLICES
>> +#if defined(CONFIG_PPC_8xx)
>> +	init_mm.context.slb_addr_limit =3D DEFAULT_MAP_WINDOW;
>> +#endif
>> +#endif
>> +
>
> In the previous patch, you moved the above into early_init_mmu(). Why=20
> bringing it back here ?
>

Rebase error. I see that you have sent a series to handle this.

Thanks
-aneesh

