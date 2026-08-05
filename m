Return-Path: <linuxppc-dev+bounces-25433-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B2FC55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 12:03:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFTb70WWWz2yLY;
	Wed, 05 Aug 2026 22:03:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785931426;
	cv=none; b=hgs8kK7DxKxTHjBR+6RjEnodqPJNmGOaJEiejtD33xrjdHORnWxQOcwR6W2OBwHagvrd6TstJ0hC4mjW3vd+CKGhMTnEbEM29dqdZLmEbgYl0NTdkyeOWoqCoRV2LA2LPVpd2YepWiIYW705LyL2hD3pLDtO0EmcW+9kObeSlE6BdUD9B/weQRUsa48fMvUZWf/U8kDJ+M3nwb7yU3rf/57JhvfCo3j+KD574dnF4o+nz23inATckN4YvRUBKbblO6zZYfn4rIObkf5II+oDtMhJi2Sbt0QQVmoywc5cbbMLYJEl3H4nrSGKXJaSaR9b6Jfs3R9JYgx5jgkmfahnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785931426; c=relaxed/relaxed;
	bh=eonv3oMHZsuXrNPjwYVsk5UoJkgHfRvx1phvOe9Uksk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xlf6gVFmc58T0nOti4ehUH07+MqLpxxc20U5nh5vP7wKVG7jyCfGbayee5SJXMi6K+48YV78eoqLvNPdsU9FMe4UMn/54AeusVLO1rKzjp49KNU18EkZfNqvoa5T315l5xUwLuS7PRPhB1YJo+jxiMWln/MX8KeQuUH969lQTOKA+lknww3iAY3nW+TEgg49/4gXXpIbDxJTKEabkXN3CfN1VXEobmRFVf6yjRa5sDtD6i2sHmAJXgb/seM2KMKf9lLoxmZkTiGWm3HuLu+auynVMl+pO8ydrvjZ/JGPpfS1jFp3gNwbQHwOEh5fnilOqeEZf44PWaz4yhW0Nvyl4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QdgVQq+Q; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QdgVQq+Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFTb56Xlxz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 22:03:45 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lWji3387171
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 12:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eonv3o
	MHZsuXrNPjwYVsk5UoJkgHfRvx1phvOe9Uksk=; b=QdgVQq+Qa8biDQhvESuqXQ
	9aMsSEpxerZREyU7zBgQPaFi/5Uk7n3bf31Hzrl/RABHAWxRmKdiQjtVWBYNV6bm
	nfakU5S/LCCQhJAAJqLVBAu7bL8FS0mt2aa814rpZt+NxNRH1R4AmhAN0TjZNhLs
	LbMejUGEyaSXAuNt0DSV5G+s5PpDZx8W83s+21sbYEdvMTDPyl51IvDXzrVTtDm7
	U2HK4MhuQcPhtHwHx0X82EUrHXSZc41zUWuANO7Zfe/bSC+hRpy2dvEInh3V16t4
	KCHMJZyYwnOJSMXx/0+VmqPQUvo/UTXOsgAR9DImPDBq/zDmJlGYoXcqq9uMoMaQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h52v9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 12:03:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BunHJ001198
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 12:03:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyp649-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 12:03:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675C3dx040370444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 12:03:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AAEE2004D
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2026 12:03:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C0E620043
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2026 12:03:39 +0000 (GMT)
Received: from [9.43.76.92] (unknown [9.43.76.92])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2026 12:03:38 +0000 (GMT)
Message-ID: <5e057554-dd0d-4add-8012-d03cda3dbefa@linux.ibm.com>
Date: Wed, 5 Aug 2026 17:33:33 +0530
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
Subject: Re: [PATCH v3 1/4] powerpc/pseries: Limit PVR list to 16 entries for
 CAS negotiation
To: linuxppc-dev@lists.ozlabs.org
References: <20260805110924.3853410-1-mahesh@linux.ibm.com>
 <20260805110924.3853410-2-mahesh@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260805110924.3853410-2-mahesh@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX4zzMnl0/i4GB
 JJom4veA7m/PkDeyUOZV6jbc0bTqKCddlkSJ9TWYaOKzJ2IKMuxchAs1d9Zb/+w7yHPRr5AXoJZ
 I515bYOGCMkmgedDBOytMXh3c13fqFY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX8qwRXCaSAlyU
 VGDJNywSaKRrRLdbLTUIu37DrzuNSAymbBtnLmOit5moiNbnb/ChRCkp6/myj2zz2ovXQdqHiew
 TmWJhz0RFqD2oE0CxJaaWnn/vwW3ylp/y7A0va4/KsKhQpJSbwiORbpmGDJxxc/VYCaATFqMZiH
 kZy8lFBiySmULRyLUxuZs1zsRJXxt8Bw8xY+ZgX9a+DQdG32631EjFwV6hl/BM3Owtg2Qe/UeYa
 mOzLS0tr7kKhBziwE9oHkCPEUz0xhc6I+vEdtpUjRfXZKvVSfLn861rqnqVObfCJiKk4wkreuZF
 jOKjjxdGx1qjrLOEcsYvC4+bFsnb6Hwj6NImX9SnWG6aQ5+SUXfQPrucyH/QuhlRzd0qwNg4s70
 mtc/HowbZ7Vcoq5dEOv1pQx/RNfPiaArM/OZuhqu7S44yCEk+E2j7i0BI18UrvG74bHUqsG5czZ
 pCed8tsPFPQUr4sOW4A==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a73269e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=2QCfGHd509E9zJr3CTUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GI8X7q6vP5UltV31tTtbJIp4bGKYNMXd
X-Proofpoint-GUID: GI8X7q6vP5UltV31tTtbJIp4bGKYNMXd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050094



On 05/08/26 16:39, Mahesh Salgaonkar wrote:

Thanks Mahesh, for addressing my review comments which I raised in v1, 
the patch looks good to me.

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Regards
~ Nikhil

