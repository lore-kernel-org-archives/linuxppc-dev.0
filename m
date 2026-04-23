Return-Path: <linuxppc-dev+bounces-20005-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF57FF9937D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 11:59:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1ZQ24ZpYz2yGX;
	Thu, 23 Apr 2026 21:59:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776945562;
	cv=none; b=mnPmZQO0OT6B9Ov+bN6ABcnvI3vgEVnFCNnJVonA79M2F1M49WJl/qIe3jEg4L/nvX1vf4DjcMf1oEHvgC2TH5y/KJrWQQlqvZAZ/efwNuyuxMa4WQkmsGbXRaSjbQ46cFesqjwNXNLmRbm8dJbqbs0zCx89Oh7zo7rktGswFmHA+Yk5OPlsgkfSDNktAMUFJqiHjUYPbtevbxexK6qWIVqsk9qpNhGsEYavgDuZxHto9ndicF4sbgBh8AmddBBT0IQA4QKNaodJOfG0pH3VfkWZDiIn7WKKg/VzOl6gi6ka1JxmH1T4fVtX2/DyAbLPFYLsfF2jGQEKIUnRuGNouw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776945562; c=relaxed/relaxed;
	bh=4QofVbd2fY2c9QjBLheiEWRmVjdc+GvpUFAXHpWahJA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Uc6h/03VDYChv1IEos/CZbWhHd011NYnLZF76C07edStc/pzI9m2/gXHJNz4FrlTsmKo9VyOcSbRoBujG+M8dwINZUfX0WRnmo+O1/qFY8kb/POGTeec05EACjTEMjtXvnANIRXu6zwxqACi6HmJPDO/uorZDSQmuyBhs8+L8eemHPDC+XJLS6+DkwOHYLDqF8p/gtJasMQUqLVYvrM0ODkIyDpvcv5XHsrxVpD7ZK9HwoDa2WfwiwR5U5KWUuqsNblsHHu5xrhAVI3M9ufEgHuVXKJhSHJrlEpB1UX2d40g926RLGVqAKqcEKFcP8FANDCjeLmXUN55FxIzghgugg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BhkhGORd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BhkhGORd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1ZQ13gGRz2yFc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 21:59:20 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N7Rm8g3658469;
	Thu, 23 Apr 2026 11:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=4QofVbd2fY2c9QjBLheiEWRmVjdc
	+GvpUFAXHpWahJA=; b=BhkhGORdh9UROQ7f5oPIeQtqLZhG0vgWiEQkAUTUbe9G
	cqlkHXAyVdIC71CV8QVR8RZepCRVhQSxp8BYj2aU9aoaatrtJ5/GM5q4ox0GQzUU
	eHxq9N4v3Redl6Lg4cgdmohQbXaG2xbPud9htcZh/up2KC8mtePJiK3tJzTXfN9I
	RUO11b+dASMASQN1vbh+xRmfuywQMFdgD6r/m5R/92ju5xuHQkRKDxgpUlOyPPsF
	5mI83s2GvwrNbGZVoqRs6RpKq7gqdr3lNXzDFjIgZGxWqAEfteR3ZVrahcEje+mn
	bnhdlkR4Iruzlqk3E7Fye9ib1EugYwvlpcUSHDkVwA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7qwra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 11:59:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NBoNoE004181;
	Thu, 23 Apr 2026 11:59:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkypf8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 11:59:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NBxDtd31916634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 11:59:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91E9358067;
	Thu, 23 Apr 2026 11:59:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C7D758052;
	Thu, 23 Apr 2026 11:59:11 +0000 (GMT)
Received: from [9.123.12.79] (unknown [9.123.12.79])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 11:59:11 +0000 (GMT)
Message-ID: <c6b26023-c629-4f09-a449-dffeaba06082@linux.ibm.com>
Date: Thu, 23 Apr 2026 17:29:10 +0530
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
Content-Language: en-GB
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [mainline]kdump fails to save vmcore when crash is manually triggered
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oDLcXlz5XLRDww826XBb50MmUlScc8kM
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69ea0993 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Bpsi7g8vAgtjgGakxm8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oDLcXlz5XLRDww826XBb50MmUlScc8kM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDExNyBTYWx0ZWRfX0khvnf9H62Nn
 rtQKqZj7xzUSkkGLSxXCZhBSb6kvlxZAqTU7Ov9nj9zGQycnDqZfnSzlIqTjp9s5zezmQ4d7ihg
 y/nNiHu0H4Zlc6JPlmLrq13B7zE06Ymcs1vzr5TWxJOc7vww67sIvGgIyezLWgmU56hzSexzB65
 2LVqnx1/k4D53lijpGayk2n48O+9PDjSSK/DKfaaUtvzRagxCCf5I0ap+v84KpMsOsJVgZF99Rm
 HsbJ+ye5Mx+OYu6gfAOuxYCofEkS19nDM50MEQNb078akXQUwUQltqYH83JXPQHMxfi6fUDUQVh
 Skr2pofJCmJARubFQFvUro4SROuLRRX46qZ1eBalJzElXAVe/zBdbaA8RP9Wbs364fpGSwYjxHM
 Mm1cMVzjpKYvgtNSD/4uHz6UZ29qpNL20NpJsq3hiV/0fekIRHoWLiobo1PRvdv4IJo0b+MX/fM
 J5zcleMzJGFQSY6gdNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230117

Hello!!

IBM CI has reported vmcore save failures when kdump is tested by 
triggering a kernel crash via sysrq.


Below are the kernel and tool details:

Upstream kernel version: 7.0.0+
Upstream kernel commit-id: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6

kexec-tools 2.0.32.git
makedumpfile: version 1.7.9 (released on 20 Apr 2026)


Error:

While booting to crash kernel, I see below continous prints in console logs:


[    0.037177] vmcore: Warning: Zero PT_NOTE entries found
[    0.037181] vmcore: Warning: Zero PT_NOTE entries found
[    0.037184] vmcore: Warning: Zero PT_NOTE entries found
[    0.037186] vmcore: Warning: Zero PT_NOTE entries found


And During vmcore collection, I see below error.


[    9.948432] systemd[1]: Starting kdump-capture.service - Kdump Vmcore 
Save Service...
          Starting [0;1;39mkdump-capture.service[0m - Kdump Vmcore 
Save Service...

[    9.992306] kdump[408]: [0;1;38:5:185mKdump is using the default log 
level(3).[0m
[   10.158555] kdump[526]: saving to 
/sysroot/var/crash/127.0.0.1-2026-04-23-06:06:27/
[   10.164060] kdump[531]: saving vmcore-dmesg.txt to 
/sysroot/var/crash/127.0.0.1-2026-04-23-06:06:27/
[   10.198598] kdump[537]: saving vmcore-dmesg.txt complete
[   10.200376] kdump[539]: saving vmcore

Checking for memory holes                         : [  0.0 %] /
Checking for memory holes                         : [100.0 %] |
Excluding unnecessary pages                       : [  6.3 %] \         
       WARNING: Invalid free page order: pfn=5a45fc, order=64424509439, 
max order=12
WARNING: Invalid free page order: pfn=621a02, order=2166518513861132288, 
max order=12
WARNING: Invalid free page order: pfn=6697b3, order=6706141453275365419, 
max order=12
WARNING: Invalid free page order: pfn=669b5d, order=69335804542976, max 
order=12
WARNING: Invalid free page order: pfn=66c5a8, 
order=14125543804861677568, max order=12
WARNING: Invalid free page order: pfn=66c661, order=845524441759747, max 
order=12
WARNING: Invalid free page order: pfn=67dadc, 
order=17224182427472101376, max order=12
WARNING: Invalid free page order: pfn=682b38, order=3103260797896228864, 
max order=12
WARNING: Invalid free page order: pfn=682efa, 
order=14269216714183933953, max order=12
WARNING: Invalid free page order: pfn=682efe, order=134217728, max order=12
WARNING: Invalid free page order: pfn=68c0a0, order=3031209642551148544, 
max order=12
WARNING: Invalid free page order: pfn=69709d, 
order=17296239995740225536, max order=12
WARNING: Invalid free page order: pfn=6aa909, order=2166511968028983296, 
max order=12
WARNING: Invalid free page order: pfn=6ae921, order=6273236509957029888, 
max order=12
WARNING: Invalid free page order: pfn=6c1456, 
order=17296239987150290944, max order=12
WARNING: Invalid free page order: pfn=6c35a4, 
order=14197601399000268800, max order=12
WARNING: Invalid free page order: pfn=6c5de2, order=2166511933669244928, 
max order=12
WARNING: Invalid free page order: pfn=6d58da, 
order=17296239987150290944, max order=12
WARNING: Invalid free page order: pfn=6d7987, 
order=14557325072076374016, max order=12
WARNING: Invalid free page order: pfn=6dbb95, 
order=17944838645085110272, max order=12
WARNING: Invalid free page order: pfn=709d7d, order=6273234623090655232, 
max order=12
WARNING: Invalid free page order: pfn=709e11, order=3031203148023726080, 
max order=12
WARNING: Invalid free page order: pfn=70c02f, order=6705580187335000064, 
max order=12
WARNING: Invalid free page order: pfn=715384, 
order=14990794317172375552, max order=12
WARNING: Invalid free page order: pfn=715aef, order=5048255524311662592, 
max order=12
WARNING: Invalid free page order: pfn=71a51e, order=6199767839173706752, 
max order=12
WARNING: Invalid free page order: pfn=71aab5, order=5048255524311662592, 
max order=12
WARNING: Invalid free page order: pfn=732e19, order=28147502510048512, 
max order=12
WARNING: Invalid free page order: pfn=739896, 
order=17296239987150290944, max order=12
WARNING: Invalid free page order: pfn=73b956, 
order=17296239991445258240, max order=12
WARNING: Invalid free page order: pfn=73e043, order=2166511933669244928, 
max order=12
WARNING: Invalid free page order: pfn=740049, order=6705582074453032960, 
max order=12
WARNING: Invalid free page order: pfn=760109, order=6345294104196284416, 
max order=12
WARNING: Invalid free page order: pfn=760260, order=2166511968028983296, 
max order=12
WARNING: Invalid free page order: pfn=774eb8, order=3103267236521967616, 
max order=12
WARNING: Invalid free page order: pfn=77949f, order=3103260802191196160, 
max order=12
WARNING: Invalid free page order: pfn=784ac6, order=1971974104455872, 
max order=12
WARNING: Invalid free page order: pfn=785196, order=2166518513861132288, 
max order=12
WARNING: Invalid free page order: pfn=790654, 
order=14557325072177037312, max order=12
WARNING: Invalid free page order: pfn=792cbe, 
order=13837309858646983424, max order=12
WARNING: Invalid free page order: pfn=792dbe, 
order=13837309859722035968, max order=12
WARNING: Invalid free page order: pfn=793779, 
order=15351363758810792960, max order=12
WARNING: Invalid free page order: pfn=7963af, order=2166511933669244928, 
max order=12
WARNING: Invalid free page order: pfn=7bda8a, 
order=13837313428760297472, max order=12
WARNING: Invalid free page order: pfn=7bfbfa, 
order=14269094696377647104, max order=12
WARNING: Invalid free page order: pfn=7c8498, 
order=18088873534452400128, max order=12
WARNING: Invalid free page order: pfn=7d4bf7, order=1441792, max order=12
WARNING: Invalid free page order: pfn=7db498, 
order=18088873534452400128, max order=12
WARNING: Invalid free page order: pfn=7dba0d, order=6345292217329909760, 
max order=12
WARNING: Invalid free page order: pfn=7dc618, order=3319440018652528640, 
max order=12
WARNING: Invalid free page order: pfn=7e8788, order=1113619897082537567, 
max order=12
readpage_elf: Attempt to read non-existent page at 0x20000000.
readmem: type_addr: 0, addr:c00c000020000000, size:32768
__exclude_unnecessary_pages: Can't read the buffer of struct page.
create_2nd_bitmap: Can't exclude unnecessary pages.

makedumpfile Failed.
[   10.687238] kdump[542]: [0;1;31msaving vmcore failed, exitcode:1[0m
[   10.689073] kdump[544]: [0;1;31msaving vmcore failed[0m
[   10.699975] kdump[549]: saving the /run/initramfs/kexec-dmesg.log to 
/sysroot/var/crash/127.0.0.1-2026-04-23-06:06:27///
[   10.701749] systemd[1]: [0;1;39mkdump-capture.service: Main process 
exited, code=exited, status=1/FAILURE[0m
[   10.701933] systemd[1]: [0;1;38:5:185mkdump-capture.service: Failed 
with result 'exit-code'.[0m
[[0;1;31mFAILED[0m] Failed to start [0;1;39mkdump-capture.service[0m 
- Kdump Vmcore Save Service.

[   10.702090] systemd[1]: [0;1;31mFailed to start 
kdump-capture.service - Kdump Vmcore Save Service.[0m
See 'systemctl status kdump-capture.service' for details.

[   10.702249] systemd[1]: Startup finished in 3.351s (kernel) + 0 
(initrd) + 7.350s (userspace) = 10.702s.
[   10.702388] systemd[1]: kdump-capture.service: Triggering OnFailure= 
dependencies.
[   10.703543] systemd[1]: Stopped target timers.target - Timer Units.



If you happen to fix, this please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



