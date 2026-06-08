Return-Path: <linuxppc-dev+bounces-22188-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910CACD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 12:04:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYrLZ69rhz2yS4;
	Mon, 08 Jun 2026 22:04:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780920262;
	cv=none; b=jWpwn81r9u+xQqwjRhYe8KHxxrHmtrTcGC4LpxrdmFEJ116wKMAKMQMIs4V7rW6Cv5IXuVj8XNNt7voDpYxFpNORYFHZtyQ8u4LZ9Gxm7rruERMXhTNqJ5WqP4hjHEhki5bHo2/jC1Zs2JCqG7H+XNkDzyqzIJPy8dxDVmioFGOdx8ERNzl12tgcgHPXQdwLQCumnxQcb18m3uvmRIwCR2bJvAlmJpZ888akPZD4VvZZKn/sjHIlsiz8/CKQFQVYv1Wrn4LKILB58RCP0S91V34hjrp7KFgaJd90ryUTLgorFtqj9vsUoPmIxaQVZ4rL3jbg87ZuIITZ8uIH6rckoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780920262; c=relaxed/relaxed;
	bh=f9Or2Zz0HzX2sqdKsSO0pvkM1+40p2vgkpOS8tr1vAc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=euj5ZOHK+fsPdpVuzs6fyhL95g21mfLyAiX2bJECHhXYzEMCKqx8//4ww8dae15w067g6ZgIvwLwP4q5/fAyk/z6/RE/ld3r7L6iZnXHg2EOjMx8dl9yLUqMpdAiZmiiwQZicFrqBLdYHKfn3LNu3EzbTTvR7oZ7NF1dbyl2w8CXzeuoZGLYrNuhIeyO2EJyUmtDakCh5symOGUhxU8lL85Qq8UpsoRnfc/r97fLYdWX9br2+t+KZN/ipl7HRUnS6G+eZEN+4Jp4gI21Zz6JSAWMZ2jGunagJ0fPqDf58Gg7h8+3Y5WRyetFW+tCLkOFeNNV563+tP+59+gvTpQTJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SrT4oLgh; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=yeswanth@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SrT4oLgh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=yeswanth@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYrLY6sYKz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 22:04:21 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6587nmSv1596687;
	Mon, 8 Jun 2026 12:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f9Or2Z
	z0HzX2sqdKsSO0pvkM1+40p2vgkpOS8tr1vAc=; b=SrT4oLgh+Lz6eI7v/YRqHW
	w+0f2niJT6mn8/nIcNdgIZJeNNVbp3fZ5kEVN7LVCrYNrBccK1c7BpLjR5GrJKUu
	6/fULpxC3Y5pJ/dPooP9VnDHyjiBjRzKUpy1CAHJykTwDHvPlGeqC0djeVVmbFYP
	CLvKSxDS9UE3Up3/fPFq9cqA5pwhWFEqM8A3WpH9zgeyITFuRxO2DHdo/Ox+Jb+t
	fN6QsSXci+p4RaFLQs1IfIrKkZ7ukdyDHIJHCpTipgC573gWnGBezoomH8yo16dT
	vXYriaUu/oP7WbwpCX6FPuolSWFM385e9WFaUnHlH/E8yD3jvkaC9T2czeobu2iw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qf2rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 12:04:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658Bngsp023861;
	Mon, 8 Jun 2026 12:04:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpwae1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 12:04:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658C4H0p22020820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 12:04:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5A4D58067;
	Mon,  8 Jun 2026 12:04:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 415E258056;
	Mon,  8 Jun 2026 12:04:16 +0000 (GMT)
Received: from [9.123.9.7] (unknown [9.123.9.7])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 12:04:15 +0000 (GMT)
Message-ID: <fdef9aaf-af56-42b1-975b-19a4c19472dd@linux.ibm.com>
Date: Mon, 8 Jun 2026 17:34:14 +0530
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
Subject: Re: [BUG] kernel BUG in team driver: buffer overflow in
 team_add_slave()
From: Yeswanth Krishna <yeswanth@linux.ibm.com>
To: netdev@vger.kernel.org, venkat88@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a26afc2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=6i1IRE6oVdN0yyl8cBUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fYkDlWuD2UVKzKd4I3KTttXR0ut-jb0n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwOSBTYWx0ZWRfXzNH1u+l6N4uG
 mGMm3mzOVvIvR2symKd0+harZ2tuIyyJf9SQp4r9N8uLgHyH9Vd1AuRyBRqksJUuNkcL+36wHEI
 Kj3VSQWQzBd006tsWpOKkndWqpD+0Aym+XF2AXiBjr2DxNlHrImtZgXBs9+la3hIliCJdHUunOl
 74XA3mqvTb8c8bCpYEt8QZHbKDCKnPZyhE5OviAasY8/C3xW/0tS6O6ff5srkXuwnn8DKv1ES1J
 2n9LGmv1Iy/cL2hW7FHiM7cW1Y3fiuZeepM2fXnvhBvzSCIjY7HF4ZgNnYymfYTPXHfNjYUkwjm
 2dFR1WEyXsCP/Bt/n51dQxC07WwD5m/J6F08aZ9RQVWJenY4kZYEXNTOtecBFm/50wdTaIXtXen
 +1TFF/w7kU0nW6xk5ZhUbMRgPagWri6UaYfkkqp6/ojeGN5UUYTbxHScrCVlyfG3zLE7cJxb5Oy
 4iSXKWkC4lyi2FGt1mA==
X-Proofpoint-ORIG-GUID: fYkDlWuD2UVKzKd4I3KTttXR0ut-jb0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080109

Please add this tag Reported-by: yeswanth <yeswanth@linux.ibm.com>

On 08/06/26 3:30 pm, Yeswanth Krishna wrote:
> Hi Team ,
>
> I encountered a kernel crash while running selftests on kernel 7.1.0-rc6
> on a POWER10 system. The crash occurs when adding a slave device to a
> team interface, triggered by FORTIFY_SOURCE detecting a buffer overflow.
>
> **System Information:**
> - Kernel: 7.1.0-rc6-160099.42-default+ (commit d548c6f4301b)
> - Architecture: powerpc64le (ppc64le)
> - Hardware: IBM POWER10 (9043-MRX), pSeries
> - Config: CONFIG_FORTIFY_SOURCE=y
>
> **Crash Location:**
>
> [ 3492.897824][T77143] kernel BUG at lib/string_helpers.c:1044!
> [ 3492.898057][T77143] NIP [c000000000ac1120] __fortify_panic+0x18/0x28
> [ 3492.898096][T77143] [c00000000efdb350] [c00800000b857a18] 
> team_add_slave+0xc60/0xcc0 [team]
>
>
> **Call Trace:**
>
> __fortify_panic+0x18/0x28
> team_add_slave+0xc60/0xcc0 [team]
> do_set_master+0x19c/0x240
> do_setlink.isra.0+0x388/0x1450
> rtnl_newlink+0xac8/0x1030
> rtnetlink_rcv_msg+0x450/0x530
> netlink_rcv_skb+0x74/0x1b0
> rtnetlink_rcv+0x24/0x40
> netlink_unicast+0x2e0/0x430
> netlink_sendmsg+0x210/0x580
> ____sys_sendmsg+0x30c/0x470
> ___sys_sendmsg+0x94/0xf0
> __sys_sendmsg+0x84/0x100
> system_call_exception+0x154/0x2b0
>
> **Reproducer:**
> The crash is 100% reproducible via selftests:
> ```bash
> cd tools/testing/selftests
> make -C drivers/net/team run_tests
>
> Please add below reported-by tag:
> yeswanth <yeswanth@linux.ibm.com>
>
>
> Thanks,
> Yeswanth Krishna
>

