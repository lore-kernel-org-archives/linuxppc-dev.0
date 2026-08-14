Return-Path: <linuxppc-dev+bounces-25835-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF615C5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 05:40:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLrfZ73Xrz2yQH;
	Fri, 14 Aug 2026 15:40:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786686022;
	cv=none; b=mFjkt9bbnQ/mfwx3v+X0Iqkec+hqvPJEYdKWGm3wlifnpa/sznqXuHGEGYr0qSHe2sz0YKKrGxoe+pFYZ1jgdujFpQmfAwUoR4fi9INJdKth27SOn6/fvxptw32nE65L3qabb9bfuXZsPN4Hll4IFs3asLzdpTjg+txkRYgLmJQSnxcW307tBYHKi+TQ3l0pUPFRHh1VHeMsm6/8IhKHToV8DPPd6gb8R1E4+7PcrBnAiovVm+X88ppiH/3O5Pma7S49e5YUXwVXSh+s+T7GupAKzHBkq/avLdvi+NO35GSAgi4kwWKje8aQyVQPy/dn/tiNiFT47vacZxMdHNMNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786686022; c=relaxed/relaxed;
	bh=cFW7DESud6rIij4JxaaBn6Vdo1dsHqEcjEYmXXvvEJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k/AMdmzj5sMme0BUeoaMcgsUi61mfaHowTjhGjjU2moyQ5I/p8ZslNavXyfOOsxpNOqP7vJGeSEqa3S1HykCr5n+maPEbowFMUm+4V3hoLAQq7vrw6bc07DPahOP3rAlSZJOL1Aj5Tcz9kN7VGTrT0Th/ju0NOtR31o3OlI8cXxrwVgOegnMkwXFAimL5zFHbKb0gqkuO2WJZNhoytoj8eYEkAZkWDpCimMZmL4igRYDAyHgBkLeOewOeG7OE7USwa9b3WYw2t57KB3L3dgvFDD/+L0nZ04WQ3c9dwER97iXtG6t+c4NuJyuiMqUpk9IyhEfqJFCr+uzd4BuHlNYkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cweFpa5p; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cweFpa5p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLrfZ0tdHz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 15:40:21 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4VlM52471582
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 05:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cFW7DE
	Sud6rIij4JxaaBn6Vdo1dsHqEcjEYmXXvvEJU=; b=cweFpa5p1g3Sm/Nufw3gb9
	F0Kaegq03FMcQhI9VN0J2VyjSQ43yPdVEN28csPs+1hkmLTYWiBQBDH6Ac+/uK+8
	hDSyY46z4Xe7l8Aj5TZ1Ti93zo2n5T3t134eAlUcp580uMZErmRTXI0LpwSHrWAW
	2YH/7WxIiPHWnFuERgXhfZm84L71rrncvqcc0wN1TDVzQgBIBTzxzpFS/nh3nGCu
	pfjPUsrOilEOXSATZfxKUjX6+oiHKUUSvw2CEDankKf7OqEeQsx9KRdDz+ArRMsg
	gpFoFAUUkjMhR6YboBQdVzLG88q9yYvUrSPEBSaMVUnY0JhZ8apGIumDE608hBWw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk0bb6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 05:40:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E5QJN7023431
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 05:40:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hdyd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 05:40:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E5eG9L29164014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 05:40:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2CFA20043
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 05:40:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22F1A20040
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 05:40:16 +0000 (GMT)
Received: from [9.43.75.52] (unknown [9.43.75.52])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 05:40:15 +0000 (GMT)
Message-ID: <2dc3cfe9-33b5-434c-9758-7f03f0af0e1a@linux.ibm.com>
Date: Fri, 14 Aug 2026 11:10:15 +0530
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
Subject: Re: [PATCH v3 4/5] powerpc/pseries/eeh: Implement RTAS-based EEH
 error injection
To: linuxppc-dev@lists.ozlabs.org
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
 <20260721033815.5300-5-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260721033815.5300-5-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA0MSBTYWx0ZWRfX93yCc8wesyJ8
 XJG+VOdzFpts8aZtiSaK4PjMZD0wiSSOV/kCvqnUzm6GgcwqZncyKJFiAQDuM+jpPW3hxbVtDPy
 sJUps036Ui4jp74a745tSMmhzP9ztNtLo/jDzhZpKCU3oJ2/5sqRu8JQSaID3irM/sE+fmpCruJ
 2vE3JE6QJtpjFkdpskem5OEVdAL2dP89iKOHwfHOD2damySAMxa4AA0StlzhMzc3UI2kFlgyQAX
 DH2ILSrBQMhljTl9WBuZxlWdSGicyO0BEKOqPdUurX8aNi0j4qMDU/n7/o/cZ9CeUQjQIkIYKvl
 HuJ+5P6Q4P62Xghz5SlhZODyHfF3v8kVCunGHUy28wYhxvuDjfLWEvVFvKijbBPwXnvRxYrYrPn
 JULT3bvGQHTLIIMmonjIlEvZQEX5CYO8fCxsgYVhQMM5crM7gk5VLaqCtFG6lCskR1PVZyc7yJX
 JSc6JRWHSN3gUDYUV4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA0MSBTYWx0ZWRfXxC0d8+Sb/Q1Q
 Qs4E2EL/QjHCaSq9y/PYdunsf/uK0LNliBJql7Q95xznaTRBVsyoowAsx+Wa9886S2+teAh6pLP
 RFHuUOjyp23DeSlBvOIfkzJII4H7+e4=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7eaa44 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=m4GIexyGO6dlE0cnW38A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: r7eWFfFii86JGyg1gmAedjiolYCszZDl
X-Proofpoint-ORIG-GUID: r7eWFfFii86JGyg1gmAedjiolYCszZDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140041



On 21/07/26 09:08, Narayana Murty N wrote:
> +out_unlock:
> +	mutex_unlock(&rtas_errinjct_mutex);
> +	return rc;
>   }

Hi Narayana,

Should we translate the raw RTAS return values held in rc into standard 
Linux error codes (like -EINVAL, -EIO, or -EPERM) before returning from 
pseries_eeh_err_inject()?

Thanks,
Nikhil

