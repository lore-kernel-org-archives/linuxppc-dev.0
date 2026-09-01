Return-Path: <linuxppc-dev+bounces-26354-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5317BC61DE4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 06:15:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYwZr07LPz2y2P;
	Tue, 01 Sep 2026 16:15:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788243331;
	cv=none; b=U6EYBY3qZZDEH/CgG2Ol1SP/5klru595q3lp5XP1/Jg18yS+vK6XJ2OrCzgvQMpWReXSUN9wbyDp/PwzZ45jqFWwohYnXWKbfbMbZvwht+Gucskk4jWj/mJhRBufGOXZ7CbDzlaMgPIegRLd3At+ct2NOnyUgRPUtpo3Fl3xx6r+UubTiA4RwOd8vOBRleVaBhGm/LMoEUVljam+NSwfWbMNm1P20nJ5KzjaLg7Mvi7FUJxWeRCIQvFlejCuwzR/49gsivCgce+FV77sTPSv54Nijkv+89PzT2yhJAsn4ILwWGnvIMMWyNea77S+I5BIdftHpZkVlajzhRbA2+f67g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788243331; c=relaxed/relaxed;
	bh=51LRUAn8+eNB4xhG2rGHa+i41AFwwFm0TgYaGk/DbR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FklwYW1R1Azn5O4EWiQfzVN9b42DdfRbUd+EckAvJvvcal41KHg71KbFlM0EcAeMo7xb+OXyLWRijWr07IBbgXZMLBxfPnATGjivAm5ov5x969PJEdLRgN+76AnB9Wr0n01bgyyyFXMv44sUCuIfHoNDYf0LozJy8UwiFEtYa0nXz+OncWDEanSN5yWct4xlYQoZr7JSLDWU3C0ecdV0khCcNiyDJ7EgzHQsT0mrqhcjAHh7CwqbfH8zBIdSnM0Bmj/wcwiqftQ8pC5f1NKOUpsVRDZAtrxbhCTYvR69eNf3u5SXVABHXmsGjIZCVrSIeHjFO3nFTODGUHmhVAJyQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q+duQFK5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q+duQFK5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYwZp4WhXz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 16:15:29 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68111t8X2064834;
	Tue, 1 Sep 2026 06:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=51LRUAn8+eNB4xhG2rGHa+i41AFwwF
	m0TgYaGk/DbR0=; b=q+duQFK5SYtwu1e/YI95vH9ZwlImLsrIc7/G80OPtYG4Lb
	Kb43zbIw4+qFL5S7h7Ukg2e89essbzyiw2Mm3xNErvbUIkBKLXywsI0GYz8iiMSl
	v0/WRpqC/TcLzi8X+sKBtABbB0FuQNjhjaCHDZYN5ihv+vyIj9RaPxxXUaDmP3O4
	TBm7842oqTiSWG4WSNRHA3XOjClpn+S5/epFUQOXLoajX4Vx5EXUtyokp2bxshZp
	ExbD45VU4vkGdZECjFtGpvzIHKuLs+fk5Q0SEWCjdnnpZrO/14Bh9ssz+XrwlbFd
	WDWAQvpiMOAc3W7hmF3z2WSVPqg33n2l3vb+HDxg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r61df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 06:15:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6816BJiF021117;
	Tue, 1 Sep 2026 06:15:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqabfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 06:15:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6816FO4B37749152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 06:15:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46BDF20043;
	Tue,  1 Sep 2026 06:15:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1777020040;
	Tue,  1 Sep 2026 06:15:23 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.39.24.131])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Sep 2026 06:15:22 +0000 (GMT)
Date: Tue, 1 Sep 2026 11:45:20 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [BUG] Continuously increasing spurious interrupts inside pSeries
 guest on PowerNV host
Message-ID: <apZteAd6mDv9URaD@Gautams-MacBook-Pro.local>
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
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a966d7f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=fAUXoO9nBjRxoZdOUygA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA1MiBTYWx0ZWRfX+2aPfSqZUg1i
 9eSXrcP4DT4K11Yyr+4KsbazhAMWrOnjbeF2LkMUwDkkWFyBiBB3qqekencRMDEf7Rv7MwlVDra
 Q3lOL0qVmlc3y7k7QPLOlpLzBTiiMT2Ffayi1HhPiA+LxY92RhQ/SLQVn3pq87j9rjUkcr4oLK4
 UuiXfMER1T2jABg7WIaN/tP5k7V/PXaDaL4C6dw/2J/pqB3up2/M9f3Vi0zhBkdZfMzEaTrqT5S
 41LrMNrX5GpS4I3ln5B5no+O8UMhz7oTULfgpJ/0gZeVqCnNG+VTJ/SUuRJzKd5C2Dx1bsOEH9K
 6jzb6+GPFVL+d1QQS3pxe0KCHe7WUB9Q4ipl7fT1XChyloPe9BH0ZO28xcc0x2WvIZTjDudUp74
 l8y42HPGf5xDBbPDndVGslgBFfwRjMIjB/ARwQ6fonlrwwzZfiAS6ngWNE8G0cCD442IfJ4SjoK
 37Qvwv86FmF9wPT79pA==
X-Proofpoint-GUID: In4h2fAHTtw_PiOViGW5a59kXhfnagiX
X-Proofpoint-ORIG-GUID: pKULp4G6t_945hYCHK62EGPc7OqH24In
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA1MiBTYWx0ZWRfXyAg4xla0vysp
 2OI0qz7FIjMp/OXr0BFLKIlinIM1MDm89X+x8M7L+wemY0APOznm5ymDrOfUkly4NTZdCJkfX4i
 ZcyG0FuIr5hsDRInnpy146SpobNfWHc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010052

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

I was able to narrow it down to commit ecd10702baae5 ('KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE')

Reverting the changes in this commit reduces the spurious interrupts
observed considerably. I'll try to root cause the issue and send a fix.

Thanks,
Gautam

