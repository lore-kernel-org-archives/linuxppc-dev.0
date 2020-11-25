Return-Path: <SRS0=IR6y=E7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5907BC5519F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 15:01:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B2A2083E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 15:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V7smuBMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B2A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ch3xX10vczDqMG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 02:01:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=V7smuBMi; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Ch3sd58zxzDqpC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2020 01:57:57 +1100 (AEDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0APEWLMu058829; Wed, 25 Nov 2020 09:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 in-reply-to : references : date : message-id : mime-version : content-type
 : content-transfer-encoding; s=pp1;
 bh=P0hDD8DJqPY0Nx+l4omQmDi2QCfl054i4QcstWxvPg4=;
 b=V7smuBMi6Et+2v9JN0UNPi/jvUTtcW/zEOiDDGvDp4RwX+/0awyTd7P+EJRsNLfMbfwP
 vYEQq0kA/6LJ0L0o8axVOzqsqTV4YyO4+cVj+o1hzsTFBHoKncd9bTw6OwW/8v4T6SOU
 3OGYQWFi0A9uYrS6enoeGefKat+5n4DBqV+jV8UxF9t+DNy0CmrpXOPtHNwezM/TbLW+
 8h2j+1I+F9kg0j/y1h/fFwPp+TMa1szOpBa6pQdH2lgUjJUXFb4rLl3SzhhImmHGne1p
 EoHSdOOsgjDMJIt5DiYKxRyGtkt03QgOtqlmcby50S4JHYr364clbSfzIaL+T6QSthd+ vA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 351nrky7x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Nov 2020 09:57:43 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0APEvDXK002356;
 Wed, 25 Nov 2020 14:57:41 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma03wdc.us.ibm.com with ESMTP id 35133p0fcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Nov 2020 14:57:41 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0APEvfWh14091006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Nov 2020 14:57:41 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BF74AE05C;
 Wed, 25 Nov 2020 14:57:41 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 767D9AE05F;
 Wed, 25 Nov 2020 14:57:39 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.77.195.3])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 25 Nov 2020 14:57:39 +0000 (GMT)
X-Mailer: emacs 27.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v6 03/22] powerpc/book3s64/kuap/kuep: Make KUAP and KUEP
 a subfeature of PPC_MEM_KEYS
In-Reply-To: <a98c3e0e-ddc9-3278-b707-669627c45e88@csgroup.eu>
References: <20201125051634.509286-1-aneesh.kumar@linux.ibm.com>
 <20201125051634.509286-4-aneesh.kumar@linux.ibm.com>
 <a98c3e0e-ddc9-3278-b707-669627c45e88@csgroup.eu>
Date: Wed, 25 Nov 2020 20:27:35 +0530
Message-ID: <87mtz5trfk.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-25_08:2020-11-25,
 2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250088
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Le 25/11/2020 =C3=A0 06:16, Aneesh Kumar K.V a =C3=A9crit=C2=A0:
....

> diff --git a/arch/powerpc/mm/book3s64/pkeys.c b/arch/powerpc/mm/book3s64/=
pkeys.c
>> index b1d091a97611..7dc71f85683d 100644
>> --- a/arch/powerpc/mm/book3s64/pkeys.c
>> +++ b/arch/powerpc/mm/book3s64/pkeys.c
>> @@ -89,12 +89,14 @@ static int scan_pkey_feature(void)
>>   		}
>>   	}
>>=20=20=20
>> +#ifdef CONFIG_PPC_MEM_KEYS
>>   	/*
>>   	 * Adjust the upper limit, based on the number of bits supported by
>>   	 * arch-neutral code.
>>   	 */
>>   	pkeys_total =3D min_t(int, pkeys_total,
>>   			    ((ARCH_VM_PKEY_FLAGS >> VM_PKEY_SHIFT) + 1));
>
> I don't think we need an #ifdef here. I thing an 'if (IS_ENABLED(CONFIG_P=
PC_MEM_KEYS))' should make it.

ppc64/arch/powerpc/mm/book3s64/pkeys.c: In function =E2=80=98scan_pkey_feat=
ure=E2=80=99:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
ppc64/arch/powerpc/mm/book3s64/pkeys.c:98:33: error: =E2=80=98VM_PKEY_SHIFT=
=E2=80=99 undeclared (first use in this function)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
   98 |         ((ARCH_VM_PKEY_FLAGS >> VM_PKEY_SHIFT) + 1));=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
      |                                 ^~~~~~~~~~~~~=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
pkey headers only include arch headers if PPC_MEM_KEYS is enabled. ie,=20

#ifdef CONFIG_ARCH_HAS_PKEYS
#include <asm/pkeys.h>
#else /* ! CONFIG_ARCH_HAS_PKEYS */
#define arch_max_pkey() (1)
#define execute_only_pkey(mm) (0)
#define arch_override_mprotect_pkey(vma, prot, pkey) (0)
#define PKEY_DEDICATED_EXECUTE_ONLY 0
#define ARCH_VM_PKEY_FLAGS 0
..

Sorting that out should be another patch series.=20



>
>> +#endif
>>   	return pkeys_total;
>>   }
