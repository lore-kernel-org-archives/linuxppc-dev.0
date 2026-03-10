Return-Path: <linuxppc-dev+bounces-17942-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB19CFCC9CB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 06:31:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVPDN0KBCz3bjb;
	Tue, 10 Mar 2026 17:31:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773124307;
	cv=none; b=gSYo4Q7XjTbWwWw10tvbkepokBbvjJB+u1o1aIylgsgPa6SpfrGDnJI3EBO+SC904ITJGTcUkZUZAhOrwjkMkNNemeJHmTdjrQTYtTk32+yCwVm4NVvhcZtHOYqTwsqfjki3nAK5INBrTaMuQqcInefFyvRchT8Lqe/L9Jqfm3QrFVVPEUXd7XN7WmS+l+yCgjB8JV38Mn1VVAnXeqbF+Br5VFegxITHN/lJoxMmdyuD4WEc+Iw5IqB2jGLz63qpd4ObXLRk2mmlPje80YphEtC/eYhuq0002DYZq02vyoqyuzg70lKp7rVErpFCmBMX2FMgqccup6UzYyebQHkcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773124307; c=relaxed/relaxed;
	bh=SaErOJOOx+i+eT48z2MnE0DrXZVxkhdRgynwobO8tXY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iUnEpWT/yokwsuV+KT/HtDbq9AStTO50s76zbE0G7OJwGK5l4ApDc7wV6Z1HFq6tej4PWzyDVVbuo3d6uJqX73lUE0MEb3IX57PHGnd9Y+4YjlbTrOuaAhtg/GIkGaBrsVx9sl/nKzwRy/KPAoPyhuvsmhUB/tTQWisY02j1i9SDCJORTKIqNN3OXO65g+L+n1xCBxCKk44UHQDyxIVXR1+1YeBo27fdLyTiGjbATlKoTknMGCZShvzMdnSALWMwJCR59M79oYzYqfQhlaqNleQUp/cFYVo/xugX6MMq/BCJyWX7i9/7b2cI5q0dX/zWezEkmXmQc9P9TjKXAq4tOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H0KotnfQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H0KotnfQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVPDM0yW0z2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 17:31:46 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629FJsqQ1262800;
	Tue, 10 Mar 2026 06:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SaErOJ
	OOx+i+eT48z2MnE0DrXZVxkhdRgynwobO8tXY=; b=H0KotnfQa8FWSPxo8oYgbT
	X4RVQFmvGC4wrMXo2vfkvAC1XQtSeHjIXYNrt2YIyGDrwXwoEuQxot/37l6O9+Li
	Df/q9WPGntNuI8JaUIIGQyY+suHRNftg9aZE7ttQ95P39ab1gOVYiExEFeuLrPwV
	SF9HNwYcCX0OJwILaDMletNwX266bI5xMTcTPUvjocQrgXD/K4f+PAg8VBRqWKUu
	+3I0PxSiAkm19S4gGNZXIBoqFFWxCoCfabv3BcmxXxAfL8kojree7kSUr7HGqeSz
	8XamwwRTtd8mw6mGgSWk+NXo3nx7ao2+W8NNPzsSemz03QJRP9gjtDnXCnXnmdsQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun9cx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 06:30:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62A56mw1021168;
	Tue, 10 Mar 2026 06:30:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsr3ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 06:30:48 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62A6UkPb27001350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 06:30:47 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB73058060;
	Tue, 10 Mar 2026 06:30:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B4F458051;
	Tue, 10 Mar 2026 06:30:43 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.98.109.174])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 06:30:43 +0000 (GMT)
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2] powerpc, perf: Check that current->mm is alive before
 getting user callchain
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <aa71fOBjQwvCFFNq@linux.ibm.com>
Date: Tue, 10 Mar 2026 12:00:31 +0530
Cc: Viktor Malik <vmalik@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8560AA7-E351-49B6-AD7E-1E65C901D806@linux.ibm.com>
References: <20260309144045.169427-1-vmalik@redhat.com>
 <aa71fOBjQwvCFFNq@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Viktor Malik <vmalik@redhat.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: k_IHO-GGdi6Y5h5NLU1_6rgR5OzdJV6T
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69afba9a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=FTemPexENOiiN3R5Jr8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA0OCBTYWx0ZWRfX3RqwDW+CP43K
 DcXOAus0tRXU3vg5MF9Aw4Bc2A1vfY2gJptZN1A4+E+DH3njJ/PWmTS9sHupl7U9fZujTWEUTft
 W1z9CLPZhwApQOCsRUDIm9u/8tP1YrndJEAgABi1U57H9uS6hmh0ievfDpdPY5ai2k07m/Wq/8R
 23o3T1rEwhLa2+/fHIS8UX/95PccrPBvJvlWejOhzqZinkr4nJmjRf4r3O3In9fqT+DOX9C1iJT
 uBDks+8qtSvo7C/MfOtKaQzzJ4n/omFzATFeoqu4f3aKWFgNla/gtNpHMupKkBj43lEyCpQRQqy
 QfxBrj7trpFQwXmdHqmXj0Tnd4V2K6mwTx1wTu1rnvK7Lg0df6RtyXtPboeYtdGwiQl6JWa72qb
 XhSMnh1XzSNUDtbELpYOLwkVj2WDNyuTASK+gIGJ9GovV23q6NG8BK1LMIaLoJHiLB0LW8t9Z4n
 AsibeIJP8oyZddIf8Ww==
X-Proofpoint-ORIG-GUID: twKloH2qB9W8EqoRy6abojGwRbwrdKE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100048



> On 9 Mar 2026, at 9:59=E2=80=AFPM, Saket Kumar Bhaskar =
<skb99@linux.ibm.com> wrote:
>=20
> On Mon, Mar 09, 2026 at 03:40:45PM +0100, Viktor Malik wrote:
>> It may happen that mm is already released, which leads to kernel =
panic.
>> This adds the NULL check for current->mm, similarly to 20afc60f892d
>> ("x86, perf: Check that current->mm is alive before getting user
>> callchain").
>>=20
>> I was getting this panic when running a profiling BPF program
>> (profile.py from bcc-tools):
>>=20
>>    [26215.051935] Kernel attempted to read user page (588) - exploit =
attempt? (uid: 0)
>>    [26215.051950] BUG: Kernel NULL pointer dereference on read at =
0x00000588
>>    [26215.051952] Faulting instruction address: 0xc00000000020fac0
>>    [26215.051957] Oops: Kernel access of bad area, sig: 11 [#1]
>>    [...]
>>    [26215.052049] Call Trace:
>>    [26215.052050] [c000000061da6d30] [c00000000020fc10] =
perf_callchain_user_64+0x2d0/0x490 (unreliable)
>>    [26215.052054] [c000000061da6dc0] [c00000000020f92c] =
perf_callchain_user+0x1c/0x30
>>    [26215.052057] [c000000061da6de0] [c0000000005ab2a0] =
get_perf_callchain+0x100/0x360
>>    [26215.052063] [c000000061da6e70] [c000000000573bc8] =
bpf_get_stackid+0x88/0xf0
>>    [26215.052067] [c000000061da6ea0] [c008000000042258] =
bpf_prog_16d4ab9ab662f669_do_perf_event+0xf8/0x274
>>    [...]
>>=20
>> In addition, move storing the top-level stack entry to generic
>> perf_callchain_user to make sure the top-evel entry is always =
captured,
>> even if current->mm is NULL.
>>=20
>> Fixes: 20002ded4d93 ("perf_counter: powerpc: Add callchain support")
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

This patch fixes, reported issue.

Regards,
Venkat.
>> Changes in v2:
>> - Move call to perf_callchain_store() for the top-level stack entry =
to
>>  common perf_callchain_user (Saket)
>>=20
>> arch/powerpc/perf/callchain.c    | 5 +++++
>> arch/powerpc/perf/callchain_32.c | 1 -
>> arch/powerpc/perf/callchain_64.c | 1 -
>> 3 files changed, 5 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/powerpc/perf/callchain.c =
b/arch/powerpc/perf/callchain.c
>> index 26aa26482c9a..992cc5c98214 100644
>> --- a/arch/powerpc/perf/callchain.c
>> +++ b/arch/powerpc/perf/callchain.c
>> @@ -103,6 +103,11 @@ perf_callchain_kernel(struct =
perf_callchain_entry_ctx *entry, struct pt_regs *re
>> void
>> perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct =
pt_regs *regs)
>> {
>> + perf_callchain_store(entry, perf_arch_instruction_pointer(regs));
>> +
>> + if (!current->mm)
>> + return;
>> +
>> if (!is_32bit_task())
>> perf_callchain_user_64(entry, regs);
>> else
>> diff --git a/arch/powerpc/perf/callchain_32.c =
b/arch/powerpc/perf/callchain_32.c
>> index ddcc2d8aa64a..0de21c5d272c 100644
>> --- a/arch/powerpc/perf/callchain_32.c
>> +++ b/arch/powerpc/perf/callchain_32.c
>> @@ -142,7 +142,6 @@ void perf_callchain_user_32(struct =
perf_callchain_entry_ctx *entry,
>> next_ip =3D perf_arch_instruction_pointer(regs);
>> lr =3D regs->link;
>> sp =3D regs->gpr[1];
>> - perf_callchain_store(entry, next_ip);
>>=20
>> while (entry->nr < entry->max_stack) {
>> fp =3D (unsigned int __user *) (unsigned long) sp;
>> diff --git a/arch/powerpc/perf/callchain_64.c =
b/arch/powerpc/perf/callchain_64.c
>> index 115d1c105e8a..30fb61c5f0cb 100644
>> --- a/arch/powerpc/perf/callchain_64.c
>> +++ b/arch/powerpc/perf/callchain_64.c
>> @@ -77,7 +77,6 @@ void perf_callchain_user_64(struct =
perf_callchain_entry_ctx *entry,
>> next_ip =3D perf_arch_instruction_pointer(regs);
>> lr =3D regs->link;
>> sp =3D regs->gpr[1];
>> - perf_callchain_store(entry, next_ip);
>>=20
>> while (entry->nr < entry->max_stack) {
>> fp =3D (unsigned long __user *) sp;
>> --=20
>> 2.53.0
> LGTM, feel free to add below tag:
> Reviewed-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
>>=20


