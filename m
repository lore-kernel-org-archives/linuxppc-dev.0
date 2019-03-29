Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24763C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 10:27:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9448B206B8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 10:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9448B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VybQ3Ns0zDqF6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 21:27:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VyYh2h5vzDqB7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 21:25:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44VyYh1VKvz8tRt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 21:25:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44VyYg3Q5gz9sQr; Fri, 29 Mar 2019 21:25:43 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mahesh@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44VyYf5s7cz9sQm
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Mar 2019 21:25:42 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2TAPegQ100982
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Mar 2019 06:25:40 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rhef5jba2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Mar 2019 06:25:40 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 29 Mar 2019 10:24:43 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Mar 2019 10:24:41 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2TAOe3A61407380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Mar 2019 10:24:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78B5652050;
 Fri, 29 Mar 2019 10:24:40 +0000 (GMT)
Received: from [9.85.92.96] (unknown [9.85.92.96])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B0FA15204E;
 Fri, 29 Mar 2019 10:24:39 +0000 (GMT)
Subject: Re: [RFC PATCH 2/3] powernv/mce: Print correct severity for mce error.
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <155324738319.7819.17982472592795327790.stgit@jupiter.in.ibm.com>
 <155324739171.7819.1095626412782166400.stgit@jupiter.in.ibm.com>
 <878swyo7es.fsf@concordia.ellerman.id.au>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 29 Mar 2019 15:54:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <878swyo7es.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032910-0012-0000-0000-00000308C983
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032910-0013-0000-0000-0000213FFE73
Message-Id: <2a78d8e0-6383-4bf2-9762-9c7eb5521a85@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-29_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290076
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
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/29/19 5:53 AM, Michael Ellerman wrote:
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>> diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
>> index 8d0b1c24c636..314ed3f13d59 100644
>> --- a/arch/powerpc/include/asm/mce.h
>> +++ b/arch/powerpc/include/asm/mce.h
>> @@ -110,17 +110,18 @@ enum MCE_LinkErrorType {
>>  };
>>  
>>  struct machine_check_event {
>> -	enum MCE_Version	version:8;	/* 0x00 */
>> -	uint8_t			in_use;		/* 0x01 */
>> -	enum MCE_Severity	severity:8;	/* 0x02 */
>> -	enum MCE_Initiator	initiator:8;	/* 0x03 */
>> -	enum MCE_ErrorType	error_type:8;	/* 0x04 */
>> -	enum MCE_Disposition	disposition:8;	/* 0x05 */
>> -	uint16_t		cpu;		/* 0x06 */
>> -	uint64_t		gpr3;		/* 0x08 */
>> -	uint64_t		srr0;		/* 0x10 */
>> -	uint64_t		srr1;		/* 0x18 */
>> -	union {					/* 0x20 */
>> +	enum MCE_Version	version:8;
>> +	uint8_t			in_use;
>> +	enum MCE_Severity	severity:8;
>> +	enum MCE_Initiator	initiator:8;
>> +	enum MCE_ErrorType	error_type:8;
>> +	enum MCE_Disposition	disposition:8;
>> +	uint8_t			sync_error;
>> +	uint16_t		cpu;
>> +	uint64_t		gpr3;
>> +	uint64_t		srr0;
>> +	uint64_t		srr1;
> 
> Can you switch these to use kernel types while you're at it, ie. u8, u64 etc.

sure.

> 
>> @@ -194,6 +195,7 @@ struct mce_error_info {
>>  	} u;
>>  	enum MCE_Severity	severity:8;
>>  	enum MCE_Initiator	initiator:8;
>> +	uint8_t			sync_error;
> 
> u8 here but bool later?

Will make it bool everywhere.

Thanks,
-Mahesh.

