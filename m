Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B91C56202
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 07:39:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DBE206C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 07:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eiGF+Qnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DBE206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ChV5d5X7ZzDr95
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 18:39:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=eiGF+Qnu; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ChV404VVyzDqVp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2020 18:38:24 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AQ72aJh110945; Thu, 26 Nov 2020 02:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 in-reply-to : references : date : message-id : mime-version : content-type
 : content-transfer-encoding; s=pp1;
 bh=0fzQV9Izrk05YZ9N1QOl3ANBtJdiwi1fBc80x3YBr28=;
 b=eiGF+QnulwGW9eCVi5giQawi8WkBqz2m/x3WashaAgNn7hohXsH/noB/vUGRDrfybR4x
 PCEMsCmD3sgRUrABfgCvGTSu8IAcYRJoBheOYuZMiXNJ6xKoUYLNHBJkwKcCmvzTncQo
 yh9PnonO8gixWFjILydED/HKy6Dra9I8H/HId2hALUqP8PTiwdGqCWFCShQoss2Y0OxA
 ys/prDOrwqz7qXrIw5xuWh+3Vo+NDcjy263p29ufrjVGX+ubPNZf1vWrVhUC3q6zBxgT
 kciGUTgY5thll+cGCkRvUZYv/73m8e151yipdCYUXsv3dieGSLJd662teiWNhRLAXD8/ 4g== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3527fch3mc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2020 02:38:10 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQ7Wftn005961;
 Thu, 26 Nov 2020 07:38:08 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma04wdc.us.ibm.com with ESMTP id 34xth9deuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2020 07:38:08 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0AQ7c8gB58917236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Nov 2020 07:38:08 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53E93AC062;
 Thu, 26 Nov 2020 07:38:08 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DA17AC05F;
 Thu, 26 Nov 2020 07:38:06 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.75.69])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 26 Nov 2020 07:38:06 +0000 (GMT)
X-Mailer: emacs 27.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v6 09/22] powerpc/exec: Set thread.regs early during exec
In-Reply-To: <f5960226-f451-41ed-2992-bbe0acf9d190@csgroup.eu>
References: <20201125051634.509286-1-aneesh.kumar@linux.ibm.com>
 <20201125051634.509286-10-aneesh.kumar@linux.ibm.com>
 <f5960226-f451-41ed-2992-bbe0acf9d190@csgroup.eu>
Date: Thu, 26 Nov 2020 13:08:04 +0530
Message-ID: <87k0u8tvoj.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-26_01:2020-11-26,
 2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260037
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

> +++ b/arch/powerpc/kernel/process.c
>> @@ -1530,10 +1530,32 @@ void flush_thread(void)
>>   #ifdef CONFIG_PPC_BOOK3S_64
>>   void arch_setup_new_exec(void)
>>   {
>> -	if (radix_enabled())
>> -		return;
>> -	hash__setup_new_exec();
>> +	if (!radix_enabled())
>> +		hash__setup_new_exec();
>> +
>> +	/*
>> +	 * If we exec out of a kernel thread then thread.regs will not be
>> +	 * set.  Do it now.
>> +	 */
>> +	if (!current->thread.regs) {
>> +		struct pt_regs *regs =3D task_stack_page(current) + THREAD_SIZE;
>> +		current->thread.regs =3D regs - 1;
>> +	}
>> +
>> +}
>> +#else
>> +void arch_setup_new_exec(void)
>> +{
>> +	/*
>> +	 * If we exec out of a kernel thread then thread.regs will not be
>> +	 * set.  Do it now.
>> +	 */
>> +	if (!current->thread.regs) {
>> +		struct pt_regs *regs =3D task_stack_page(current) + THREAD_SIZE;
>> +		current->thread.regs =3D regs - 1;
>> +	}
>>   }
>> +
>>   #endif
>
> No need to duplicate arch_setup_new_exec() I think. radix_enabled() is de=
fined at all time so the=20
> first function should be valid at all time.
>

arch/powerpc/kernel/process.c: In function =E2=80=98arch_setup_new_exec=E2=
=80=99:
arch/powerpc/kernel/process.c:1529:3: error: implicit declaration of functi=
on =E2=80=98hash__setup_new_exec=E2=80=99; did you mean =E2=80=98arch_setup=
_new_exec=E2=80=99? [-Werror=3Dimplicit-function-declaration]
 1529 |   hash__setup_new_exec();
      |   ^~~~~~~~~~~~~~~~~~~~
      |   arch_setup_new_exec


That requires us to have hash__setup_new_exec prototype for all platforms.

-aneesh
