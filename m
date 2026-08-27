Return-Path: <linuxppc-dev+bounces-26128-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F22C5DF9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 05:44:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVr6n3NGYz2xwN;
	Thu, 27 Aug 2026 15:44:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787809441;
	cv=none; b=XHoSFv3dfkX0e97iSfcSRV/Wy1PHdY08KOpfsI/IwOCDoMcU97rFJsX2Oj8ZImJTYDdeg8ztnglS15ISm0418U93ehEPB3IAqjWIf6FRYoMGX9I/0C4iPy4UBT00ZM/JlESCF7YN8FvXpunxuMgQpNl4y4CS0sJiRICECO9kWfEOg+vfuGgzV67ZO48MPqPNJ6xcS7x4PG0fWIN/DiRpt4HWt2uXAaiJ2tDMJFMSFuY2JKK6e2TzEaEsE8b9gyLgzw0Ckxjq2ui2z/rqGeqXF/sFt9rU3a1Wye/C87e4rR7rq/NZvNLmdoPj2faAhBCVQ4Lf7rquH8GMOT82V13XDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787809441; c=relaxed/relaxed;
	bh=DV9GVoeB/JQu1cXyB1OqFr/qKNhqgk/5nx75IvHLrxY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=AGcZxKat5TqjyLbu1IcHJ1gwqi0Q+ZZmvhoXzq/tSBbqkyYuV3ZY/fofC+a4GXq0QJi0BH34lgO623EKLM5OCS+Pj2ZCF2lcDsfRpQy20KHvAlK0Mbqm4f2A5VLiTPcURd0cpmyE8v6f2Mp2g9rD9Z5HbEN9tZj/eFB0P3ywuEwAPb6CYbGEa+TSusDeuYhK+V+PKDoBc/s09ysttNsWtUFew17UpLN6HJs0ZRsVfx/yeZI29RRJc/eSdqfezjcxBgsHEZeBs/erfmNSwxqaYH+FxzNvHQe41/j+YMiUgFJbygHcY73rGj3veFTQn1EJ3lW9t4WVaEDkwxuumgobaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CqAPgj9E; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CqAPgj9E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVr6m374Hz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 15:44:00 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3VX584139690;
	Thu, 27 Aug 2026 05:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=DV9GVoeB/JQu1cXyB1OqFr/qKNhq
	gk/5nx75IvHLrxY=; b=CqAPgj9E6FjwX/faSqxiY/yqewDW5aYsYN3CoO5lSn0H
	p1cItnhoVqW5pLpbfuSsY40pNLHW9+dpC7QmEuHRhcz9TwoehUgr9ylixjinadx2
	55zj8aI0dAG2MxuZcwGso//QQKzw36YiWqWyOp0k8NFVWrUCb0R2LJMruP5uNXq0
	++GXtAh1Nb88Ii1/MWLDfIKHPxdlUmwERuded2PqFGgLWqzSXorUUNlz8SmZe3Kc
	e7OuoiJj77pWwGg6GUyiBIfsZ7fqBUpqm9sUEsetpVr12cbp3NE/2OXwhvdDDUx3
	R4FclOR1OJzm2VCRHM1oPFnP2hg39XiST+olW/TxjA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er3by0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 05:43:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R5fHFg003376;
	Thu, 27 Aug 2026 05:43:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsye2dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 05:43:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R5hiI141550272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 05:43:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39B3C20043;
	Thu, 27 Aug 2026 05:43:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDE6120040;
	Thu, 27 Aug 2026 05:43:40 +0000 (GMT)
Received: from [9.67.79.223] (unknown [9.67.79.223])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 05:43:40 +0000 (GMT)
Message-ID: <e301014d-568f-4ed5-bc64-b8a85ca0b1e1@linux.ibm.com>
Date: Thu, 27 Aug 2026 11:13:39 +0530
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
Content-Language: en-US
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, tglx@kernel.org,
        maddy@linux.ibm.com, christophe.leroy@csgroup.eu,
        riteshh@linux.ibm.com
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: powerpc: userspace processes crash on abort() from libc.so.6
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rlnnksVDgoov12X-Qr3QaOX5eVkfsAvr
X-Proofpoint-ORIG-GUID: rlnnksVDgoov12X-Qr3QaOX5eVkfsAvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0MyBTYWx0ZWRfX/19EjURAiiBf
 ufEkrl3VCiUfazHt3bTt7zOCYxeATyqbb06sjy7wMi0LzRoV43rQD47ALDvCUka3HekodM2vJ83
 i604Y51yx+lnbhwU81STOny0mQGH1VpqJW1nT9kzRLoVaOhODMp3SslnnIG+apXN7/JSt3FnUkx
 6icNSWTgtZq2wtsRCzAyoLpRW2PN5kKza7rXpUMmOmXs9wJmMw5oBAuUxV61a1ypM24+MZsOdpc
 YQz4ar37xvcdkpyVmdPjlHXAs84N29YANw/4CuSZPQITNmetHbGhzPRTPY6ui5L5jr7OCTQLuBG
 Esb/KiTFcMr1hAG5917g9cJEeNLT3AUtAU5LpSNYvSGonM6k7J5xNt8vK41v167sXArzGGWyhyM
 k/i7SRBvtiNDWwrFH1cQyb0EcorUVBCl1/XpXY7j7EjtfV9oiBrWONuWgRHtmwAFy3lc3WjYXXY
 fBkNfYiEvlm7/H8EwxQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8fce94 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ihYbd9jE9oaAB4i0KMUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0MyBTYWx0ZWRfX3M467djiF2Oo
 vIjtuB26kCuaELUFieeDl+/FALnScvE56SRgsPcxzMoQKRFvAz47VUtPiiGDpsvZvSh+69xec0T
 LD6CJ0/8vWTymIQ94Pua2Lm23Cr0ncs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270043


Hi All, Thomas,

On my PPC64 machine, I see the below systemd crash orginating from 
abort() during boot on top of the tree. Complete dmesg can be seen here [1]
       abort (libc.so.6 + 0x29484) 

       __libc_message_impl (libc.so.6 + 0x9e00c) 

       __libc_fatal (libc.so.6 + 0x9e06c) 

       start_thread (libc.so.6 + 0xadffc) 

       __clone (libc.so.6 + 0x152d68) 

       __clone (libc.so.6 + 0x152d68) 

       create_thread.constprop.0 (libc.so.6 + 0xad9c8) 


The git bisect pointed me to commit 3424d8c18a7da "(Merge tag 
'core-entry-2026-08-17' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)"

Please find the kernel config used to build the kernel at [2].

I have tried applying the pending fixes from Mukesh [3] and Ritesh [4] 
for the currently outstanding issues and still see the problem.

The system is running Fedora 42, with glibc-2.41-7.fc42.ppc64le. The
complete list of toolchain and packages can be found here [5]

Thanks and Regards,
Shivaprasad

References:
1 - https://gist.github.com/shivaprasadbhat/6f166374bab12b4f4c1cd4ac829e562c
2 - https://gist.github.com/shivaprasadbhat/aa499468e124015eec5932fb13e88e05
3 - https://lore.kernel.org/linuxppc-dev/lda1jyut.ritesh.list@gmail.com/#t
4 - 
https://lore.kernel.org/linuxppc-dev/20260820134718.2176411-1-mkchauras@gmail.com/
5 - https://gist.github.com/shivaprasadbhat/ae56ca849c3009e8642a6313dc465ea7

=========
Backtrace from dmesg:
[   22.039343][ T1833] systemd-coredump[1833]: Module 
libsystemd-shared-257.6-1.fc42.so from rpm systemd-257.6-1.fc42.ppc64le
[   22.039378][ T1833] systemd-coredump[1833]: Stack trace of thread 1828:
[   22.039378][ T1833] systemd-coredump[1833]: Stack trace of thread 1828:
[   22.039401][ T1833] systemd-coredump[1833]: #0  0x00007fffa4c29484 
abort (libc.so.6 + 0x29484)
[   22.039401][ T1833] systemd-coredump[1833]: #0  0x00007fffa4c29484 
abort (libc.so.6 + 0x29484)
[   22.039429][ T1833] systemd-coredump[1833]: #1  0x00007fffa4c9e00c 
__libc_message_impl (libc.so.6 + 0x9e00c)
[   22.039429][ T1833] systemd-coredump[1833]: #1  0x00007fffa4c9e00c 
__libc_message_impl (libc.so.6 + 0x9e00c)
[   22.039461][ T1833] systemd-coredump[1833]: #2  0x00007fffa4c9e06c 
__libc_fatal (libc.so.6 + 0x9e06c)
[   22.039461][ T1833] systemd-coredump[1833]: #2  0x00007fffa4c9e06c 
__libc_fatal (libc.so.6 + 0x9e06c)
[   22.039491][ T1833] systemd-coredump[1833]: #3  0x00007fffa4cadffc 
start_thread (libc.so.6 + 0xadffc)
[   22.039491][ T1833] systemd-coredump[1833]: #3  0x00007fffa4cadffc 
start_thread (libc.so.6 + 0xadffc)
[   22.039521][ T1833] systemd-coredump[1833]: #4  0x00007fffa4d52d68 
__clone (libc.so.6 + 0x152d68)
[   22.039521][ T1833] systemd-coredump[1833]: #4  0x00007fffa4d52d68 
__clone (libc.so.6 + 0x152d68)
[   22.039551][ T1833] systemd-coredump[1833]: #5  0x00007fffa4d52d68 
__clone (libc.so.6 + 0x152d68)
[   22.039551][ T1833] systemd-coredump[1833]: #5  0x00007fffa4d52d68 
__clone (libc.so.6 + 0x152d68)
[   22.039580][ T1833] systemd-coredump[1833]: #6  0x00007fffa4cad9c8 
create_thread.constprop.0 (libc.so.6 + 0xad9c8)
[   22.039580][ T1833] systemd-coredump[1833]: #6  0x00007fffa4cad9c8 
create_thread.constprop.0 (libc.so.6 + 0xad9c8)
[   22.039614][ T1833] systemd-coredump[1833]: #7  0x00000000003af858 
n/a (n/a + 0x0)
[   22.039614][ T1833] systemd-coredump[1833]: #7  0x00000000003af858 
n/a (n/a + 0x0)
[   22.039639][ T1833] systemd-coredump[1833]: ELF object binary 
architecture: PowerPC64
[   22.039639][ T1833] systemd-coredump[1833]: ELF object binary 
architecture: PowerPC64
[   22.042109][    T1] systemd[1]: systemd-journald.service: Scheduled 
restart job, restart counter is at 1.

