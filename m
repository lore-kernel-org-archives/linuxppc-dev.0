Return-Path: <SRS0=MsOR=LD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC9CC48BCD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 13:12:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69426100B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 13:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69426100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G0SF1124Sz3byZ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 23:12:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ImWZIZwn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=naveen.n.rao@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=ImWZIZwn; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G0SDN2J16z2yY9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jun 2021 23:11:31 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 159D9wED142664; Wed, 9 Jun 2021 09:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : subject :
 to : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yxbcsvcQ14tknvV8R4ciw+N+iHvH9heLnV2Sh+qgv9A=;
 b=ImWZIZwnfHWGSsotwvAulngsrwLucRaefKypqGhXeVXrVLdLCwaGqpg/1l42RNr+JYlO
 LNwG7FNShYrs4mkUHQDMCbHIiCX6qsCaA4/XzUsYaER2jAhAYyOY4oB4mMfrV7Fm5e6g
 ngrQ9W9AR5t0QyGOQ0487SvSJYCL1qZmxP3st8O6qQ22Pw/tqpqi2g4DkX0rmb0DD/I3
 v50N2crAl7ACkhlwg0gdrOWJj5x6GvTy4l7DtZQwFEJL/GKIhBdXbJptxnhh6PP2czsP
 DstX9qAvyRWeZg+17Pwe+1Xewyhr/OZkbH/0x0x9k1WqVCIiE3Pkh6OmKf7DBT/D6410 vA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 392x9p01gt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jun 2021 09:11:18 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 159D8E71028946;
 Wed, 9 Jun 2021 13:11:15 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03fra.de.ibm.com with ESMTP id 3900w8s769-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jun 2021 13:11:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 159DBD7R22151610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Jun 2021 13:11:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B110AE045;
 Wed,  9 Jun 2021 13:11:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FE21AE051;
 Wed,  9 Jun 2021 13:11:12 +0000 (GMT)
Received: from localhost (unknown [9.85.114.11])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  9 Jun 2021 13:11:12 +0000 (GMT)
Date: Wed, 09 Jun 2021 18:41:10 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/bpf: Use bctrl for making function calls
To: bpf@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
References: <20210609090024.1446800-1-naveen.n.rao@linux.vnet.ibm.com>
 <4c371bd1-1fcf-54c1-d0a2-836d40887893@csgroup.eu>
In-Reply-To: <4c371bd1-1fcf-54c1-d0a2-836d40887893@csgroup.eu>
User-Agent: astroid/v0.15-23-gcdc62b30 (https://github.com/astroidmail/astroid)
Message-Id: <1623243814.sye72m0d51.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WQTLCc_rzCIFIUteP8Xihj-q8aMzQM3B
X-Proofpoint-ORIG-GUID: WQTLCc_rzCIFIUteP8Xihj-q8aMzQM3B
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-09_04:2021-06-04,
 2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090065
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

Christophe Leroy wrote:
>=20
>=20
> Le 09/06/2021 =C3=A0 11:00, Naveen N. Rao a =C3=A9crit=C2=A0:
>> blrl corrupts the link stack. Instead use bctrl when making function
>> calls from BPF programs.
>=20
> What's the link stack ? Is it the PPC64 branch predictor stack ?

c974809a26a13e ("powerpc/vdso: Avoid link stack corruption in=20
__get_datapage()") has a good write up on the link stack.

>=20
>>=20
>> Reported-by: Anton Blanchard <anton@ozlabs.org>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/ppc-opcode.h |  1 +
>>   arch/powerpc/net/bpf_jit_comp32.c     |  4 ++--
>>   arch/powerpc/net/bpf_jit_comp64.c     | 12 ++++++------
>>   3 files changed, 9 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/includ=
e/asm/ppc-opcode.h
>> index ac41776661e963..1abacb8417d562 100644
>> --- a/arch/powerpc/include/asm/ppc-opcode.h
>> +++ b/arch/powerpc/include/asm/ppc-opcode.h
>> @@ -451,6 +451,7 @@
>>   #define PPC_RAW_MTLR(r)			(0x7c0803a6 | ___PPC_RT(r))
>>   #define PPC_RAW_MFLR(t)			(PPC_INST_MFLR | ___PPC_RT(t))
>>   #define PPC_RAW_BCTR()			(PPC_INST_BCTR)
>> +#define PPC_RAW_BCTRL()			(PPC_INST_BCTRL)
>=20
> Can you use the numeric value instead of the PPC_INST_BCTRL, to avoid con=
flict with=20
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/4ca2bfdca2f47a293=
d05f61eb3c4e487ee170f1f.1621506159.git.christophe.leroy@csgroup.eu/

Sure. I'll post a v2.

- Naveen

