Return-Path: <linuxppc-dev+bounces-25969-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B849C5DF6D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 07:54:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPzPV33PKz2yCK;
	Wed, 19 Aug 2026 17:54:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787126094;
	cv=none; b=TKktSVWDCfJ5LyrdbLQml5TNEDDgqX+KtUQDNFNZfnZJtgyqlvmqdJfSm83h8RfsoRIUhXk9m/LrT3tD0wDDPXkyXCUufxTbZJYWVZ4UCzvxJDEvGixDqPjv8P85CKoB6iFkOiihJvRVJOqDJXWADn/sv56wjz9QcHuhTtS9knSMapI1lWWZk3ila14RNz0FOSEXvcvnK5DKrOb9RvwYp7jh8mXKLLnXYnR9W8YGg8UAfRjLuvfC/S9s8gsIpIyg69q7je44xK6DYN4DeXRZGzJm6tAxJwF/0khYGxS1OpsvrTNPQcJbPkI5r4OGkzDaYLITOT6UoZTZ4W7ISB1xZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787126094; c=relaxed/relaxed;
	bh=mZngZduxrFQALZMlxRHsA7IicZDx6tf8QmDryyLLDqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar1owQaKYUAU1BoAAWjrTaNJWLUx6LF0TrY6K8B/nGOAj0hIrH1y3zC2S7MwrXwzCIyVTvd9rqKVYnm4cCqXIB7z2zYa2y8JzcEStinrYhZtwQUP15Ks/nUR6HuR6FjC1rOqlTzd7lsceFbg+udGrTdyKx4O/WAKokwfp43vihi8ny25LHEsIWE+7I0epVn/z9xG4XfOXc+1USx14HSau8t8tHkxXHyWFCiPB2PnAudLOLLi6D2V52ZvLVWCJxdLtFjLURBlLGJlcwa0qgDKruJ71yz5Dx+u0hB8f8WNLVIyU9KvWFoytCGqJbp/Qh6AFFnT1GC19KO57GFMk137BQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dEgl4Oj8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dEgl4Oj8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPzPT03Glz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 17:54:52 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6WZ2o1545680;
	Wed, 19 Aug 2026 07:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mZngZduxrFQALZMlxRHsA7IicZDx6t
	f8QmDryyLLDqA=; b=dEgl4Oj8OLQT1UfbW/ZTg+PMYvBrjTxQvgFpJ5SQpjAtqd
	sy5z+oya3S6fgTsKPDlWK2X16D+6FX2eA6RUIEXqbG3OiF2hFigbDocRsuslSvpT
	i1XuA6L11EHRSQ/4wJm+8EvkXPdppmf7DtB4MdouyFXEgCW68J964hNlbor39nOt
	TxjNf3FIL00wwsGZtjofUVhe0z/QexctwAP/CLooJTM9fQDvZAfdnn6zMwdLiMkL
	NS7ZvW4PfHx26C77UsbDHb+zJbesIuBW80IAt1TD0zgbbbS2EbVqSjA9ILyWaz+W
	QVZfL6KTKzYBdO1Aiuo8mIQ2wWuakys0vmThYZVA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu22a9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 07:54:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J7fJ91017106;
	Wed, 19 Aug 2026 07:54:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw7wj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 07:54:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J7sjGG45416746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 07:54:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD07F20043;
	Wed, 19 Aug 2026 07:54:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0703D20040;
	Wed, 19 Aug 2026 07:54:45 +0000 (GMT)
Received: from dhcp-9-123-15-208.bl1-in.ibm.com (unknown [9.123.15.208])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Aug 2026 07:54:44 +0000 (GMT)
Date: Wed, 19 Aug 2026 13:24:42 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [BUG] Continuously increasing spurious interrupts inside pSeries
 guest on PowerNV host
Message-ID: <aoVhQpVvWcIIlES-@dhcp-9-123-15-208.bl1-in.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a856149 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=9KDQ1UL0WzeGepnXIz0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: eIVaAg2ew7tla4Xqv__QeL6YKZndxB-d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA1NSBTYWx0ZWRfX6HXMDOKhNQXw
 86uoUL3YSbACkX7Sl7f8jjX1Hg018ur/5yhksdqegSVP/peksGLzngTQxFkCMyRdHEmcDP3BgOF
 5tdXg1g1PSOjSpMyHp/uxifT4Uurm//EyPmF0FiZn1f2ka8Q8P9u8+9ZE8GHbk6oPoprnVfnaug
 SpNJL7ZlvJEseuEK0/MZNPD/pLBCmGuwC3muSRO4oLt7jpRGUShsL29OH5Eb9EjXobSOGs9nkBI
 zGXKe/nt8qd48xx2JM0jq5+KcZtMC8nlbEUAOLw4xrXcmzQCeuR5X5wjvlMqQMTOeq2gvS7nusH
 3DeXxOlPR8L1NQxrYolk2v++lyb81BwaxChJqpqm1wq1o/n5R7OU+M59l9DCl3y12JhcYmL3fg/
 GXJFV0ogQFTL6Q77RB2Ovjl30chHfgz72VToYPsfVSZNlz4N9BmgQwTyvMWma1iLsCmatQfi4DY
 Bs1n493Y6xM45ARoTXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA1NSBTYWx0ZWRfXwtKBCcM8Q13C
 53qxR9TvFgSc7rQEG0fd4sdJ5hebRdSpZytXBikq1wTI592NBx39D1KVVH3itUHUJBrDlbWgA+M
 8bvCqduo+q6bI49yT//iPemILtX83pA=
X-Proofpoint-ORIG-GUID: jZtT2ONyC8WXsOZM1ITsMZW3rUIReOIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190055

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

I am able to replicate this observation with KVM on PowerNV (XIVE):

1. Host and guest with kernel 6.19 (stock fedora kernels): Huge number of spurious interrupts

2. Host and guest with upstream kernel 5.19: A very small number of spurious
interrupts observed.

We'll look into this and post a fix.

Thanks,
Gautam

