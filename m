Return-Path: <linuxppc-dev+bounces-18212-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222A7EFCBB6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 06:26:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ4q73kMZz2xpn;
	Mon, 16 Mar 2026 17:26:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773642371;
	cv=none; b=U2gd8Owk/oHYIbjmAuN4oJ+XP3TErTmjD0fkOuBYII2PngCninYQY36eZeKFWr9fQE0MdgN5qDv0HOkkRLS1iZHmoez8vEGAENhyNXm6oqRfUcjiPPxXpys+TLzrx3bJhNCLSCeLEZ9UncHiWL57xB6qgS6NePbpPjA/VXN08COxI+xIMEHQSY7vc516fGAEomL3pXibtJZXPOAEaM17zo1NEkHAf1omUwHxsk5BlnLI1Aa8xrzT+8yrGTsXrcQ7Xdn6cTALAE+o51NUCmrLHKaTEzJX8/HC0vTiZnPIim+sxSVs0kRbfGgXnzIZ7Z2Ve3Jsg+8M9iSqoUTctPNqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773642371; c=relaxed/relaxed;
	bh=ZZvOsDEOjQU96fYPxlcVKG8jZFe5rT/5ilS5dmBxUSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAgHtI1BAUVt0t0CvgESe0xktuGaMk2Ew3N446uSo3ECtjT3xcyUhWA6cswGyooXWebZhGiLoB72FxVdqdkoQD4fCHWZ/VHn2AQD7CmdnFH7m2I4/P7x895x5VXpmziheQX0MxN0m4lZvrnsZFswGkjslXT0SWutX2bfD26s2Jr58njLgR3PHbv5/LOuHxfmEjaXYt8IRz9irWsgkO5Yfs9UOhqcg0kAzNFhxNGl9FaLFzAoAgz4TC9lkJbvhP6sR0BG3IMUPnzlw/NkzkOE6eXTdkkaWts325A1NTjP0YLR1sAQYCD8T2vBb6mMZQU7NidgQnB8W4b+c8pxVagpcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RPsgPTCH; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RPsgPTCH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ4q65Jgkz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 17:26:10 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FNjeqX967663;
	Mon, 16 Mar 2026 06:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZZvOsDEOjQU96fYPx
	lcVKG8jZFe5rT/5ilS5dmBxUSE=; b=RPsgPTCHdW0bUqbDHm6rxF/rmQ9bQOcFr
	9Ba1dExKYxaSIaZwEYG1kAtoHi5bOtZu8zzwWA+hUm+U2Q8EzwgmM/m/QMNoBE0N
	n1/6woU0yza+tBz1Glgj0mD4ltnsQuaPuyx5RMTMREF+i3K2t0o28gO2NESgADrr
	aklFF/SuKTIrbbo6MZzNV+6EfMwWFGr9I1e47hnY3weUgwanlj4dq5WwWQMi26LD
	MFfFsf3neCcue9RhFAhCPDpKhHG4bDkuuPA/r2qbCkdSG1ILtwo4f3tgGZVmvAjX
	UyJu8LBEl0exg7JdfdC0Kn56SWmUds4+G47rJnYmQHAbTIwRyKJ+g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cp91x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 06:25:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G6EAQD032327;
	Mon, 16 Mar 2026 06:25:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jkhuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 06:25:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62G6PhwO43712950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 06:25:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E524E2004B;
	Mon, 16 Mar 2026 06:25:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 284DD20049;
	Mon, 16 Mar 2026 06:25:39 +0000 (GMT)
Received: from li-2fa77bcc-2701-11b2-a85c-cd621c23b6bd.bl1-in.ibm.com (unknown [9.123.13.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 06:25:38 +0000 (GMT)
From: Sathvika Vasireddy <sv@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nathan@kernel.org, masahiroy@kernel.org, kees@kernel.org,
        naveen@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, maddy@linux.ibm.com, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu, mingo@kernel.org, mpe@ellerman.id.au,
        sv@linux.ibm.com, nsc@kernel.org
Subject: [RFC PATCH v4 2/6] objtool: Set ELF_F_LAYOUT flag to preserve vmlinux segment layout
Date: Mon, 16 Mar 2026 11:52:33 +0530
Message-ID: <20260316062237.30948-3-sv@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316062237.30948-1-sv@linux.ibm.com>
References: <20260316062237.30948-1-sv@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b7a26c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=dGyo4u3eiptz4-Zsc8UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA0NSBTYWx0ZWRfXx0KeWWLxiAkh
 ue0kaLhuojb+id7MA/sepUbUaducK9uNC3X5TkvPLhv6YDgTC+qpyff/kISOZBLYZNbACFrAtHq
 vW/b+1tyL6Jux6E1SIxDWMdPzL8L8+rR5hVq3y0yL3wNni94rteuHYbOHNgdemz0loZzeu0Ojzt
 llzTfnX7vPVqn9oYyHIjfeuOO3LecX++gqLIu3wfI/pFfdbMu4SQ+9oJf+UgWZtO4cwMJoJa0fu
 jvsbpzsJFmWPFI5lZn5yR6jlSJTzKBhC7U2pQA2+wJuYD6P0+fCrYuilt/ek2haX6sDLo1XHkMj
 /sdtcoQ1fqpf6YNyRLDulxEhejZsONf1qZn8kgCxbB4peEyQ9xqCaBkCD959kWzOb7r5mBj/+vr
 /pPEkXP9Z30ke2fDKYel4qdnJM9fvmZerNoAqboRzX5wBIujgxUavkl8OT9dtRwjMf6A1OqGyFC
 Q7gJCtgo5RRfR1vQgrg==
X-Proofpoint-GUID: GmcYMIHmX5wXMZ3p-ZkNoFBJvJ5N2xSd
X-Proofpoint-ORIG-GUID: MjNrBFtveABCS8hU7vK8mehQHNuDlOx9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160045

When objtool writes changes back to vmlinux with --ftr-fixup --link,
libelf recalculates the file layout and inserts padding between
sections. This corrupts the ELF segment structure, causing kexec to
fail with:

    ELF Note corrupted !
    Cannot determine the file type of vmlinux

This happens because libelf's default behavior assumes it can freely
rearrange section offsets when writing, which breaks the carefully
constructed vmlinux layout produced by the linker.

Set ELF_F_LAYOUT after elf_begin() to instruct libelf that the
application is responsible for the file layout. This prevents libelf
from inserting padding or repositioning sections while still allowing
data modifications to be written back.

Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 tools/objtool/elf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d519eb3d7fd8..3c84c2713a7b 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1158,6 +1158,9 @@ struct elf *elf_open_read(const char *name, int flags)
 
 	elf->elf = elf_begin(elf->fd, cmd, NULL);
 
+	if (opts.ftr_fixup)
+		elf_flagelf(elf->elf, ELF_C_SET, ELF_F_LAYOUT);
+
 	if (!elf->elf) {
 		ERROR_ELF("elf_begin");
 		goto err;
-- 
2.43.0


