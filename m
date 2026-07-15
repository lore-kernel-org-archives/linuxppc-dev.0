Return-Path: <linuxppc-dev+bounces-24300-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF88C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 14:04:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0dFr2Xclz2yb9;
	Thu, 16 Jul 2026 00:04:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784124256;
	cv=none; b=X2vaabKRZShxSj5MpguOZzOGwDNSqPv4jYrtAE2EBwlMqfU61yN5DBLxgTwMBv7UTfmkJJ2la4N6txwUZWS+jZGBdYHD0DO9lq8b8nmo6RgsXQxpIVWf6Ekz36osX/0jLpPQt1BilGO8AY/Use2yZ/1zmZUooVChY1ZRTkgGs2JXwWAh5U4OkKNXHQ34pM1/a7NNRiJNOvcdOJ9HcFc1Iz06L2QyV6YJYGhCHqQ+FHQX3tWqvXaIFw5nkH923Mp3KDxRRuH3LxEjJYjjpTrLvljCckIBVO5JAOMNdwMMXMdb1NEA4La5lsjve7DfJJSlCpm2re3Q+LNVTEKLOF8OrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784124256; c=relaxed/relaxed;
	bh=YyfTyIEAL5kua/z+DL6V22i/iEjQJXHO/+uxbXWs9lw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=DzbhMejS7vfz4BXc1cyeO14k3p6+SfssW6Dkn21jmZR3zghXHy7Jn8OVjHY1ZiFP5S6nr0xoGpHXU2GsUhUnnF20Q0kavg6WyeCvxBnxd0CAjGgY3jaslzSpDyPiaoQhVL7qs9fCA5hoKU3Kbs4NomWJuOq8/1fMvtMmakIGAxZePBtPMjH7zj40HPezZifP7M5Cz2FFPUjoyg3vxD95Z0UqQ5YNMv9+Kl+86PC7P2sDEl6Fg6E07IvfMPvGmKLws2EbDa2ztN0ogDEK29HvgbTeSUhiX+2JBTPUuPsYGmVGyS2umBbhVF4QdOPkvuiBzQbfiJqrBqT0jFqRL8alNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JWA2Q5Re; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JWA2Q5Re;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0dFq2pv7z2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 00:04:14 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBfxkp051782;
	Wed, 15 Jul 2026 14:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YyfTyI
	EAL5kua/z+DL6V22i/iEjQJXHO/+uxbXWs9lw=; b=JWA2Q5ReNKs76zbjLnAgFc
	icyLyZY3eA382HUTk+bN+9KlqT8MP7+qO4TZW77PoVLJ31xj+n4tCqJgz2E/yM09
	e/nW6I8oih02xi8KFVwzcM5c+KzaDstXE1KJmZviTMDc6cQW9Fe8Yv6etR62tKzg
	yfGhoQbcPZvKqbKjUP+S3OzTbEkr4GqdTSb0Afct+30BXt5qbLZegd4hG4lHesGC
	qZJazTEeFkwhT3VobEvXGz598/plidVVB94AT0v5oWEdBLF3vZytiGpVsk/Brs/K
	HXLIstpUY+cLwUtD1RPO+l5O1apmXSeam+zaVet+XTR44qfuS7akq+BLF3YdHU8w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbub66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 14:04:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FDnc1q013528;
	Wed, 15 Jul 2026 14:04:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy81ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 14:04:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FE3xeP44433888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 14:03:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B347D20043;
	Wed, 15 Jul 2026 14:03:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04A0F20040;
	Wed, 15 Jul 2026 14:03:58 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jul 2026 14:03:57 +0000 (GMT)
Message-ID: <29f33de0-0861-459f-b6a0-440354fac785@linux.ibm.com>
Date: Wed, 15 Jul 2026 19:33:13 +0530
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
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Narayana Murty N <nnmlinux@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        shivang upadhyay <shivangu@linux.ibm.com>, sbhat@linux.ibm.com
References: <2ad00297-eca5-4f36-ad01-138837f6fa4f@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <2ad00297-eca5-4f36-ad01-138837f6fa4f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a579354 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=OH5TaQgA3MiBUNevjdYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzNiBTYWx0ZWRfX/pMIjrudh25x
 xKDQvhwweOwCvL9hlrahMrC6q+KDZ+OrS+XC2jyt31fPF+y8xOA2l9EH9AhGJ2I/H1ZwwS/TzLZ
 kSEdW1wIEdGzv/s113k6vwvyLLLCFjG07Ejpiw4KUYtLfVSIxcDJ6z2hhyMGS6Kk448BGH0o0Ku
 /dCbm0SEW3kDpTDZuVu1YsS1lFGPXPfWJbn/g03uJR1Sf7zCOifcgQJCy6mWaMd/12cFNJuhofF
 56HuRqFIDSuB1jES6ZEVbXy1pOqVAEdM8Nsvoi3Pyn3FQS88JGDr9EF8/OU5ehv6/WCopkmagvB
 LlKyexX0zZVFXw9UpWwEd6HbqFB3jcjZtDCeKOrRHLkXQJE5MbvqLieB2bOXGobmnnaK+ndrgwf
 m8Ww2NE84K28a1XHUlCTeZR1ncA8AQ279GaLiRJbBXS88kwutNpDv0AVMo9MI4TAEkZNWQgl+T8
 E2zRJiy9la4OjB9awIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzNiBTYWx0ZWRfX+UUXOv4Z4A1x
 jE79QMGRpFZ/bvjPeZgzQY7/Z2Tq/C5yn2GNQezY6xA3XrnhTODTqogwoT7TGkj+4CzTd0sb9I5
 Z7U2QOOz9DfZ4aqSmxwz60+x+2gUuxE=
X-Proofpoint-GUID: qPA0nru-Dy4FPE64HgbWt_1z-zYejFqF
X-Proofpoint-ORIG-GUID: WYsJLUuQgs0lIqWh8zqD2DiMW3YxVumA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150136


This issue only occurs with the Radix MMU.
Booting the same kernel with disable_radix=1 does not reproduce the issue.

The system also has pmem.

+CC Shivang and Shiva

- Sourabh Jain


On 15/07/26 15:01, Sourabh Jain wrote:
> Hello,
>
> Upstream kernel with head at commit 
> 3b029c035b34bbc693405ddf759f0e9b920c27f1
> hitting EEH with xhci_hcd during kernel boot.
>
> The issue was not observed on the distro kernel running on the the 
> same machine.
>
> Trace:
> [    2.130359] [      C8] ibmvscsi 30000066: SRP_LOGIN succeeded
> [    2.132280] [    T362] xhci_hcd 0014:01:00.0: xHCI Host Controller
> [    2.132289] [    T362] xhci_hcd 0014:01:00.0: new USB bus 
> registered, assigned bus number 1
> [    2.132449] [    T362] xhci_hcd 0014:01:00.0: 
> ibm,query-pe-dma-windows(53) 10000 8000000 20000014 returned 0, 
> lb=1000000 ps=103 wn=1
> [    2.132453] [    T362] xhci_hcd 0014:01:00.0: Skipping ibm,pmemory
> [    2.141861] [    T110] scsi 0:0:1:0: Direct-Access     AIX VDASD    
>         0001 PQ: 0 ANSI: 3
> [    2.143707] [    T362] xhci_hcd 0014:01:00.0: 
> ibm,create-pe-dma-window(54) 10000 8000000 20000014 15 28 returned 0 
> (liobn = 0x70000014 starting addr = 8000000 0)
> [    2.147236] [    T362] xhci_hcd 0014:01:00.0: lsa_required: 0, 
> lsa_enabled: 0, direct mapping: 1
> [    2.147239] [    T362] xhci_hcd 0014:01:00.0: iommu: 64-bit OK but 
> direct DMA is limited by 800010000000000
> [    2.147250] [    T362] xhci_hcd 0014:01:00.0: lsa_required: 0, 
> lsa_enabled: 0, direct mapping: 1
> [    2.147252] [    T362] xhci_hcd 0014:01:00.0: iommu: 64-bit OK but 
> direct DMA is limited by 800010000000000
> [    2.147476] [    T362] xhci_hcd 0014:01:00.0: hcc params 0x0270f06d 
> hci version 0x96 quirks 0x0000000004000000
> [    2.149530] [    T362] xhci_hcd 0014:01:00.0: xHCI Host Controller
> [    2.149536] [    T362] xhci_hcd 0014:01:00.0: new USB bus 
> registered, assigned bus number 2
> [    2.149542] [    T362] xhci_hcd 0014:01:00.0: Host supports USB 3.0 
> SuperSpeed
> [    2.149638] [    T362] usb usb1: New USB device found, 
> idVendor=1d6b, idProduct=0002, bcdDevice= 7.02
> [    2.149642] [    T362] usb usb1: New USB device strings: Mfr=3, 
> Product=2, SerialNumber=1
> [    2.149644] [    T362] usb usb1: Product: xHCI Host Controller
> [    2.149646] [    T362] usb usb1: Manufacturer: Linux 
> 7.2.0-rc3upstream+ xhci-hcd
> [    2.149647] [    T362] usb usb1: SerialNumber: 0014:01:00.0
> [    2.149817] [    T362] hub 1-0:1.0: USB hub found
> [    2.149937] [    T362] hub 1-0:1.0: 4 ports detected
> [    2.150020] [    T362] xhci_hcd 0014:01:00.0: xHCI host controller 
> not responding, assume dead
> [    2.150044] [    T362] xhci_hcd 0014:01:00.0: HC died; cleaning up
> [    2.150125] [    T118] EEH: Recovering PHB#14-PE#10000
> [    2.150135] [    T118] EEH: PE location: N/A, PHB location: N/A
> [    2.150143] [    T118] EEH: Frozen PHB#14-PE#10000 detected
> [    2.150149] [    T118] EEH: Call Trace:
> [    2.150154] [    T362] xhci_hcd 0014:01:00.0: HC died; cleaning up
> [    2.150154] [    T118] EEH: [0000000066e7b6f8] 
> __eeh_send_failure_event+0xa8/0x190
> [    2.150167] [    T362] xhci_hcd 0014:01:00.0: USB bus 2 deregistered
> [    2.150171] [    T362] xhci_hcd 0014:01:00.0: remove, state 1
> [    2.150174] [    T118] EEH: [000000004754a593] 
> eeh_dev_check_failure+0x408/0x7a0
> [    2.150177] [    T362] usb usb1: USB disconnect, device number 1
> [    2.150185] [    T118] EEH: [00000000063df7cc] 
> xhci_portsc_readl+0x64/0x90 [xhci_hcd]
> [    2.150216] [    T118] EEH: [00000000593ad484] 
> xhci_hub_control+0xe28/0x27f0 [xhci_hcd]
> [    2.150244] [    T118] EEH: [00000000190f1012] 
> usb_hcd_submit_urb+0x508/0xd30 [usbcore]
> [    2.150276] [    T118] EEH: [0000000072d7c35d] 
> usb_submit_urb+0x254/0x840 [usbcore]
> [    2.150303] [    T118] EEH: [0000000009787909] 
> usb_start_wait_urb+0x88/0x270 [usbcore]
> [    2.150331] [    T118] EEH: [00000000e6ec433e] 
> usb_control_msg+0x134/0x1f0 [usbcore]
> [    2.150357] [    T118] EEH: [00000000d77b1b30] 
> hub_probe+0x570/0x12b8 [usbcore]
> [    2.150385] [    T118] EEH: [0000000091c7d281] 
> usb_probe_interface+0x124/0x490 [usbcore]
> [    2.150412] [    T118] EEH: [00000000dc656a09] 
> really_probe+0x118/0x580
> [    2.150425] [    T118] EEH: [00000000131d8dfb] 
> __driver_probe_device+0xc4/0x270
> [    2.150434] [    T118] EEH: [00000000e26dfd1d] 
> driver_probe_device+0x5c/0x110
> [    2.150442] [    T118] EEH: [000000006312c397] 
> __device_attach_driver+0x10c/0x210
> [    2.150451] [    T118] EEH: [000000004edd640b] 
> bus_for_each_drv+0xb0/0x130
> [    2.150460] [    T118] EEH: [000000009b173e09] 
> __device_attach+0xdc/0x2a0
> [    2.150467] [    T118] EEH: [000000004588b69c] 
> device_initial_probe+0x70/0x80
> [    2.150473] [    T118] EEH: [000000003dba8fbb] 
> bus_probe_device+0x50/0xf0
> [    2.150479] [    T118] EEH: [00000000f1fd4a53] device_add+0x8f0/0xc00
> [    2.150486] [    T118] EEH: [00000000a74fc843] 
> usb_set_configuration+0x78c/0xb60 [usbcore]
> [    2.150526] [    T118] EEH: [000000001df4c94f] 
> usb_generic_driver_probe+0x78/0xd0 [usbcore]
> [    2.150556] [    T118] EEH: [00000000a7086db7] 
> usb_probe_device+0x60/0x200 [usbcore]
> [    2.150584] [    T118] EEH: [00000000dc656a09] 
> really_probe+0x118/0x580
> [    2.150591] [    T118] EEH: [00000000131d8dfb] 
> __driver_probe_device+0xc4/0x270
> [    2.150603] [    T118] EEH: [00000000e26dfd1d] 
> driver_probe_device+0x5c/0x110
> [    2.150611] [    T118] EEH: [000000006312c397] 
> __device_attach_driver+0x10c/0x210
> [    2.150620] [    T118] EEH: [000000004edd640b] 
> bus_for_each_drv+0xb0/0x130
> [    2.150629] [    T118] EEH: [000000009b173e09] 
> __device_attach+0xdc/0x2a0
> [    2.150636] [    T118] EEH: [000000004588b69c] 
> device_initial_probe+0x70/0x80
> [    2.150648] [    T118] EEH: [000000003dba8fbb] 
> bus_probe_device+0x50/0xf0
> [    2.150655] [    T118] EEH: [00000000f1fd4a53] device_add+0x8f0/0xc00
> [    2.150664] [    T118] EEH: [000000005bca6639] 
> usb_new_device+0x2f4/0x890 [usbcore]
> [    2.150693] [    T118] EEH: [0000000023d4a3a1] 
> register_root_hub+0x1e4/0x2a0 [usbcore]
> [    2.150721] [    T118] EEH: [00000000941149db] 
> usb_add_hcd+0x82c/0x8f0 [usbcore]
> [    2.150749] [    T118] EEH: [00000000f13842f6] 
> xhci_pci_common_probe+0x1e4/0x3d0 [xhci_pci]
> [    2.150760] [    T118] EEH: [00000000862a8445] 
> local_pci_probe+0x64/0x100
> [    2.150770] [    T118] EEH: [00000000c124ce3b] 
> pci_device_probe+0x330/0x370
> [    2.150778] [    T118] EEH: [00000000dc656a09] 
> really_probe+0x118/0x580
> [    2.150792] [    T118] EEH: [00000000131d8dfb] 
> __driver_probe_device+0xc4/0x270
> [    2.150800] [    T118] EEH: [00000000e26dfd1d] 
> driver_probe_device+0x5c/0x110
> [    2.150808] [    T118] EEH: [00000000f3819f2a] 
> __driver_attach+0x12c/0x2d0
> [    2.150816] [    T118] EEH: [00000000b7c6a37c] 
> bus_for_each_dev+0xa4/0x130
> [    2.150824] [    T118] EEH: [000000009bdf640c] driver_attach+0x30/0x50
> [    2.150836] [    T118] EEH: [0000000039921381] 
> bus_add_driver+0x1c0/0x380
> [    2.150844] [    T118] EEH: [0000000034a0727d] 
> driver_register+0x9c/0x1b0
> [    2.150852] [    T362] xhci_hcd 0014:01:00.0: USB bus 1 deregistered
> [    2.150851] [    T118] EEH: [000000002faf9b88] 
> __pci_register_driver+0x64/0x80
> [    2.150861] [    T118] EEH: [000000005142b255] 
> xhci_pci_init+0x90/0xb0 [xhci_pci]
> [    2.150869] [    T118] EEH: [00000000a9fe4af6] 
> do_one_initcall+0x5c/0x40c
> [    2.150883] [    T118] EEH: [00000000e2b1b716] 
> do_init_module+0xac/0x3c0
> [    2.150893] [    T118] EEH: [00000000fc06f562] 
> init_module_from_file+0x120/0x1b0
> [    2.150902] [    T118] EEH: [000000004ca14a9d] 
> sys_finit_module+0x1b4/0x4d0
> [    2.150910] [    T118] EEH: [000000005e56c4e5] 
> system_call_exception+0x184/0x430
> [    2.150919] [    T362] xhci_hcd 0014:01:00.0: probe with driver 
> xhci_hcd failed with error -108
> [    2.150930] [    T118] EEH: [0000000024ebcbb3] 
> system_call_vectored_common+0x15c/0x2ec
> [    2.150941] [    T118] EEH: This PCI device has failed 1 times in 
> the last hour and will be permanently disabled after 5 failures.
> [    2.150943] [    T118] EEH: Notify device drivers to shutdown
> [    2.150947] [    T118] EEH: Beginning: 'error_detected(IO frozen)'
>
> Snip.....
> And after sometime the device is disabled.
>
> [   40.450010] [    T118] EEH: PHB#14-PE#10000 has failed 6 times in 
> the last hour and has been permanently disabled.
> [   40.450027] [    T118] EEH: Unable to recover from failure from 
> PHB#14-PE#10000.
>                           Please try reseating or replacing it
>
> Attached the kernel config and dmesg.
>
> - Sourabh Jain


