Return-Path: <linuxppc-dev+bounces-28438-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33155C9832A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 04:06:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv4NS3xBYz30Vb;
	Tue, 29 Sep 2026 14:06:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790654760;
	cv=none; b=a3HbdjTTS3AH+NaBks246QvyoVL3d0jUMn0A3ctIOQn3ul9qiZ6lX/+oeXYgih5hLlTjNWZnjK4aIIbwvf++uFXHklqz68LtOHYskvkH4xQFVeOGZ1V6a2BjoM3bO877rfFtmoj1ob8xasOOUa4KlLk98eB/cLBmPcpKYsPxWaUG5NorAuDlxfk8rZ9friRKev/KDs5FADn2Kge5Y3jxWVcDJdMXyQgTE95SkI0qA+qm2aKUnRiXJx8Y26F+QcYihE1iVZfcuErR6u2xtT8cS1ugb0NWSe5uRc7QryASgLtB00Tzd+du1pdgOuKvd6Ib5sCCO6COl5/xy9eNJA6/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790654760; c=relaxed/relaxed;
	bh=IVKGpQSnDzQV98xNnRltbC8Rlk33PSFN2FV8Uj9/XB4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/Ni0eXoY01B9xDxT8T9tDm+3MNl+KKy5spry0N+sznloJYYk0xooqfUh2AulmfqqRIhWkV5VyZ7240D6VHGDbODuIgSmuQ7wYth0NQ+6OZQ2/p5flBFTJ4sjbaErN/8inj+dB7l9WKdgKOPpDthLwDcxCu2oCl72PVx/uZAIOc1bPBJ1wZAsr/BEaZGFU6jeu1hRmnU8Y/c0CkF1KLHMwCfKxPzwPz+w+Cq2PxFDh0Y615h4+Mf+en3j6iIB6z4O0vn6ON9X8rOwrAdxCsNA6la6B7n4OOTjLkTMr3bH5D0N7Os5StInk2b2VSX8zC/yejX+xd4i4d+Tmrnx2LYBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fsqRCsb1; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fsqRCsb1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv4NR5gcDz30PJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 14:05:59 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T15J4E2683096;
	Tue, 29 Sep 2026 04:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IVKGpQ
	SnDzQV98xNnRltbC8Rlk33PSFN2FV8Uj9/XB4=; b=fsqRCsb1A+6XNYiegfC6jV
	u67Qp23pSuA4hxmNsK2UhlG03j85JUPuTx4Bjst5GluvzLbts3y9YpHSQlspovMo
	3nzjpMNAmpQJpkYR7ADX83Fb5e9WDwnGO1sy9o/KkzDDkqNdqViTHS2k4Fp8jugh
	5UYyn6K2Sq7GA0fF8O8xhHeyH+IMkRt1jDAGYC6mGuMoY/3kNpEf2kxXXFbCyPgI
	FP2jsQlHXipt0YeNqhd0vF2hxWQsC4x13hEMbCd1iVe2/QEYqI26Lmj29IzUu7ms
	wzlovgMwdbkJ09mfxKzvNWVFYaIdmnN63fU4Woz18oL/UYehbmHXpQZDGU//mbiw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5556q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 04:05:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T0mOXJ959175;
	Tue, 29 Sep 2026 04:05:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpr93t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 04:05:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T45tn146268818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 04:05:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 097012004B;
	Tue, 29 Sep 2026 04:05:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D4D620040;
	Tue, 29 Sep 2026 04:05:54 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 29 Sep 2026 04:05:53 +0000 (GMT)
Date: Tue, 29 Sep 2026 09:36:05 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
Subject: Re: early boot crash in init_tracer_tracefs
Message-ID: <20260929093245.00008c9b-10-amachhiw@linux.ibm.com>
Mail-Followup-To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
References: <arYskzbiaNzBR9MD@kunlun.suse.cz>
 <20260928111234.faec09f7-8d-amachhiw@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928111234.faec09f7-8d-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNCBTYWx0ZWRfX3dMjL76d3n3q
 b0Drg7p/adh/3gNUFvQ4Dnz0PH48/5Rt9Xw9tstQuTIvBnRl1EGlD4VF+Wd4eDP89q1fIyZLvID
 aNzGSlcSBYl/BLi5eakyFUfevhM02k8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNCBTYWx0ZWRfX5G6s6o7Af9LL
 hHvufEy1Xw7Lo+19Gf5E6iYfyiwpx/KFCz7/ozOswAl8UrW5Nhwcx/FyDRXXcA3c+uJSqfYITQV
 5gO/FJ+vrDBPpu2m1H5rtnI5Z5VUmB4e9KcG3c/4deI3Yu1tf1I1c/1FqRBVnze1uYhk7PhdrXE
 xPBAFzhbDhK9omos1iDPU2BkMPrbAmvshlCZA3tjM22dIHb5raINCDQay2PSifFKdszD8d4rD4c
 47BGh8hxVelf1wROHDAl/2CGqi+SsRdtznhON48NOySi+0KDis0JaMT8c7oj/GkBAqF8hRpJsW2
 Df779OaSv63ZNLEPgpAILIVmbH12OMYjklU1ZTVOgfIAO+PQGxcq2FcRn3+4ht0Oy/xcguAeaDl
 kc65OwGBwvj/VIimrZjEDcJiXaczkxZDBFjDryNdCftBYzIAR1qwCEp0r2nN+SZ5zXWPkDo4q4M
 J3PX63Z6cTYhm3NzneA==
X-Proofpoint-GUID: B8_K4oG_8mw2yoCLL1xb7C0shd8wT888
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abb3925 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=VLc2VSdLAAAA:20 a=6Lmk3mhVHTgPPlTxhzgA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=ZXulRonScM0A:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: B8_K4oG_8mw2yoCLL1xb7C0shd8wT888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290014

On 2026/09/28 11:43 AM, Amit Machhiwal wrote:
> Hi Michal,
> 
> Thanks for the report.  We have been looking at the crash and have some findings
> and follow-up questions.
> 
> On 2026/09/25 10:10 AM, Michal Suchánek wrote:
> > Hello,
> > 
> > There appears to be a regression between

< snip >

> > 
> > Linux 7.0.12
> > https://github.com/openSUSE/kernel/tree/4c9922875554ec191166ba6c0145f12d8ff9d4fc
> > https://github.com/openSUSE/kernel-source/blob/2ebf0bc/config/ppc64le/default

I have been trying to recreate the issue with this kernel and config but I
haven't been able to.  The L2 KVM guest boots fine everytime.

In addition to the requested information, could you please also share your qemu
cmdline/guest xml you used?

Thanks,
Amit


