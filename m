Return-Path: <SRS0=c12Q=ID=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C82FC433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 11:45:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C368C64F52
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 11:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C368C64F52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsQst275Mz3dK3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 22:45:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bEfvBaFS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ldufour@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=bEfvBaFS; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsQsN5N79z30NC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Mar 2021 22:45:28 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 125BXwIS165422; Fri, 5 Mar 2021 06:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kPqpJf7p0+ZtsHItye4WbFfQC6+4TZVhSDlWIgwG5mY=;
 b=bEfvBaFSvjKhG+XpDVPo1pWu55PAAftyb80EWS0CAJaeBRNZut9iVqInpWZl0DKKEIuN
 tsVWCgRefliB/dNps+8vpGmSG+vU5ZeYZ37Lphv+x0WB0VTs1gLpST6N/0keSZSibKK5
 I0X0GFXAoYCEdf8lKxgMgvWUVqB+L3lYJRDQfgbZ5bF2bmI4PZT1q+o/+kffucymWHP8
 3pTOggrSp5JXZnaVuhOAm75T9+FOlDAlQprpY3fZptVoxxltGgF93Fir3rI4x03P62TZ
 I8H+l+U2z8fZ1QIdtb7blpSKK3iFAiWd+oBD4N13j0GYdXFNrKB7pKXJyVTmOFho6P5D ww== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 373je732hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Mar 2021 06:45:20 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125BfmEO026062;
 Fri, 5 Mar 2021 11:45:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3712fmkn60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Mar 2021 11:45:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 125BjFsx40763720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Mar 2021 11:45:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FC39AE04D;
 Fri,  5 Mar 2021 11:45:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30167AE045;
 Fri,  5 Mar 2021 11:45:15 +0000 (GMT)
Received: from pomme.local (unknown [9.145.88.223])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  5 Mar 2021 11:45:15 +0000 (GMT)
Subject: Re: [PATCH] powerpc/pseries: export LPAR security flavor in lparcfg
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
References: <20210304114240.54112-1-ldufour@linux.ibm.com>
 <871rcuruee.fsf@mpe.ellerman.id.au>
 <2c67c119-c1ec-b079-da54-0bf2f316c734@linux.ibm.com>
 <87wnulrfk4.fsf@mpe.ellerman.id.au>
From: Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <c0b69e16-3b4c-7a27-f3ca-eba1eff5624a@linux.ibm.com>
Date: Fri, 5 Mar 2021 12:45:14 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87wnulrfk4.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-05_05:2021-03-03,
 2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050058
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
Cc: nathanl@linux.ibm.com, cheloha@linux.ibm.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le 05/03/2021 à 12:43, Michael Ellerman a écrit :
> Laurent Dufour <ldufour@linux.ibm.com> writes:
>> Le 05/03/2021 à 07:23, Michael Ellerman a écrit :
>>> Laurent Dufour <ldufour@linux.ibm.com> writes:
>>>> This is helpful to read the security flavor from inside the LPAR.
>>>
>>> We already have /sys/kernel/debug/powerpc/security_features.
>>>
>>> Is that not sufficient?
>>
>> Not really, it only reports that security mitigation are on or off but not the
>> level set through the ASMI menu. Furthermore, reporting it through
>> /proc/powerpc/lparcfg allows an easy processing by the lparstat command (see below).
>>
>>>
>>>> Export it like this in /proc/powerpc/lparcfg:
>>>>
>>>> $ grep security_flavor /proc/powerpc/lparcfg
>>>> security_flavor=1
>>>>
>>>> Value means:
>>>> 0 Speculative execution fully enabled
>>>> 1 Speculative execution controls to mitigate user-to-kernel attacks
>>>> 2 Speculative execution controls to mitigate user-to-kernel and
>>>>     user-to-user side-channel attacks
>>>
>>> Those strings come from the FSP help, but we have no guarantee it won't
>>> mean something different in future.
>>
>> I think this is nailed down, those strings came from:
>> https://www.ibm.com/support/pages/node/715841
>>
>> Where it is written (regarding AIX):
>>
>> On an LPAR, one can use lparstat -x to display the current mitigation mode:
>> 0 = Speculative execution fully enabled
>> 1 = Speculative execution controls to mitigate user-to-kernel side-channel attacks
>> 2 = Speculative execution controls to mitigate user-to-kernel and user-to-user
>> side-channel attacks
>>
>> We have been requested to provide almost the same, which I proposed in
>> powerpc-utils:
>> https://groups.google.com/g/powerpc-utils-devel/c/NaKXvdyl_UI/m/wa2stpIDAQAJ
> 
> OK. Do you mind sending a v2 with all those details incorporated into
> the change log?

Ok will do so.

Thanks
