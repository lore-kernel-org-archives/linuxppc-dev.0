Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB504C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 02:46:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D652086A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 02:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D652086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wQjK1MrbzF3Xl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 13:46:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=gromero@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wQg1225PzF3MY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 13:44:13 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAF2d6LW061708
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 21:44:11 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nrw9q63uw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 21:44:11 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Thu, 15 Nov 2018 02:44:10 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 15 Nov 2018 02:44:07 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAF2i6YY19988482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Nov 2018 02:44:06 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83F03C605B;
 Thu, 15 Nov 2018 02:44:06 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DBCBC6059;
 Thu, 15 Nov 2018 02:44:05 +0000 (GMT)
Received: from oc6336877782.ibm.com (unknown [9.80.225.70])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 15 Nov 2018 02:44:05 +0000 (GMT)
Subject: Re: It looks like that wild_bctr on powerpc/fixes is still not
 compiling
To: Michael Ellerman <mpe@ellerman.id.au>
References: <4dddbc2a-fc3f-5ea5-54be-8e2a5375db76@linux.vnet.ibm.com>
 <87o9asv5iq.fsf@concordia.ellerman.id.au>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Date: Thu, 15 Nov 2018 00:44:04 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87o9asv5iq.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111502-8235-0000-0000-00000E28205A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010051; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01117590; UDB=6.00579681; IPR=6.00897699; 
 MB=3.00024167; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-15 02:44:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111502-8236-0000-0000-0000435CC994
Message-Id: <91c54115-706f-c614-6776-4b374b0e9e82@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-14_20:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150022
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

Hi Michael,

On 11/13/2018 10:58 PM, Michael Ellerman wrote:
> It looks like binutils 2.27 doesn't accept ULL but binutils 2.28 does.
> 
> Ah yep, here:
> 
>    https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=86b80085c889cd388fa677a5ae9053fd4be3776c
> 
>> The following trivial workaround can solve it by forcing a type promotion on
>> the compiler side whilst leaving the macro taken into the asm code without
>> the UL string:
>>
>> diff --git a/tools/testing/selftests/powerpc/mm/wild_bctr.c b/tools/testing/selftests/powerpc/mm/wild_bctr.c
>> index 90469a9..d2772f4 100644
>> --- a/tools/testing/selftests/powerpc/mm/wild_bctr.c
>> +++ b/tools/testing/selftests/powerpc/mm/wild_bctr.c
>> @@ -47,8 +47,9 @@ static int ok(void)
>>           return 0;
>>    }
>>    
>> -#define REG_POISON     0x5a5aUL
>> -#define POISONED_REG(n)        ((REG_POISON << 48) | ((n) << 32) | (REG_POISON << 16) | (n))
>> +#define REG_POISON     0x5a5a
>> +#define POISONED_REG(n)        (((REG_POISON+0UL) << 48) | ((n) << 32) | ((REG_POISON+0UL) << 16) | (n))
>>    
>>    static inline void poison_regs(void)
>>    {
>>
>>
>> Should I contribute such a fix?
> 
> Yes thanks.

Segher kindly suggested to use explicitly "unsigned long" (thanks!), so I sent
a v2 to:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/181434.html


Best regards,
Gustavo

