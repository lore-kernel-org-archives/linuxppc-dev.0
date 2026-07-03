Return-Path: <linuxppc-dev+bounces-23499-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AFBC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 11:40:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsBd91gcwz2xdb;
	Fri, 03 Jul 2026 21:40:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783078813;
	cv=none; b=iDdL2P0aMvIeuj9nz7wPKoB1288Ku1vDeFQfQNiUUkqc/WFhfvfjShNTaDrE+i08n+uag0nezf4qYAu36gEY1erLr3SgYVUGLQ0rGhYFme8KfI9ea3A0S/r0snrDJEmDpdnM97qfsYGUEW91qcWek0EE3HB+v3DVv7zVgl2Rk8CIDO7gQgRQIGfgMZfZ5LB45jm6qEaueieBWLuA/ZsuOa5XM/sbviMvEK++oXiv8G1ad9zPl+VzF9g2yWIB09i3Rk0xY0w8y+R4Qn5NuxJxgs9EZgxihn1IroWjCAXhrBSevoWCAOm2PDufm4HUIuuPT6POixrjmbiAu8YJZOBy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783078813; c=relaxed/relaxed;
	bh=oF3oIUV+LKz0emUew5qxSHFBM4G51YQMA7zouIB8abk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YGKkAIYoiNqxUIMVgHzPZXIZcRLHC+BWR4rSxwtW6vjur878iGCd0O5Yapq2s8nq3Yul+aFPpfvZ+iFNXuXMn0Hr2kDPJhE9MeDEW4uuHEfP8sFQSWEQRcHcppo52oZt5DTfClfqXf5FPBB+ot+eYlerEEL5rEpanhCbclkoAtmDlYBT6+BuVjrj4LrFJ+KAA5kgC2ah6Q6yjy1XsaruYfQxjR3s764CTSJpbxkbAk0R+PVRlUQGVxdthTOhKGfKfwvgIcVW5zb7hEjobgGFC9So9PRuEHG/5yvTu1ji8bZScKhSpfSl15F4hXumCRr+xrdwn5Ku6HZTmAKqYX5Llg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VXVUBoyp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=svens@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VXVUBoyp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=svens@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsBd80QqVz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 21:40:11 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636ITbX1761163;
	Fri, 3 Jul 2026 11:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oF3oIU
	V+LKz0emUew5qxSHFBM4G51YQMA7zouIB8abk=; b=VXVUBoyppp/UHI5Y4PknK/
	64pw1LEU//x+soMgCRCdX4EdRm1zU4BCz8O9WW4oNRLNu5JhDcy4EBLyBm/6FrOQ
	hqGOcwUP7gl/7Sj9txOvVGDP8jQ9qbjCNjUToJILQOuNpLHDRC8DEuwqJjn5Bsbk
	jf3l63BG5cKpkTLnfzlDDlALQjJJoBf+gKHNlL4ClS0BXrHUc4dnXahOQIQvzOE2
	RnjFerav6HoB22z55ZqFWCNMvqeWu1Ub2Lv9DtcEBi0qc+6pcdgn8D9isf+11H2I
	9r8JlXCZvNiYvmLVs1eyz9jM/CbzeXd+fEHg62Ub1+lS6+670BWFEDmq6/u/L6Ow
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk6hfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 11:39:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663BYsLL011332;
	Fri, 3 Jul 2026 11:39:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2grf4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 11:39:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 663BdJ1R49021346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 11:39:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45EAF20040;
	Fri,  3 Jul 2026 11:39:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC89120043;
	Fri,  3 Jul 2026 11:39:18 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jul 2026 11:39:18 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet
 <corbet@lwn.net>,
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
In-Reply-To: <akecJWAJP-e5CYP_@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
	<BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com> <87h5mhnjsr.ffs@fw13>
	<yt9dwlvca8rn.fsf@linux.ibm.com> <87ldbsmnie.ffs@fw13>
	<yt9d5x2w5r84.fsf@linux.ibm.com>
	<20260703105718.GO751831@noisy.programming.kicks-ass.net>
	<akecJWAJP-e5CYP_@kunlun.suse.cz>
Date: Fri, 03 Jul 2026 13:39:18 +0200
Message-ID: <yt9dtsqg480p.fsf@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDExMCBTYWx0ZWRfX9A1mR90iQ9fU
 Jnq5F39WZRpZmJZJo+YsMXBKsZBl5gTM0jj9mCML5R/Bd24LYkLFgakI/FJBKEk/4h15P+huPhT
 Qt4x0X5evHrib3jUNImZ7xP5zALzpi3mdHxCzHrZiWHfDxHBlxixkSy9cDZPp/nTWVn344jkMMG
 O12i1eIjoY94y3kSaaPRuWeqICdkdOzFC9qN9cXcDbd4yx6KKWE4d1phTqPs9FLJ4FlkNJ8+4fa
 /LYyk6rTIsgzLZV9WgaObJlQoHbWw7lz4c+lbe8M9Y7kkveYms1BJh6DmtlzccJMJ25zlPyUfZ8
 JmMUjXhd8ewPBbHid4BGyyAMEeqTyK6ykKlCepPfXv4InKeRsqJriegDf9oxa/3VabPxqAi+ZDP
 fSV0sApuWT7vTMVqvinurA0q0Phf9Nlh1Md0MKTtLGwkyMUTXh+Ps6RpfCKXyu2yzYMrNM67vWx
 yRdPu407r0ZBuNDOK9g==
X-Proofpoint-GUID: 0UewXK-tXcTk8FWkyPWn8VMN9H9juXe0
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a479f6c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=7COA2AqOHvKb0wdBt1EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDExMCBTYWx0ZWRfX+Zctx0ZJQz6V
 Vq7aSPRPQpmK2s8ZW9Ab8ojRDqpVU5I5jpBSa8I4jJz5wtRMPZX84BaKOeHe7JCg0Z84TaNiznM
 cYzIAWu4Lm8wE8gWWhsc6/49iUcKYqo=
X-Proofpoint-ORIG-GUID: XUA9fyTmm3_KCsdJOv0Gf6JjV0mivGPV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030110

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> The same could be asked of syscall_enter_from_user_mode. I find it very
> odd. Why does it conflate the syscall number with its return value?
>
> It never uses the syscall number passed in except when returning it
> unchanged. When it pokes the registers it reads the syscall number from
> them.
>
> If the caller of syscall_enter_from_user_mode only read the syscall
> number from the registers when syscall_enter_from_user_mode returns and
> indicates the syscall should be still executed this whole shenigan would

I agree. The fact that if (nr < NR_syscall) just works because -1 gets
casted to 0xffffffff and is therefore out of bounds is very odd.

