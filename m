Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481F9ECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 15:14:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A59F2150D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 15:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A59F2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZwhL4fCrzF3Zx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 02:14:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZwfK2BD4zF3TN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 02:12:56 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9HF7MKK069258
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 11:12:54 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n663t4q82-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 11:12:53 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 17 Oct 2018 11:12:53 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Oct 2018 11:12:51 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9HFCoDi27656398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 17 Oct 2018 15:12:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8C14B2065;
 Wed, 17 Oct 2018 15:12:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 773B9B205F;
 Wed, 17 Oct 2018 15:12:49 +0000 (GMT)
Received: from oc5000245537.ibm.com (unknown [9.85.171.202])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 17 Oct 2018 15:12:49 +0000 (GMT)
Subject: Re: [PATCH v06 3/5] migration/memory: Add hotplug READD_MULTIPLE
To: Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20181015194738.5705.88953.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <f38687fe-7d46-830b-e4bb-ef78a7f99a65@linux.vnet.ibm.com>
 <87sh16lo72.fsf@concordia.ellerman.id.au>
 <80494db2-6a01-059f-890c-df7c410714f7@linux.vnet.ibm.com>
 <8fa9d2c2-97a9-69ac-1e3b-cdf867e225e2@linux.vnet.ibm.com>
 <871s8pl7p4.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 xsBNBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAHNLU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPsLAeAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/Us7ATQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABwsBfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Wed, 17 Oct 2018 10:12:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <871s8pl7p4.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101715-0040-0000-0000-0000048202E2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009892; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01104018; UDB=6.00571503; IPR=6.00884071; 
 MB=3.00023795; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-17 15:12:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101715-0041-0000-0000-0000088A1957
Message-Id: <ba686c81-4f44-f04b-91a8-7f86cf0ec977@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-16_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810170130
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
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/16/2018 07:48 PM, Michael Ellerman wrote:
> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>> On 10/16/2018 02:57 PM, Tyrel Datwyler wrote:
>>> On 10/15/2018 05:39 PM, Michael Ellerman wrote:
>>>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>>>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>>>> index 2b796da..9c76345 100644
>>>>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>>>>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>>>> @@ -541,6 +549,23 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
>>>>>  	return rc;
>>>>>  }
>>>>>
>>>>> +static int dlpar_memory_readd_multiple(void)
>>>>> +{
>>>>> +	struct drmem_lmb *lmb;
>>>>> +	int rc;
>>>>> +
>>>>> +	pr_info("Attempting to update multiple LMBs\n");
>>>>> +
>>>>> +	for_each_drmem_lmb(lmb) {
>>>>> +		if (drmem_lmb_update(lmb)) {
>>>>> +			rc = dlpar_memory_readd_helper(lmb);
>>>>> +			drmem_remove_lmb_update(lmb);
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	return rc;
>>>>> +}
>>>>
>>>> This leaves rc potentially uninitialised.
>>>>
>>>> What should the result be in that case, -EINVAL ?
>>>
>>> On another note if there are multiple LMBs to update the value of rc only reflects the final dlpar_memory_readd_helper() call.
>>
>> Correct.  But that is what happens when we compress common code
>> between two disparate uses i.e. updating memory association after
>> a migration event with no reporting mechanism other than the console
>> log, vs re-adding a single LMB by index for the purposes of DLPAR / drmgr.
>>
>> I could discard the return value from dlpar_memory_readd_helper entirely
>> in this function and just return 0, but in my experience, once errors start
>> to occur in memory dlpar ops, they tend to keep on occurring, so I was
>> returning the last one.  We could also make the code smart enough to
>> capture and return the first/last non-zero return code.  I didn't believe
>> that the frequency of errors for this operation warranted the overhead.
> 
> The actual error value is probably not very relevant.
> 
> But dropping errors entirely is almost always a bad idea.
> 
> So I think you should at least return an error if any error occurred,
> that way at least an error will be returned up to the caller(s).
> 
> Something like:
> 
> 	int rc;
> 
> 	rc = 0;
> 	for_each_drmem_lmb(lmb) {
> 		if (drmem_lmb_update(lmb)) {
> 			rc |= dlpar_memory_readd_helper(lmb);
> 			drmem_remove_lmb_update(lmb);
> 		}
> 	}
> 
> 	if (rc)
> 		return -EIO;

Okay.

> 
> cheers
> 

Thanks.

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

