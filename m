Return-Path: <linuxppc-dev+bounces-26879-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63F0C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:19:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfrH60jf3z2ywy;
	Wed, 09 Sep 2026 16:18:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934738;
	cv=none; b=cvlJbBPwtEOwbKjFEmsmdDdHHN/DlVCm6GgaRheQL6OiQ0UD+RVEPOARqXU/A9wZR0/ATPgla71vgeOXwS6rwtnCjtQ8XQE2UbnF7dpofL2iMZntA/u7i8bKFrwe6Rn9V5dPRrr5wybrLGm5XUZE27TX0xicjzY8FFRsaWolJTtrlQ2XRf3hrS5Vh191sZ/nBpy/YbEl8HAnbOa6Cu+E3M5Pme/2cwn0MTZjxTq4nmO1PYbqGvc9ENIv6QZfatGD6///9z96ERZ0tIkiM9YxbtOLl0gcauz71diIIzSRBiL8SqfWrfkYRG9Y2yBpccTF3X8JjcqtQUuEBggBPRrqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934738; c=relaxed/relaxed;
	bh=mEKrnbUo+oAYrBYLUe8ytG6hfLqpGa2Ewy/OTHbb8hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQ8R/q1ibvFMKUGQwynVPhf8jiQ0xQ1EEj7NFpUvSNHUTbbFsmDZnuXDJQOyZHISv7/x46KPfxagAZx8Mqa8ssP+wjH9C08YzrOJ1gVGQAHY0J0y3Iu+TmyOHx6neaKpZ+lWz0pUoOrXE00tC1O4gb7OngNnJ6+VE+fUE4iGpLq15w2Ujan4SSOXIROLNb/ayxi2a/SgrBkByf7L5oQqomh2FddykK30g1Q7jJD9hM1UwQVh65+ayJGUZ1bvRhLQko8seSQg2WT7hKsI4xsKO+CvUGDk9396/UH4jMJT7eTu031Lp4ft/ty/q5yIMPX0wr3yYME1bg1jrFna8XoByQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GhzsBYqx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GhzsBYqx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfrH5035Zz2yvc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:18:56 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1bDR1116403;
	Wed, 9 Sep 2026 06:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mEKrnb
	Uo+oAYrBYLUe8ytG6hfLqpGa2Ewy/OTHbb8hg=; b=GhzsBYqxG7NccuA3RjNeJ/
	zm34AiEgC0uKm6UNL9BYcREnS9HimhdSUMw5TCy1ReowkYm7Lq2eZNwqNiNH+iBP
	iB+NGhJT98nKoykW0M/lUrcMvLL4aHK2hyRfWrwHGr6OUmahdfQ5wk7i5TrYwBn8
	XrjjzQQsEHGM1BGraghFq8rCrkn4YNTICUoJMgfsE3LxvglByd0D539vxRz20Sas
	oUUjcuM0Xj2J+Tedmje0vbVyEcrBZ86lq8yuCV6esTFubA8LKc6mIqBS6E33ZdDt
	Eq4TV4pcj3I8PyJHM5+CBwNvWMk0pMAJsy62S/RaZwigiw6apEmlqijJP951RS9w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjruqa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6896BDa5002263;
	Wed, 9 Sep 2026 06:18:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03ygdts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6896IcfS46662018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:18:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D65FB20043;
	Wed,  9 Sep 2026 06:18:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C096F20040;
	Wed,  9 Sep 2026 06:18:35 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.64.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:18:35 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: harshpb@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/eeh: Fix recursive locking on devices without EEH sensitive driver
Date: Wed,  9 Sep 2026 11:48:34 +0530
Message-ID: <178893459268.174069.5130701368927941646.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178404937381.913.2759874335293830160.stgit@linux.ibm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa0fa44 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=ng_bIwBZr1CxlLq88DYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX3V+ybrdOXxCg
 VLrpCTHk/561RijgDZMHw9pC3tXOtVP6fz/wfbaOjXw3wKhD08DSLWQNYvd+aRl5WxFG9xMCTMz
 2DqLsknmp04siTMB21WPlVjkv5AhjDE=
X-Proofpoint-ORIG-GUID: qYMVKJyJO9jA-KQA_7FwdIuakEg2bH4L
X-Proofpoint-GUID: cEwzS9G6tUHKQYcNAGAt0Hx0VPpX1mtf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX2AHvBsAUj7bz
 GZ/bB1isGpH1oBStqMvzKdfzQA29hlsGAx4hCHXtP+vdl3Y11u8Pmn+WFP70CPT3n4nBkMUWWaD
 Cpwmy9kK/9jNzdi/dtffcx/XL5yrRO7z5C45LDmjbkS4oCa6AjFuCwEsQwlNaGXZeYR7Z/n2F5J
 MyfnVfag3dziHpdutNEdMWk3dFMufkpOdvyKvkDnQKXYtyVpCYw6wgFUtyTeyZJ2h7hlIzgfIYv
 nMMKIjIVtXlA2YTaOWq4U/hFYSFJZzCDeIb5BZw5OjGRCtAv2Os+SrW2OeeQC3TrqJ5X92IocAn
 2JZ8WONoR7E1H148pjl+7STLa46Tp6u03tRr7nPJ6fdPE4DEVQQObAOqDuziuy4+Jxsw9fmQYHY
 HAoy0P8TJSiwaPyzgSOqZOsdSOHUY4bTBsMoh/dMHUcytl7WQWQ1FXXEl/ABHQrRPIU5ZYN5qs3
 WaPj0mmbhmN2/c3it9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090066

On Tue, 14 Jul 2026 17:16:23 +0000, Shivaprasad G Bhat wrote:
> The commit 1010b4c012b0 ("powerpc/eeh: Make EEH driver device hotplug
> safe") refactored the EEH code such that the pci_rescan_remove_lock is
> held at the beginning of eeh_handle_normal_event() and the
> eeh_reset_device() is called with that lock being held. Looks like the
> commit missed to remove the existing lock/unlock inside eeh_rmv_device()
> which is no longer necessary. This is causing the eehd to hang on the
> lock which it actually holds when that code path is taken.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/eeh: Fix recursive locking on devices without EEH sensitive driver
      https://git.kernel.org/powerpc/c/c5e68706527968282e49de205cc2b935823cb88a

cheers

