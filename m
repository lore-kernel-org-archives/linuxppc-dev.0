Return-Path: <linuxppc-dev+bounces-24616-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B72C4452B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 22:07:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4Wj916Ydz2xJR;
	Wed, 22 Jul 2026 08:07:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784653949;
	cv=none; b=Yfj0923fXh1Rc2KD0/Ox29DxFTazQHK4uu4e9jkGUyEXDfzumeJ3wdHoIDyAYWH+f0nliXPXirJH6QauLRrIUyLW7AuK330z9ujL1UWG47FBFWf4OynXEYJ8z4eS2InUaLRnJv1nRfI920noIP5/uOeBW3EKdK86ldmYy2FMrtez3rWHTzC+id+2nk2BkWMUsFuzbMw66DIw6S9sJqAbGLsjWsm2fgY2MoSAxMxDg+PiGsW79VWC+tL79sAY3sU2ahUD3oE3i9P2pxjviJkBrjl5DcogYbQhJLXlY0JmIPP53aB54GQkiXJu5d5Amu0+BMBAFRHMVJY6aorNfzlbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784653949; c=relaxed/relaxed;
	bh=JlnBXXFLqSPOhrvoqxmlfnQRdDb3byg2AarOIYliRow=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D6F4lmBP1kxZ3aK+HybYbdsK07b7Geumw8CTkFA/4rgAhVSS39NsSdyVbTjJ16J4SUJAoxWCXLD7j9VP1GRr5AFcA6nyn9YTOXNUubMr9fIzkqkAfMpC1vxl+9U3wlUdm8+wFMZSGoB3LViiIWuOAw0nGZVnwkw8zX84Sk3y/kyDvzrJbqxGn58e46Av0WVX9m9nhV5PPe0F3iuEkqDCYXVOqL+3Ne3O5ZRT35+KFKgq3itjO18qqkzkAV3Gn6SdNzp0iai/jCrJajROmO3+tr7KtCVTgVAFW/NHI8TfxyVCsrtDjJGhxQQFo1CE3udbds1A+0iPqf1hykceb1FrTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PSw1Zgb5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=asahu1x@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PSw1Zgb5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=asahu1x@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4P8D0j3Bz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 03:12:27 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LHBk9u1544136;
	Tue, 21 Jul 2026 17:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JlnBXX
	FLqSPOhrvoqxmlfnQRdDb3byg2AarOIYliRow=; b=PSw1Zgb5CZE5R0nrl0tp9A
	OKtQDS4ZQxviWbTFxLesbi57zHiDlXoEEZ8y0Gh6VZi+fZO1UeUq8nTg/AgmoCoF
	gCQMKDMKlnTaqONizaVHdBr3xjjeZaH9/2EmlKmjVRv1mkTwnRfpmqSEsK3z3Cca
	e7M9l5r4RTiTnhIlwNSbuBn4+jXf3BIr2zzuCcwPfHj6IUBF54Hj7Jst9HAus3yc
	Xo5e5vnAcAVdSzr5u6WQFSErGP3+NoiOa4tmVxPsmwFNqrJ8m8eIjovQCrTNkLTc
	oD2cCh8ih8nFbYIuQvWclsTTEaVLZNjWGqLpQ+Qy9+Tt0tZitTgdE5HLCalPV1fw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g5e2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 17:12:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66LH7Nkx024973;
	Tue, 21 Jul 2026 17:12:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah39xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 17:12:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66LHCKj652625858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 17:12:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1926E58056;
	Tue, 21 Jul 2026 17:12:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50FA258062;
	Tue, 21 Jul 2026 17:12:16 +0000 (GMT)
Received: from [9.39.17.135] (unknown [9.39.17.135])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 17:12:15 +0000 (GMT)
Message-ID: <0b4fe641-ac79-416d-8b8e-8dc9adaa1041@linux.ibm.com>
Date: Tue, 21 Jul 2026 22:42:14 +0530
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
Subject: Re: [kvm-unit-tests PATCH v2 0/6] powerpc improvements
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com, asahu1x@linux.ibm.com
References: <20260719130027.2347519-1-rathc@linux.ibm.com>
 <7cf674d9-6928-47a3-9d80-c1bd22ae6f7b@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <7cf674d9-6928-47a3-9d80-c1bd22ae6f7b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE4MSBTYWx0ZWRfX4IIKSa4QJ3rH
 RgixbFh5lWVG8zRP315PQ659q2y2E70MV6gmbcdoo4f30ZpVVv5YhjEBGxZXmTMY9lG+VeyvqrR
 MBfXmcgDAek/O4Jtfic8ALRq9amvoGvvs0xznuIMlADQDm3Kez2b9vtG5wbTQMVRgCTefatVtLw
 yj9EgJmk2Z4JoCYBQ4BPtSstFAD4BQi23aucDKTb7WJDGIQW68o3fycbuWlzk0lS1lqh+WFaCD0
 Q9IXsuJ89hJymJ/bOGkZVD9+WULCqQ0aGufD7WMNFiq6Y2FyO7weHV/Ptnh66Zs0UJkZEToBTnq
 Tmk0jwIvX1/ksU5Acyofy2glKpcmteh94FkB1tl0nqn2WZkgOe38lnKsVq6wn1J65uby/sjpowz
 pThG0o7RJr2J92otGfvQ8lTt/2snVNH7IoLIeyj6uaM+HB9NRAvty4JHNUBTy5TWbx/hkyfP4WI
 wY9mKLkk5PbeKT9i+Zw==
X-Proofpoint-GUID: giPh5XzHR3pJXqeJ8CZDOLYzH_-1BwAC
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5fa876 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=jDKATvllps1Oe7LPM_oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE4MSBTYWx0ZWRfX4r4YQcqAMyrm
 aWCDCjKkl7TRn4Js/ycVn0nxGnzdi/+bGbBSrjbLxi3xmYm67TgfA4tqiT3fHbhmTPQbz+q8thN
 G8VEMUWSpR//neh664o0JKcZ3w7n1xY=
X-Proofpoint-ORIG-GUID: 22rp3vZ0agM4Yywxq_jhtfULvbimLyYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210181

Sorry for the formatting mess in my previous email, my mail client 
stripped the linebreaks. Here is the readable version:

On Sun, 19 Jul 2026, Chinmay Rath wrote:
 > This series aims to add a couple of new powerpc tests and improve
 > the powerpc build structure.

Tested on POWER10 (native KVM, ppc64le).

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>

--- Environment ---

   Host CPU   : POWER10 (architected), altivec supported
   Kernel     : Linux 7.0.0-27-generic #27-Ubuntu SMP PREEMPT_DYNAMIC
                Thu Jun 18 19:14:19 UTC 2026 ppc64le GNU/Linux
   OS         : Ubuntu 26.04 LTS (Resolute Raccoon)
   QEMU       : 10.2.1 (Debian 1:10.2.1+ds-1ubuntu3.1)
   Accelerator: KVM (-accel kvm -machine pseries,cap-ccf-assist=off)
   Branch     : origin/ppc64 @ dde8f397

--- Test: pmu (Patch 1) ---

   $ ./run_tests.sh -a powerpc pmu
   PASS pmu (22 tests, 1 known failure)

Full log:

   timeout -k 1s --foreground 90s \
     /usr/bin/qemu-system-ppc64 -nodefaults -accel kvm \
     -machine pseries,cap-ccf-assist=off -bios powerpc/boot_rom.bin \
     -display none -serial stdio -kernel powerpc/pmu.elf -smp 1

   PASS: pmu: pmc56: PMC5 zeroed
   PASS: pmu: pmc56: PMC6 zeroed
   PASS: pmu: pmc56: PMC5 frozen
   PASS: pmu: pmc56: PMC6 frozen
   PASS: pmu: pmc56: PMC5 counting
   PASS: pmu: pmc56: PMC6 counting
   PASS: pmu: pmc56: PMC6 ratio to reported clock frequency is 116%
   PASS: pmu: pmc56: PMC5 counts instructions precisely 900
   PASS: pmu: pmc56: PMC5 counts instructions exactly 21
   PASS: pmu: pmc56: PMC5 counts instructions with branch 21
   PASS: pmu: pmc56: PMC5 counts instructions wth conditional branch 24
   PASS: pmu: pmc56: PMC5 counts instructions with illegal instruction
   PASS: pmu: pmc56: PMC5 counts instructions with fault
   PASS: pmu: pmc56: PMC5 counts instructions with syscall
   PASS: pmu: pmc56: PMC5 counts instructions with rfid 2
   PASS: pmu: pmc56: PMC5 counts instructions with ldat
   PASS: pmu: pmi: PMAO caused interrupt
   PASS: pmu: bhrb: BHRB is frozen
   PASS: pmu: bhrb: BHRB has been written
   KFAIL: pmu: bhrb: BHRB has written 8 entries
   PASS: pmu: bhrb: BHRB has written 4 entries
   PASS: pmu: bhrb: correct conditional branch address
   SUMMARY: 22 tests, 1 known failure

   EXIT: STATUS=1

Note: The KFAIL on "BHRB has written 8 entries" is expected. POWER10
records 4 BHRB entries when other threads are active on the core; the
test explicitly accounts for this with a fallback 4-entry check which
passes. STATUS=1 is the correct exit code when known failures exist.

--- Test: selftest-setup (Patch 3/build structure) ---

   $ ./run_tests.sh -a powerpc selftest-setup
   PASS selftest-setup (2 tests)

Full log:

   timeout -k 1s --foreground 90s \
     /usr/bin/qemu-system-ppc64 -nodefaults -accel kvm \
     -machine pseries,cap-ccf-assist=off -bios powerpc/boot_rom.bin \
     -display none -serial stdio -kernel powerpc/selftest.elf \
     -smp 2 -append setup smp=2 mem=1024 -m 1g

   PASS: selftest: setup: smp: nr_cpus_present = 2
   PASS: selftest: setup: mem: size = 1024 MB
   SUMMARY: 2 tests

   EXIT: STATUS=1

--- Test: selftest-panic (Patches 5 & 6) ---

   $ ./run_tests.sh -a powerpc selftest-panic
   PASS selftest-panic

Full log:

   run_panic timeout -k 1s --foreground 90s \
     /usr/bin/qemu-system-ppc64 -nodefaults -accel kvm \
     -machine pseries,cap-ccf-assist=off -bios powerpc/boot_rom.bin \
     -display none -serial stdio -kernel powerpc/selftest.elf \
     -smp 1 -append panic

   qemu-system-ppc64: OS terminated: rtas_os_panic
   PASS: guest panicked

   EXIT: STATUS=1

Note: The panic test validates both the new rtas_os_panic() RTAS call
(Patch 6) and the run_panic() exit status fix (Patch 5). QEMU exits
with "OS terminated: rtas_os_panic" confirming the ibm,os-term RTAS
token is correctly invoked, and the test runner correctly identifies
this as a successful (expected) panic.

Aniket Sahu

