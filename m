Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197D606AA26
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZXKhegGN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNsmq237lz2xfK;
	Tue, 10 Nov 2026 14:38:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794281883;
	cv=none; b=KOh6wlqKqYg93qbRCnqQjoLIB+7SAklaTbU5Wpb/2bFtwbO6P/Wc8PjsBZBE3zUNy0T79VgFECCsVGfjEi+gThuceAHPGezEXNJP9Gq2inYiNtqH1WSq1/4+Q9bdWK1aQDbhL1OcL1F6eMDqP+264Uoh0CdgTkAix0C8/LXapRGghFZM6R42GA9XW9Hp2VMlRl92dM59CuVBmLn3a5jk78jIpOYOSQ0Kjt6m+un+hCdpQHxInUFCGgcuyjV8f4SDdnSWAbr9xAlK4Lc9bWXuYlLOelt1vW+xpvJan4eEJecGeNdfpohuR89W8Cj+l4nMbiluyZBO2H7vYo2MInHMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794281883; c=relaxed/relaxed;
	bh=RizbXeQwSS8Q6T8pRtftF5Z2CgoWFTnXtYNX9zCDglQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAgd4SxyyRgqNJ4h0ECXtO2TvhCY+tTI/u0VuZf4o8k51SYr5lRs5GnDneSDBr+N7I1SzelBRcLDFZnke5OLObb5Yvfw60ubyQgZEjm4rI0SxgYgUl5D2ATVh2xqFzJpP8/yORFFJp65s1CvMuplETwWyT2ceERH9/ERekh21H55nVTUZxzZnXNqLBEY+eVUZ9a0E6KJl2TU5U6XdhcScQKUreHu97CSrmWNJ2ritazuZunpbmvx9w2RSg6yRo+ePcAiXFyycIR4ndCpdK3EbPannyjgWzTh0DwIgnQd1pHlbEaE01MvIJuPyCO46xPGmUZTHheDsqeaLvuUYKwPtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZXKhegGN; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZXKhegGN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNsmp2f7tz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 14:38:02 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0idpc3480957;
	Tue, 10 Nov 2026 03:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RizbXe
	QwSS8Q6T8pRtftF5Z2CgoWFTnXtYNX9zCDglQ=; b=ZXKhegGNUSSqlcBka8IlLn
	reOXaigECu+ybMo/jzGozPuTBANd6cfhDW0IU0I0YH2cxcg2FVSi0ZDQ8jwkAC5a
	o8aHmKoizH323tSYmhusHwCfPwrJHS4c+NEwJmG4LKWBYtdVl3PEbSDTi+B9Bw4O
	0FoQ7APsGVp2aesyBX+SnMuLqqMW2b+gFz5+NpQGDpk52rmwu5FyBNy2pkX9kxCN
	IjI9uwjCy2JRZlPluaw/CjBsat4WmLupghwM2JHl+ZOfkCxqrrye5spYRQ7kub00
	xi7CbzxYmfzrd7resx2gahUk+oDbWQzYO0JChMGPAcJ4Pd4ei567F2jByfTZiJxQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunt2yk4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 03:37:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0nwmH4070475;
	Tue, 10 Nov 2026 03:37:47 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg4np5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 03:37:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA3bkG58323622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 03:37:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE8D45803F;
	Tue, 10 Nov 2026 03:37:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78DBB58061;
	Tue, 10 Nov 2026 03:37:41 +0000 (GMT)
Received: from [9.123.14.23] (unknown [9.123.14.23])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 03:37:41 +0000 (GMT)
Message-ID: <eacfdd0e-1e8a-453c-977f-d3717c22ed12@linux.ibm.com>
Date: Tue, 10 Nov 2026 09:07:40 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/9] keys/trusted_keys: fix PKWM output buffer cleanup
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, stable@vger.kernel.org
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-3-ssrish@linux.ibm.com> <auy450SsVheY_yCz@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <auy450SsVheY_yCz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxMiBTYWx0ZWRfX77wfdAw6OZKN
 jP/t5IIBCLmddI+wnXkRoDtnxUMIVYAEa1F4S102D5W192pH1ZIWJL8O9zPhUzi6mDeHOEnSdTb
 c4wlrhZGodzyncEvMd617okIFtlCrZNAqblAPZGVP/hC/kcVBV8Y4k9b+QZuak8vn3sd7M8RrOA
 7PPpLkrD25YZJxBijmLStdkNuVyyXgHr57qaEo4IvLyGwlPf7BAF/drUyT9KZ2sWZKGvXzM6ufA
 3NxHfpwBftZ8jdfWYfswl8wSrhKIJuJDBpLQES16Cj/eYcKzjRjm0dxdJZNQi3vViqwS3bvr9wf
 1tp16xEHeh668b3RnEIZshAVTbMGPdK+fTXUYo6p9AehkPd6lfge6qFmnKuhOPTJDbtLoyHUrV1
 5hJ2jltAUA/EGiGwncxBLzYu5RU4qFngqQoID7E7Oxaas9KUtyzLVvGBzW5c8pq1z5KPBcaKFJG
 ueNgrzRfkhmQcmF7wTg==
X-Proofpoint-ORIG-GUID: NIx-aZp2D-AFmjTdtAtrrQOBx5IQHvFq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxMiBTYWx0ZWRfX2V858s0WhzrR
 dHd89HgQnRzuOFHcP50QQ753QpWueEtEZfmHDnEZcyzieM5a85YPkXTaL3bqA8Y+VeGUGSdYM18
 XlyO6hG3e6G5TNoFs7bgVmG3E28nWVU=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af2918c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WH08Y0zQAg0zyyIRucIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: S7C16z5zsO0DXYXtKNTprjsF-w-cRkVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100012
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/5/26 10:42 PM, Jarkko Sakkinen wrote:
> On Thu, Nov 05, 2026 at 08:13:13PM +0530, Srish Srinivasan wrote:
>> The PKWM seal and unseal paths unconditionally free their output buffers,
>> but the PLPKS helpers can return without initializing those pointers.
>>
>> Initialize the output buffer pointers to NULL to make cleanup safe on early
>> failure paths.
>>
>> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
>> Cc: stable@vger.kernel.org # 7.0
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> ---
>>   security/keys/trusted-keys/trusted_pkwm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
>> index 422f752598e1..97ffec0ce1b7 100644
>> --- a/security/keys/trusted-keys/trusted_pkwm.c
>> +++ b/security/keys/trusted-keys/trusted_pkwm.c
>> @@ -82,7 +82,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
>>   {
>>   	struct trusted_key_options *options = NULL;
>>   	struct trusted_pkwm_options *pkwm = NULL;
>> -	u8 *input_buf, *output_buf;
>> +	u8 *input_buf, *output_buf = NULL;
>>   	u32 output_len, input_len;
>>   	int rc;
>>   
>> @@ -129,7 +129,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
>>   
>>   static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
>>   {
>> -	u8 *input_buf, *output_buf;
>> +	u8 *input_buf, *output_buf = NULL;
>>   	u32 input_len, output_len;
>>   	int rc;
>>   
>> -- 
>> 2.52.0
>>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>


Thank you for the Rb, Jarkko.


>
> Br, Jarkko

Thanks,
Srish.

