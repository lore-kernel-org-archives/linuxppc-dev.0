Return-Path: <linuxppc-dev+bounces-21957-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18C2CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 07:33:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVfZ92GQDz2yFK;
	Wed, 03 Jun 2026 17:33:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780472001;
	cv=none; b=WRV3aUmK/sM1BZOk+eICc0cOSldLPVUr/YSYlz8JpSaKD7GUS/3HwrpZ/qCliZiJ04KeLzrI8FGs+RNuuVoBkJ13abhGoI5jEepFRXIlnI5//EQMPY4TfpqVQ46Y7JzvwYSs3czsVlsGHKGqRJTMC/0J6+8Cu3H3S7NAxrBF3e1ciehRNPalCl6Blr0/ApD4t7AyD9vmqJEKwkFE5+SvPOrNNCqezIutIvucEWQUs8hP9cWeYUPbAn71nJqhIXYNxO4+X5PNe7MXesBSyh54nhYcAnVoPwlmGQfZC3URpbQxo/mNATBRYZPP0W3g0OgekT4yjBP+AKvdESUrJQgu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780472001; c=relaxed/relaxed;
	bh=UKtTvusYrXL2Bbsl9VLcA8xX9VdpG+vcmpX8UTGAvck=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E0hfOofQnwgcLkLOLUfnc3MJIpbcyPb6y00/wpSTs/tAfc152NRiVqWtbA7lAJwaerh6zEOsEgeey1xaaQaIGRu0djcW2tyjMDK6SkueQYfgyxq3alBp3cOHtT/FkZHwcGqCXYIzj9WFOTOaiEMdJt12/3uozVfIJgdqCsMr87FZmLZv346Z7uUNDNB8asiB7GXK072apNJxQwz1Cb7ktAaivud/mFOo50yHqx6UCc1pwxTEhZjP+slWS45hu3BlS0jAWPylD+FSbLq9eSiKtkeRXYZkz1oFRLn0t9AE+7Yl6c6tv9f4uaZtVHCVHXENH9G0fgINqE9EBv/XRKXSjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TECXzGzE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TECXzGzE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVfZ74ld4z2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 17:33:19 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537K1UP2914981;
	Wed, 3 Jun 2026 07:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UKtTvusYrXL2Bbsl9VLcA8xX9VdpG+
	vcmpX8UTGAvck=; b=TECXzGzEyEfNq2a/2BS++FE0xxZzIVQkZwOeD2QO90TPY4
	4zvFlrgeJRLy0jlgHcFebGVnk2Sezu7/dkakhEyZmqgtq1rhq/5COHftb6miEiDJ
	rUnK/h6Crub7XN8L7aetidx/hsUhCQ+u62MMgCXPU5E1P+g1K7ydB3y4lE/hZLag
	OIWcqsuLQcJntZsBrXRundeF8WkdQa5UH5gNgWeWKD/KhXQqlINARFm4182bS80r
	OHTxyhnS+jc7aQpyBuc48TDYwtx8isjnpywoWKmVuIFNI2Mx7EjSyRVvcBj2iOzY
	rkKlSElCiWYcayh8F9I6iWClfsWVSJsHHVgakrwA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd49tak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 07:33:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6537ORsg006698;
	Wed, 3 Jun 2026 07:33:15 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegpv1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 07:33:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6537XECr6161250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 07:33:14 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4131758052;
	Wed,  3 Jun 2026 07:33:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF72158045;
	Wed,  3 Jun 2026 07:33:11 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.22.158])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Wed,  3 Jun 2026 07:33:11 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 03 Jun 2026 13:03:09 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org
Subject: Re: ppc64le kunit test failure: guest_state_buffer_test
In-Reply-To: <20260603064225.GC18149@sol>
References: <20260603064225.GC18149@sol>
Date: Wed, 03 Jun 2026 13:03:09 +0530
Message-ID: <87ecioyt6y.fsf@vajain21.in.ibm.com>
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NiBTYWx0ZWRfX37RTbk1hhRB+
 HV1zUFFB7z3tk5e91h+iY1Ajnuj8/8/fq3+qxxaAnw4dljedkTo5yo3KcJBCrm5vDWeDhY999Q0
 7/shG1aIFWicKs3Cgqjnn3IUT6btKIumO99740MgKNHCJiL8g/jm34K6GDzJhJFqq0Pz6hUNtsW
 CfXaST6UZS6TI34H1XUKUEibowRpZNfKYXMysQve/B2u/6icLLe62vFkWrVnDVvxUfwBuZ94T7t
 ibzsRF/feyr9D9WCVFMPruj21oIFCF+bQ4fn0zn6Y841iXzZGbilpgxRofzoNlsoxvnmbjjRqz1
 nzKtwQ0JK2t1wXH1yQgURQJVmv3lVfmtkPT+pVjQV1QAWtijHOQ76Mgzc+UZ75+9Nqh90KJd2oy
 lxZPT7bLW4eWgfp1wYXiqwoNlW+aGEBB+4PHzzi2yEPmz64XBPGf6eAEmQoZTn546ccHu5UiolT
 Ij0MPpzw+s45ab36+Pw==
X-Proofpoint-GUID: 4BjY6n51ydzdBrwulsUZaiNUxu1j8QKX
X-Proofpoint-ORIG-GUID: 4BjY6n51ydzdBrwulsUZaiNUxu1j8QKX
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1fd8bb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=GNRFBLUNPABI2W2ee-4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030066

Hi Eric,

Thanks for trying and reporting this. This kunit test depends on
availablility of Qemu commit 5f7d861e("spapr: nested: Add support for
reporting Hostwide state counter ") [1] that was merged in v10.0.0.

Since you havent mentioned the qemu version used I assume its a version
< v10.0.0 . With the qemu patch available you should see this test
passing with results similar to as originally described in original
cover letter of the patch series at [2] that introduced this kunit test.

[1] https://gitlab.com/qemu-project/qemu/-/commit/5f7d861e65d90e0446b8f22a0bc859a5d8058ea6

[2] https://lore.kernel.org/all/20250416162740.93143-1-vaibhav@linux.ibm.com/

Eric Biggers <ebiggers@kernel.org> writes:


> FYI, the KUnit test arch/powerpc/kvm/test-guest-state-buffer.c is
> failing when run in QEMU PPC64LE:
>
> [  146.554299][    T1]     KTAP version 1^M
> [  146.554348][    T1]     # Subtest: guest_state_buffer_test^M
> [  146.554543][    T1]     # module: test_guest_state_buffer^M
> [  146.554927][    T1]     1..7^M
> [  146.556873][    T1]     ok 1 test_creating_buffer^M
> [  146.558221][    T1]     ok 2 test_adding_element^M
> [  146.559532][    T1]     ok 3 test_gs_bitmap^M
> [  146.560309][    T1]     ok 4 test_gs_parsing^M
> [  146.561246][    T1]     ok 5 test_gs_msg^M
> [  146.562116][    T1]     ok 6 test_gs_hostwide_msg^M
> [  146.562911][  T428]     # test_gs_hostwide_counters: ASSERTION FAILED at arch/powerpc/kvm/test-guest-state-buffer.c:488^M
> [  146.562911][  T428]     Expected rc == 0, but^M
> [  146.562911][  T428]         rc == -2 (0xfffffffffffffffe)^M
> [  146.563600][    T1]     not ok 7 test_gs_hostwide_counters^M
> [  146.563653][    T1] # guest_state_buffer_test: pass:6 fail:1 skip:0 total:7^M
>
> Tested on next-20260602.  I haven't bisected it.
>
> Note that this test is in the defconfig.
>
> - Eric
>

-- 
Cheers
~ Vaibhav

