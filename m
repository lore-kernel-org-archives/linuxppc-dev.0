Return-Path: <linuxppc-dev+bounces-22181-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4A9CD8C8E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 08:41:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYls14TG3z2yCM;
	Mon, 08 Jun 2026 18:41:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780908117;
	cv=none; b=AaLeJUxHmuyAgbD+eMURYcIVo6x9yKHysoBCxAuncQ0iXUj5DTz+rLzjfWCN9hD6yR9Bz5yJRfO8KX9lCtRMv2+LutVm7BgsDOwKC8HG3ToX7uAqLf11fgPv2eY7o80TBGlhj5OM+5ghCC/pszkJzYZyq5A050+smm35si2aZiLo99FR3+qaN7GyK4CiQi2qf8h2P+deGotPFCYWx7f5XIAHsw2gnZWSWgPUn3lEhuya0L8IH2H/qAuVuqy9D+WSGwIxyLIWrCTGpilmPr96ZrE0OdTwhsHO0hu8fbaLPdu7h5SluRqwQmKL9xlqqPSG4cfA7XrBe4pRc7SJtBkq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780908117; c=relaxed/relaxed;
	bh=oNmfjHZJRZvm1sNDrL/NuDvRFR+oaQAgWMXuBwz+8j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0zcUSqet976tFtx+cW6dn1ubkOhK4pBcw0YYa+FPYFkM02SNu9dQljSTzh4zxfN1smWHKeTb/YKiV31ZYWBniZEJbRl0XMPAKLe8Th0LBri+6kcDmGgNiovX3VUk7FAsWReEud7QTk1FeU4VeEa6OdfpjiDaVSXqDVybb7OvzcPL892NbCffOs8TuzCkESL+FYv6R16EWWkWJLW9TvsqKSpuZoYXAMuqWkkhuvINOFW/q+0hA6ZU0ahKM05SkiCG1jhwu59ZRyZTgyzjYxbC/EqkEABPqid9vTx1vdecoMsSnx8x1n6EJ7/17IH5ZYt7D4V3viAL8liurwPXq3B6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r+HbwqCI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r+HbwqCI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYls06mplz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 18:41:56 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657Mtrwr3416909;
	Mon, 8 Jun 2026 08:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=oNmfjHZJRZvm1sNDrL/NuDvRFR+oaQ
	AgWMXuBwz+8j4=; b=r+HbwqCIo7V/5hwXKFd1LONZ4Jvf90IeZ1+lIEvbzx4fKF
	ykjs+qBjcHHEPPLtI4WAdiGrRzTVzOOL5hRwwjN3VMGHI+MT/EuHEvxDAU3jrUJ3
	22kd9dUPw21Hx7u9kIlSPsWFXqIZSxfmrtOlWC8JLRdw/3hqHrt7gov6T9yfrGGQ
	L30awkI9/8Ls1QzBYEiDFJXUvEvQNLDmADJPHVDOCvLnJMPtXVnv5xwy2ayF8TIv
	/B7lEpEPo447EornL4nfHm+ksg/skOJ0VpDwOFLgaziQLV8OgbTWf8aYhKEECLdG
	zOpbYqp0SMEy81lqd0mfpTU23b9zt+P3ZK/hKPHQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qed5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 08:41:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6588YeoH014213;
	Mon, 8 Jun 2026 08:41:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgvepd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 08:41:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6588fhO935651864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 08:41:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB5702004D;
	Mon,  8 Jun 2026 08:41:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89AE220049;
	Mon,  8 Jun 2026 08:41:40 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.97.181])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 08:41:40 +0000 (GMT)
Date: Mon, 8 Jun 2026 14:11:33 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host
 compatibility mode
Message-ID: <aiaAPQmWG7JXGoGn@Gautams-MacBook-Pro.local>
References: <20260603141539.47620-1-amachhiw@linux.ibm.com>
 <aiGJvUqgjUo6M5et@mac.bl1-in.ibm.com>
 <87ldctmosh.fsf@vajain21.in.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldctmosh.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a26804d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=e3Y8OUfPrnf12rFgJ6AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 1cOFj7y23auh6U6zkI4yS1SfysaPNzKj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3OSBTYWx0ZWRfX8paRBT870B29
 JYikC9zZA2cYMzuICjHLPc1xPtCyVVFx2LXxAyzBkkqIoWv7hU2HP7ebYWGZs3YIqBCOXonkoL7
 KddPnCkctMPdHPf0lP5Ra7C7OD2bs05iHCjSB+o/tppHUjk0h82ytit4zIbYzz0KE1FKvMVwnpu
 22uAA3F2t7H20hOxFWuGnySOVVovyA5bzcuVjEanTCr9LwOtfxiBy+yCj2A63RQp1Gt4A7Zw9Y3
 5c5ymlgxsW8dxnH1otYTInGSDKeL383Gqe7eUDB8L15706QOwblq+F3J40b0MXoeoQqUz1IyUiu
 AWs0UnOHLqPj4rYid8MQYVOypnbWg1YfOAMYqk9HderLgVVlxXCUkvPr7jB0eRIC0o3Z1WpHWgF
 /0oD9S1uiIkP/WPgDJZ9tkalALs1/zv2/E+w+cakuTkwGcOZa/AxF6m6eAve4YD4WymEtGS/VI2
 cGW4Q5L/iMCFXSdCPsA==
X-Proofpoint-ORIG-GUID: ZtD31xyr9EAiG7G5dM9V5q-tjCIg3eF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080079

On Fri, Jun 05, 2026 at 12:55:50PM +0530, Vaibhav Jain wrote:
> Hi Gautam,
> 
> Thanks for testing this patch. Few questions:
> Gautam Menghani <gautam@linux.ibm.com> writes:
> 
> > On Wed, Jun 03, 2026 at 07:45:39PM +0530, Amit Machhiwal wrote:
> >> On IBM POWER systems, newer processor generations can operate in
> >> compatibility modes corresponding to earlier generations. This becomes
> >> relevant for nested virtualization, where nested KVM guests may need to
> >> run with a specific processor compatibility level.
> >> 
> <snip>
> >
> > I booted a KVM guest on LPAR with this patch in the following scenarios:
> <snip>
> 
> > 3. P11 guest on P11 host booted in P10 compat mode: No error observed
> This should have resulted in an error since booting a P11 guest on P10
> compat mode host is not allowed with/without this patch. Can you please
> check your test env and share the boot results.

- lscpu output (host P11 LPAR booted in p10 compat mode)
# lscpu                                                                                                                                                   03:35:13 [3/3]
Architecture:                ppc64le
  Byte Order:                Little Endian
CPU(s):                      960
  On-line CPU(s) list:       0-959
Model name:                  POWER10 (architected), altivec supported
  Model:                     2.0 (pvr 0082 0200)
  Thread(s) per core:        8
  Core(s) per socket:        15
  Socket(s):                 8
  Physical sockets:          4
  Physical chips:            2
  Physical cores/chip:       16


- lscpu output from guest
# lscpu
Architecture:             ppc64le
  Byte Order:             Little Endian
CPU(s):                   4
  On-line CPU(s) list:    0-3
Model name:               Power11 (raw), altivec supported
  Model:                  2.0 (pvr 0082 0200)
  Thread(s) per core:     1
  Core(s) per socket:     4
  Socket(s):              1



- QEMU command line
/usr/bin/qemu-system-ppc64 -device virtio-blk-pci,drive=drive0,id=virtblk0 \
    -drive file=/home/gautam/images/fc41.qcow2,format=qcow2,if=none,id=drive0 \
    -m 100G -smp 4 -cpu host -nographic -machine pseries,ic-mode=xics -accel kvm


Thanks,
Gautam

