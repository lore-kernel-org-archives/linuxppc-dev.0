Return-Path: <linuxppc-dev+bounces-26365-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05021C624C6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 09:17:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ0cs6xh0z2xGt;
	Tue, 01 Sep 2026 19:17:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788254253;
	cv=none; b=mj4itEARJ/yIrd31ttBzpgRXohG1ewjz9UT+cz+Pd4ynKkqIaK1n2r7oBdcLKYPtq07sAkn0dkVAAHqTz0FmNgi2DJ8dVehes+CJst+mR4Bfual5oI9Rn78Q2VsgOh3/8tKZe6ADAkXRGpIpc7zxVqFp6yT4usjSL0+385m+XMzv3nf0W9lMSdi53xh9VZ6xro20Tc5JchnDdGdwXDQxn6Zl414OY0PPPd7CDphVzDMa1TlYXND9cs9U6ojivqdAnp1F1+XnnfpbwP5UU5Sq+2pcbiqSiG9yX3nSahVXfKaAWruqnqa6h6yzmEvp9Xl8eaqEHI/Ug2LHYj/tv55q7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788254253; c=relaxed/relaxed;
	bh=xUuGoLCE+8fDfjHh5FczwjvzJVI36XWP0rFIy82Uyok=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=S3wb6QZn9cCsPm3zcbLdkpPOZh6fHpDwksIkJRQW6bK1UidGIcVJjbZzctPKh+3OOSt3YCgdVBIajqTF27z7QXuNDpulbVmVqiBVDZpVcT9mN/hWJT4+FF7T3LTJOxyF1O4kh4sAk1fTl84+/P/hdUz/5KQBsRbst0BaylNx6Xy++fFTVqk3FYvLTffaFaeUXshgynNq8w/WoIENIXiRUGWPhhui/jciiGb3Y9e7tNc5GS8t+Dfef8qhA6bWR+gg/4OmDkjsHuWXwxnW6c8/ECRpgedC7hjeo37cFDElfYVp8a1KXwdm43Vn5HjG5he8pKOwBtlgQ2aG/3mkYwkv/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kJlX3wTQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kJlX3wTQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ0cr5vjDz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 19:17:32 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6817Vdqn3635859;
	Tue, 1 Sep 2026 09:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xUuGoL
	CE+8fDfjHh5FczwjvzJVI36XWP0rFIy82Uyok=; b=kJlX3wTQcbdgBm+MqPXlC/
	1EIVC2rQ3xxUUNpz4YDCS6eDLEFcM9R6wsBaNaCL6LGgQRiMYBK5qIFZ28HuB8aP
	a+OeXnE6B/H/5B5tl/vV1qH0ZdJYOsXb1mSuGyLYuBFvShWtEGybe7HkrhmcNfHm
	dJKSmGqfchy2+XYp2m5PXpOAM5wdOE9cdh5IbRB5WgdbRzgciF1BSSRqsxwh8iJL
	K00CUnu2uq5lzgVkzLpvYDhCBZKdbXk3R5R6KjBKd/59FvvNd4SNxGFH7CXnngdl
	Hh5NtuBuqohVGqJiO9sWG2S9+mciitX8NBk9jTJWnqar12air0ZZIwGPTF1m4U1Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudpqq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 09:17:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6819BGbK028057;
	Tue, 1 Sep 2026 09:17:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccey2n5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 09:17:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6819HP4K1377006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 09:17:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 374EF58052;
	Tue,  1 Sep 2026 09:17:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C754458056;
	Tue,  1 Sep 2026 09:17:22 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.9.83])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Sep 2026 09:17:22 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] powerpc/entry: Clear TIF_SYSCALL_RET before syscall error
 return
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260828053811.1042300-1-sshegde@linux.ibm.com>
Date: Tue, 1 Sep 2026 14:47:10 +0530
Cc: tglx@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, chleroy@kernel.org, sbhat@linux.ibm.com,
        mkchauras@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <51BB4B46-5227-4FE6-A368-A05E45CA4915@linux.ibm.com>
References: <20260828053811.1042300-1-sshegde@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: v7kA_hfiVqwZZueVb-2Av2MN1UpneIZ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4MCBTYWx0ZWRfXxgo11J9td64p
 xwQ85WOSAFWgbz3P258pYKaymgxOGjIahzKvxMKeAxVArVKV4B+g6cnIpYOEUzPECouPD4+Lvna
 FT4Ll9+4totAcrQ3YQN/KHYdsrISqAHBcBVQtFvLkCimmgMf0mRQWQ9+qMtgB87Ub7YCcVNXd9K
 56jkqGNTvOd796pzU4IwDr7hnvsFCbexc9Yn/fAgVJ9xfyz6MqhyCiBNe9gBBJ6vkElElL2oAKm
 a+z9ladbu7n2Hr5QfCLPj87cBBAU0ILHzMHCjyTJt4c+TL/zjLmMCNr9U04ggRqfgzNEglzoQ8m
 Zdx/hdEk+p4aNiTGbVRAHBUHwMsFYTOzSpHJG+ND/z6o3HDz6o4Wp9S1YG1r9HIJgJwbqN8ki6y
 8kcoThj0fSwKVgGcYAKXjGPefj3ApKUhIGX656SA9bAFPN6oEQEMHPnBAgyeaz+BNaoPBbdiA/5
 6f68MpfGrSliZ95coww==
X-Proofpoint-ORIG-GUID: 0OnnASqNBx2GEwqB5pYim-XRWPOggbg3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4MCBTYWx0ZWRfX0D8oKDWmy931
 YkV/VChb5SvWyyN+tZd9h+L6HMT3Clp5fkhBqHomyXIy2TDwc79pKwZYNzqJSwZziO57esidXM0
 OEJpThLrZ1KQBGG71nyc7irYC59aDm0=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a969828 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jdSCQhKvPWLdp4stf3gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010080



> On 28 Aug 2026, at 11:08=E2=80=AFAM, Shrikanth Hegde =
<sshegde@linux.ibm.com> wrote:
>=20
> Shivaprasad reported a boot failure due to userspace processes crash =
on
> abort() from libc.so.6. It was bisected to merge request
> commit '3424d8c18a7d ("Merge tag  'core-entry-2026-08-17' of=20
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")'
>=20
> Upon checking the merge, when =
syscall_enter_from_user_mode_randomize_stack
> fails, which could happen when a tracer like seccomp or ptrace =
intercepts
> and skips the syscall, the code returns to userspace immediately =
without
> clearing the intermediate flag which was set.
>=20
> When the next syscall is made, it immediately aborts the valid syscall
> since the flag is still set. Hence clear the flag on occurrence of =
first
> failure.
>=20
> Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Closes: =
https://lore.kernel.org/all/e301014d-568f-4ed5-bc64-b8a85ca0b1e1@linux.ibm=
.com/
> Fixes: 3424d8c18a7d ("Merge tag 'core-entry-2026-08-17' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.
> PS: I have kept the block below since earlier code was checking it
> regardless of result of syscall_enter_from_user_mode. If it turns out
> to be a redundant, it can be removed later.
>=20
> arch/powerpc/kernel/syscall.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/syscall.c =
b/arch/powerpc/kernel/syscall.c
> index 4916c205c4bb..fbefe1927b10 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -18,8 +18,10 @@ notrace long system_call_exception(struct pt_regs =
*regs, unsigned long r0)
> long ret;
> syscall_fn f;
>=20
> - if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, =
&r0)))
> + if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, =
&r0))) {
> + clear_thread_flag(TIF_SYSCALL_RET);
> return syscall_get_error(current, regs);
> + }
>=20
> if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
> return syscall_get_error(current, regs);
> --=20
> 2.47.3
>=20


