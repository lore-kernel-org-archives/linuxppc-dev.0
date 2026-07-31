Return-Path: <linuxppc-dev+bounces-25176-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD848C5516D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 11:22:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBNvs4WJBz2xpn;
	Fri, 31 Jul 2026 21:22:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785496953;
	cv=none; b=D7myxSSnPttxywr+QGN7ikgB1TCdybN8P08xawW9Og2Kt4WKyYeInPhTh9Tpyi14/cCkHHqr6RTFjIiociMtNezO5z4d/Rmzo6ufrO17D+n/kRV54dk5+nYfudACieT84aJKkuSZibPEofyM7nG9JV2LTTENmWqAvnDPqrViG3lKDrUcckHOEliD8AetT4sdKP2kYI0YP6oTztLVZ6pKFUnzGJEJ0RMyqliVNZ+htO50XHMMnygwxNaBaXpaTds12vJuKGkvgXQmOsIPnv681798oLLUZdk7oFtBQpFNSbdMn3ByUnWC7CHmqt4XnnEgub8mfphEbsmedLAioa7i9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785496953; c=relaxed/relaxed;
	bh=3HQhqBOfD9w5BVAhgTwwGC9ZZCj/zYTsS3rL3ph7hnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjPqJbdv2W+pvsbDQLJIalIHhtZDwl8GhmtNPebWZYDOtKcTF5U+Yo3mKz1Zfnf+Q9+4XnH7TcT8ijBHaSuIDHXcIBI2dN9HWxw4b11JrHvYx7f7N15YU8wV9BpD4/ptAHOLMQidZ8T26VvqePllIOiltS95LR9m1N9WYnhncJoUcTY4s6I54+QzeImuZKUIY94mYZXy1EGzd3hE8iDCNnGFCToFhFNgQXtDiHArbMJJintOpW/+XL9ngjHVtzkXpDprLZDYhUY5i+FKBy1WTDndAN6T0jJJIWp0a17G1wChISqjqDg2Ym+twDb9kqo4PXtHHxKnEg+2XmkX3xQ6Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QKPooDvk; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QKPooDvk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBNvr3pKKz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 21:22:31 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8Hfug3629875;
	Fri, 31 Jul 2026 11:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3HQhqB
	OfD9w5BVAhgTwwGC9ZZCj/zYTsS3rL3ph7hnc=; b=QKPooDvkZcn74Bf99msdgr
	tcEmY8t9i6PAEST7ie1Vu7naZ09ibSmCPsmiWyrsvx4Xu/IXcPxKqpPcS+Ac5ZW+
	RTw0Tuuk4hghHv5GuI5jn4ufdGwiaBoInKy2EOWRNYNHYgEvFK2lPeG4iatBUTNx
	8mWYXgSOhygTJVj/wWaVUszzLLVsjKxPjtLHhspYkDGK+YOR01Vu3GQtLYajrY83
	idjc7c4jyiwdDddH0Yh1jRc1YprgnZftWzu1RxCEMgZ4fHTpFFBnlNY6bpFVnOG+
	bZDFvirwf4Y/v/EVwer6h80lbpputT5nSqIEXeWJzHI6p7VsfM0b6T9XbcC5K+lQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycvmqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 11:22:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VBBF1C005650;
	Fri, 31 Jul 2026 11:22:09 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqffw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 11:22:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VBM8cF60031436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 11:22:09 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C57058062;
	Fri, 31 Jul 2026 11:22:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A7135805A;
	Fri, 31 Jul 2026 11:22:03 +0000 (GMT)
Received: from [9.43.104.204] (unknown [9.43.104.204])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 11:22:03 +0000 (GMT)
Message-ID: <cea73ceb-8fa7-4fae-be1b-dec668a2ac95@linux.ibm.com>
Date: Fri, 31 Jul 2026 16:52:01 +0530
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
Subject: Re: [PATCH RESEND] powerpc/configs: enable CONFIG_RAS to fix EDAC
 support
To: Michael Walle <mwalle@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>, Tony Luck <tony.luck@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        David Heidelberg <david@ixit.cz>, linux-edac@vger.kernel.org
References: <20260730105546.3658570-1-mwalle@kernel.org>
 <20260730185620.GDamueVIGV-8iIzozX@fat_crate.local>
 <DKC6Z5YGBF2O.TAJAN566BN0L@kernel.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <DKC6Z5YGBF2O.TAJAN566BN0L@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: E8EEELUfbfzjJ7Esb8Rgl4gViW_8s2P2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA4NSBTYWx0ZWRfX0phIGJrhmGVw
 lwuAGUvDAfCq1O+CRllKFjgC0SrkdIBiJ/b8LCfbLuYSzhi8wyku29LwTU51hYzvfUrm38qmmPS
 t5d5AaEUE/i4YQolSnka5xme85YeSAv3DEs/Ng89uwqbl2S/J9uvGMiwPR3iikk5j+W+kBqMM4m
 69N5+Q4muFuh7osL/aKiFEAtiQ+0JJ1QXswQzkUcCCOKAAinz/aou+xznxKtbxf3L8DhH0S8uY9
 tibH3qLgWuz+6B5o02+wRq924vpgGdu1I4uaw3+xT7aX530QFk4/yEw0H8bAPSzJEni77i3jrep
 GDEHvYX8C7NG61Mdq+uoeuH0YZqUnyMiWV13RyYga2fFKbmiQit2B1SoMeSHGJGbG0QOhK5cqXb
 k1bCMfloioCPjhjlp95HMmcFOp6oSVfSjhpvQuHjT+iEURD5/q7/HBEkGMUbZw5hkUSgIevoJva
 AKbh0SKIT2R0yvVhTDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA4NSBTYWx0ZWRfX0TI984AiOeN1
 2erVke2rrkI7Pdo6BQdoDA9D4mvDZwblT7EKE8rbjJwybJ+/u9Ug9O+/08ay1BbsHwZFjv6wD6U
 33JCHe1fnNhnlHYcTgjDHXfvSnBxWSA=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c8563 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=uMe6KACeWnfwCRVUapwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MYg2Y5N7fT8TYl8Yow4A8JUutj5FVgym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310085


On 7/31/26 2:05 AM, Michael Walle wrote:
> On Thu Jul 30, 2026 at 8:56 PM CEST, Borislav Petkov wrote:
>> On Thu, Jul 30, 2026 at 12:52:18PM +0200, Michael Walle wrote:
>>> Before commit e3c4ff6d8c94 ("EDAC: Remove EDAC_MM_EDAC") EDAC_MM_EDAC
>>> selected RAS, after that commit, EDAC depends on RAS, but nobody enables
>>> it. Enable it in the config again.
>> I have no clue what you're trying to do but forcing RAS=y in that config
>> better have a real good reason why.
> I don't get what you are trying to say. CONFIG_EDAC_MPC85XX is
> enabled in the that config already. It's just that the mentioned
> commit broke it because it removed the "select RAS", while
> EDAC depends on it. So yeah, up to that commit it was always
> enabled in that particular config.
>
>> Oh and we cannot support CONFIG_EDAC_MPC85XX anymore due to lack of hw:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/commit/?h=edac-misc&id=749c5102487b558cc7d73961a6d0da2fceaa022d
> Still, it's already enabled in that config and it somewhat recently
> got IMX9 support, so I guess NXP is interested in keeping it.
>
> That being said, I have the hardware, but right now I don't have
> much time personally. The best I could do is "Odd Fixes". (I also
> have two pending patches for that edac driver, yet to be posted to
> the ML).
I dont have hardware to test this config change and currently platform is
in odd fixes anyway. I can take it via ppc tree but definitely need 
community
help for testing fixes in future.
Maddy
> -michael

