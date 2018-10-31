Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6FFC6786F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 00:11:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4453920664
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 00:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4453920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42l7zh6M4DzF2Pp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 11:11:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42l7xh0QjKzF1fD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 11:09:43 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9V04aT2083380
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 20:09:41 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nexwxw847-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 20:09:41 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 31 Oct 2018 00:09:40 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 31 Oct 2018 00:09:37 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9V09aQr43188410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Oct 2018 00:09:36 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62A162805C;
 Wed, 31 Oct 2018 00:09:36 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A58402805A;
 Wed, 31 Oct 2018 00:09:35 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.85.171.36])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 31 Oct 2018 00:09:35 +0000 (GMT)
Subject: Re: [PATCH 2/2] selftests/powerpc: Skip test instead of failing
To: Michael Ellerman <mpe@ellerman.id.au>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Breno Leitao <leitao@debian.org>
References: <1540326197-15537-1-git-send-email-leitao@debian.org>
 <1540326197-15537-2-git-send-email-leitao@debian.org>
 <56cdd832-6229-bf95-58ee-1783f931e7bd@linux.vnet.ibm.com>
 <132d7e4f-153f-8ba4-95f2-f0d9c1a66f28@debian.org>
 <87efc8be37.fsf@morokweng.localdomain>
 <87r2g7ihwi.fsf@concordia.ellerman.id.au>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 17:09:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87r2g7ihwi.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18103100-0060-0000-0000-000002CA129C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009956; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01110361; UDB=6.00575332; IPR=6.00890454; 
 MB=3.00023971; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-31 00:09:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103100-0061-0000-0000-00004708633A
Message-Id: <fd8d4568-c69c-5e90-27f6-574a4bc88d2c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-30_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810300199
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
Cc: linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/30/2018 08:16 AM, Michael Ellerman wrote:
> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> 
>> Breno Leitao <leitao@debian.org> writes:
>>
>>> Hi Tyrel,
>>>
>>> On 10/23/2018 05:41 PM, Tyrel Datwyler wrote:
>>>>> --- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>>>>> +++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>>>>> @@ -352,17 +352,11 @@ static int write_core_pattern(const char *core_pattern)
>>>>>  	FILE *f;
>>>>>
>>>>>  	f = fopen(core_pattern_file, "w");
>>>>> -	if (!f) {
>>>>> -		perror("Error writing to core_pattern file");
>>>>> -		return TEST_FAIL;
>>>>> -	}
>>>>> +	SKIP_IF(!f);
>>>>>
>>>>>  	ret = fwrite(core_pattern, 1, len, f);
>>>>>  	fclose(f);
>>>>> -	if (ret != len) {
>>>>> -		perror("Error writing to core_pattern file");
>>>>> -		return TEST_FAIL;
>>>>> -	}
>>>>> +	SKIP_IF(ret != len);
>>>
>>>> If we don't have proper privileges we should fail on the open, right?
>>>> So wouldn't we still want to fail on the write if something goes
>>>> wrong?
>>>
>>> That is a good point. Should the test fail or skip if it is not possible
>>> to create the infrastructure to run the core test?
>>>
>>> Trying to find the answer in the current test sets, I find tests where
>>> the self test skips if the test environment is not able to be set up, as
>>> for example, when a memory allocation fails.
>>>
>>> File: tools/testing/selftests/powerpc/alignment/alignment_handler.c
>>>
>>>         ci1 = mmap(NULL, bufsize, PROT_WRITE, MAP_SHARED,
>>>                    fd, bufsize);
>>>         if ((ci0 == MAP_FAILED) || (ci1 == MAP_FAILED)) {
>>>                 printf("\n");
>>>                 perror("mmap failed");
>>>                 SKIP_IF(1);
>>>         }
>>
>> I think TEST_FAIL means the test was able to exercise the feature
>> and found a problem with it. In this case, the test wasn't able to
>> exercise the feature so it's not appropriate.
>>
>> Ideally, there should be a TEST_ERROR result for a case like this where
>> an unexpected problem prevented the testcase from exercising the
>> feature.
>>
>> If we're to use the an existing result then I vote for SKIP_IF.
> 
> Yeah I agree.
> 
> See for example some of the TM tests, which skip if TM is not available.
> Or the alignment test which skips if it can't open /dev/fb0.
> 
> In this case it should print "you need to be root to run this" and then
> skip.

Agreed that there should be some indicator of why we are skipping the test. My original point I was trying to make was that I thought skipping a failed open was okay because we are likely not root. However, I wasn't sure that a failed write was okay to skip as that could be an indicator that something has actually been broken.

-Tyrel

> 
> cheers
> 

