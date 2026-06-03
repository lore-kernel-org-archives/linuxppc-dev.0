Return-Path: <linuxppc-dev+bounces-21969-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9590BCD6E56
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 11:25:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVljh0mb9z2yZZ;
	Wed, 03 Jun 2026 21:25:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780485912;
	cv=none; b=Tl061S/kTfZ7bIazqpW3aHfAgw59TmOyNTGI3nFlxbrflQkH6fMClA0VdClI/BlY0eXM+GM6PCS+q+AOyBYqVv5TtdkePaQc7dDoNetDlHn1+CyWiLvoBh9teyOADarjZrzZ3AGjG/MlVVbcSLAErwg2YRKV+2f/wezBdtmgvkn35te9xxIwVyZNo4Gly7Fqf1ICKt0kD0RjYS366oOkoAyjw6/zQSb4bcL5MVVoT0BOT8tCLWbg9gUoV+2inOVuEcj8piavkU3YqJQSFfGpN6QWsAjXSkU6nEQkAEKO0vUF/Hmp3RmREX3IflyeZOuJr9uZ6f3CF1hGWuaKcnZTAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780485912; c=relaxed/relaxed;
	bh=BD66DkEkpe+MLVUzgYeR064w0vRlJWvFVh3ZzZzAV00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AgErpLpRo1ZdEIPYtTRxRIVMzGLd87cJvvI0h9Ap5I/f0RhVmQbrKB3cL+h+5+4cVkwOWPKbMSsUvGJsCY6mS/XlC27hPwRQDybq5Jc2Qy9uqEFFncuCWCCWy7b3+iauGjkjtmHr924xz8agpemzbkNmqxXUBvrPzKA66rEUAq8+F/NhhyoZTEZbRmlG8a/TrFkEgR2d2zeUCuQwfLLHZB4HySpK7JzJ6xddFfsYQ0XKTSD92OSHDgnsOHr76YiTpyqzWODKqKtnaUaY2DlaxjxZldCSg5vvazJhtLZa24U3pFcMkpI+G3sP/0Td9JsIliFQINOr6+8m2C28f47lGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pWMzSYbH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pWMzSYbH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVljg2QlVz2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 21:25:11 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537b5481089524;
	Wed, 3 Jun 2026 11:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BD66DkEkpe+MLVUzgYeR064w0vRlJW
	vFVh3ZzZzAV00=; b=pWMzSYbHQv6S1Q6rN4BrZLF3rBfktxk6DMibcLwKIZxkF1
	luu5P5EYtuhwF95rU6Ww2vtZm/RT0qk9N9Qz3pQ9K6GaYRWz3zLETw6emI0IrPed
	oAbqUsgWrD8hvi2XDSSGmDeaY3Me3gprlfjXpDYif3+7RCpg7uIH2xhFrfn3Tpzn
	OpGVKqRh58LvASPsec+Gv39HKq087xxkPLTf86hM8eJlPbD2TJOtqVvU1JX0Hyvo
	zDueNo5gceVxslQaM4KSJ13asu0KQgKYKSH3gWWL3/36l5gDGol27wH3qcgUxzDV
	hK4trPEjLPnAgAS0A3sXLC9QqGBjLdZZzFudGK2Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqahqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 11:25:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653BOJ3f014297;
	Wed, 3 Jun 2026 11:25:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k7wrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 11:25:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653BP6KZ29884928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 11:25:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E03F258059;
	Wed,  3 Jun 2026 11:25:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F43D5805E;
	Wed,  3 Jun 2026 11:25:03 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.22.158])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with SMTP;
	Wed,  3 Jun 2026 11:25:03 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 03 Jun 2026 16:55:01 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: Re: ppc64le kunit test failure: guest_state_buffer_test
In-Reply-To: <20260603074035.GA1148188@sol>
References: <20260603064225.GC18149@sol>
 <87ecioyt6y.fsf@vajain21.in.ibm.com> <20260603074035.GA1148188@sol>
Date: Wed, 03 Jun 2026 16:55:01 +0530
Message-ID: <87a4tbzx0y.fsf@vajain21.in.ibm.com>
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
X-Proofpoint-ORIG-GUID: OxqPfvJumCXsSGExPvWdG7jEGPfKMdKX
X-Proofpoint-GUID: OxqPfvJumCXsSGExPvWdG7jEGPfKMdKX
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a200f13 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1mqWeeG4xpLTK_Yxio8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEwNiBTYWx0ZWRfX0isWrKUe6+PE
 YxgawLfb5PyOdvhUjhMDQuO/O66upFdS/36f4zWFbJWrHMwfQI3uQSWtWOxzs2dlDOKxigs/5X0
 CWGXjlWuTGoAxgeNTQVFvK3/op4eydqwA5AJLcIdgQgdUcKXB7txzDgC5oDK776YVi6GoatDk0q
 oRZW7k/LU+KkPSE6yUVdVZ+cXhmU8aIPBSiUCsV7r6r5b3L1JCYLo+TdmYdnIdn2DWT0k4n2yQs
 XLzF+j37FPn4idljDWVPG1CLa1hHnlBfB+GgZ9PovotTGAED1NNiG1pxL77kwbiozXCURPytpXq
 B5hkVdmGnUAcuZpbbOTjx/RmZ605FZdr0kO4N4mU35FE13dgZrGvSIBy3fbxDrEArnHtojt7qLp
 Hy17ItvniNOb8dcManF91rqOpVAxxX0pCVGUdFuRWyBIKPGPR0DHiWaE5xYIU4Khk5IG0WlNSx0
 AwHvja7gSNXC92dBtqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030106

Hi Eric,

I just successfully tested this kunit test on kernel tag next-20260602
and qemu master HEAD == 405c32d2b18a("Merge tag 'pull-tpm-2026-06-01-1'
of https://github.com/stefanberger/qemu-tpm into staging") [1]

If you are using Qemu >= v10.0.0 then the kunit test failure you
reported is due to Qemu not enabling 'cap-nested-papr' capability which
is needed to enable KVM-HV Apiv2 support in Qemu.

Without 'cap-nested-papr' Qemu doesnt register the H_GUEST_GET_STATE
Hcall which this kunit test relies on. Hence it returns -2 (H_FUNCTION)
for this unsupported HCall. The failure of kunit 'test_gs_hostwide_msg'
is expected as the underlying hypervisor doesnt have support nested-papr
APIv2 capability.

To fix this please enable qemu-system-ppc64 machine's capability
cap-nested-papr to enable nested-papr APIv2 support.

Below is the test log showing successful 'guest_state_buffer_test' kunit
test passing :

$ ./qemu-system-ppc64 --version
QEMU emulator version 11.0.50 (v11.0.0-1621-g405c32d2b1)
Copyright (c) 2003-2026 Fabrice Bellard and the QEMU Project developers

# kunit test is specific to nested-papr APIv2 so qemu cap-nested-papr needs to be enabled
$ ./qemu-system-ppc64 -display none -nographic -kernel ~/linux/vmlinux
-machine pseries,cap-nested-papr=true

<snip>
Booting from memory...                                       
OF stdout device is: /vdevice/vty@71000000                                                                                       
Preparing to boot Linux version 7.1.0-rc6-next-20260602 (vaibhav@*********) (gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2), GNU ld version 2.46-3.fc44) #2 SMP PREEMPT Wed Jun  3 04:11:38 CDT 2026
Detected machine type: 0000000000000101

<snip>
[    4.335850][    T1]     KTAP version 1
[    4.335896][    T1]     # Subtest: guest_state_buffer_test
[    4.335946][    T1]     # module: test_guest_state_buffer
[    4.335970][    T1]     1..7
[    4.337296][    T1]     ok 1 test_creating_buffer
[    4.338998][    T1]     ok 2 test_adding_element
[    4.341996][    T1]     ok 3 test_gs_bitmap
[    4.343406][    T1]     ok 4 test_gs_parsing
[    4.345607][    T1]     ok 5 test_gs_msg
[    4.347247][    T1]     ok 6 test_gs_hostwide_msg
[    4.348012][  T131]     # test_gs_hostwide_counters: Guest Heap Size=0 bytes
[    4.348183][  T131]     # test_gs_hostwide_counters: Guest Heap Size Max=0 bytes
[    4.348350][  T131]     # test_gs_hostwide_counters: Guest Page-table Size=0 bytes
[    4.348653][  T131]     # test_gs_hostwide_counters: Guest Page-table Size Max=0 bytes
[    4.348813][  T131]     # test_gs_hostwide_counters: Guest Page-table Reclaim Size=0 bytes
[    4.349354][    T1]     ok 7 test_gs_hostwide_counters
[    4.349569][    T1] # guest_state_buffer_test: pass:7 fail:0 skip:0 total:7
[    4.349635][    T1] # Totals: pass:7 fail:0 skip:0 total:7
[    4.349708][    T1] ok 4 guest_state_buffer_test


Can you try adding 'cap-nested-papr=true' to the Qemu machine you are
using and see if the problem resolves for you. If it persists can you
please share the Qemu command line you are using.

[1] https://gitlab.com/qemu-project/qemu/-/commit/405c32d2b18a683ba36301351af75125d9afda08


Eric Biggers <ebiggers@kernel.org> writes:

> On Wed, Jun 03, 2026 at 01:03:09PM +0530, Vaibhav Jain wrote:
>> Hi Eric,
>> 
>> Thanks for trying and reporting this. This kunit test depends on
>> availablility of Qemu commit 5f7d861e("spapr: nested: Add support for
>> reporting Hostwide state counter ") [1] that was merged in v10.0.0.
>> 
>> Since you havent mentioned the qemu version used I assume its a version
>> < v10.0.0 . With the qemu patch available you should see this test
>> passing with results similar to as originally described in original
>> cover letter of the patch series at [2] that introduced this kunit test.
>> 
>> [1] https://gitlab.com/qemu-project/qemu/-/commit/5f7d861e65d90e0446b8f22a0bc859a5d8058ea6
>> 
>> [2] https://lore.kernel.org/all/20250416162740.93143-1-vaibhav@linux.ibm.com/
>
> Nope, it fails even on the master branch of QEMU.
>
> - Eric

-- 
Cheers
~ Vaibhav

