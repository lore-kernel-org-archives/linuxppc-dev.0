Return-Path: <linuxppc-dev+bounces-24274-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02E5C4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 19:08:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h083h1Knxz2xyj;
	Wed, 15 Jul 2026 05:08:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784056128;
	cv=none; b=PTu/TlAXVSCHHIvuOY4zlfN5ZplcumwrUiytPTFgf3V3UKRcR1HyC+/wO81Tcu3DglsjEzhTyO92+naKizczmvHWBsRdTSzz2lQxZIpVsXz4b6F5/i09z3BibKaslLdmFoNAWQ7dVDN1pt4DhrKV+8Ac7sHSV/MM5ZG0W280vIIBgSJ8Q3rFdpaOF1XRQUTeZB/FQhegQt8WrhB4lWHEH66s5y+p05f6/qpAgImaAnCqvgyn+/UHM2YZiZPgXe8lYcylxIlYKZqLHYAKo2tBFt8Dz6X7oCvcnBaxMdUg/MuBiHZm1Cii12Drjsb+8kI56N20KWEvMLAFIF7ohAhgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784056128; c=relaxed/relaxed;
	bh=Vuj+Ht+bWBXgdR7o6mAha/AiCqLJrI8F71+vJEzBqiA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=CQyyGGekicpVhV/BAbwPTL07YQkcsnkPlm03AhC7QPldP+kZKFloXBHesQvncUCJD2uav0j+sKlgMgeRYw0Cc6r3S9ekJ3HcTe522uakrHggPKWRqvg0Bffcejef2/jzcMJIKgXraaxIoXLqnvqke0JFxqakKHo8iDfHnnKQigPXYiXOgJn8/j+JTNFiX7D+eZ24fZbvrcltFhUvixRsY1343oeNpC0Vg1NkS4nRfBcIOy/6gQx3YXSP37WkVQ5LvWk6MsY2zTrpUEeojoUfZ83g9upQkSftegkSdu1vx6ADb6T1L6HrSuH6YAvLkdH15QgektktYJw2WPj03FyUIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k9Mmq61y; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k9Mmq61y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h083f6cQ7z2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 05:08:46 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EGBeLN1812773
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 19:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Vuj+Ht+bWBXgdR7o6mAha/AiCqLJrI
	8F71+vJEzBqiA=; b=k9Mmq61yNsBNzVMbfOSL84uBj944rl9GqpqjPOm6rwnvgz
	I1JxDdo0jlBUb2gF6U37MnJ69/MWPJPfY07zkgmwO2YP2zukeS26OAxJkpgLhmzW
	YqeUv8eeYXpqRMKR+bETdC9/6+U48YZhKjRy2KzwYtxNSQydX7ICOlmWDZ4Ihqpf
	E4nGYCPXNRMECxh/iDvXIQLbslEKSCAd4IqFX5CMaQeH4ubistKYfStkh46apsyA
	eyDFlPxRI5utJ+OE1cWCIYD6YEpLq5yUkblZKhSU9IaH/0fsX9gjj7VMh463tR1w
	kcLy6pnAw/JkqQg+1sdj/t1Ai/My5G0iNZVNe+zg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt7xph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 19:08:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EJ53dA004167
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 19:08:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgc46s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 19:08:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EJ8fqm61079964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 19:08:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8396320043
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 19:08:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADD3720040
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 19:08:40 +0000 (GMT)
Received: from [9.67.149.23] (unknown [9.67.149.23])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 19:08:40 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------GeC8Rz7OlfKB00t0csMADy6a"
Message-ID: <404f6d27-db62-4a21-b364-4c312eb28f87@linux.ibm.com>
Date: Wed, 15 Jul 2026 00:38:38 +0530
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
Subject: Re: [PATCH v3] PCI: pnv_php: Add null checks for OpenCAPI PHBs
To: linuxppc-dev@lists.ozlabs.org
References: <20260609084903.1352581-1-adityag@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260609084903.1352581-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lB1Yl2MfiUdnK4Y8OQmy-sa2a4555u8P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE5MyBTYWx0ZWRfX9F/1uL9zKwR5
 IeBH7vvD0MZ31U63Ae7BRDglpou3XSy9HviAULjUDJ3Z8Ex/wXuZa7mqggLHo90JSmMJZVOPqCh
 QCW5ju3t9BdZiBZoYKPhIgO+GAKJzYc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE5MyBTYWx0ZWRfX0z4Zy3xQxmrq
 aZvPBxdrF1M3i2u6tN86nX7qARgRH312Khd5F2V5kRVf5H2QDK1PBPFzGAtC/3XVF1apEXdTLAQ
 9L3eUjEeprrdlSYwSB6cxuibBGYRoAMXIrO5NhhrHYEPq5gF0hNEvLLzPL6kLpcz37AMfVLJseJ
 IsH3Y5hbHXuY0i7k7mzWxjYKUaBe2idJ67HQlHsHxV1sdP4u14bdb+y2JiM9YsjJWkgOiISws9Y
 iHiXPbwlLFKBxHz/1wRExaLFN4Hz50PKKKutTrSTuZ4eewDaizlJAA1X6cbuqwVxBywIxRrcC3J
 buqqCI6XGPg9B9wQmsIzG/zx81WnhmXly6wSE7fVaVCyM7enltk1s9lme2vVMpLAjT0p5soadbr
 8j2rOCurqvHi+kypPTS0QbjWgl+KHaKi2kz0TzPhyOi2khHdVDBqueNsHlQj1HeACtZ/ymGaCZj
 MKHecLPbfLuo3CjVFRw==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a56893c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=r77TgQKjGQsHNAKrUKIA:9 a=h1lzkvbI6--FBJ429TUA:9
 a=QEXdDO2ut3YA:10 a=VnNF1IyMAAAA:8 a=SZfh5tWvwiCKCnnFSAkA:9
 a=IPrSfL2mXS_VxbUp:21 a=_W_S_7VecoQA:10
X-Proofpoint-GUID: lB1Yl2MfiUdnK4Y8OQmy-sa2a4555u8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140193

This is a multi-part message in MIME format.
--------------GeC8Rz7OlfKB00t0csMADy6a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aditya,

The added NULL checks for OpenCAPI/direct PHB slots make sense. The 
patch looks overall good to me but I have one question about below change:

On 09/06/26 14:19, Aditya Gupta wrote:
> +	if (!bridge) {
> +		*state = 0;
> +		return 0;
> +	}
> +

Is returning success with an indicator state of 0 the expected behaviour 
for slots without a bridge, or would returning an error such as 
-EOPNOTSUPP(Operation Not Supported) or -ENODEV(No Such Device) be more 
appropriate?

Thanks,
~ Nikhil
--------------GeC8Rz7OlfKB00t0csMADy6a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Aditya,<br>
      <br>
      The added NULL checks for OpenCAPI/direct PHB slots make sense.
      The patch looks overall good to me but I have one question about
      below change:<br>
      <br>
    </p>
    <div class="moz-cite-prefix">On 09/06/26 14:19, Aditya Gupta wrote:<span
      style="white-space: pre-wrap"> </span></div>
    <blockquote type="cite"
      cite="mid:20260609084903.1352581-1-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">+	if (!bridge) {
+		*state = 0;
+		return 0;
+	}
+</pre>
    </blockquote>
    <br>
    Is returning success with an indicator state of 0 the expected
    behaviour for slots without a bridge, or would returning an error
    such as -EOPNOTSUPP(Operation Not Supported) or -ENODEV(No Such
    Device) be more appropriate?<br>
    <br>
    Thanks,<br>
    ~ Nikhil
  </body>
</html>

--------------GeC8Rz7OlfKB00t0csMADy6a--


