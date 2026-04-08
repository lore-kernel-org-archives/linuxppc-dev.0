Return-Path: <linuxppc-dev+bounces-19475-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2540FFD5F6F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:30:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97m30GHz2ynf;
	Wed, 08 Apr 2026 14:29:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622564;
	cv=none; b=SbUao8sVk0O8YrDpaWqTN3wVj3UEjBxtCsec9UfO2YBgAsnM+n5to2WXC5Ic9vxbEQs7DmCBisvWxzsuY8A5UUwCNU1Z0ZSB2jafVi/fVoUbTQAJhyZtEIsC+Ziv+0pT/g8eY8DwlANod3YMgoyEqXYeyOy0HtHqkYlMHBb7DLdkSyXMfDjQ4/sZoRyCfTDmNT7n4iEvX2ULfxFrjFylRgQB59zLl6H4p7qy2PVV3wZrNw8ZoSTJCzjsTviiGndpOVfG7znP03ymGDXR/r1edtZhxWEdtLrtTFGo92cLzuMmEBDa0DAVfoj2sJDdgaEQJEk7Blb2lYeW9O5g9dV1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622564; c=relaxed/relaxed;
	bh=4L+XrbBn6aqxc/cZMugsZLvLOmOwBTXN0CqIuUBUUWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7Ls27lY3Jq6DXUxj+ionCXATOHoaE86cA+lUWz8TFwsu2U57umC2SbJsfyFp588cWPXM7yIxpqPbQnSMUCkyF0Oq3Y1CssNk2Jom1cW6y4KwX/29KyVnojSXxYuhXZuP4d2Dx2OEZFttF3umjHTRNxXC+dhr7Iy3DGthI2HQzwn+mZvdFveqE8CLppF9XxP0++pxPfHHVrcPdB5iUiRs1zQnTHqFEB+p6+SWeY76rrtF3Dh2haFGmiqe3aFXqm9+zDcVrIPWP22LCUc9xzzp8G9kPGPeB1pc7IXNiFY3VQisxwDL/M66cCE1ciQN2CnZ3xw2e6z6W2oPs7lX8Dt1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=drI/NMoi; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=drI/NMoi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97l5JQFz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:29:23 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EX9bd2302449;
	Wed, 8 Apr 2026 04:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4L+Xrb
	Bn6aqxc/cZMugsZLvLOmOwBTXN0CqIuUBUUWw=; b=drI/NMoi9vPKRui1yKlTwq
	QsyNLwbe5DFVzW9MdGbkNYq8oD3BykEGEJVFKlEk+DsoY7dUHrJitPhNlm1q2vLA
	YoVUParn3BcIpfM4aIDbeA4iHR/78WrZ/aNaV0cnrWqUGMLy4jb1+0NBH2/U+AWY
	6aHVP3RG2i81hvpuR9eWnNsOqAatQjbdztK0r+MLi+iNI0U5mpHF/7ZdmNIz9Q/d
	qTO4IYbQD6qowT5l1pGVEeKE+hce05FMlIiOqbMxJs/iavdDF2z1lIy1G1bOvXSn
	42hltRuQ80utg2uHvjSd50xgcZ339N9nu/oXWXmSSBvlYqtKyAqGApqfjWetbMrw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fe78w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63801V3G019113;
	Wed, 8 Apr 2026 04:29:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9e0c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384TCdY51708288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:29:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E784920049;
	Wed,  8 Apr 2026 04:29:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 007D120040;
	Wed,  8 Apr 2026 04:29:10 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:29:09 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>
Subject: Re: [PATCH v3 0/2] powerpc/crash: backup region offset update to eflcorehdr
Date: Wed,  8 Apr 2026 09:59:08 +0530
Message-ID: <177562236418.1381144.6606742361317067702.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312083051.1935737-1-sourabhjain@linux.ibm.com>
References: <20260312083051.1935737-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX2Yi3BiZ+fY/t
 5z9xZxlbenfF+S7rO4y25jVr3GyDM7YFJpNB5h416//AiSaBe10nC4oGKcuJ6Zq2smsy11a+9rr
 MRjvFpzhZLCkw2S0ejOfVwUmt3ljranbcQYz/VUHlmbv3VENYRtKgLX+vVIjaAwlYkpQPJaYQF3
 F1Tkid/ibrCTJr27wO8uJoKiA5Bgk5VcyAXzxkIG/q75sp63AfbMBl858gWHA7N+onvvRxaUloR
 f+FIRbeKIAsRA3G2TAoP372mUWiBBma7EAt7etFuTf5PWajn234OKyvKuMe/TXnUFurY9DCDCRF
 3d7/mVtDeCWRYVh6/MJSBPg5eY3wsBPnOQ+ZAxBeqEs3YMVt0l/HZ4MvyGc7VsDTacWjglu+VHa
 P4utBqEBgrSXgFHSRFhMhne6TDMtCnE5AKhrMOWH4zgEs2yOOSpBjwVv9B/sIQvFl96z8DzmYzR
 /vbAatsKjI7RPrZQJ0g==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d5d99c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=Gpftc5ZwerXyouRiEuwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CGSl4NHLfjRna6VEvg13fMSANvRitO7j
X-Proofpoint-GUID: iOtznQQaHeChczPB_hYR25ZEzHHQp9SL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Thu, 12 Mar 2026 14:00:48 +0530, Sourabh Jain wrote:
> On a kernel crash, purgatory copies the first 64 KB of the crashed
> kernel memory to the backup memory region reserved within crashkernel
> memory for the kdump kernel. This ensures that the capture kernel can
> use the first 64 KB of memory to place the exception vectors and other
> required data.
> 
> However, in the elfcorehdr prepared using the kexec_file_load syscall,
> or the one recreated during a memory hotplug event, the offset of the
> program header representing the first 64 KB of memory is set to 0,
> whereas it should point to the backup region.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/crash: fix backup region offset update to elfcorehdr
      https://git.kernel.org/powerpc/c/789335cacdf37da93bb7c70322dff8c7e82881df
[2/2] powerpc/crash: Update backup region offset in elfcorehdr on memory hotplug
      https://git.kernel.org/powerpc/c/f53b24d1fa263f56155213eabab734c18d884aff

cheers

