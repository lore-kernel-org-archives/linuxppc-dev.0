Return-Path: <linuxppc-dev+bounces-27876-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A33C982EE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 19:26:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpYBl1hPQz2yVd;
	Tue, 22 Sep 2026 05:26:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790018815;
	cv=none; b=bkyshN5/vspGrr9+TjX0zhW38DFN7mEim6BNwDQOmP77ajJ90G8EWpsx171dou1iSB/RaooikETMqGQfTtgfCk5RBPDQhn2ddqJAhOAdMtpMBDTfMesuYfdVV2AzA560qe6XTsNgDIjf4CX7H3MjgHe9xUYpVKpDnkvuM6vAB0M5MU6qgj/VB8IZtPoZFiNspZkIr2VamOtUA3TZOopZbNWTRmuTc/WgI3e7oUwepjAtd6oc7B9AnlB45Z66rbogWn1N9v6AjH194+bfwb6xbzGIdC5goFS0DPWHiqesz3UcxFPGjdn7AVmW0/R4GIU0RYdCvOOUFOv4yBguTCrfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790018815; c=relaxed/relaxed;
	bh=cbHkgCfr3twGPLqRav4nUuRjrvrvOvewHchIn5Azz6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liqQ1LWsfnwFQfjEssH/UyKIGB8VHAOc966sgjrkH7CBscD6p9z+SVqJtmJ0RKQNPa0pgFRkEYxTVw2m9PHe69GXn2jaELPN605eMLmfHMp0FSRtO9eLLBXEg4UxMNg7XLy2KJemzad9cojLavwArXgdFq0voBw5HiPifmr6R5IPCi6MT/jDzhKpYmiwakl8Uv5w5dvtmZn2xBk2FZgFuqfvuUkOhZ/X42uEpmMfPZlC80bXDvSW+785cIv1b3SeGHntDta63odXDWmcXVeCDGERTkjKwWCvIrU8uFHyEjQPeQVzjo1EtM8AhUAtZu1GSH3vl78XR6gx4EPeanJ9ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZRkeCLwh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZRkeCLwh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpYBj5vg8z2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 05:26:52 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LF8YLw703559;
	Mon, 21 Sep 2026 19:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cbHkgC
	fr3twGPLqRav4nUuRjrvrvOvewHchIn5Azz6k=; b=ZRkeCLwh1vpXSMfO4kwFkf
	xoep/7i1SYNmBg1hc0twmw11+YdKuBHj7TP00MFSp86a6TfuXw6lT+rrRPiB6yu8
	dCcCBnfGCFwKmHslskN8ZRJ/6OVy+NKWpZwVWrqIJGj1470Q99fBHrMejcNUrZjU
	Ew99Wsksg8gaZmM5yq0NZ/Lfgk7OdbTJY7xEKrIzTgxwF66QVpz/74ERVEVDGgFp
	Kb0aezFPxlh31CcWK3OxVmzLAdY8lGm/2sSUzPHRDol9a9rrYUOZW2gnp4uLVzT2
	w3qnnlVXJwpMiNHms/Czv8fwfg3QvjXOJsr206jV2Ya9RNWRzRlAftD0oiE2FW4Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqa4fa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 19:26:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LJEmeL1431683;
	Mon, 21 Sep 2026 19:26:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53veuw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 19:26:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LJQZpf31457804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 19:26:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D259258059;
	Mon, 21 Sep 2026 19:26:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF4755805D;
	Mon, 21 Sep 2026 19:26:30 +0000 (GMT)
Received: from [9.67.77.117] (unknown [9.67.77.117])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 19:26:30 +0000 (GMT)
Message-ID: <bcd5e2e9-5000-44a8-9e7d-ebb4cc3e02d9@linux.ibm.com>
Date: Tue, 22 Sep 2026 00:56:29 +0530
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
Subject: Re: [PATCH v2 00/10] Extend PKWM to support user-created wrapping
 keys
To: nayna <nayna@imap.linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@hansenpartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
 <b133937fab3f5cd7203d8b48824a6e0e@imap.linux.ibm.com>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <b133937fab3f5cd7203d8b48824a6e0e@imap.linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab184ee cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Xgi9pjjPtvcisj4yZHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3OSBTYWx0ZWRfXxzEg00pP+D7x
 54LNJrh5IpFh2l0uaAJ4Tohcy2b/ROiFKd97LFT3KQSWlbMe2WLMm8vpN0gjQ4T0Kyj+F5aN9ux
 ooMekuK+5Hsm81WE1ewo2S9GMD07RLH0ELUfv/ufa7K/pCYXRRaOkJHae5nFMQJ8CQOZ77twP4U
 XQW3iGy54NaBpUXRBKBAo0Mg+V6GtoYEundsL+7zocFA4VCSHZqapxILrrrKAPlSBOt+nmUCIlX
 8U+YdueeXJobhS2pGSyPLfKnPeB1/P8cr2QT9YcWE6NF77jxePb3XWH1Nkb+Fug2YzR2BT7QR4a
 uaRVWa2UumOAjwkjXRhWVkm6d5/KMdLKbwxO1XgT+FtOX8jNVwKEgob4lVJBQJFi0Kwiwql6trE
 Ezeg8T9WNkZ43xpwDYJN0IcwinAjoxYtYvgXvCgdgsrPrs1q5zJ+FsXDZf+ACzn+oPl4NGv7sAE
 FdTnVJUO7LKtOnNU94g==
X-Proofpoint-ORIG-GUID: a8PxXmDplA7WdE98ZVMAbjuus_uvxCue
X-Proofpoint-GUID: l18ZMeXMEawAD3hhx_qESs7ofoIhuFxq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3OSBTYWx0ZWRfX9bWlZlIGHVUw
 Nr+lU6TdUFAKtT993OVxSA0zCynC71dg6lSzDEEd8vQvAtP8OoX7pdFPuZH7c9dr2G+1X/+iiwa
 2qlhOtgWjaVLDriiMBPNSXAu8Pgj508=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210279

Hi Nayna,

On 9/21/26 7:09 PM, nayna wrote:
> On 2026-08-31 07:17, Srish Srinivasan wrote:
>> The PKWM trusted source currently uses a single default wrapping key per
>> LPAR. This key is created during trusted source initialization, and all
>> trusted keys backed by PKWM are sealed and unsealed using it.
>>
>> Recent versions of PKWM allow users to create and manage their own 
>> wrapping
>> keys through a set of lifecycle operations. This patch series brings 
>> these
>> PKWM capabilities into the kernel, allowing users to create, manage, and
>> select wrapping keys for sealing and unsealing their trusted keys, 
>> rather
>> than requiring all trusted keys to use the default wrapping key.
>>
>> This series adds support for user-created wrapping keys to PLPKS and 
>> PKWM.
>> It begins with seven preparatory cleanup and bug-fix patches that 
>> improve
>> error handling and type consistency, clarify macro naming, prevent
>> unsupported capabilities from being exposed through sysfs, and update 
>> the
>> documentation and MAINTAINERS entry.
>>
>> The final three patches add the required hcalls, enable wrapping key
>> selection by label for PKWM-backed trusted keys, and provide a sysfs
>> interface for managing wrapping keys from userspace.
>
> Thanks Srish for your work.
>
> It would be cleaner to split these into two separate series: one for 
> the cleanups and one for the user-created wrapping keys management 
> feature. This makes each series easier to review and test. Also, this 
> allows cleanup patches to be accepted even if the wrapping key 
> management feature is still under review.


Sure, that makes sense.
Will split them up into two separate series.


>
> Thanks & Regards,
>    - Nayna

Thanks,
Srish.

