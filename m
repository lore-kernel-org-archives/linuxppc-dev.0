Return-Path: <linuxppc-dev+bounces-20448-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FFECD3430
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 08:47:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8sb06qQyz2xMV;
	Tue, 05 May 2026 18:47:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777970844;
	cv=none; b=KEcR4odWWqmo1KjevOIn2uzy2J4ysIKiQFYcdW5snewP8LBDiPTD8PNG1Re8JOeRQiyDI93X6iXHXdkkyOnHca81JISD/5Wt7fasbgboEQA5PKaAhtRmWgxSjn2qlJ9879HICsgc3Vg6ireM+i328o7BuuXm/3YJgrB8hPNPmJI6PequwGD5UjaXQUeQTaqH1BgrEWbulDQJ+32waZXJxFF3pdcQmJT3/JyeaqTJkpNn1C/AaUQnr18+KobUwGsWHtw7R39b7QyprH3E8kxKx+X3kw4PFcU30bLylBHJARN989WafmteHDUiCCb+mkIAVZzkJB4mESLKaPhOcRB/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777970844; c=relaxed/relaxed;
	bh=BjlYOPVSncnM2b0yFWrLhG8f6G8kzasvWSJy/dQk/dA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KapK0sORNZotrQMTwnNLYW0ojktwxBKAJgoQTfd1d9MIwyn2pHZbzfxAcvZkB0mG04RFFvvOLhbQY4ZQPgBRXp0iB1ziPEC2fEbRK3g7DHHlYe4Ipa0htQfywcwbDQnzzOS+wdwOenDUjUogDyHj0beIkmwhj65ola6Iqot8bExstYEofqIqfJ/A+DRFoQlLK0GCI4yOTszY94R3Xt76tnR9uVWaBw7OYOILSZPuxIEGNvFMTpfCamZWrmiAV90Da3+jI/1VD2Mm3FOVM07p8gMCh/7sBDQQQtYyE/7pQjcORGWVMkvqf9FEb0VcCY+4ppwT0hCHbY9UrZ7FbZqEGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g3eI3KOR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g3eI3KOR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8sb01qqNz2xGc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 18:47:23 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645681dc2606962;
	Tue, 5 May 2026 08:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BjlYOPVSncnM2b0yF
	WrLhG8f6G8kzasvWSJy/dQk/dA=; b=g3eI3KORvjcquC5V+tDgVHeMVNw6mkFl9
	VpkEtC0JOZXbEDvaKj66DT4n3DYKhGv86OGREUrIgQJ+m32Ol9oR/D5SitkvmwTm
	Sy1U06fPeQ7iHH42egcjUP2Y+aDy4Hr3nFywrbijbl8uuZ++PYt8Gr6H4GKrLaJd
	pJlVOu7wiy6PF1/oODo+8rN3nMWEEAr/ZPy4oniXJ9C8lED/MlkC3B3hkYvOeqbX
	tF7YYJQWiwj+kPI8olonnoahORiliFufmqWio+Zb21LmoGpCJToFQpnH07apFMnN
	qQLiFn2E4MXXPqKUsL06vqElC9ZxyN+v8DvSvgKnxDd094/WBDwNA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7asc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 08:46:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6458dUDT018333;
	Tue, 5 May 2026 08:46:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9y8hhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 08:46:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6458kr9g51839240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 08:46:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A2232004E;
	Tue,  5 May 2026 08:46:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C187520043;
	Tue,  5 May 2026 08:46:46 +0000 (GMT)
Received: from li-2fa77bcc-2701-11b2-a85c-cd621c23b6bd.bl1-in.ibm.com (unknown [9.123.13.4])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 08:46:46 +0000 (GMT)
From: Sathvika Vasireddy <sv@linux.ibm.com>
To: nathan@kernel.org, nsc@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org, ojeda@kernel.org, masahiroy@kernel.org,
        lossin@kernel.org, tamird@kernel.org, thomas.weissschuh@linutronix.de,
        rostedt@goodmis.org, ihor.solodrai@linux.dev, thuth@redhat.com,
        pmladek@suse.com, aliceryhl@google.com, elver@google.com,
        kees@kernel.org, legion@kernel.org, ardb@kernel.org,
        yuxuan.zuo@outlook.com, alexghiti@rivosinc.com,
        alexandre.chartre@oracle.com, bp@alien8.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sv@linux.ibm.com
Subject: [PATCH v1 2/6] objtool: Set ELF_F_LAYOUT flag to preserve vmlinux segment layout
Date: Tue,  5 May 2026 14:16:24 +0530
Message-ID: <20260505084628.17940-3-sv@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260505084628.17940-1-sv@linux.ibm.com>
References: <20260505084628.17940-1-sv@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA3OSBTYWx0ZWRfX4WjxiSb3gXtV
 T6XkrVuhnTwldORwUXn9tY9wcOajEDd6B0cRceHQvNGGTiqaoh8N1wu17o3rziIR+yCAe9lO5nV
 iO2Ky0m7j1S8DzHTDQ+zUnte0bocj/Zt7zB+VJN0NOAL4eF3Mr3srEhd14/Rrni+me1zz23H4/i
 zAiDST+0fHXzvfQomd9UMk+MrtwAPnOp26TN0p0QAsLEhXM2Nz80pcB003L48kQPnXAORlNIDkP
 tM6XGPFOYY0rd7jS4QbeA1kMUEFwJp5W+n19RMjfhzcGnvQk7hetF2crFP3cN3sQfE23sfH2bh9
 msHWZt37eQ1RX1/uELBfWKbPbV5XiFebrRd4e18vtuTgnLUSOxD6ISxE7tRGQosyndVaVr6T/ns
 PVNpNJTSM5bAEkelM8FAw6T+Uq6eCCC/rMZ/3h+WKnGH4GYmJKLmOaWaVoutRhsVYDAkrTlZcy7
 gwNmJTfm1jRWMFKFWpQ==
X-Proofpoint-GUID: FbpAoVpZbO6Me2AALh09RV_gioLPNohg
X-Proofpoint-ORIG-GUID: ukP5QapWDPuwWKRAvCoMZDxpgrMzUfCG
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f9ae82 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=dGyo4u3eiptz4-Zsc8UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050079

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
index 2ca2a4e4b92e..8752cec5e818 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1162,6 +1162,9 @@ struct elf *elf_open_read(const char *name, int flags)
 		goto err;
 	}
 
+	if (opts.ftr_fixup)
+		elf_flagelf(elf->elf, ELF_C_SET, ELF_F_LAYOUT);
+
 	if (!gelf_getehdr(elf->elf, &elf->ehdr)) {
 		ERROR_ELF("gelf_getehdr");
 		goto err;
-- 
2.43.0


