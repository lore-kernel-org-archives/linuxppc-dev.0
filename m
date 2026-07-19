Return-Path: <linuxppc-dev+bounces-24414-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCAEC44512
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 07:15:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2w0L4Jlwz2yQJ;
	Sun, 19 Jul 2026 17:15:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784445330;
	cv=none; b=h3hEz/GBHnz6DDRZHiVvtKs1iwb7DDkGR0qkwuePRlaCaccq9f+wEGUhSv8FaK6kv4Ip/MVJx6T0QadPOUrl4V9kkTx1nWtIciT8yUll3EHuxa+YIT0Dfje1u69ZSqIflUaHP8LthBRxOEYbHmvhXs1+V+cdWGHxvOy6sAFfd2tY6E+GwoQLiW6GFlfa8djCgBKeRY7SsfWWWO0/oOhqBwuTWDFwBYHFe8uwFwkEYDrkc/5kUypKlP5I96Z+UC9jDy0rNxWiVQWUo/7lly/tEYcnLBQ9D6aaK2IF5pZBa0+FbNVG2Dl2QMnJQV6UZQj333oO2I+K0W2CdI4Rht6doA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784445330; c=relaxed/relaxed;
	bh=ox8trhHUvNH0WHMQUhN5/bhYvJeZT8+F45fQOMaO39w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PIZnT5o/+VuVKTL6zpgV80fvxVzuRmrMCk7mnJNBxwSgB3MU2XxaYKOv33vd5WqfQODFNuHIRVJJucKRzB5IYCGG2LiiTdu9BMfq7DUpXayyQbqB1+3jSZPWPvvxHQYMnwelcd+bScIJSxze0T1/JKrgOvL/LUCUyY+eX1y+YRRYJWh1UQlC5j1fjXcSWdFQZkpxygl12j+3pa91Kmdw1XfrEm/me/LAThaRXZ+rF+S5uAQaRFI11E2AfoXh1kBdoVp43ykYNcCVqugEpuhu5hcWZl4GG5qAiA8y9hLmskZuFwlZglH6K/V/YYRZ1iGvMbho6tjJU1Maq+dHpGlCzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Mx97koCB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Mx97koCB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h2w0K3PzHz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 17:15:28 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66J5BbIK2654280;
	Sun, 19 Jul 2026 07:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ox8trh
	HUvNH0WHMQUhN5/bhYvJeZT8+F45fQOMaO39w=; b=Mx97koCBG78ZNpBuy1soP7
	0uwwvswmbfpexwdjlWWXKlkiNlAU8jozZDLNHELHiOuiEgBWraU9lB+fOqNtLP2b
	dlMiXbXGwNSvpEsqZlMBDlmq8q7iHisR7ZApf7U66lnAUzEMxA9bTFirZ2JvvdtG
	udKdeYl6kE+rlSV8SZZGR3j+PH0vNmF/EX6taInYAPov9ZFc/Cw4RN3fklcMTQPE
	UBYiXYowUeUAOlsgbQYkXYrHh9c0CnRRBjzdTrG2yfr00uxMuxaAEw6Xrdzn2Qcj
	Zx17mURoq4qEraVjX4GsUhdcATwquXuE9Oj0EpOJMu/CjCqB57BAhFCdvH+eXJjg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab2qb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 07:15:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66J74ipj005963;
	Sun, 19 Jul 2026 07:15:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpryng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 07:15:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66J7FFNK59703796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 07:15:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35D772004B;
	Sun, 19 Jul 2026 07:15:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0165320043;
	Sun, 19 Jul 2026 07:15:12 +0000 (GMT)
Received: from [9.124.218.25] (unknown [9.124.218.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 07:15:11 +0000 (GMT)
Message-ID: <b0c5b727-2888-4927-81e6-4ed3592a7e60@linux.ibm.com>
Date: Sun, 19 Jul 2026 12:45:10 +0530
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
Subject: Re: powerpc/pseries: EEH detected with xhci_hcd
To: Narayana Murty N <nnmlinux@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        shivang upadhyay <shivangu@linux.ibm.com>, sbhat@linux.ibm.com
References: <2ad00297-eca5-4f36-ad01-138837f6fa4f@linux.ibm.com>
 <29f33de0-0861-459f-b6a0-440354fac785@linux.ibm.com>
 <ad7eefde-0439-4258-92a7-4ab782a32d42@linux.ibm.com>
 <e1733e27-1210-4d73-bfa2-b86c085ebd6c@linux.ibm.com>
 <251a81b8-fa29-4704-b264-25ec12ec3c8b@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <251a81b8-fa29-4704-b264-25ec12ec3c8b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDA3NSBTYWx0ZWRfX0MN41B7vyOUK
 4C+Q1IwlS+GaWLJpq/jyzetV5KWcxBu4WHMTx/tPXTcbzbUOD5mek0rsJq5r5WPlBc4Wi1yohrZ
 M3sm5V4sywAakRIzax0ItKbZy7M17BLaX3Ax/HPfv0yJ4fFaJOs9bphJIWWecmS12bynhrEotR6
 49W4XY0R0rctND/5VoKFw0h3hlIfMUpNJstnVjLFGUBcgw526ge1SieUWDnvo15FUgzYDytFDtR
 GLoHUQQri8YDC3Uz2rp/uFg9j+t//UTOPCVZJnzH13YxyplKSflpa6/WJrTmp3MdSS07SvKsDxO
 Pb0zlO7Lkoc2YFzx35ANyfOdAjzdlRu60xtKfFmizt5FuLN5sDgTUB3M1VeQsjcSkEacdr3R4xl
 fQ2yh1M1jDoRhncZCr8P3Lja5LkDElHyNZCuKQTQol78RVBNbzJJgpBq/6njZjAOLHxmE+7lkyU
 SzFxtDg9CGMV6JmQqrw==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5c7988 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=dQHYoLlMQ75wI51CLIAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IfwggU-l7TRPo8WgJKBQe3UtJRUuJ5Wr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDA3NSBTYWx0ZWRfX2svb0cpC/ESp
 ssG57XZOl1femu1VuGHRTqS02fxfeevK088oECp2ytY53mEocMnzulRu+LaUyEX6AkdydDx9XXo
 btStshE1WscGB7npPdEQb6fSb0ADW3Y=
X-Proofpoint-GUID: Vasx_EH4Gv2xx3hbkJ8zTwQmaiR9wyag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190075



On 19/07/26 10:55, Narayana Murty N wrote:
>
>
> On 19/07/26 9:47 AM, Sourabh Jain wrote:
>>
>>
>> On 17/07/26 10:26, Narayana Murty N wrote:
>>>
>>>
>>> On 15/07/26 7:33 PM, Sourabh Jain wrote:
>>>>
>>>> This issue only occurs with the Radix MMU.
>>>> Booting the same kernel with disable_radix=1 does not reproduce the 
>>>> issue.
>>>>
>>>> The system also has pmem.
>>>>
>>>> +CC Shivang and Shiva
>>>>
>>>> - Sourabh Jain
>>>>
>>>>
>>>> On 15/07/26 15:01, Sourabh Jain wrote:
>>>>> Hello,
>>>>>
>>>>> Upstream kernel with head at commit 
>>>>> 3b029c035b34bbc693405ddf759f0e9b920c27f1
>>>>> hitting EEH with xhci_hcd during kernel boot.
>>>>>
>>>>> The issue was not observed on the distro kernel running on the the 
>>>>> same machine.
>>>>>
>>>>> Trace:
>>>>> [    2.130359] [      C8] ibmvscsi 30000066: SRP_LOGIN succeeded
>>>>> [    2.132280] [    T362] xhci_hcd 0014:01:00.0: xHCI Host Controller
>>>>> [    2.132289] [    T362] xhci_hcd 0014:01:00.0: new USB bus 
>>>>> registered, assigned bus number 1
>>>>> [    2.132449] [    T362] xhci_hcd 0014:01:00.0: 
>>>>> ibm,query-pe-dma-windows(53) 10000 8000000 20000014 returned 0, 
>>>>> lb=1000000 ps=103 wn=1
>>>>> [    2.132453] [    T362] xhci_hcd 0014:01:00.0: Skipping ibm,pmemory
>>>>> [    2.141861] [    T110] scsi 0:0:1:0: Direct-Access  AIX VDASD  
>>>>>           0001 PQ: 0 ANSI: 3
>>>>> [    2.143707] [    T362] xhci_hcd 0014:01:00.0: 
>>>>> ibm,create-pe-dma-window(54) 10000 8000000 20000014 15 28 returned 
>>>>> 0 (liobn = 0x70000014 starting addr = 8000000 0)
>>>>> [    2.147236] [    T362] xhci_hcd 0014:01:00.0: lsa_required: 0, 
>>>>> lsa_enabled: 0, direct mapping: 1
>>>>> [    2.147239] [    T362] xhci_hcd 0014:01:00.0: iommu: 64-bit OK 
>>>>> but direct DMA is limited by 800010000000000
>>>>> [    2.147250] [    T362] xhci_hcd 0014:01:00.0: lsa_required: 0, 
>>>>> lsa_enabled: 0, direct mapping: 1
>>>>> [    2.147252] [    T362] xhci_hcd 0014:01:00.0: iommu: 64-bit OK 
>>>>> but direct DMA is limited by 800010000000000
>>>>> [    2.147476] [    T362] xhci_hcd 0014:01:00.0: hcc params 
>>>>> 0x0270f06d hci version 0x96 quirks 0x0000000004000000
>>>>> [    2.149530] [    T362] xhci_hcd 0014:01:00.0: xHCI Host Controller
>>>>> [    2.149536] [    T362] xhci_hcd 0014:01:00.0: new USB bus 
>>>>> registered, assigned bus number 2
>>>>> [    2.149542] [    T362] xhci_hcd 0014:01:00.0: Host supports USB 
>>>>> 3.0 SuperSpeed
>>>>> [    2.149638] [    T362] usb usb1: New USB device found, 
>>>>> idVendor=1d6b, idProduct=0002, bcdDevice= 7.02
>>>>> [    2.149642] [    T362] usb usb1: New USB device strings: Mfr=3, 
>>>>> Product=2, SerialNumber=1
>>>>> [    2.149644] [    T362] usb usb1: Product: xHCI Host Controller
>>>>> [    2.149646] [    T362] usb usb1: Manufacturer: Linux 
>>>>> 7.2.0-rc3upstream+ xhci-hcd
>>>>> [    2.149647] [    T362] usb usb1: SerialNumber: 0014:01:00.0
>>>>> [    2.149817] [    T362] hub 1-0:1.0: USB hub found
>>>>> [    2.149937] [    T362] hub 1-0:1.0: 4 ports detected
>>>>> [    2.150020] [    T362] xhci_hcd 0014:01:00.0: xHCI host 
>>>>> controller not responding, assume dead
>>>>> [    2.150044] [    T362] xhci_hcd 0014:01:00.0: HC died; cleaning up
>>>>> [    2.150125] [    T118] EEH: Recovering PHB#14-PE#10000
>>>>> [    2.150135] [    T118] EEH: PE location: N/A, PHB location: N/A
>>>>> [    2.150143] [    T118] EEH: Frozen PHB#14-PE#10000 detected
>>>>> [    2.150149] [    T118] EEH: Call Trace:
>>>>> [    2.150154] [    T362] xhci_hcd 0014:01:00.0: HC died; cleaning up
>>>>> [    2.150154] [    T118] EEH: [0000000066e7b6f8] 
>>>>> __eeh_send_failure_event+0xa8/0x190
>>>>> [    2.150167] [    T362] xhci_hcd 0014:01:00.0: USB bus 2 
>>>>> deregistered
>>>>> [    2.150171] [    T362] xhci_hcd 0014:01:00.0: remove, state 1
>>>>> [    2.150174] [    T118] EEH: [000000004754a593] 
>>>>> eeh_dev_check_failure+0x408/0x7a0
>>>>> [    2.150177] [    T362] usb usb1: USB disconnect, device number 1
>>>>> [    2.150185] [    T118] EEH: [00000000063df7cc] 
>>>>> xhci_portsc_readl+0x64/0x90 [xhci_hcd]
>>>>> [    2.150216] [    T118] EEH: [00000000593ad484] 
>>>>> xhci_hub_control+0xe28/0x27f0 [xhci_hcd]
>>>>> [    2.150244] [    T118] EEH: [00000000190f1012] 
>>>>> usb_hcd_submit_urb+0x508/0xd30 [usbcore]
>>>>> [    2.150276] [    T118] EEH: [0000000072d7c35d] 
>>>>> usb_submit_urb+0x254/0x840 [usbcore]
>>>>> [    2.150303] [    T118] EEH: [0000000009787909] 
>>>>> usb_start_wait_urb+0x88/0x270 [usbcore]
>>>>> [    2.150331] [    T118] EEH: [00000000e6ec433e] 
>>>>> usb_control_msg+0x134/0x1f0 [usbcore]
>>>>> [    2.150357] [    T118] EEH: [00000000d77b1b30] 
>>>>> hub_probe+0x570/0x12b8 [usbcore]
>>>>> [    2.150385] [    T118] EEH: [0000000091c7d281] 
>>>>> usb_probe_interface+0x124/0x490 [usbcore]
>>>>> [    2.150412] [    T118] EEH: [00000000dc656a09] 
>>>>> really_probe+0x118/0x580
>>>>> [    2.150425] [    T118] EEH: [00000000131d8dfb] 
>>>>> __driver_probe_device+0xc4/0x270
>>>>> [    2.150434] [    T118] EEH: [00000000e26dfd1d] 
>>>>> driver_probe_device+0x5c/0x110
>>>>> [    2.150442] [    T118] EEH: [000000006312c397] 
>>>>> __device_attach_driver+0x10c/0x210
>>>>> [    2.150451] [    T118] EEH: [000000004edd640b] 
>>>>> bus_for_each_drv+0xb0/0x130
>>>>> [    2.150460] [    T118] EEH: [000000009b173e09] 
>>>>> __device_attach+0xdc/0x2a0
>>>>> [    2.150467] [    T118] EEH: [000000004588b69c] 
>>>>> device_initial_probe+0x70/0x80
>>>>> [    2.150473] [    T118] EEH: [000000003dba8fbb] 
>>>>> bus_probe_device+0x50/0xf0
>>>>> [    2.150479] [    T118] EEH: [00000000f1fd4a53] 
>>>>> device_add+0x8f0/0xc00
>>>>> [    2.150486] [    T118] EEH: [00000000a74fc843] 
>>>>> usb_set_configuration+0x78c/0xb60 [usbcore]
>>>>> [    2.150526] [    T118] EEH: [000000001df4c94f] 
>>>>> usb_generic_driver_probe+0x78/0xd0 [usbcore]
>>>>> [    2.150556] [    T118] EEH: [00000000a7086db7] 
>>>>> usb_probe_device+0x60/0x200 [usbcore]
>>>>> [    2.150584] [    T118] EEH: [00000000dc656a09] 
>>>>> really_probe+0x118/0x580
>>>>> [    2.150591] [    T118] EEH: [00000000131d8dfb] 
>>>>> __driver_probe_device+0xc4/0x270
>>>>> [    2.150603] [    T118] EEH: [00000000e26dfd1d] 
>>>>> driver_probe_device+0x5c/0x110
>>>>> [    2.150611] [    T118] EEH: [000000006312c397] 
>>>>> __device_attach_driver+0x10c/0x210
>>>>> [    2.150620] [    T118] EEH: [000000004edd640b] 
>>>>> bus_for_each_drv+0xb0/0x130
>>>>> [    2.150629] [    T118] EEH: [000000009b173e09] 
>>>>> __device_attach+0xdc/0x2a0
>>>>> [    2.150636] [    T118] EEH: [000000004588b69c] 
>>>>> device_initial_probe+0x70/0x80
>>>>> [    2.150648] [    T118] EEH: [000000003dba8fbb] 
>>>>> bus_probe_device+0x50/0xf0
>>>>> [    2.150655] [    T118] EEH: [00000000f1fd4a53] 
>>>>> device_add+0x8f0/0xc00
>>>>> [    2.150664] [    T118] EEH: [000000005bca6639] 
>>>>> usb_new_device+0x2f4/0x890 [usbcore]
>>>>> [    2.150693] [    T118] EEH: [0000000023d4a3a1] 
>>>>> register_root_hub+0x1e4/0x2a0 [usbcore]
>>>>> [    2.150721] [    T118] EEH: [00000000941149db] 
>>>>> usb_add_hcd+0x82c/0x8f0 [usbcore]
>>>>> [    2.150749] [    T118] EEH: [00000000f13842f6] 
>>>>> xhci_pci_common_probe+0x1e4/0x3d0 [xhci_pci]
>>>>> [    2.150760] [    T118] EEH: [00000000862a8445] 
>>>>> local_pci_probe+0x64/0x100
>>>>> [    2.150770] [    T118] EEH: [00000000c124ce3b] 
>>>>> pci_device_probe+0x330/0x370
>>>>> [    2.150778] [    T118] EEH: [00000000dc656a09] 
>>>>> really_probe+0x118/0x580
>>>>> [    2.150792] [    T118] EEH: [00000000131d8dfb] 
>>>>> __driver_probe_device+0xc4/0x270
>>>>> [    2.150800] [    T118] EEH: [00000000e26dfd1d] 
>>>>> driver_probe_device+0x5c/0x110
>>>>> [    2.150808] [    T118] EEH: [00000000f3819f2a] 
>>>>> __driver_attach+0x12c/0x2d0
>>>>> [    2.150816] [    T118] EEH: [00000000b7c6a37c] 
>>>>> bus_for_each_dev+0xa4/0x130
>>>>> [    2.150824] [    T118] EEH: [000000009bdf640c] 
>>>>> driver_attach+0x30/0x50
>>>>> [    2.150836] [    T118] EEH: [0000000039921381] 
>>>>> bus_add_driver+0x1c0/0x380
>>>>> [    2.150844] [    T118] EEH: [0000000034a0727d] 
>>>>> driver_register+0x9c/0x1b0
>>>>> [    2.150852] [    T362] xhci_hcd 0014:01:00.0: USB bus 1 
>>>>> deregistered
>>>>> [    2.150851] [    T118] EEH: [000000002faf9b88] 
>>>>> __pci_register_driver+0x64/0x80
>>>>> [    2.150861] [    T118] EEH: [000000005142b255] 
>>>>> xhci_pci_init+0x90/0xb0 [xhci_pci]
>>>>> [    2.150869] [    T118] EEH: [00000000a9fe4af6] 
>>>>> do_one_initcall+0x5c/0x40c
>>>>> [    2.150883] [    T118] EEH: [00000000e2b1b716] 
>>>>> do_init_module+0xac/0x3c0
>>>>> [    2.150893] [    T118] EEH: [00000000fc06f562] 
>>>>> init_module_from_file+0x120/0x1b0
>>>>> [    2.150902] [    T118] EEH: [000000004ca14a9d] 
>>>>> sys_finit_module+0x1b4/0x4d0
>>>>> [    2.150910] [    T118] EEH: [000000005e56c4e5] 
>>>>> system_call_exception+0x184/0x430
>>>>> [    2.150919] [    T362] xhci_hcd 0014:01:00.0: probe with driver 
>>>>> xhci_hcd failed with error -108
>>>>> [    2.150930] [    T118] EEH: [0000000024ebcbb3] 
>>>>> system_call_vectored_common+0x15c/0x2ec
>>>>> [    2.150941] [    T118] EEH: This PCI device has failed 1 times 
>>>>> in the last hour and will be permanently disabled after 5 failures.
>>>>> [    2.150943] [    T118] EEH: Notify device drivers to shutdown
>>>>> [    2.150947] [    T118] EEH: Beginning: 'error_detected(IO frozen)'
>>>>>
>>>>> Snip.....
>>>>> And after sometime the device is disabled.
>>>>>
>>>>> [   40.450010] [    T118] EEH: PHB#14-PE#10000 has failed 6 times 
>>>>> in the last hour and has been permanently disabled.
>>>>> [   40.450027] [    T118] EEH: Unable to recover from failure from 
>>>>> PHB#14-PE#10000.
>>>>>                           Please try reseating or replacing it
>>>>>
>>>>> Attached the kernel config and dmesg.
>>>>>
>>>>> - Sourabh Jain
>>>>
>>> Is the device EEH capable? it seems
>>> error_detected is not invoked any driver
>>> callbacks. 
>>
>> How to verify that? Is the below data enough to conclude the above 
>> statement?
>>
>> root> lspci 0014:01:00.0 USB controller: Texas Instruments TUSB73x0 
>> SuperSpeed USB 3.0 xHCI Host Controller (rev 02)
>>
>> root> cat /sys/bus/pci/devices/0014\:01\:00.0/eeh_mode
>> 0x200
>>
>> root> cat /sys/bus/pci/devices/0014\:01\:00.0/eeh_pe_config_addr
>> 0x10000
>>
>> root> cat /sys/bus/pci/devices/0014\:01\:00.0/eeh_pe_state
>> 0x00000000 0x00000003
>
> Could you please verify whether the bound driver provides the minimum 
> EEH recovery callbacks by running:
>
> |BDF=0014:01:00.0 lspci -Dk -s "$BDF" echo "$BDF" > 
> /sys/kernel/debug/powerpc/eeh_dev_can_recover echo $? |
>
> A return status of |0| confirms that the driver provides the required 
> |error_detected()| and |slot_reset()| callbacks.
>
> If the write fails with |Operation not supported|, the driver does not 
> support driver-assisted EEH recovery.
>
> Please also check the EEH log for either:
>
> |EEH: Invoking <driver>->error_detected(...) |
>
> or:
>
> |EEH: driver not EEH aware | 


root> export BDF=0014:01:00.0

root> lspci -Dk -s "$BDF"
0014:01:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 
3.0 xHCI Host Controller (rev 02)
     Subsystem: IBM Device 0690
     Kernel modules: xhci_pci

root> echo "$BDF" > /sys/kernel/debug/powerpc/eeh_dev_can_recover
-bash: echo: write error: Operation not supported

root> echo $?
1

ltcden10-lp2:~ # dmesg | grep -i EEH
[    0.062839] [      T1] EEH: pSeries platform initialized
[    0.120733] [      T1] EEH: Capable adapter found: recovery enabled.
[  988.128432] [    T119] INFO: task eehd:118 blocked for more than 491 
seconds.
[  988.128466] [    T119] task:eehd            state:D stack:0  pid:118  
  tgid:118   ppid:2      task_flags:0x208040 flags:0x00000000
[  988.128501] [    T119] [c00000000921be20] [c00000000004ae68] 
eeh_pe_bus_get+0x48/0xc0
[  988.128506] [    T119] [c00000000921be50] [c00000000004c734] 
eeh_handle_normal_event+0x64/0xa50
[  988.128510] [    T119] [c00000000921bf30] [c00000000004e118] 
eeh_event_handler+0xf8/0x190
[  988.128526] [    T119] INFO: task eehd:118 is blocked on a mutex 
likely owned by task eehd:118.
[ 1479.648166] [    T119] INFO: task eehd:118 blocked for more than 983 
seconds.
[ 1479.648199] [    T119] task:eehd            state:D stack:0  pid:118  
  tgid:118   ppid:2      task_flags:0x208040 flags:0x00000000
[ 1479.648235] [    T119] [c00000000921be20] [c00000000004ae68] 
eeh_pe_bus_get+0x48/0xc0
[ 1479.648239] [    T119] [c00000000921be50] [c00000000004c734] 
eeh_handle_normal_event+0x64/0xa50
[ 1479.648243] [    T119] [c00000000921bf30] [c00000000004e118] 
eeh_event_handler+0xf8/0x190
[ 1479.648257] [    T119] INFO: task eehd:118 is blocked on a mutex 
likely owned by task eehd:118.
[ 1971.167877] [    T119] INFO: task eehd:118 blocked for more than 1474 
seconds.
[ 1971.167905] [    T119] task:eehd            state:D stack:0  pid:118  
  tgid:118   ppid:2      task_flags:0x208040 flags:0x00000000
[ 1971.167940] [    T119] [c00000000921be20] [c00000000004ae68] 
eeh_pe_bus_get+0x48/0xc0
[ 1971.167944] [    T119] [c00000000921be50] [c00000000004c734] 
eeh_handle_normal_event+0x64/0xa50
[ 1971.167948] [    T119] [c00000000921bf30] [c00000000004e118] 
eeh_event_handler+0xf8/0x190
[ 1971.167961] [    T119] INFO: task eehd:118 is blocked on a mutex 
likely owned by task eehd:118.
[ 2462.687577] [    T119] INFO: task eehd:118 blocked for more than 1966 
seconds.
[ 2462.687607] [    T119] task:eehd            state:D stack:0  pid:118  
  tgid:118   ppid:2      task_flags:0x208040 flags:0x00000000
[ 2462.687641] [    T119] [c00000000921be20] [c00000000004ae68] 
eeh_pe_bus_get+0x48/0xc0
[ 2462.687646] [    T119] [c00000000921be50] [c00000000004c734] 
eeh_handle_normal_event+0x64/0xa50
[ 2462.687650] [    T119] [c00000000921bf30] [c00000000004e118] 
eeh_event_handler+0xf8/0x190
[ 2462.687663] [    T119] INFO: task eehd:118 is blocked on a mutex 
likely owned by task eehd:118.
[ 2954.207293] [    T119] INFO: task eehd:118 blocked for more than 2457 
seconds.
[ 2954.207323] [    T119] task:eehd            state:D stack:0  pid:118  
  tgid:118   ppid:2      task_flags:0x208040 flags:0x00000000
[ 2954.207358] [    T119] [c00000000921be20] [c00000000004ae68] 
eeh_pe_bus_get+0x48/0xc0
[ 2954.207362] [    T119] [c00000000921be50] [c00000000004c734] 
eeh_handle_normal_event+0x64/0xa50
[ 2954.207367] [    T119] [c00000000921bf30] [c00000000004e118] 
eeh_event_handler+0xf8/0x190
[ 2954.207379] [    T119] INFO: task eehd:118 is blocked on a mutex 
likely owned by task eehd:118.
[ 3445.726999] [    T119] INFO: task eehd:118 blocked for more than 2949 
seconds.
[ 3445.727029] [    T119] task:eehd            state:D stack:0  pid:118  
  tgid:118   ppid:2      task_flags:0x208040 flags:0x00000000
[ 3445.727062] [    T119] [c00000000921be20] [c00000000004ae68] 
eeh_pe_bus_get+0x48/0xc0
[ 3445.727066] [    T119] [c00000000921be50] [c00000000004c734] 
eeh_handle_normal_event+0x64/0xa50
[ 3445.727070] [    T119] [c00000000921bf30] [c00000000004e118] 
eeh_event_handler+0xf8/0x190
[ 3445.727083] [    T119] INFO: task eehd:118 is blocked on a mutex 
likely owned by task eehd:118.
[ 3937.246734] [    T119] INFO: task eehd:118 blocked for more than 3440 
seconds.
[ 3937.246761] [    T119] task:eehd            state:D stack:0  pid:118  
  tgid:118   ppid:2      task_flags:0x208040 flags:0x00000000
[ 3937.246795] [    T119] [c00000000921be20] [c00000000004ae68] 
eeh_pe_bus_get+0x48/0xc0
[ 3937.246799] [    T119] [c00000000921be50] [c00000000004c734] 
eeh_handle_normal_event+0x64/0xa50
[ 3937.246803] [    T119] [c00000000921bf30] [c00000000004e118] 
eeh_event_handler+0xf8/0x190
[ 3937.246816] [    T119] INFO: task eehd:118 is blocked on a mutex 
likely owned by task eehd:118.
[ 4428.766432] [    T119] INFO: task eehd:118 blocked for more than 3932 
seconds.
[ 4428.766468] [    T119] task:eehd            state:D stack:0  pid:118  
  tgid:118   ppid:2      task_flags:0x208040 flags:0x00000000
[ 4428.766505] [    T119] [c00000000921be20] [c00000000004ae68] 
eeh_pe_bus_get+0x48/0xc0
[ 4428.766509] [    T119] [c00000000921be50] [c00000000004c734] 
eeh_handle_normal_event+0x64/0xa50
[ 4428.766514] [    T119] [c00000000921bf30] [c00000000004e118] 
eeh_event_handler+0xf8/0x190
[ 4428.766526] [    T119] INFO: task eehd:118 is blocked on a mutex 
likely owned by task eehd:118.
[ 4920.286148] [    T119] INFO: task eehd:118 blocked for more than 4423 
seconds.
[ 4920.286178] [    T119] task:eehd            state:D stack:0  pid:118  
  tgid:118   ppid:2      task_flags:0x208040 flags:0x00000000
[ 4920.286213] [    T119] [c00000000921be20] [c00000000004ae68] 
eeh_pe_bus_get+0x48/0xc0
[ 4920.286218] [    T119] [c00000000921be50] [c00000000004c734] 
eeh_handle_normal_event+0x64/0xa50
[ 4920.286222] [    T119] [c00000000921bf30] [c00000000004e118] 
eeh_event_handler+0xf8/0x190
[ 4920.286235] [    T119] INFO: task eehd:118 is blocked on a mutex 
likely owned by task eehd:118.
[ 5411.805864] [    T119] INFO: task eehd:118 blocked for more than 4915 
seconds.
[ 5411.805895] [    T119] task:eehd            state:D stack:0  pid:118  
  tgid:118   ppid:2      task_flags:0x208040 flags:0x00000000
[ 5411.805931] [    T119] [c00000000921be20] [c00000000004ae68] 
eeh_pe_bus_get+0x48/0xc0
[ 5411.805935] [    T119] [c00000000921be50] [c00000000004c734] 
eeh_handle_normal_event+0x64/0xa50
[ 5411.805939] [    T119] [c00000000921bf30] [c00000000004e118] 
eeh_event_handler+0xf8/0x190
[ 5411.805952] [    T119] INFO: task eehd:118 is blocked on a mutex 
likely owned by task eehd:118.

- Sourabh Jain

