Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FFEC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 22:12:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29672082D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 22:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29672082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kTP30Q0GzF0yr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 09:12:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kTLz34yZzDrNw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 09:10:48 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9TMAhxm002512
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 18:10:45 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ne9kqtvyd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 18:10:44 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Mon, 29 Oct 2018 16:08:56 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 29 Oct 2018 16:08:53 -0600
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9TM8qJx14352464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Oct 2018 22:08:52 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EBF9BE051;
 Mon, 29 Oct 2018 22:08:52 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEC34BE04F;
 Mon, 29 Oct 2018 22:08:50 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.173.218])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Oct 2018 22:08:50 +0000 (GMT)
References: <1540326197-15537-1-git-send-email-leitao@debian.org>
 <1540326197-15537-2-git-send-email-leitao@debian.org>
 <56cdd832-6229-bf95-58ee-1783f931e7bd@linux.vnet.ibm.com>
 <132d7e4f-153f-8ba4-95f2-f0d9c1a66f28@debian.org>
User-agent: mu4e 1.0; emacs 25.3.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH 2/2] selftests/powerpc: Skip test instead of failing
In-reply-to: <132d7e4f-153f-8ba4-95f2-f0d9c1a66f28@debian.org>
Date: Mon, 29 Oct 2018 19:08:44 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18102922-0012-0000-0000-000016D05D79
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009950; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01109841; UDB=6.00575020; IPR=6.00889933; 
 MB=3.00023956; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-29 22:08:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102922-0013-0000-0000-000054EDDEF0
Message-Id: <87efc8be37.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-29_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810290196
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


Breno Leitao <leitao@debian.org> writes:

> Hi Tyrel,
>
> On 10/23/2018 05:41 PM, Tyrel Datwyler wrote:
>>> --- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>>> +++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
>>> @@ -352,17 +352,11 @@ static int write_core_pattern(const char *core_pattern)
>>>  	FILE *f;
>>>
>>>  	f = fopen(core_pattern_file, "w");
>>> -	if (!f) {
>>> -		perror("Error writing to core_pattern file");
>>> -		return TEST_FAIL;
>>> -	}
>>> +	SKIP_IF(!f);
>>>
>>>  	ret = fwrite(core_pattern, 1, len, f);
>>>  	fclose(f);
>>> -	if (ret != len) {
>>> -		perror("Error writing to core_pattern file");
>>> -		return TEST_FAIL;
>>> -	}
>>> +	SKIP_IF(ret != len);
>
>> If we don't have proper privileges we should fail on the open, right?
>> So wouldn't we still want to fail on the write if something goes
>> wrong?
>
> That is a good point. Should the test fail or skip if it is not possible
> to create the infrastructure to run the core test?
>
> Trying to find the answer in the current test sets, I find tests where
> the self test skips if the test environment is not able to be set up, as
> for example, when a memory allocation fails.
>
> File: tools/testing/selftests/powerpc/alignment/alignment_handler.c
>
>         ci1 = mmap(NULL, bufsize, PROT_WRITE, MAP_SHARED,
>                    fd, bufsize);
>         if ((ci0 == MAP_FAILED) || (ci1 == MAP_FAILED)) {
>                 printf("\n");
>                 perror("mmap failed");
>                 SKIP_IF(1);
>         }

I think TEST_FAIL means the test was able to exercise the feature
and found a problem with it. In this case, the test wasn't able to
exercise the feature so it's not appropriate.

Ideally, there should be a TEST_ERROR result for a case like this where
an unexpected problem prevented the testcase from exercising the
feature.

If we're to use the an existing result then I vote for SKIP_IF.

For reference, here are the test results that DejaGnu supports (it is
the test harness used by some GNU projects):

https://www.gnu.org/software/dejagnu/manual/Output-States.html

I would say that SKIP_IF corresponds to UNSUPPORTED in DejaGnu.

--
Thiago Jung Bauermann
IBM Linux Technology Center

