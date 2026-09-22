Return-Path: <linuxppc-dev+bounces-27898-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DF1C982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 08:07:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpt3s4D7sz2ygK;
	Tue, 22 Sep 2026 18:07:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790064425;
	cv=none; b=UbZn/RkVJVXPaWG7mk1siKGslbD1XZIhE6AEXOSnZfXPHlMXGriy5+opptRa27pWTNHnAFfqN4zh8f3WaiG/dMfnO4LHwmJFREAVrJR+Ka/xOZI9pzhTc/FDhxlwHI71/j7yseAVuE+UG9j9suswCVOl0X0dnueY8Uvl5DESotO0e1tqZus/Hiyq8ku0Zw3Ij1HrljTjhpZYaoUld02VOshwcwZOgSEEhzTYh/fZWrJ2tfJF6yM1cj8AqAUvzMQauTK+wA0n1W/1ZXS07jeOSFU4DeK2wF72NufbUNHw1irVT8ZHTNB1Xun6HAPwvR1VXr0Q75wI5T0buGeg36VIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790064425; c=relaxed/relaxed;
	bh=veofPPVFic/lvSAI24x5IEF3mKgql9Wu+Wi6xp2PVcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjlgVROKdUsfg5Ajnsa/VW8dqnQV87Z/zM8hjXhMQX3yAWma8oZ5RelGI+5fqRe7wvdDBEC3PKOFAkjx8yv4aTjR+FLHpt1eIbyzMGxtXmYZGqlpb4YvFQmCBs8C80UqKIxxJknAsr7oY5+c//RYv5PEQBYA7Vyo4UP+US5j6IxOm7DJlLIPyxxaZX9VZhu8NMf0vi2b17iLpebI33Dkhnxo8pFv94Lrl3iE5LyjkB27Kx5oo4Uh3EWQUqoCxXALT5q4l86odQ5MW8fJLoIE01MXmJZkPg/+hn8cJMpj7XvdBznQmFT7JFI2eSkV8snamZ12CyremgJ8NMs/XeiZvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Tm5XqziW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Tm5XqziW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpt3r62HZz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 18:07:04 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05Pc22948355;
	Tue, 22 Sep 2026 08:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=veofPPVFic/lvSAI24x5IEF3mKgql9
	Wu+Wi6xp2PVcA=; b=Tm5XqziWjXyIhwOHQLj++CU+dS/tWELZr5HG4fTS0mqka4
	irIp1DuomdOmqgAGWBwWlRTRttfrfEVKT3yQzAwZyyurAUx3zG8ja6+WPOAesBwn
	YGW6lxxeViDSnzodOOl5SFB8hWl8a+NiUi/5LtdqsIAQzLxgzvz7S5+UaaQyTuFA
	o1ut7wZ0LoNA/3SQbzd1IB4ky1TmeQH8RQTJWGET7sihTwnrbTUS7/MUyORHrFMD
	jxWzhXxo6HBr+97wIJfQQrgyKRxXRAwe14Xv1GLxAOr33ZRxJOHYg5Szu/fxrHYm
	6kpuEHeXVPTrZbvnfouhWi6uMqQVvmbYEdcMLP5Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs4n5w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 08:07:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5QuIK2002277;
	Tue, 22 Sep 2026 08:07:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjrx53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 08:07:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M86xbs39059906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 08:06:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E70F2004E;
	Tue, 22 Sep 2026 08:06:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01C9220040;
	Tue, 22 Sep 2026 08:06:36 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.123.6.5])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Sep 2026 08:06:35 +0000 (GMT)
Date: Tue, 22 Sep 2026 13:37:38 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [BUG] Continuously increasing spurious interrupts inside pSeries
 guest on PowerNV host
Message-ID: <arI3BkmyAy5Yj3SO@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab23726 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9KDQ1UL0WzeGepnXIz0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: cWLhJ60_kmOlkhe7P6L9BvHpFTkf6Rl-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDExNSBTYWx0ZWRfX0KM+ZhgjEsHD
 lN8G7Ht+ivPO2G/4V9XRhBIX4R2TTv6LhEZsZKaFKylJKvXDPiBYyo1xCTviMwAHfWOsvSAuj6U
 VJnodnGU8o2kfXXYgvC+dPTPsYaSF3yGF9zUsqz5Q0ru1+a9dX5z4dnDNZVZ4RBY/l/61rcswhI
 nDGkPgACmOi7gzdSbwKiywWa8oZojyS3p1ya9RyOg3HZBTjQyU1hrhuBz+IUMXdITKOCFvHYUf+
 Bd7d7bBkKrN20+hlw5m53NPAIafg8Y533JRvy3ffgpFIuyLfBLqqYccuXhBaQYYutFV+dUX6q2s
 wNc0YlTtu1gqBNFWq88CCZSIuFtjCNf6upDuArfAt7pJE+LA+koGpEXvOzxwIcBCEvjxKSOpu1i
 9vXs8yP/oCtm2XHSYBY2UcRZGL8bNhW3HtNF3t7ZUCvt2GmpkZjSY41cfr7KsZi2eMMoafvwhGm
 q9ARxaU2cabKBqgZaLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDExNSBTYWx0ZWRfXz7Q/wcyv8uHq
 3EanhBpz2bKzo1X6OIl+3V4J5GW8dKqf8I0f5ddd71TcYpYBEO8O5xuBXAH99+FsvVg3UZloyTC
 21rPS9rYrqYvaSfSf3xPK3vshtliYTE=
X-Proofpoint-GUID: nWt09R-k0Aou7tTZaspUq0HK1WILJXLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220115

On Fri, Aug 14, 2026 at 09:56:30AM -0500, Timothy Pearson wrote:
> With kernel 6.12 (Debian stable) we see a continuously increasing spurious interrupt count inside a pSeries guest running on a PowerNV host:
> 
> cat /proc/interrupts
>            CPU0
>  16:          0  XIVE-IPI   0 Edge      IPI-0
>  17:          0  XIVE-IRQ 4096 Edge      RAS_EPOW
>  21:          2  XIVE-IRQ 4353 Edge      hvc_console
>  23:          0  XIVE-IRQ 4097 Edge      RAS_HOTPLUG
>  24:          0  pSeries-PCI-MSI   0 Edge      virtio0-config
>  25:      50995  pSeries-PCI-MSI   1 Edge      virtio0-input.0
>  26:      45569  pSeries-PCI-MSI   2 Edge      virtio0-output.0
>  27:          0  pSeries-PCI-MSI 16384 Edge      virtio1-config
>  28:          6  pSeries-PCI-MSI 16385 Edge      virtio1-input
> LOC:       5781   Local timer interrupts for timer event device
> BCT:          0   Broadcast timer interrupts for timer event device
> LOC:          2   Local timer interrupts for others
> SPU:     449927   Spurious interrupts
> PMI:          0   Performance monitoring interrupts
> MCE:          0   Machine check exceptions
> NMI:          0   System Reset interrupts
> WDG:          0   Watchdog soft-NMI interrupts
> DBL:          0   Doorbell interrupts
> 
> The spurious interrupts are apparently from the virtio0-[input|output] devices.
> 

I've posted a patch (currently at v3) to fix this issue:

https://lore.kernel.org/linuxppc-dev/20260921111043.49825-1-gautam@linux.ibm.com/


Thanks,
Gautam

