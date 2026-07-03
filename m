Return-Path: <linuxppc-dev+bounces-23460-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6603CC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 06:27:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs3hQ6QlJz2xdb;
	Fri, 03 Jul 2026 16:27:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783060054;
	cv=none; b=US1d2kvCVQUhwdIz7mSMUm3mguNfBoIEGTLQXRQL6zoYsoKDTSWjGUnY3/JlRyh+ctKMrC4Vw0F5GrcljGAhXJ4cMEyDL3jfFCCI8EJ5C9GwlLxGJXVtHetwipHR/R7RfBRwuRrTs1MvYQnQkmUy+z4kim3r3hxh847EBqS1jpOuPVgIEVBWYbWVOeJ949cTECiqDAPJCF0NS7+4ukpQZLJJdfeTbLmpLAs2ZpO2HXkPGAQQw6qcVQWCD/lW+BkPFQ7AX1fy3iVGG73vOmqDe8KKsM+7oDSRjiBmLw+fszABUY4rXnB77/ubNwNzgLE758v0tqV+GbiA0gFtUegAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783060054; c=relaxed/relaxed;
	bh=bzSJ5oINpFJ908+/DlXAb6mMKV/rQA7/s/nikIgFT8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GuH0NyOO37sBmow+cnTqC6KhWC+cqmMcxSPqjysD3OpXeSd/akIWnYTdLbT2lmb7mSsAsKzIRSvQDLnDuTryyhoCPsmA00ktGeMIJylFulX8eveH3bno+y0MKrduLB/CNzSnZaAGT2zdlEAsF1ykFQlfpKNYfAFtxKqLAoMEp5v/ikzjZHCYBM5l7NZRLZM+oYvqCg6Z/9wIwFHoF/0FhqtWSv8thxPVD7ujfxlkIDaZofXnDHYoMDng6wF4J5i1EaqXENSUiOu9dABgeAyGOCZzlUP//1RbHsrOlgcAV1xZHhhvB+tc+/mePdPbkHaacigp8I2cRMo7eUPCP2tNCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Pw6s5+Cm; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=svens@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Pw6s5+Cm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=svens@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs3hP6qt7z2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 16:27:33 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IOgf1930697;
	Fri, 3 Jul 2026 06:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=bzSJ5oINpFJ908+/DlXAb6mMKV/rQA
	7/s/nikIgFT8M=; b=Pw6s5+CmmFCb80gIoq6tsI0q0aCGJX6vTC9bDMoCWv8rCQ
	BQwT/k3RlVT5PB9oWiN3yIzwYfdrpmtzUdOduS56aevlvXaQj3i/71DPXlv5pAom
	jQa7qZgOiU2Snvpu77TNqHz2DYwzG7DqMhjcrK3gcsJTPvoSEa1M3WeZfwIc0zpb
	YvyPQWRATqXq60c7TJJAiUzJCyhIhkCsoFUFvxpJjsM2ey9v5BdeITB2p/3n6IBK
	E5eu6p2C164OppwPOcYhHC99iNQfPsu61NFaORG3G0fLEjM5YPMJqdA8z9mJ+xEr
	FzyiId6iEfjL9fio1XMXnvIrEBqQfpm84/TrO/KQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pedu3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:26:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6636JeVe018576;
	Fri, 3 Jul 2026 06:26:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wfmh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:26:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6636Qb3J10551638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 06:26:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9948E20040;
	Fri,  3 Jul 2026 06:26:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 196EF20043;
	Fri,  3 Jul 2026 06:26:37 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jul 2026 06:26:37 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andy Lutomirski
 <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
 <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        Mark
 Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jiaxun
 Yang <jiaxun.yang@flygoat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukesh Kumar Chaurasiya
 <mkchauras@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Zong
 Li <zong.li@sifive.com>,
        Nam Cao <namcao@linutronix.de>, Deepak Gupta
 <debug@rivosinc.com>,
        Lukas Gerlach <lukas.gerlach@cispa.de>,
        Rui Qi
 <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
In-Reply-To: <87h5mhnjsr.ffs@fw13>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
	<BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com> <87h5mhnjsr.ffs@fw13>
Date: Fri, 03 Jul 2026 08:26:36 +0200
Message-ID: <yt9dwlvca8rn.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: V512ICONGfIMzJeZgVibyqNOAgCIuMj8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX9npPGr21F1Qu
 IxrtK/vAbfCr/GjsGc0u2aK9/RjeRqQQxIqfLJKEbYS2rVdUgC0sRFh4WVLTWusnXUlzaONkVSv
 QpZLyXZQc1kKsiJGmHdrvgQ2beaxoYk=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a475624 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=CrRPdQPxwsYmpd-Ypb0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX6VwZUBxp6jeb
 YMK4Efb+Qc4f6HI3qRM6LEVMnYXnaV7F2JIWD9cC8n/1Ua0yROt/ntMjQ7JjawRqYb2UhuJEhIf
 kwff4gdG3VgvqVsSfAcTszHO1TVWNO8+/UxgPZ8zWhBBCttRy2m+q4SNKXaJq7tBN1MSLpUj8M0
 7W4FP1ssOGWe8L+/ua2YzHBud8HlGnMOWBzHt+GDxv3KTwfzuHqZ/kVo2rwvOV731TLu1Jpnt1e
 jWK2FjpN2ieAhYzNCHjrSOUjUqKO+qMBIEW8xL1CXx73aSSAQCNyNVpp6dCu6gaRnOJzPqT0ZfH
 sGkwpzfIYoBDH9tmtUWbOrSgC3Ic5tyrmNxrdnyp6ONquF4Srhz07xLlirUJImU90/i7eUG1W0K
 JAD4aY7gp37lGzleaK0YwCjHEWTB4OpcPGWdlh1FKYX5CIhKuawlelq8rIa7CO8kac5pdLoBC65
 sK8KQichxzL7mL8vqcQ==
X-Proofpoint-ORIG-GUID: 48DwgYVDq6x5ccTjcsfSLPConSUTJzSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030058

Thomas Gleixner <tglx@kernel.org> writes:

> If seccomp overwrites regs->eax and aborts any syscall (including -1) by
> returning -1, then the value seccomp wrote into regs->eax is preserved
> and returned to user space.
>
> The same applies for syscall_user_dispatch() and ptrace...() if they
> decide to overwrite regs->eax _and_ abort the syscall by letting
> syscall_enter_from_user_mode() return -1.
>
> trace_syscall_enter() is not any different. If the magic BPF in there
> rewrites the syscall number to -1 then either the original -ENOSYS or
> the BPF induced overwrite is returned to user space.
>
> It's less than obvious and I have no objections to clean that up and
> make it more intuitive, but I still fail to see what Michal is actually
> trying to solve and what the magic flag is for. If s390 requires it,
> then that's an s390 problem, but definitely x86 does not.

The difference between x86 and s390 is that on s390, regs->gprs[2] is
used for both the syscall number and the syscall return value.
That was a design mistake early in the begin about 25 years ago, but
it's ABI now, so it cannot be changed.

When seccomp decides to skip a syscall, it write a return value into
regs->gprs[2]. When syscall_enter_from_user_mode_work() returns, it
returns this number. If it's negative all is good - the 'if (likely(nr <
NR_syscalls))' conditiion would just catch it and skip the syscall.

But if it's a positive number, the code cannot distinguish whether
that's a return value or a syscall number.

So I introduced PIF_SYSCALL_RET_SET when converting s390 to generic
entry. This flag tells the syscall code that a return value was set in
ptregs and the syscall should be skipped.

I'd like to see something like the change from Michal going in - cleaned
up of course. It would allow us to get rid of PIF_SYSCALL_RET_SET.

