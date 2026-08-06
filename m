Return-Path: <linuxppc-dev+bounces-25469-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE171C55838
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 04:53:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFvzw6YY7z2yPR;
	Thu, 06 Aug 2026 14:53:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785991996;
	cv=none; b=gnuBbre0FzOrhMEc0qGPCQybpSH5nMvbsqBZHWdQVMj5iP6TGKAvM/HlJe572+GeGUEMYezYuiBPoLY2IRvDged9zQdJJBmVyU9qqTOec3YXavpn7kh5YblsBwugImnmIPAXVNSx+0NC8taJpQpTML23iVKYFgeZYJoAeA240+9kant8z3RGYv9BnpN82l+YbgtfBo/LfdF3VhWfBE0q+gexYsKyKtxXi8WO5MuUIVIcTp2SJ1hoh+Ohtmgown6ECD+LrxkScc+xTuwcvPbdjVZavfDYawhQP/4D4CRuk9+WMFHP77g/n8pn/e15y1Q0ub7gkaZw1KafSIfsaCcWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785991996; c=relaxed/relaxed;
	bh=NdHNokS4Pc91yn7uZpHvAl29Hn2vGvZO2V87ucLoJ54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXVWLZFTW+dIh8/ZZSqzrXPFwJ4VDIPOYwN4InTp67mJj337D3oQ1RqW5bl47KSuHiwp0L24Ie3oSRsSfFFX2VesY8PfBXI/vJIQake82zGmMkbhH2Mvc3CGcpN4YPBfbq4NM2n7xSRjwN7jPYI0vZrKHDo/ESCK/Y+WQnUnWrMqeuJyxiXnfH6AJ1K0B6KAy30WoaVFi6fDlpugtUC6q+D2ZlgGPQLSo3GDWUmh6dDduhReHmi5FeCH8qsOJx4Mq6kqo8Sgr7vWcOLCI84n+4ugt5LLI776wvDrbfkAhMUPveEVFddqtQT88lXDT2Fa4OHb6fwydvWwRWXzIgI3BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DQaCxrRy; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DQaCxrRy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFvzw0Wvgz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 14:53:15 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NmJpb994808;
	Thu, 6 Aug 2026 04:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NdHNok
	S4Pc91yn7uZpHvAl29Hn2vGvZO2V87ucLoJ54=; b=DQaCxrRy1Ljen24lkkZTZh
	MX92xuCMTEZSLomjCzjIh2mWVjk1la2JNrumvFK/2YVcHjz9ORxREqVIf+SEdNoQ
	um3PKLfNYe1+bB+uEP6FEFFlmuz9WfSfqyhqt6GXecFd7yOHTzi218ZEvyjE+y5C
	TWHkAv+lQenp4gHO5tj6tvl6r9+STFtFZ/ZS1hQRZpjXJWcLDr1yQ1mTP5yD6K0L
	rQ9qxHJwOZMkZ+rFgNRJH9sJRVTRU43MYOgI01XLspKbj08lt/1z6+V1Hpm5FPy+
	Wj/Gxe8fVX6aDG59KqDasd30fbMdt40wJCB0P7Yj4GyWTL/jGTZuE0VBD4TnKFiw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hx131-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6763uGuh017617;
	Thu, 6 Aug 2026 04:16:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbghd9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6764GQcR46137836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 04:16:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC71E20049;
	Thu,  6 Aug 2026 04:16:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A522920040;
	Thu,  6 Aug 2026 04:16:23 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 04:16:23 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        mchauras@linux.ibm.com, msuchanek@suse.de, sshegde@linux.ibm.com,
        david@kernel.org, thuth@redhat.com, agordeev@linux.ibm.com,
        mark.rutland@arm.com, ruanjinjie@huawei.com, ryan.roberts@arm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: Re: [PATCH V6] powerpc/syscall: Fix syscall skip handling for seccomp and ptrace
Date: Thu,  6 Aug 2026 09:46:22 +0530
Message-ID: <178598971874.942627.7409142497641761431.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731081521.1852133-1-mkchauras@gmail.com>
References: <20260731081521.1852133-1-mkchauras@gmail.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX2TZbWJ4H5CoS
 W2RVa+LEq1HVUk3Hosh1l5SyuEP2mfLHoS5p2cxsl7v5+HVKk34b3YLYYQiW7pGX9zADwZclIWS
 cBDTEXfojynMcjpRUIvYCMPXoaoEbLQ=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a740aa0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=-_iW5eXQ-KMzy3zx3P0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX5zD5vgWuVLKw
 O6On3xGlH6AQn8rlR8yCegFgMjUwrea9mceSuVff2pQdVBDiyGHvCQTFz7kgI/KpMWn+sph8EYg
 SAjy8YWLygUkTOulXp/J+ABTsaU8UB9iYmlugL6HUUy8XQ91Ak3OajJh4N4NHmQcPSI0Dp3MBGi
 EADQVcvalvSOr3dQhG2s6OFOgaKlYO/yzCNU137cUp0zoQVXFhCp31BMTeinVunGI1E0/HybVo+
 ziHrtu/H1+KAYFBNcbyAgmzUYoFqZ/NElRNu1JWxUVfOW61oBB5xn0Acc4FFLSYE/0vcv9eFLt6
 QDPdaoSyau4gtCGwwmurCfMSnIv2+Vj2ZVkihTFxpPvBFMidKVa/d5u0mIHL76tZ+oMR5LJOm+t
 yXxQTOsTuGJaCvhj42F+FVPGyDjtAF39QZKs4EjvIBLLpX1yrhxYDuvu1m6WPszjVPAsm3Kgwfp
 8MAmgGsx56eTmvzhQrQ==
X-Proofpoint-ORIG-GUID: mRM5pqkHG7QuiLj8P2UQop-8OKEwEJq8
X-Proofpoint-GUID: dg0sfg-lZHYOM7YkynkT148DqFtLnSfr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060025

On Fri, 31 Jul 2026 13:45:21 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> After enabling GENERIC_ENTRY on PowerPC, syscall_enter_from_user_mode()
> returns -1 as a sentinel to signal that seccomp or ptrace has intercepted
> the syscall and already set a return value via syscall_set_return_value().
> system_call_exception() was not handling this sentinel, and since -1UL
> is >= NR_syscalls, the code fell into the out-of-range path and returned
> -ENOSYS, overwriting the errno already placed in regs->gpr[3].
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/syscall: Fix syscall skip handling for seccomp and ptrace
      https://git.kernel.org/powerpc/c/69cb2be898be6d5826cacd1a628f6945a24480b6

cheers

