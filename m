Return-Path: <linuxppc-dev+bounces-19459-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F48FD5F6E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:28:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr96p2fWnz2xm5;
	Wed, 08 Apr 2026 14:28:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622514;
	cv=none; b=a16D5qyPcTl+au/8Pu0qhTwRneq1KglaWXEvxSrQTZPCho3cZkSlAzSdAb0W1qKh4c81g1YEaKOEZT66K/HX5KS/djmpjTjgWUf8p71Q4al8PerB0O6rjviNqyuXeb0dNAAeE+fgX8kgAZy6tWRKS33Dgl2gsLqYhLuIjTB1qjm0TdvXCQr/XQeWvCo0Gw563SxtF6lj1lmHzZaTllKEMSsaXstO3NdACN8i3xBPQsJUWnn5P/aCRcKZtttP3SSOhTQ3Z3X0WO9Qw4RFEEIC214J1fD/hDN/3bG1lsap07eb0qvSMSBpxBpbKOpZ7ZKW3UWvF2wFZ9Y42xHVbxUbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622514; c=relaxed/relaxed;
	bh=ZxEyyIiUKlF2uKzBSygpWfE4G67uUHpTtCxu0vo+q2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DopeNzAKQZwJ6FtP91pJIFYjPFYBNWJW2vou+h02yD1c4TRGJiFFyz0KJ7BaC+UhxrrfppVVwIybDf9Lo4KJ6QPpF68Tb01o9SnolvzFlw+sDS9ybaKJbH4N9VF4NtQsG0yAIKUEPUUMDcRpg9Oa+TpbAY/YRVugKBW2MTysDRpdDNxcVZurS8crPwwGYZakY1tz93zLVI9w2DPrtEon8xB60h2jZE0QpfmIv7uM7nwz9F66BCL4R9krY0MnfF4CV1XHoGygWJGocPC3t50sRtxgC6sdNlh8gXDuyzAlsvh5eZ3GhVhpBzdHtgv43veeUI9C79TfypIjadpuE33Y1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D94Ng21I; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D94Ng21I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr96n3Nb5z2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:28:33 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EC5Jn2212549;
	Wed, 8 Apr 2026 04:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZxEyyI
	iUKlF2uKzBSygpWfE4G67uUHpTtCxu0vo+q2w=; b=D94Ng21IQPCxyuKiB1ohOx
	Iy2Aaf7zRGRtU5+beiwnegDv5MkdNlLDgojZ31G2Ds/CC+/nSxPqF7M7AfCcKY/D
	2fGLl1VUw258SEd5gtMUXGN1KzBc9+d+X+dl2j3dJ815mfIbqwpWYKNxFVhhF3BD
	KWkPhbqoD+U7qj5yYQya0FrbdK7WzwTFtloUizXVFIwkfvm4/HqOvuOdSISIrY8J
	6zx2k1ili74v6Gqmy+usD8aGz0zifF2fMdwv3w398WL20r0tMqCMu6KpNccRtZtw
	mZtIXInU+/Bg/fzpbqlukqvUvl7inh6esmcQMwsafLhdrOBnI459NKpvCPH9B4Pg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hdqv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637NRX6B018952;
	Wed, 8 Apr 2026 04:28:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9e09p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SDDn48497076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A946E20043;
	Wed,  8 Apr 2026 04:28:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D75D20040;
	Wed,  8 Apr 2026 04:28:11 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:11 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, adubey@linux.ibm.com
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] powerpc64/bpf: Implement fsession support
Date: Wed,  8 Apr 2026 09:58:10 +0530
Message-ID: <177562236435.1381144.2477911890156878591.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401141043.41513-1-adubey@linux.ibm.com>
References: <20260401141043.41513-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX2o3VLv7zpn8w
 JIWAtud13ReQnPnM13nazLMKJIDIuPyTq83rcSDvaL17149WebGpCfgG6ncWZCYlmSYpA9AyeXx
 wKrrAMZDjjGfQCJkPcxFR8WYhYjHWnV2MvAf9ajYgo9w5lUL0wPUFbsONPEAQQuX4ythRUzHjmT
 Z7pHkVyPg1Vg2GDFV8WqjKyFT+D7JcvS9PeHpIe3rgqF0m+RkM6ifZhtDhryzW8fHBmAaGUTxus
 QinjZ47BKZHdCsPOH3aYDtsHBERiikxrzbpp3A85V9pA74VGEmwUeNbmLj+/G9CTBXdkV+fWEQn
 lytq/LYnexDpVNC0TsWwGfHZNxxpy5FwmZwRrr2Z8cYkiS85xNE7M4nSBmIFiN4ulJIWlQkwLce
 PeCtoV/v7qmJbdccLVrjyhQVT2HPUn0aVzBDssONP9+jTfzA3L3NR8aYG9L++Q1KZ7ZtHrJi3jj
 QbZiwxr0WLQmg9TMrvw==
X-Proofpoint-GUID: oBhpRDp3BGBSfHFnCDyzvH08OylGBcwk
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d5d962 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=dDFj2F6xnHxliyz7cEQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oBhpRDp3BGBSfHFnCDyzvH08OylGBcwk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Wed, 01 Apr 2026 10:10:42 -0400, adubey@linux.ibm.com wrote:
> Implement JIT support for fsession in powerpc64 trampoline.
> The trampoline stack now accommodate session cookies and
> function metadata in place of function argument. fentry/fexit
> programs consume corresponding function metadata. This mirrors
> existing x86 behavior and enable session cookies on powerpc64.
> 
> # ./test_progs -t fsession
> #135/1   fsession_test/fsession_test:OK
> #135/2   fsession_test/fsession_reattach:OK
> #135/3   fsession_test/fsession_cookie:OK
> #135     fsession_test:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc64/bpf: Implement fsession support
      https://git.kernel.org/powerpc/c/6fab063bd8d64f15cde2d194c08a159ad3afdf27
[2/2] powerpc32/bpf: Add fsession support
      https://git.kernel.org/powerpc/c/92258b5bf1ec10204c23a793793a65dc92d17014

cheers

