Return-Path: <linuxppc-dev+bounces-22846-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9021CD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:02:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs5M3wjnz3btm;
	Sat, 20 Jun 2026 08:02:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906535;
	cv=none; b=ZW7/AQiS+B2IVEi/gdO1QMmrpp8G8IzZ88vnbkJiPLa8ftXbZhnrhn4hcoV9ur2ArZoJBD+tOc9kubMUZBF8pKcuQz1RI6OmYmDWtQ309M3OCWudRcWnZm7fJBRav3/viYiKqSgQ2LvEI1mAXEY8FQPKt8ivpAIqTSReUG4JZc9vFpaEUF3C8bbuVYoasVL15zIrgBlZaG687/4FCFWAxcbJn0gkSLFbZZQMLG7YlOy4lWWXL2pGSzQxMRolZfMUG9by2CmS41SUwHwPOgWmesSTs9O6qaUfSgJW/zDiZeGWhgaXfDGzaDCnYGshB28t142KAS91B8fXMrdJpaSovg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906535; c=relaxed/relaxed;
	bh=hEqSz4JBG0PikSQUr0yZENRMGIKec7XsYic4rufO4dQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wxu+ZKRQ4k0lmYFKfGJU4XTXluQNKist1ZFRbZKeFNPDtNOP/hsQRQB6RFHNjBBZLqXpN2QhlIp9VZ7EXq9TUgn0Gq4yQAQJzuWI6kkzQA3F7CkeLnC/pgaOArWILNA7caGN91cDlGQ0Os+b27ieZo+/jK4W9SfbZ96ONc++VE/XVa1bAPJhZ9KWQvBubonjjU0wzd3bMLsUcGuB5kaIJsUnGB1skUg9LGNPzgIdoOwCi9G7CHABOcQcCqwZq8sNfN/pBvD+FEAfWcOvogmeSPvKKdcOPuJhNHc73mVKZREoZiVDvS1NciCqv8wEgM8fP9zRdf+3YzKplcLELA0KQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KL6Ih4vp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KL6Ih4vp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs5L4M0Sz3bqV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:02:14 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmls93392910;
	Fri, 19 Jun 2026 22:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hEqSz4
	JBG0PikSQUr0yZENRMGIKec7XsYic4rufO4dQ=; b=KL6Ih4vpz8oU8Sv0pq8QFw
	fBstrRFU9m8v6Jlamo38yOpMQRf6W0Xbnc3zM1KIVec8uCaNz1bSOpf88T0Fv0cZ
	P3+uUeNkhZ3EehAxg7zX3BQuEzXBqRVq4QFrztqm17/Ky7XNimZoECS/VeJiN05U
	pULHrljYsYnTFGXUh0565hYrGG4QAIunKA4eQEK6PiCTN6cggNLip+STZWUie3yt
	IdsXvCgJ5Q5SbEwD3FEmPeUodwXWbRIzaAn10EKkthWKjrdait5qPF/4RNUidEEt
	ID5fOFlq6frvK9EouvpcylkkDjPWxRsQNqyZ8G141r6TknvTQFgm2I6YbhqgjcPA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxqesm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLnaQb014045;
	Fri, 19 Jun 2026 22:00:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172jrqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JM01hV38666508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 22:00:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFC1C20043;
	Fri, 19 Jun 2026 22:00:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F95D20040;
	Fri, 19 Jun 2026 21:59:54 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 21:59:54 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com, oleg@redhat.com,
        kees@kernel.org, luto@amacapital.net, wad@chromium.org,
        mchauras@linux.ibm.com, sshegde@linux.ibm.com, thuth@redhat.com,
        ruanjinjie@huawei.com, akpm@linux-foundation.org, macro@orcam.me.uk,
        ldv@strace.io, charlie@rivosinc.com, deller@gmx.de,
        kevin.brodsky@arm.com, ritesh.list@gmail.com, yeoreum.yun@arm.com,
        agordeev@linux.ibm.com, segher@kernel.crashing.org,
        mark.rutland@arm.com, ryan.roberts@arm.com, pmladek@suse.com,
        feng.tang@linux.alibaba.com, peterz@infradead.org,
        kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
Date: Sat, 20 Jun 2026 03:29:35 +0530
Message-ID: <178190618777.653308.8943469566889256068.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427122742.210074-1-mkchauras@gmail.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
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
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a35bbe7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=LIMivgGjvhMEkopAr_cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX8DZk0RoG3rKj
 hItLoFqFNTg5bglsJDyDTjdArVD0FeGAfv2fhTf7+FzNeSHSJW0DXSoVlAILPXbqJy6nxFWQZ0Y
 dlhgne9QZVuGij0jU4zDq+6rCsE9WmVlbTA6pxy7bW0pTD2hRCoBOuOu1APYwCIW8fAqiqibiE5
 cv8H7cqEpAkx9sWUnoKTrlZmwu7gXLLF/p7Cg5WglzcKz2CGbCVXGedW7ss2cnCeyKaxzaf2RJN
 8b4xuyL10yi+ythtdz+/aNbbYuZe2wNE/FeZ6wSEAfvD0W9nBJIWSQ6EfW6RJHX9SA5eB/DFhI0
 W3hTKlrT/TixDtQXvatzf/hMKFDYlFeAGAt5l7VQG7Da4rZVVJ8eMp78l7gxq9KgZ3Q2qhEaVsJ
 /oxPCsetDSwU7pHCD3rJs7GNBY3bp/rF5Pv+mMjgwsEd1f9CkpUnc1Iw/u8PVgJbm3LxldMjWXU
 ugOdIcAMeGkckGWd4eQ==
X-Proofpoint-GUID: Wj5MJGLoJrtN2pkp8feaIAyAJ1TGvgq8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX2DuNFGgWKu04
 4xKwoHc1MhvOCcMpwqe8X3ciPxWK9SGN3Uqw5CbjB7iZ1h+t1IHauUJlh00OIqYY7s88//KPuIv
 Rc+9+HpHC0Yx4XjhzhZrKDqK8B4AuI4=
X-Proofpoint-ORIG-GUID: DnM2syZ6IVgOWjzyLgqXHN0zJfs_NHQr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Mon, 27 Apr 2026 17:57:34 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> Adding support for the generic irq entry/exit handling for PowerPC. The
> goal is to bring PowerPC in line with other architectures that already
> use the common irq entry infrastructure, reducing duplicated code and
> making it easier to share future changes in entry/exit paths.
> 
> This is slightly tested of ppc64le and ppc32.
> 
> [...]

Applied to powerpc/next.

[1/8] powerpc: rename arch_irq_disabled_regs
      https://git.kernel.org/powerpc/c/baa590018fbfc3e7384b604c7a7951eecf10a523
[2/8] powerpc: Prepare to build with generic entry/exit framework
      https://git.kernel.org/powerpc/c/dec63ea6fafffb91811381d9a4686d4bc39f01ae
[3/8] powerpc: introduce arch_enter_from_user_mode
      https://git.kernel.org/powerpc/c/09a9d3a8499db606563eb5e75a993419f4d1901e
[4/8] powerpc: Introduce syscall exit arch functions
      https://git.kernel.org/powerpc/c/02565a782c1ee7e8ada38ad24a698e01d6ea9ff8
[5/8] powerpc: add exit_flags field in pt_regs
      https://git.kernel.org/powerpc/c/d7a6797e0bc1ee7bddb8a298f2d1acddb300efb3
[6/8] powerpc: Prepare for IRQ entry exit
      https://git.kernel.org/powerpc/c/893082ac769ba92a1338e7552d97de769f352a3e
[7/8] powerpc: Enable GENERIC_ENTRY feature
      https://git.kernel.org/powerpc/c/bee25f97ad24641df55cb3887eb5bfcb2b9d8fbc
[8/8] powerpc: Remove unused functions
      https://git.kernel.org/powerpc/c/6ed60999d33d49251b42976a5511f1bb089797ed

cheers

