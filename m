Return-Path: <linuxppc-dev+bounces-16723-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51D0E78D46
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Feb 2026 08:49:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8dfY0R61z30M0;
	Mon, 09 Feb 2026 19:49:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770626964;
	cv=none; b=c1FPNk4PElXWbD4ye1Uj8CnAatX+srZS5EsAQHo2oeAT4DVVdwqpJXbONFx4o32kBVsy2e0tuwhciIUHXmkGbWAzZRKz9NKhb0W21P1f9TyTCX0MbqJpmx/Y3xGUFRQWduTQlZn6d8qUr0+BOW1RIQnJiobP69As7ejlTekovHKpbiOR1TzI9w0JldlV5wZ5YRAsaZMveZzn2bUk2XuJNgsgwmPc6FI3MJikdR6adIZyx4MWASqUVpdVuc6FDsbHfi+f9jvREXtKgi5DEAUxoCW62l1Gztjtj4kDbWTP+emKQ1bgxkK3oprLf21JXFKB0k7HGwjVCu0fIPaaP34fsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770626964; c=relaxed/relaxed;
	bh=Vx7hbLDugiI3L3ECkZfvUG8sfxKhjD8t7xBTjwQ9vfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KL0S+MYz8oPZSs5LHI0EptaKSa+chBiq89JbX97yu47vBEpWdn0+TVBeL0REg21/OQRgflI7DkLJjQ3ydAS6+13j7FKhb77n14FU8quc+emYdLu9QBNxKyb082RUWlZwM+HTr5wBXbJj2IvoLG6P5G6uWHBDZn86UjeJzswXV1VeUj3ilo+Vj5xrlpOe96+3iBm5p5m91p3+Wz5a8DwmXr2xOxjs3w5nleycOR467TkbWAwWlaWjVg0TYvgXbOSVSvkbgNocOalvad4yG4ro0+VzSz4OzDZA44mEz7N/LfqRd0Z5k3NQwYDhpplfoWDHWeOLaVLEJHNw/Ued+OiT6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pMUhXotN; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pMUhXotN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8dfW4p6nz2yr6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 19:49:23 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618BvvYF3433326;
	Mon, 9 Feb 2026 08:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Vx7hbLDugiI3L3ECk
	ZfvUG8sfxKhjD8t7xBTjwQ9vfA=; b=pMUhXotNE6QWIuJicnNQcIKepYc3H2K5n
	7wD2OZ/mEVRO56fkHFgL5oLYfFWGpd7y4VZOiJSS5xcjFg7AJ2XDGB9PTBo06Juj
	eis9Towvz9T0GDCobTHLVGYpmuBw2CfU8VQYBe83Axf93Thaf/uU+Ypde7XBmq5X
	nwwd89B9rECFVTkqOeSv0O4Z9wpkws9bG9uI75aZzHYdITxp9hZNebL0LjxBkT0z
	gr2kWFUtdqMXWqMS3A7RZVoZ32P7li9Ky1D74X9+p9I2eI9dEEOPt9CPCqkyINkz
	JKrDEwY6kWnfHu/iHomDbPZy+DM3vuomIe/O6zAG2uhY51F+jbr7g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uvye4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 08:48:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6197N6Lo002575;
	Mon, 9 Feb 2026 08:48:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqsckyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 08:48:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6198msjm50266568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 08:48:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02CDA2004E;
	Mon,  9 Feb 2026 08:48:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 449532004D;
	Mon,  9 Feb 2026 08:48:50 +0000 (GMT)
Received: from li-2fa77bcc-2701-11b2-a85c-cd621c23b6bd.in.ibm.com (unknown [9.79.195.233])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Feb 2026 08:48:50 +0000 (GMT)
From: Sathvika Vasireddy <sv@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nathan@kernel.org, masahiroy@kernel.org, kees@kernel.org,
        naveen@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, maddy@linux.ibm.com, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu, mingo@kernel.org, mpe@ellerman.id.au,
        sv@linux.ibm.com, nsc@kernel.org
Subject: [RFC PATCH v3 2/6] objtool: Set ELF_F_LAYOUT flag to preserve vmlinux segment layout
Date: Mon,  9 Feb 2026 14:18:16 +0530
Message-ID: <20260209084820.57298-3-sv@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260209084820.57298-1-sv@linux.ibm.com>
References: <20260209084820.57298-1-sv@linux.ibm.com>
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
X-Proofpoint-GUID: Mf87jfHInFbk69MapXEC8CeS9cKIVSeh
X-Proofpoint-ORIG-GUID: -apIo1t-HJUBbk6XG9wBOjLD7VpqBG94
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=69899f7b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=dGyo4u3eiptz4-Zsc8UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA3MiBTYWx0ZWRfX/knWIYESMxKs
 0bei1RzS8Bs2yVrwie3PjynjnciDD49G0Hw5Pt1tZWp4WY7hWYwZRKHGetdR/NsLBmnL7rsjbnj
 KTM+N+R2ZZ06/Vl/CLlXtAzWmkpqj+dtil7dpdYMKVk7z1DM6tm/p2AbLnVemc2pS2xv65rn45h
 9yrsHNpuhQ6jxa1NVo4t+zyIt8grbiwR1CXVSz7NeSMgKS1+MheCY57rkoClZzHeJ7FGF7iCG8r
 3fwTxrqfy0h5nTxZCjY8tyh9X9c/idCS4LVUW/l9VHpISBVNx5eVISjxR7rYLV4kQZLg+R/SIE/
 zCc8Nd5VVEYmS4gaQirv1zh+oZ5h81TNXwmT8cy78R/pHsg1yoFW7PdKbKWKEj6JU9hxVMUVSFU
 EsUQ3ho/wMnGR92QgQFgRY59p/8xvtq7BkDwXS52tDfM8jwgs0VzknJ4/JpH7iCg89Ijevc0XSS
 5uJaprYpErs+5N6eb0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090072

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
index 94370a470cbb..f7c6fd68ffcb 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1159,6 +1159,9 @@ struct elf *elf_open_read(const char *name, int flags)
 
 	elf->elf = elf_begin(elf->fd, cmd, NULL);
 
+	if (opts.ftr_fixup)
+		elf_flagelf(elf->elf, ELF_C_SET, ELF_F_LAYOUT);
+
 	if (!elf->elf) {
 		ERROR_ELF("elf_begin");
 		goto err;
-- 
2.43.0


