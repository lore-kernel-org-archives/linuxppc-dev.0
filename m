Return-Path: <linuxppc-dev+bounces-19462-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECE0FD5F6D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:29:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr96w2FMdz2yqP;
	Wed, 08 Apr 2026 14:28:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622520;
	cv=none; b=XPiJgXSh5FmFAZcDOjjPGaRTTmG7NhKPQ0+iWfij2TbMny86ckhgOv3ysgWwEmbJYCr9r81KnVOQAxt2OrZgSqqhn2c9Oo6bnizuGctEjDKphd2YLtZeQq2bdMCgD8xnRmEa4dTGGDEBhpnuTVn1JPIctK6/TPLUj7YWC6XhgEUUmOqacqlr5AUGW4liSTh2EBR4VNujci5x7wSeo8dVTFOAmqGKP769gNqTrn5v1/sJGCI6Wdhhvj8G6JwChd3nDJX4J2vfYeQ2t0I5Y/GofbRyGoOMZ7YYon++R7MsFzw516Cv7c17F3Pf0WA9PDd1LXbCcjXNGXF3oF4RbllYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622520; c=relaxed/relaxed;
	bh=sTYWaayrimRpPwSSgo7/sUPNPuhaZpD1b5+V5PqBLF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwQwHc1Jjj8ndlW4QGB+h4xtUhefB0Js/0vxeVPNw1yrCFS5fnS/syiMJp++KnumSZ3vgsX0uZ+dhwoGqwIECNMY4GtjCGYZnH/VGJaeB/2JSYkA2fQR7PyX8tuPET+FQ5YhZcmmjPnnKBH6uoo3Rl8payuTB+xRhdnTgM1sXH52DfURWLtMN0zr+lyBC+eic/hLO2slgiEyOzNiX/JpMAAKY11ikB2HItT676JgN3VsAtxZiUY/PD6FWdxvVk8whI7u56C2lKIsRVeugJCF2lkOQk+0XTWO6j70Wjez/DiLZJXCQUKhdXBxSUH9Oao+egJRlVmqX9s3AhU9tb2Qsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j4Xvrp+8; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j4Xvrp+8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr96v3ggHz2yrb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:28:39 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Dr4gx2594862;
	Wed, 8 Apr 2026 04:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sTYWaa
	yrimRpPwSSgo7/sUPNPuhaZpD1b5+V5PqBLF4=; b=j4Xvrp+8/5vtpBPRdwj6zQ
	QQ6GA4dIBgwUgKPg5vV5aeA0yibxVwar2+rySOTVcdcYxrKJQoGctGdh1KA775Qs
	uoh3OfWDG8cgTO3GOhMKqO9052buk7ljHRYaqV/VIFVYqbyaRkMp15eW3fS7A5Uv
	/4MxMAiC7bbRkCbDcMXwKAi9K0m2f6eqG+xSXw707E+TzienaYsfotRlceeLVjPh
	wPF2AmYtg1NhqIe+Z+fmfRQjamtbKXYxjuBBy68WdUEX2TSXoKPRgk4LERsVuXwK
	3+BWP6uvBD+30iagDRcHZZSyxFr09wYiSVMzbS4V3wftJzsCOYMJo7QqB9f+ZsoA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e67tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637NYbG5013821;
	Wed, 8 Apr 2026 04:28:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf46050-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SKb431064518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB9DC20043;
	Wed,  8 Apr 2026 04:28:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5441420040;
	Wed,  8 Apr 2026 04:28:18 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:18 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kurz <groug@kaod.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests/powerpc: Suppress -Wmaybe-uninitialized with GCC 15
Date: Wed,  8 Apr 2026 09:58:17 +0530
Message-ID: <177562236422.1381144.4554144401168873566.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313165426.43259-1-amachhiw@linux.ibm.com>
References: <20260313165426.43259-1-amachhiw@linux.ibm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: G-qH3MqtFyaihStNPY5YFbbVWzyxAClT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX/BAOe+ncuKhk
 DugWvbEG0AMFDuxIE48S2IaYs1d6WNMyHuFZVxQcT+ox6MIK/9i+frIydzQFZWRXJjPQwQRA1st
 L7tkGrEuUjDA/qTVR3hlFa3y9D5GUqGZsNNRHnUIduUshxaTGQerEASguBvGK3KiLbDmk6dPFI1
 hXVb8wgbnXLYA1gBECw5diBdbfXetpGKVyRoLXpIR+DkuV6DvU6hRIsup02on1lm0Ff5NvzjE+V
 fg+xlLhKQwJaq7S8ffr5FI6Cv64LD6hHeiglFbSN62ZzaXrtwn1T1ezBBph/P+AK3+TQ4FnIx95
 cYbDOQE/mfAa+XMC7stC2cV3ySPI2LKSjTebVlYDZD9edIrbgJre73nd4bDvSxZfvccB2GUr4Hw
 hcEubB2rSK6U2Ui8XWm7zneGX6zSF1eS/RL1sFRP2e4n9dp111X6WTSdsvD+Z4ytxUjPalwzxW/
 eY+IXgVg6+Cc9J/nvJg==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d5d96a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=oeOQCyp_1XCr1dGvqAMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ez6dFC_gI3skCz9XJG-SPahKkdPdSBmn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Fri, 13 Mar 2026 22:24:26 +0530, Amit Machhiwal wrote:
> GCC 15 reports the below false positive '-Wmaybe-uninitialized' warning
> in vphn_unpack_associativity() when building the powerpc selftests.
> 
>   # make -C tools/testing/selftests TARGETS="powerpc"
>   [...]
>     CC       test-vphn
>   In file included from test-vphn.c:3:
>   In function ‘vphn_unpack_associativity’,
>       inlined from ‘test_one’ at test-vphn.c:371:2,
>       inlined from ‘test_vphn’ at test-vphn.c:399:9:
>   test-vphn.c:10:33: error: ‘be_packed’ may be used uninitialized [-Werror=maybe-uninitialized]
>      10 | #define be16_to_cpup(x)         bswap_16(*x)
>         |                                 ^~~~~~~~
>   vphn.c:42:27: note: in expansion of macro ‘be16_to_cpup’
>      42 |                 u16 new = be16_to_cpup(field++);
>         |                           ^~~~~~~~~~~~
>   In file included from test-vphn.c:19:
>   vphn.c: In function ‘test_vphn’:
>   vphn.c:27:16: note: ‘be_packed’ declared here
>      27 |         __be64 be_packed[VPHN_REGISTER_COUNT];
>         |                ^~~~~~~~~
>   cc1: all warnings being treated as errors
> 
> [...]

Applied to powerpc/next.

[1/1] selftests/powerpc: Suppress -Wmaybe-uninitialized with GCC 15
      https://git.kernel.org/powerpc/c/6e65886fceb23605eff952d6b1975737b4c4b154

cheers

