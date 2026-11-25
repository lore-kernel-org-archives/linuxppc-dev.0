Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2807606A326
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WWcp0Ha4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZD0Z3Gkzz2xqh;
	Wed, 25 Nov 2026 19:50:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795596638;
	cv=none; b=V8rdcmDZVdtjlZczwm0Xq/YB4zXoQhgHgr55Wklsw7y5Gxc6/2r8FdlMGKT8R9mrVhMja8GfzOReF4uyeCE/SQR3P6JKuNfO/bg4RF8OhDEMIxil2U+Y032MQsPv4tH/rijD4XmW0CYieCKw8t6uaRZO6zSF9wuK8Ok0t9twvdXjY/3f9Pmy7YjO9ulZE+e3XhVpyxYsfs+sOiFSy1ADMTSYT0lPCoF6cA1k8gH+rYeHu91YqVW5oows3vTWM6sJbnG/LiJvZtqbhxyrRZMOzrr+I2acSqrX9RybDOJFjuCd/siZ4g5W9NW7KjKJ3muwKUgKXbbR0ssdCOl+ITIQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795596638; c=relaxed/relaxed;
	bh=jAXF1iU14qqHaUZc04NyH6q3nfEi9VdvI6B9iqAoq1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBEOhymthnhTqyKUkYoGLexrmRRrs9cwQ0CAOpL8NJsEOPFAp7sf2fBbVTyCjSMjMrfizvLpXVOCBoI69QCXw3cssHFu5s6num7mfSNYEV7TeSJCdvCfJq0xjlxtQ4MiS1ACqtGpDQQWQUJm1DXBRJ72sPsdfDxMz1SxW2dgVvG6z18B4QjXXU6fkcyy5ionvsYP/2BzA//01/WwjNtMU8s2n3D6UuVmzjbuoCzJK8hpdGCTw/090M52YRYL5jMfM6QH9LaisKJ4i25+aoMXvJAeBySxEZHsX0RlFDmuzggPWiCeYegzbGL2pfJdJaqHDju8Drg1ccLi1HvAuVNEFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WWcp0Ha4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WWcp0Ha4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZD0Y3dRgz2xlh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 19:50:37 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP6Ys9M532464;
	Wed, 25 Nov 2026 08:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jAXF1i
	U14qqHaUZc04NyH6q3nfEi9VdvI6B9iqAoq1M=; b=WWcp0Ha4r4mGg8kEdSwszP
	F8qTZamwxZGVuAShqhc8a0Eh3YK3cSLuXMfICO/lhFZU4I+on0gd4zPoEtkgiYuM
	V7gYdcCVa4lUOsya4iX1yzUAcIJVhGWOxO+v6LLDN3oyFGgtS1PDjtmh4rx7/zzb
	OGiGHDDoQHrC3ZeqOjoHmk5Kv7UW1j+ZY+3CWQ6AJvL5fc1m0Fpy0iVgwi2q4Nly
	8v/7axZrPuYNROS3U2xZhly9ajfif2r3eSjm5gUmb9OgWg4wx0A94tFpvKukWZqt
	de0eeqX0S6lbRxBYgyRLHmgtOd92X1+VUXNM5+69GsSP+KWm8Vff/Jvn4fzRaDPw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkkjbg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 08:50:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP8BbVc3967663;
	Wed, 25 Nov 2026 08:50:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx037t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 08:50:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AP8oDaw47382960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 08:50:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 664E82004F;
	Wed, 25 Nov 2026 08:50:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83C662004E;
	Wed, 25 Nov 2026 08:50:09 +0000 (GMT)
Received: from [9.39.29.113] (unknown [9.39.29.113])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 08:50:09 +0000 (GMT)
Message-ID: <298e965b-6de2-43b6-a6c0-e844b115438b@linux.ibm.com>
Date: Wed, 25 Nov 2026 14:20:08 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PREEMPT] Kernel panic - not syncing: stack-protector: Kernel
 stack is corrupted
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        Narayana Murty N <nnmlinux@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, harshpb@linux.ibm.com, gautam@linux.ibm.com,
        amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Damien Stewart <hypexed@yahoo.com.au>,
        Christian Zigotzky <info@xenosoft.de>
References: <D0ECD6B8-7F15-48C8-87A4-DFE5F35A42D8@xenosoft.de>
 <EEB13352-2FD9-4169-B709-FF7822AA591F@xenosoft.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <EEB13352-2FD9-4169-B709-FF7822AA591F@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfX9PSc71lOnPjU
 m8/O9MV9dJAk4XpNHrs9S5LE15oDym16brkY6ro7yYMA+qL6XIr/rqtBl3fNyUyR2fznB5x5VII
 TEKlBthG5NhBXHEhuA0IdTvwwF1eZlwCvH/vtGh4pwQ5SMSyPYaiz7Q5FeMlDJN9uv/3lI8sAdk
 sfLDj8ATx92KSGdIBTyzi95uKYzQnOc+bJWwQfopS+Ph/L72/OO3qRnOa1i7luKg3dF/5B6OQ1J
 4y/NB680Jh9pslai3iaIiISxCYDKddC2k0SBZrm+pK5Um3LmAq+hlNXYDghxypMPK4J3gABCZeG
 +ZeEX8I7w/DL/xGtgbaZS8VG8xrR6gSdh8hmFMRflmgT5Gf0yReXicjUfAvak682g719mFCTuHP
 pw7/QwbBqXVJuuegiEG3ab5tWreGmz+cwTrNK7oEAIop53G5L6nkk1G4pvZq/BpvSGwNRbmXWpK
 0tU1MHoL23Ww8RWkD4g==
X-Proofpoint-ORIG-GUID: ZKznimse3gQ5bR5x74fEz6vR-q5T1Uqr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfX0sc8dcAkNfFQ
 hT/u/l10Jv2SoZP1ISuvxsigg9wiySVbEbHI4bR0/6PGw4kX5J63sz2fWt2QDwGddcfEFgBnE5S
 x2+fzPnWbCkup2siH1hqznSvT32Q77Y=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b06a14a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=oxC9TbpiAAAA:20
 a=OuRNIQCiARzACWCb_SwA:9 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: OiJXjawNaA8bwld_nRVqb8fr-ZaBIgxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250034
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/25/26 2:16 PM, Christian Zigotzky wrote:
> On 06 November 2026 at 07:09 am, Shrikanth Hegde wrote:
> 
> Hi Christian.
> 
> We had one known issue which michal had brought up.
> Do you have tracing enabled or running a bpf/bcc program?
> 
> - - -
> 
> Yes, we have BPF and Tracing activated in the kernel config.
> 
> Nemo kernel config: https://github.com/chzigotzky/kernels/blob/main/configs/x1000_defconfig
> 
> Edit: I have deactivated tracing
> 
> Link: https://github.com/chzigotzky/kernels/releases/tag/v7.4.0-rc4-3

If possible, please share the logs. Lets see if it gives any clues. Is it while system is idle
or running some workload?

