Return-Path: <linuxppc-dev+bounces-16183-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E05D6CFBE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:16:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy4PB27Zcz2xHt;
	Fri, 23 Jan 2026 15:16:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769141774;
	cv=none; b=NRtdZZtFZsbIf76Du24PY4NyQIcvyjw6MpwNaoRYmGGvBn2p0/e3SQZ2kqqqUznNY7c7Whkw+zyOGnm+/klepV15maA1R/fQur8pC5+H+gxlcrSAVSYCelUtbnTv3efmyynjmXM8KdMQ2BVE0QhH7+Dxf69oZKA1sFlDFQ6ps18afA8NJa7jrM68BFjcL5efLRLJEgyNvhPIwoUltDlGzXXltBQ8ZMxNeXT46t1hJA2zziBzw6peBHDD37Jkjv2N6NmFIbvqjG1gH9xALt1wNV7i5VJqt54dtmhf6HCMyMkum7vnxCA6scaN9oONluS7zCQgmUwv/++hpf+6QXYDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769141774; c=relaxed/relaxed;
	bh=Riu69QaoFgIuf+kGEDCpMwZSfcgLwlQwRc2gOITtSsw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=V6iJ8aSrqP2geZPnJQ8YmqDwwnThtCASyzqiofyHL4ybqHdRfDW1PsYkQAyLOEBubGFjn89qvBVrXDUV4Pigu5u72dkWyfKSRGgKWM9Anh2vXckzz5NcEc62sYqQnqqAYZDqPIqIRxY4tEP6QE+VqnYhwqmkDCpkufN5hMZdCVSW3MghU6uQphvuXPzCzhfJQ6x2fW2ZfIWcElxxHEKCu2vWBjH+1mvyqW1IgJ5D8F0FEQemh3xvP+8RxEO9VrsEgBWl04oe5ZJUoeuGb4PGhCah9ubBR3xhPjTjN32APuyDAgqo+RBQMrheWtjhUwHJHKipvEJhdBoaJw5gyIgawg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LfzyqjtS; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LfzyqjtS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy4P904MRz2x9M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 15:16:12 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MNkBCs022334;
	Fri, 23 Jan 2026 04:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Riu69QaoFgIuf+kGEDCpMwZSfcgL
	wlQwRc2gOITtSsw=; b=LfzyqjtSRitH1/Bu60retmwbHE9VVZogGNMBMiblA6f5
	j6lf5H0JQtLqc7oD+EU5+/QBxc36LA7WxFq/KMwFbKl2jcc4u07LZL9Kqtwc0QQF
	nyiJcR/gA2RjZTXeIHEpoCDha18ZI7q5alDcnXox4VD1yNxTpRxA2RcmphgV7CuS
	nvFAiy9vTuSv5RJWVk6wS5nXmyLBFo6Oso6L5x9Dh1bCGI7wrbJmMnwLB8azWx4X
	EQFliJIZfSJrIOYYpaq0nD62yxUPVofFUtAxqIXKuvHzk/SMS7613vWmYcb9PoE3
	9+jss4mfPOYT3yUsCvTj7nn91JtDai2ROGyqYja0/w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612ggqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 04:15:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N3vNAe027285;
	Fri, 23 Jan 2026 04:15:56 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrneuhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 04:15:56 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60N4FuHW48431484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 04:15:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AD4D58067;
	Fri, 23 Jan 2026 04:15:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0940E5804B;
	Fri, 23 Jan 2026 04:15:54 +0000 (GMT)
Received: from [9.61.254.244] (unknown [9.61.254.244])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 04:15:53 +0000 (GMT)
Message-ID: <43ea0202-891d-4582-980b-5cb557b41114@linux.ibm.com>
Date: Fri, 23 Jan 2026 09:45:52 +0530
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
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [next-20260122] Build failure on IBM Power Server
To: Madhavan Srinivasan <maddy@linux.ibm.com>, broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 63PI_Ryf3-qDDnOIePgISAlILPLUbABf
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=6972f5fd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=-bjmUSXcj69GP4b_tKUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 63PI_Ryf3-qDDnOIePgISAlILPLUbABf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDAyNCBTYWx0ZWRfXztDPyYghc221
 Xw3En3k2P9I/mYm/Huczcr21ytswW3uINc0zFMhug8MOnArv8BzSV7tb59xzdEGri+6HVrl1fDv
 0dMyet0z1zON/OyMmVzG9bRxwV3OG8wnim6Oc9eJOPGHjHj/8UfjnKJWA+c4amX6jo7Y0YWzjl3
 0Hy0+S+p0CmpwpylTZHHQEZQKt1Fg4VQfI8ecPx4GnthKnQBa/YER4CJVXgEh6T4DGHZi71zmCy
 9kBcMLP8P9K1cP+QDl78msuCJv4DI7Z57qxQFC2W58QAu1KmzjOSejwWp5iN5AGLK4wfRbD/NzU
 sxVhnm8O6P7b4cQdXcz0oOJskVIGXcG3m2860Wcr4UL4usADItf4npmH/9HdlPTTilvB/YjrS1r
 HkLVab2yancRHvS4OI3uI1F/qxDpPAlHA33h8jtxctU2Gy1TrMVKpmtjkNxISqyWksdAnQdpN43
 Kh4g46mGEHHhrocqmUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230024

Greetings!!

IBM CI has reported build failure of 20260122 on IBM Power server.


Error:


ERROR: modpost: "phy_get_rx_polarity" [drivers/net/phy/air_en8811h.ko] 
undefined!
ERROR: modpost: "phy_get_tx_polarity" [drivers/net/phy/air_en8811h.ko] 
undefined!
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
make[1]: *** [/home/upstreamci/linux/Makefile:2040: modpost] Error 2
make: *** [Makefile:248: __sub-make] Error 2


IBM CI has bisected this issue and below is the bisection log.


git bisect log
git bisect log
git bisect start
# status: waiting for both good and bad commits
# good: [24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7] Linux 6.19-rc6
git bisect good 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
# status: waiting for bad commit, 1 good commit known
# bad: [a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d] Add linux-next 
specific files for 20260122
git bisect bad a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d
# good: [2574bcf1765ec13bf3ef469aa5b15cce293aebb6] Merge branch 'master' 
of 
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
git bisect good 2574bcf1765ec13bf3ef469aa5b15cce293aebb6
# good: [2ad38467d20c16f38d0cffad711ef4f4acdb8b29] Merge branch 
'for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
git bisect good 2ad38467d20c16f38d0cffad711ef4f4acdb8b29
# good: [a954370fea56ee1bf995524255a34da7a1ddb524] Merge branch 
'for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
git bisect good a954370fea56ee1bf995524255a34da7a1ddb524
# good: [c7ec480f05dd0185a26f190471905ddf1215bc52] Merge branch 
'staging-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect good c7ec480f05dd0185a26f190471905ddf1215bc52
# good: [4427398fed2b8e07a62fd4f3f6fcf9ffcf56829a] Merge branch 
'for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
git bisect good 4427398fed2b8e07a62fd4f3f6fcf9ffcf56829a
# good: [852ccea1ca3144beb7003976d4fa04dbf81b307b] Merge branch 'next' 
of https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
git bisect good 852ccea1ca3144beb7003976d4fa04dbf81b307b
# good: [f174dabd307dfd92edacb34e8bee0384daa1bd2e] Merge branch 'next' 
of https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
git bisect good f174dabd307dfd92edacb34e8bee0384daa1bd2e
# good: [e31f3c967c66cf03eecdf50fe138d05f635e3698] doc: Add housekeeping 
documentation
git bisect good e31f3c967c66cf03eecdf50fe138d05f635e3698
# good: [0cc83fc23debf3e2df19c4510a77fe2d60ab2693] gpu: nova-core: don't 
print raw PMU table entries
git bisect good 0cc83fc23debf3e2df19c4510a77fe2d60ab2693
# good: [75df6953fed6b7274f9c5080925ae4c8d3e424e6] Merge branch 
'for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
git bisect good 75df6953fed6b7274f9c5080925ae4c8d3e424e6
# good: [086714bbb96f63785da251e1f8d1ce3e716a6e42] Merge tag 'v6.19-rc5' 
into drm-rust-next
git bisect good 086714bbb96f63785da251e1f8d1ce3e716a6e42
# good: [6ea52b6d8f33ae627f4dcf43b12b6e713a8b9331] drm/tyr: use 
read_poll_timeout
git bisect good 6ea52b6d8f33ae627f4dcf43b12b6e713a8b9331
# good: [b956937ce78fae5fa785f6a95f291e2137502c5e] drm: tyr: Mark BROKEN
git bisect good b956937ce78fae5fa785f6a95f291e2137502c5e
# first bad commit: [a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d] Add 
linux-next specific files for 20260122


If you happen to fix, this please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



