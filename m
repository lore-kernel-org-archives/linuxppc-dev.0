Return-Path: <linuxppc-dev+bounces-25233-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6413C55175
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:40:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6WJ6X8Fz2yhP;
	Mon, 03 Aug 2026 16:40:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785739244;
	cv=none; b=AG3td3+kP+RgGFg6Zz+7QVnoSLQlveBWQWgobva/c//z8ld/8oPgHaVe1sCXbp8DmxoC/IEBZoZZuVDujkzFI0V8QxVaDovU3RW0W59m67b9DNc72yLnUHWCMxZj4355H8CImKKVkWhOBuDvnVfz8SW7R0ZlCP4RZpulCjYbGjFizHOK1c4u+L3Cg5IGtt0U87W70jqZzTXb2phIuDbBVB+rVtXAE+eSWbQ9Qn0z6NFzfFRnWgLMP7tnrDmbUqe4uWjUdO76EKe9jvd1PHy2q/QhkB5yx7CwTct+fvDtrgmXZRgDZ3bNcTGjSSotcmneBXRFTBDA0mWgq73zOyqKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785739244; c=relaxed/relaxed;
	bh=Lb6wohb8KJsmy43RQwwPDnPYTJOUBnE/QDIsoU7PHf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LHGtbB0qj4RWNhv8/INI6LQlHG7akAc1YY5G1Q7eVt1x2T/5Yfk6zEu+i+Da5l4HLmwmoaOQVpSgIpaS+yXcZHDXgBoRSe504n0q3vqgWsy06NkZxCzOmgKBCqYJSgYfOY5ZO5DfqrQKFowWkQz6vVpA2txb4GH6UY0RyZ2tAqLMqkJRGmpFzVGJEyYF4BIMZ3XootlUwFnDSVNOaXorGkD6eh9MeMwzIIp7/ebnM0CTia939AWAT37e09hHS9nH8PwPNn2K3A2UlyUEFCOf9uf3Fzl4TDkgKkPpifZZLOKR79xmdZfnnWK0eqbdslLGPlf49FppNCD4hjMi/yqRQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UyosqYuS; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UyosqYuS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6WH63yRz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:40:43 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmkiB225054
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 06:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lb6woh
	b8KJsmy43RQwwPDnPYTJOUBnE/QDIsoU7PHf8=; b=UyosqYuSfDEk0zYvcSAPQZ
	isA2+XD3flIK/GFMgAqTQDr7E+mtkVEx9I6K2dKv5udi7KPzCjrYq/VhCUadi8IG
	OOVh0LufxB8Q6rtiS4prOeQyicxHky1l1NBLAywx5NYYPMu848wwnFzoTdQFqdjM
	24HZg+btp1QLYSADXFac7wsQJ+qcodVXJ0K7XJ9CO8B32Er94crtyO2NqiJylrSc
	SmMc+DBGiVUSB19GpRgtiJD2XR6Hxj1+OyAns77JIFxSyEuMJ5jfQZg/KIfEDhpm
	KoH1wlX/EOh068bjzhc3kl4kg2G8OVT+jc3bDcl1CHUq6UdX+4VH/g+xGFNTUD+Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3q8ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 06:40:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736QGB9015121
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 06:40:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg3w1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 06:40:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736eckw30605672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 06:40:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBA2720040
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 06:40:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 836272004B
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 06:40:37 +0000 (GMT)
Received: from [9.123.10.251] (unknown [9.123.10.251])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 06:40:37 +0000 (GMT)
Message-ID: <f8cb3d48-2566-45a6-80fb-75c4fd614506@linux.ibm.com>
Date: Mon, 3 Aug 2026 12:10:35 +0530
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] powerpc: Add Power12 architected mode
To: linuxppc-dev@lists.ozlabs.org
References: <20260729145405.3230272-1-mahesh@linux.ibm.com>
 <20260729145405.3230272-4-mahesh@linux.ibm.com>
 <aba0e4a7-9364-40cc-a2b1-d03fbe5b51db@linux.ibm.com>
 <anAxLf1YncCCXzNM@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <anAxLf1YncCCXzNM@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a7037e8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=G1olrjtX0pKDVB5CAGcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4Dtmir5zZOUqL8xhWn70pXnJ5g-kLADc
X-Proofpoint-GUID: 4Dtmir5zZOUqL8xhWn70pXnJ5g-kLADc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1NCBTYWx0ZWRfX/oKzY6hP5U3B
 YNMc5OUwNt7UqEBli86FQAo8yvFsqaxynwwbPoH/d4uKiVeDcSswYVz1wI3n10QnUtIbF8ckll8
 f75CyVdLOowmVNX+4J2v9XGA81zGC4w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1NCBTYWx0ZWRfXykZaSkg3FkV5
 llUxX/OkTuha3w8IRx06NjYXwqimFDRls2D/J5oy1HtLLBTDpSCl9B/z6U681OYslxS3NExcr82
 ULVQeZsrppAdM7PjoQCZvpUcCErr7O0GJC6VNYJ7adVfznu284OEj97D2G51JotCdrFVQE2C9JL
 YQZ8W5YcKolL8NYWKH0ixAH1UzGGPgMArWETsdGtNKbTGs9tnk4+S27JfRr6nZIF+8X0AqLYrcZ
 5vML9PA0IWpBM56Rw2v+HPwWYjjtLLa5AvdT0SoOgO9kwq2dEc3ONCo2McFfzo97VmHE8+a/z+J
 5JlUzU6P99yTQWjnHkDKC3YsoKawAX0bp3cMAka8M7z2krDjM1GeDnote9195wRZEfCSMhlH4pb
 +qooBexeChaYKpSVXgQEjb/8yx7b4J9duS8om2KCM3vH08h8cCriMfhxpILrPVo08FGQZoiHoJD
 W6QYeefKTdKxt32wwig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030054



On 03/08/26 11:44, Mahesh J Salgaonkar wrote:

>>> +#define PPC_FEATURE2_DMF		0x00008000 /* Dense Math Facility */
>>
>> Hi Ritesh and Mahesh,
>>
>> PPC_FEATURE2_DMF is added to the uapi header but never set anywhere in
>> this series. Would it be better to drop the #define here and add it in
>> the series that actually enables Dense Math Facility?
> 
> This bit is defined for future use.
> 
> Thanks,
> -Mahesh.


Understood. I have no additional questions, the patch looks fine to me.

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Thanks,
~ Nikhil



