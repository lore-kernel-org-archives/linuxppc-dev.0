Return-Path: <linuxppc-dev+bounces-27850-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FA7C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:26:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHsv2m3Tz2yft;
	Mon, 21 Sep 2026 19:26:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982787;
	cv=none; b=R+4uc78+TIiNNZLJVEagLEw2x0zM/DCjKSJNtVFOOBXDgVX9O/bYU6ZGUtPKy5OcU2Vqwz5/i0rFgncCeTsomNhaNeoJGrZDWooBimA7fXWOZgIdDffOto44EyVaNJpx2VTA9Bqaq42nvsefQGva/NZ3wPN1aXg0F0r6QIoeZjlmPHSm2QEfbib7KgpT5vTJUxgiJOMoXB4c4Hxw7Dqov7EMFSr9dAdiloKj66W46u0Ll+zG1dIBEW+JQFpCp/7SKxApPlzEUzOyC2sibqzoFw+MEiIHYfVQuviot2LjpJutHSqg4M7mEaZI5V/GgBLxMuFjAVL01drQGIT+5VwFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982787; c=relaxed/relaxed;
	bh=xytVi9pdIT1LqxLyC+bHEvqfWMmb8m+inCRslyqdSiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMOwoIufZ6xNB3yggxzolvO3bihyWta7JhwOXbL5OPE7H5HwoxqBquicbEun6IkYHk0CiDiz+F7ogRVVnANtpK9rR0yebsSGiYYdl4+jLTJI0W7Q4qeXSM9vusftD8yuN+a+lKwZt8gZsjpaVWIZGoSfrL41tBETVDC8BbeCjoGOWHRXVEr23PYfHr6VY3zhq7OJ8Jxs6IjknYEK2dLbOi+TijNMwoc/+S8HSSjkw2YWCB/7kX2Ql2xIbGcUIBtrpAv0VgZG/D0kpY3XKoyt7rZZcNvJXhZ84t/c4dv9h9v9Cf/HittdkaIhK9JRiPPUYnhwY2r6BjbkWVXz3NByag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z7eAYAwd; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z7eAYAwd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHst4WSMz2yfs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:26:26 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7aO1P820807;
	Mon, 21 Sep 2026 09:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xytVi9
	pdIT1LqxLyC+bHEvqfWMmb8m+inCRslyqdSiI=; b=Z7eAYAwdujPwp78eY/cOX7
	XHkOrk6cBQLpG+jOt3nMgqe6ijlPf9EMxcuIV0EnrtcvnXx0NQAInSjrCSL86h01
	IhP/7j8sMwBxk1coWL0XB4QLxyRZJjExkpkwaVSmgH1njNKRFlg4fkIqayQbd+Fm
	jA3hAzBIrjMkpg8mGblv49+xMR6jq+2YAqfFfU0voGCXQQTUD1OwGBOS7p0ybaJg
	FcRw2ELg+G+yy94V/nMrKB3FEq3P4neCG+xBtE1o48IMtZBG6tw03U/MiKh3A81y
	u8DXzl0vZhKcnu0icQff5MsshIPUT12rMfAh/RxFrL5IKTC3QaLtHKoHvs3JKxcw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg27rbm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:26:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HwYO844286;
	Mon, 21 Sep 2026 09:26:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjmmk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:26:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L9QJIb47710508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 09:26:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E93A72004B;
	Mon, 21 Sep 2026 09:26:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF61D20043;
	Mon, 21 Sep 2026 09:26:17 +0000 (GMT)
Received: from [9.123.2.177] (unknown [9.123.2.177])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 09:26:17 +0000 (GMT)
Message-ID: <4243a207-32d4-40ee-b41a-4bc862492e46@linux.ibm.com>
Date: Mon, 21 Sep 2026 14:56:16 +0530
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
Subject: Re: [BUG] PCIe passthrough of MCS9990 fails
To: Timothy Pearson <tpearson@raptorengineering.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>
References: <133526175.85096.1789756371777.JavaMail.zimbra@raptorengineeringinc.com>
 <1582840094.85102.1789757342292.JavaMail.zimbra@raptorengineeringinc.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <1582840094.85102.1789757342292.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: PDXnb5PfretDHfXYz9BFXDg0wLuRWED0
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab0f840 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=yKAn6K1XAAAA:8
 a=voM4FWlXAAAA:8 a=pGLkceISAAAA:8 a=PTqAF-kfUxTkO0AQ2uoA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=6M1ixcW_PCWoKiWyFx5v:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzMCBTYWx0ZWRfXwM0S8fryZlnR
 kX3sH8ivKedCLGisIBbtWcbetWXPzhBHFixXoi+8YkGpry7vSB63JZPuoYZB0xenTU2AdmA1cau
 lqUIUUKwKAcUzbYIBquLiT8CViyToRzvbis5bC8StxgOxrKKFmmRfRy7f5PncmZllbILNLj9j2m
 EVH+t8wqfNpVLk2D38yGTntHGflxUbMrByBQT56xm0LlH6BpW5bPGQl5LD85I50t3XUp9uhHehO
 KI5BMvvcb3tj8TZU+jFQ1Kz3L9mAfPMXSuUGF4T4Psz56lrbiCiBN79Y0Z0G6B4G9duFqIo0c/7
 01e1Um+PXSejCrwLABf8sY4jUZ4XjbBAHqeJYS5au8Oi59Ywze7YMD2QsIq3tcAaejSLmJnGyMW
 OgJzhCIFr7w/4aGY/7HCuZU+HEvaP9ozGgK3SR9kG2NdVzUx0AMzIKsxnea+Zhkv3yVfSYR9ZIl
 ixKFPCPuJH1FfB+z6Bg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzMCBTYWx0ZWRfX54r6y4SdUU+6
 m34L+rwuO+cyTfDT/pcmA2e0ZF2NmqLvaedQ+S8zEwHIl3ZKinUEYxuZwe+onBHqB9bjYLYwg6Q
 SpSPQEZTWZ4duSmgxCzbKH9IctTv3yo=
X-Proofpoint-GUID: RTmq5acvFfBbWlfsxtArpoiC9H9iw4_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210130

Hi Timothy,

Thanks for the detailed logs.

On 19/09/26 12:19 AM, Timothy Pearson wrote:
> I've also seen the following failure in the guest when passing through more than one PCIe function:
> 
> [    0.710454] pci 0000:01:00.1: EHCI: unrecognized capability 00
> [    0.710546] EEH: Recovering PHB#0-PE#10001
> [    0.710598] EEH: PE location: N/A, PHB location: N/A
> [    0.710669] EEH: Frozen PHB#0-PE#10001 detected
> [    0.710745] EEH: Call Trace:
> [    0.710832] EEH: [000000007d519995] __eeh_send_failure_event+0x7c/0x160
> [    0.710944] EEH: [00000000419515d5] eeh_dev_check_failure+0x2e0/0x6d0
> [    0.711011] EEH: [000000008950df7e] quirk_usb_early_handoff+0xca4/0xfd0
> [    0.711076] EEH: [000000002528ae55] pci_fixup_device+0x140/0x2d0
> [    0.711137] EEH: [000000002e85a626] pci_apply_final_quirks+0xb4/0x1b8
> [    0.711199] EEH: [00000000e0915ba4] do_one_initcall+0x80/0x3b0
> [    0.711255] EEH: [0000000014cb0304] kernel_init_freeable+0x340/0x3e4
> [    0.711311] EEH: [00000000b18e64ad] kernel_init+0x30/0x1a0
> [    0.711357] EEH: [0000000047d4e5e3] ret_from_kernel_user_thread+0x14/0x1c
> [    0.711413] EEH: This PCI device has failed 1 times in the last hour and will be permanently disabled after 5 failures.
> [    0.711493] EEH: Notify device drivers to shutdown
> [    0.711538] EEH: Beginning: 'error_detected(IO frozen)'
> [    0.711584] PCI 0000:01:00.1#10001: EEH: no driver
> [    0.711589] PCI 0000:01:00.3#10001: EEH: no driver
> [    0.711644] PCI 0000:01:00.5#10001: EEH: no driver
> [    0.711689] PCI 0000:01:00.7#10001: EEH: no driver
> [    0.711737] EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state:'none'
> [    0.711860] EEH: Collect temporary log
> [    0.712602] EEH: of node=0000:01:00.1
> [    0.712654] EEH: PCI device/vendor: 99909710
> [    0.712720] EEH: PCI cmd/status register: 00100146
> [    0.712761] EEH: PCI-E capabilities and status follow:
> [    0.712876] EEH: PCI-E 00: 00010010 00008fc1 0000283f 01078011
> [    0.712989] EEH: PCI-E 10: 00110008 00000000 000003c0 00000000
> [    0.713044] EEH: PCI-E 20: 00000000
> [    0.713082] EEH: of node=0000:01:00.3
> [    0.713129] EEH: PCI device/vendor: 99909710
> [    0.713187] EEH: PCI cmd/status register: 00100146
> [    0.713232] EEH: PCI-E capabilities and status follow:
> [    0.713345] EEH: PCI-E 00: 00010010 00008fc1 0000283f 01078011
> [    0.713460] EEH: PCI-E 10: 00110008 00000000 000003c0 00000000
> [    0.713513] EEH: PCI-E 20: 00000000
> [    0.713547] EEH: of node=0000:01:00.5
> [    0.713595] EEH: PCI device/vendor: 99909710
> [    0.713655] EEH: PCI cmd/status register: 00100146
> [    0.713700] EEH: PCI-E capabilities and status follow:
> [    0.713812] EEH: PCI-E 00: 00010010 00008fc1 0000283f 01078011
> [    0.713938] EEH: PCI-E 10: 00110008 00000000 000003c0 00000000
> [    0.714007] EEH: PCI-E 20: 00000000
> [    0.714052] EEH: of node=0000:01:00.7
> [    0.714108] EEH: PCI device/vendor: 99909710
> [    0.714182] EEH: PCI cmd/status register: 00100146
> [    0.714239] EEH: PCI-E capabilities and status follow:
> [    0.714371] EEH: PCI-E 00: 00010010 00008fc1 0000283f 01078011
> [    0.714501] EEH: PCI-E 10: 00110008 00000000 000003c0 00000000
> [    0.714571] EEH: PCI-E 20: 00000000
> [    0.714623] EEH: Reset with hotplug activity
> [    0.714942] pci 0000:01:00.1: quirk_usb_early_handoff+0x0/0xfd0 took 12340 usecs
> [    0.716273] PCI: CLS 0 bytes, default 128
> [    0.716424] Trying to unpack rootfs image as initramfs...
> [    0.725599] Initialise system trusted keyrings
> [    0.725679] Key type blacklist registered
> [    0.725797] workingset: timestamp_bits=38 max_order=19 bucket_order=0
> [    0.725891] zbud: loaded
> 
> Passing through one single EHCI function seems to at least allow the guest to boot, but only *once* after each power cycle.
> 
> All functions are in the same IOMMU group:
> 
> [  617.749136] pci 0031:01:00.0: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
> [  617.749797] pci 0031:01:00.1: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
> [  617.750412] pci 0031:01:00.2: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
> [  617.751035] pci 0031:01:00.3: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
> [  617.751668] pci 0031:01:00.4: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
> [  617.752270] pci 0031:01:00.5: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
> [  617.752871] pci 0031:01:00.6: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
> [  617.753467] pci 0031:01:00.7: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
> [  617.754039] pci 0031:00:00.0: disabling bridge window [io  0x0000-0xffffffffffffffff] to [bus 01] (unused)
> [  617.754642] pci 0031:00:00.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff 64bit pref] to [bus 01] (unused)
> [  617.755257] pci 0031:01:00.0: BAR 0 [mem 0x620c080000000-0x620c080000fff]: assigned
> [  617.755813] pci 0031:01:00.1: BAR 0 [mem 0x620c080010000-0x620c080010fff]: assigned
> [  617.756195] pci 0031:01:00.2: BAR 0 [mem 0x620c080020000-0x620c080020fff]: assigned
> [  617.756559] pci 0031:01:00.3: BAR 0 [mem 0x620c080030000-0x620c080030fff]: assigned
> [  617.756923] pci 0031:01:00.4: BAR 0 [mem 0x620c080040000-0x620c080040fff]: assigned
> [  617.757281] pci 0031:01:00.5: BAR 0 [mem 0x620c080050000-0x620c080050fff]: assigned
> [  617.757635] pci 0031:01:00.6: BAR 0 [mem 0x620c080060000-0x620c080060fff]: assigned
> [  617.757980] pci 0031:01:00.7: BAR 0 [mem 0x620c080070000-0x620c080070fff]: assigned
> [  617.758332] pci 0031:00:00.0: PCI bridge to [bus 01]
> [  617.758662] pci 0031:00:00.0:   bridge window [mem 0x620c080000000-0x620c0ffefffff]
> [  617.759016] pci_bus 0031:01: Configuring PE for bus
> [  617.759357] pci 0031:01     : [PE# fd] Secondary bus 0x0000000000000001 associated with PE#fd
> [  617.759875] pci 0031:01:00.0: Configured PE#fd
> [  617.760213] pci 0031:01     : [PE# fd] Setting up 32-bit TCE table at 0..80000000
> [  617.762565] pci 0031:01     : [PE# fd] Setting up window#0 0..7ffffffffff pg=10000
> [  617.763014] pci 0031:01     : [PE# fd] Enabling 64-bit DMA bypass
> [  617.763631] pci 0031:01:00.0: Adding to iommu group 10
> [  617.764218] pci 0031:01:00.0: enabling device (0140 -> 0142)
> [  617.764735] pci 0031:01:00.1: Added to existing PE#fd
> [  617.765064] pci 0031:01:00.1: Adding to iommu group 10
> [  617.765483] pci 0031:01:00.1: enabling device (0140 -> 0142)
> [  617.766003] pci 0031:01:00.2: Added to existing PE#fd
> [  617.766331] pci 0031:01:00.2: Adding to iommu group 10
> [  617.766764] pci 0031:01:00.2: enabling device (0140 -> 0142)
> [  617.767179] pci 0031:01:00.3: Added to existing PE#fd
> [  617.767517] pci 0031:01:00.3: Adding to iommu group 10
> [  617.767932] pci 0031:01:00.3: enabling device (0140 -> 0142)
> [  617.768339] pci 0031:01:00.4: Added to existing PE#fd
> [  617.768655] pci 0031:01:00.4: Adding to iommu group 10
> [  617.769068] pci 0031:01:00.4: enabling device (0140 -> 0142)
> [  617.769468] pci 0031:01:00.5: Added to existing PE#fd
> [  617.769768] pci 0031:01:00.5: Adding to iommu group 10
> [  617.770176] pci 0031:01:00.5: enabling device (0140 -> 0142)
> [  617.770623] pci 0031:01:00.6: Added to existing PE#fd
> [  617.770921] pci 0031:01:00.6: Adding to iommu group 10
> [  617.771321] pci 0031:01:00.6: enabling device (0140 -> 0142)
> [  617.771729] pci 0031:01:00.7: Added to existing PE#fd
> [  617.772014] pci 0031:01:00.7: Adding to iommu group 10
> [  617.772451] pci 0031:01:00.7: enabling device (0140 -> 0142)
> 
> 
> ----- Original Message -----
>> From: "Timothy Pearson" <tpearson@raptorengineeringinc.com>
>> To: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
>> Cc: "Ritesh Harjani" <ritesh.list@gmail.com>
>> Sent: Friday, September 18, 2026 1:32:51 PM
>> Subject: [BUG] PCIe passthrough of MCS9990 fails
> 
>> When passing through all eight PCIe functions of a MCS9990 PCIe USB
>> multifunction 1.0/2.0 controller on a PowerNV POWER9 host using qemu, the guest
>> fails to launch:
>>
>> qemu-system-ppc64: -device vfio-pci,host=0031:01:00.1,bus=bridge-1,addr=00.1:
>> vfio 0031:01:00.1: Failed to set up TRIGGER eventfd signaling for interrupt
>> INTX-0: VFIO_DEVICE_SET_IRQS failure: Device or resource busy
>>
>> If I instead pass through only one function, or only pass through odd functions
>> (the EHCI controller set), I get the following errors in the guest:
>>
>> [    0.886625] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002,
>> bcdDevice= 6.18
>> [    0.886710] usb usb1: New USB device strings: Mfr=3, Product=2,
>> SerialNumber=1
>> [    0.886791] usb usb1: Product: EHCI Host Controller
>> [    0.886845] usb usb1: Manufacturer: Linux 6.18.38 ehci_hcd
>> [    0.886902] usb usb1: SerialNumber: 0000:01:00.0
>> [    1.142469] usb 1-1: new high-speed USB device number 2 using ehci-pci
>> [    6.530490] usb 1-1: device descriptor read/64, error -110
>> [   22.147501] usb 1-1: device descriptor read/64, error -110
>> [   22.371536] usb 1-1: new high-speed USB device number 3 using ehci-pci
>> [   27.526896] usb 1-1: device descriptor read/64, error -110
>> [   43.141934] usb 1-1: device descriptor read/64, error -110
>> [   43.245985] usb usb1-port1: attempt power cycle
>> [   43.638173] usb 1-1: new high-speed USB device number 4 using ehci-pci
>> [   54.491254] usb 1-1: device not accepting address 4, error -110
>> [   54.611274] usb 1-1: new high-speed USB device number 5 using ehci-pci
>>
>> If I reboot the guest, SLOF fails as follows:
>>
>> Scanning USB
>>   EHCI: Initializing
>> usb-ehci: reset failed
>> usb-ehci: control transfer timed out_
>> usb-ehci: unable to setup device on port 0
>>
>> Note that this card works perfectly on the host kernel.
 From what I can tell so far, this looks like it may be related to the
passthrough device falling back to legacy INTx on a shared IRQ.

My current suspicion is that the multifunction device may not provide
usable per-function INTx masking, so VFIO cannot safely mask one
function while the IRQ is shared by the other functions. That could
explain the interrupt behaviour we are seeing, but I would like to
confirm the actual interrupt mode before drawing any conclusion.

Could you please share the following from the failing setup?

lspci -vvv for all functions of the multifunction device on the host
lspci -vvv for the passed-through device inside the guest
/proc/interrupts on the host before and after starting the guest
any VFIO/IRQ related messages from host dmesg
the relevant QEMU command line

In particular, I would like to confirm whether the device is actually
running with legacy INTx, whether the functions share the same host IRQ,
and whether MSI/MSI-X is being enabled successfully in the guest.

Thanks,
Narayana
> 


