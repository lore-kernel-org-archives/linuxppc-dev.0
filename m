Return-Path: <linuxppc-dev+bounces-24296-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2F6C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 10:16:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0XCM1rCcz2y8p;
	Wed, 15 Jul 2026 20:16:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784110607;
	cv=none; b=UPn+Fp3+TkVlB5VKL3pU9evncEWsbtGcu7nsCamhlaqkoD5to0XuT16yQwsgMcg9fEt25FvwuTZvbqDXMLiu1XzAOdOpZNmYZbHQLRCuvwpr/E6eX06xLSOk0ikLQ2t5T6F9NP+QddU+3R3U8KH1N69nGxc5xQnjetLpseraoN6rC7g29vxKLIvXklRHKxES95UOkO/WmbIQWS6W6SF/oqeSBnXkSTtuOyVK06naZjiDUCgtdDG+THVQc3/b7W3RRjr5NU7dEYnFDvHxuH/D6lTOcbNvAAKd63qOqO2HIxkTJ3GGEUZNfGqah0P40BIM0mPSFxeIt9Dy70TRb1kcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784110607; c=relaxed/relaxed;
	bh=Q806OM4Jr2iBv2JqXAp/aV8BCx1Zku8M4WzQxA2sX80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9SDyxuuCH2zLzdpFo2cjkRcPoZvnLQ808zupy90OzFVVbjrGBTVirWFqFQqoIbo51pLLjxZHIpDu0TbGYN3JXuoPqskjyJcixz8SJUiW2zyV2TDSOps+w0Aw7+6ha9mzXlApD2pdlvckQ/zDalOwckqoyd2WdhpWFoA7JTnPP8t7JHkndisv/2YbNrc2X81YhIpWSaPbLH7gj5/dhL5zv/SgCtJvMCQ3qn/av4Dda+geHnx0OMXeGr6MfG0RKK59VlE6rRCJpsaMQ9RfBCjwiv/0DJzOSxlFwrwadJs0l9bHngu38uEiscgSKDYfh+/TaT4uMvPN1JQ5dMS1MO8kQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JG6QLyHU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JG6QLyHU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0XCL1KMkz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 20:16:45 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F4C0Re3272809;
	Wed, 15 Jul 2026 10:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Q806OM4Jr2iBv2JqXAp/aV8BCx1Zku
	8M4WzQxA2sX80=; b=JG6QLyHUYk7lI8z8b5IoBHQGFDnfxcHqc/Kcabgcg4Uu//
	Fz4PeiDBk4cJfUcxkcFIlFtlvyrokk/esiBGkQEMrNOFv+l6VXurKHM3MuzFWCi6
	Pj8kFwmLxqgqHV8pELYR1dCysU6ff2ijYKhrdFDNaHBHzuA+FuOu89yYV5fcqPLg
	zLUkuCrStwvISKHFWVIpvKqNPiWhyIm96BFh+uVfznbPD6+f7ucKh+Hjz4Jj8Qu1
	y/o9gL7RKm6cFfP5RKx53PrOOkHwJM/XXt+AjmhvqqtlIc2P46YWejc+wCRMi3ef
	Ia4JlY03IfPac8mOQTVM01H+Mp7yEZg4zkRjv62g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbtbh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 10:16:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FA4Zwn020850;
	Wed, 15 Jul 2026 10:16:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy7456-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 10:16:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FAGPCV15204668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 10:16:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4107D2004B;
	Wed, 15 Jul 2026 10:16:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 663F82004D;
	Wed, 15 Jul 2026 10:16:23 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jul 2026 10:16:23 +0000 (GMT)
Date: Wed, 15 Jul 2026 15:46:27 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, harshpb@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/eeh: Fix recursive locking on devices without
 EEH sensitive driver
Message-ID: <20260715154411.36742571-f0-amachhiw@linux.ibm.com>
Mail-Followup-To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, 
	maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, harshpb@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, 
	linux-kernel@vger.kernel.org
References: <178404937381.913.2759874335293830160.stgit@linux.ibm.com>
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
In-Reply-To: <178404937381.913.2759874335293830160.stgit@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a575dfe cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=APd2T_Ys9ggmFCAL7HcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA5OSBTYWx0ZWRfXzqwyp/9fbAfG
 Bh+Wf+kIZqurrjBSSwOEqian5NMfI5WdpLMQgrcq9zRfaeZRlQaH1PXVIVuP3K9M1bGnKF93irr
 xdx3kymXZ/DIDkvj+zMtfPo49M4esZ7pHgqRLreihNwUxAQgJQ/N1g8CV3R6yXpk/JLGXtOVyCH
 roGhDnQpwQ+mK7r6xSvnMdkovm+09maIjwdfyou1+eqtUkxlva910OwzFRGc6Ot3hLfaJk0cH1l
 a2yNcaUCEX8NZ5hx/IjmcBkzbha5Yx4EfBxep3CSlOp4COlxXMJcZOWQBwWK0Dq3V8k8rGM8Bdw
 z9ycY1p1PrrNalQXQ5JT47IfDt6zpO/dIJk/MuK6Yh8BbL2iDjcWk0Dk2Kpn3nzldsbnMg93haS
 rHpaaUXuDZcmiMAAj9zd3YIQJSMsOvJj14/RIGCs9VRUARDvO5Z3giZGWilL3bFAjj9sJ7mhF/n
 /3wpeDly5LH+dQquLMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA5OSBTYWx0ZWRfXy1xynKptARI4
 Flh8QFWwXxiP5nNYa3y/k6+N5VoHM6H+53XVmE5r4afGj0N16JFqD2znhSYiKHE4g7LSbv+p1Cd
 csggc4KE1EhuFV8qwN7yav73eYK2cRM=
X-Proofpoint-GUID: PHOx-lt5fsB-ieLtt3XpZ4WPh_f_foSu
X-Proofpoint-ORIG-GUID: yfMiA9BsDBMv8-0rYkxpRe33QMlJwfj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150099

On 2026/07/14 05:16 PM, Shivaprasad G Bhat wrote:
> The commit 1010b4c012b0 ("powerpc/eeh: Make EEH driver device hotplug
> safe") refactored the EEH code such that the pci_rescan_remove_lock is
> held at the beginning of eeh_handle_normal_event() and the
> eeh_reset_device() is called with that lock being held. Looks like the
> commit missed to remove the existing lock/unlock inside eeh_rmv_device()
> which is no longer necessary. This is causing the eehd to hang on the
> lock which it actually holds when that code path is taken.
> 
> [<0>] 0xc00000011c78f870
> [<0>] __switch_to+0xfc/0x1a0
> [<0>] pci_lock_rescan_remove+0x30/0x44
> [<0>] eeh_rmv_device+0x290/0x2e0
> [<0>] eeh_pe_dev_traverse+0x80/0x130
> [<0>] eeh_reset_device+0xcc/0x23c
> [<0>] eeh_handle_normal_event+0x830/0xa80
> [<0>] eeh_event_handler+0xf8/0x190
> [<0>] kthread+0x194/0x1b0
> [<0>] start_kernel_thread+0x14/0x18
> 
> The issue is seen for cases where the errors are detected on the PHB
> directly AND|OR for devices where the driver error_detected() returns
> PCI_ERS_RESULT_NEED_RESET, and driver being not EEH sensitive(i.e no
> error handlers like slot_reset(), resume() etc defined).
> 
> Fixes: 1010b4c012b0 ("powerpc/eeh: Make EEH driver device hotplug safe")
> Cc: stable <stable@kernel.org>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_driver.c |    2 --
>  1 file changed, 2 deletions(-)

The change makes sense. eeh_handle_normal_event() already holds the
rescan/remove lock across eeh_reset_device(), so taking it again in
eeh_rmv_device() can deadlock exactly as described.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 028f69158532..d64cce17a4e0 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -533,9 +533,7 @@ static void eeh_rmv_device(struct eeh_dev *edev, void *userdata)
>  		if (rmv_data)
>  			list_add(&edev->rmv_entry, &rmv_data->removed_vf_list);
>  	} else {
> -		pci_lock_rescan_remove();
>  		pci_stop_and_remove_bus_device(dev);
> -		pci_unlock_rescan_remove();
>  	}
>  }
>  
> 
> 

