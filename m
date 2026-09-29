Return-Path: <linuxppc-dev+bounces-28453-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB190CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:22:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv8lg34Jkz30PJ;
	Tue, 29 Sep 2026 17:22:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790666575;
	cv=none; b=AlZ0oAd0DWs0QYbTrtTIt1unlZ+xtBpBxvE9cA5IB2C5tWVU3VJjlYejuo/oW2476dHt1pCEqA0Yzi9NoT+QjzkQkjp2MNb35JlMJU0YO6jQXbHqAiygNpnh4sYc4GmTjmLH3n71k0EuW/9P9bhPRj0nhTvQqn7US6iEIJXtSJF4nmZPTyjPxCqarhV5pMm2jV77aK7Zv2h3BznrOkrojH8rdXzrziMXjkqg17onn5K/piOSFveMIp5wS8sOWTvHAetOkKsX0S4/Pvv0PjoHm700bRRdNFpds8LFgvJ60LRS44H/O3fpzHaZozjtxB+LtSHWXHWDmCPSm8ksB+samw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790666575; c=relaxed/relaxed;
	bh=g8tTQZ2uKce9fmNdVcB0txupfJQREmbAfU9Mihwgn30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3prdY6FypBjdmJe8k7eyobke5lbku+qZ38tXyGNhJynGchs0yWEat7JzwUcUX1UA0OGxofu3MwY/cszgEFQ3/caTfb83sCzVC/DF+ltnMEZkUrOSspQEV5rOmiIkWbQzLpVXwoonC6xTWwUiJh37MYscse/xOzi+zJwQp8T4BnKnN8B1DEm7ZjIvahqPmEnBZiOdIrmx2WwhYxZrj1/Vnb7RJde/FtfeiAh8k88bhIyiQntiYR4phpFFI3dJ2dGoxo7mqdVzFNnthzLbvSEb2yN7FUSeli5tk+FL+GsWkF+5OLTBxNPAVSasODvz26Wlmi5V2jFQy4RNRGbW7ohFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MZi6TzjQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MZi6TzjQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv8lf3sS6z2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 17:22:54 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46EjD1805735;
	Tue, 29 Sep 2026 05:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=g8tTQZ2uKce9fmNdV
	cB0txupfJQREmbAfU9Mihwgn30=; b=MZi6TzjQfZywUQeURPsI5t9GuN8HfkDTk
	molgkf0Kr9vMjCa4+BvJOUE46O+Lqs7i3I7ZI8UDkCSncQN2TJpBazh7PkswVmE5
	FwYmyg50lm+vl72sQrSLxLOsKrZEHRhe3wKFgav2dvKrzu8MHwr7DoVURhJ5xMNQ
	p7Hac4UMn/5v10c+9q57XXQ3uJ8TP8nw7NQZbSyLxhgLJQQSvGhtXPIvNYY7fuxi
	rRRccat324zRIMHPy7WVnKJblMCaFAhGO+KMeHHWyFM0o4m8EjLHx8vxjRTWvNy/
	BBihjqDXMCaBUWoaj1Ggmk7QoXSfRqtOBxPvl853Fy+L/whO4hXlQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe4ugx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:52:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4HoqI1184427;
	Tue, 29 Sep 2026 05:52:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcprk6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 05:52:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T5qQP943057496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 05:52:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E68F820043;
	Tue, 29 Sep 2026 05:52:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF07220040;
	Tue, 29 Sep 2026 05:52:18 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 05:52:18 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: sv@linux.ibm.com, alexandre.chartre@oracle.com, alexghiti@rivosinc.com,
        aliceryhl@google.com, ardb@kernel.org, bp@alien8.de,
        chleroy@kernel.org, elver@google.com, ihor.solodrai@linux.dev,
        jpoimboe@kernel.org, kees@kernel.org, legion@kernel.org,
        lossin@kernel.org, maddy@linux.ibm.com, masahiroy@kernel.org,
        mpe@ellerman.id.au, nathan@kernel.org, npiggin@gmail.com,
        nsc@kernel.org, ojeda@kernel.org, peterz@infradead.org,
        pmladek@suse.com, rostedt@goodmis.org, tamird@kernel.org,
        thomas.weissschuh@linutronix.de, thuth@redhat.com,
        yuxuan.zuo@outlook.com, sourabhjain@linux.ibm.com,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v2 5/6] kbuild: Add objtool integration for PowerPC feature fixups
Date: Tue, 29 Sep 2026 11:21:36 +0530
Message-ID: <20260929055138.43489-6-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929055138.43489-1-shivangu@linux.ibm.com>
References: <20260929055138.43489-1-shivangu@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abb5221 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=vy1mQZ1WB7j3BMigChgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfX4M6WmLc9nqDL
 q+pFRg9hbu18AuBYupPKog/X/m3j+Oim3IdXvqhSVplKjM4EwG9ithxs4Q4gFccq/4+P8syR0xD
 0YYoGLo/dxhDqtAxbdh0m41Rvksm6UU=
X-Proofpoint-ORIG-GUID: FoKb2uDzsxQpe8xQmcDD__FIgEi17Pk6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfXx+RMZOo7h6Rl
 S3e5OGndBlXvgkK8euNX59U7uEnmhSvo52LzFTjW6YWxS4DGiijqcKTXrJ+2X24z37da0a9uaNu
 mI8wEkjhZP5HekeLEJxGerTlBhY2ZbOOfDytOFNYU7pFeLFH4Xck3jFat9tXCc73UjP72HpUyyU
 dYgOt8QFuubTlH+nmSq9jL3cSEi4yZSR08LeIx253fyy35ZRk7DXyioswMODfJM5mKmXLy3DDXy
 CeJT8vXV3UVwcFBq7i+TELwUFnhROWXG9s745agjNV+f2v9ogqPRFF1K7PV0IRs4PLVJctts+FY
 5ST45OWp4VV+3Y80MBj+l8Lwjm90eqJAz521z6wO1PXY3TtSqa2FHjWkXzonOD+i9Ow+axQHvh9
 ntJsvZl6gN9irb3yXTgo2xA0XaMtlbiwPHj1S0s/y/G4grYDLscvevBHgwttAMUnUKdnsZvauae
 8iFabl5rBaacIDmWC/g==
X-Proofpoint-GUID: z8unBXdemuN9uGNt4XtpuuICerrEQw7e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290022

From: Sathvika Vasireddy <sv@linux.ibm.com>

Add build system support for PowerPC feature fixup processing:

- Add HAVE_OBJTOOL_FTR_FIXUP config option for architectures that
support
  build-time feature fixup processing
- Integrate objtool feature fixup processing into vmlinux build

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
Acked-by: Nicolas Schier <nsc@kernel.org>  # kbuild
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 Makefile                 | 7 +++++++
 scripts/Makefile.lib     | 4 ++--
 scripts/Makefile.vmlinux | 3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 6b8b812f23b9..363cad32fb26 100644
--- a/Makefile
+++ b/Makefile
@@ -1566,6 +1566,13 @@ ifdef CONFIG_OBJTOOL
 prepare: tools/objtool
 endif
 
+# CONFIG_OBJTOOL and CONFIG_HAVE_OBJTOOL_FTR_FIXUP are unrelated, separate
+# options. It was integrated in objtool in order to borrow the elf parser,
+# but this is different from how the other objtool commands are used.
+ifdef CONFIG_HAVE_OBJTOOL_FTR_FIXUP
+prepare: tools/objtool
+endif
+
 ifdef CONFIG_BPF
 ifdef CONFIG_DEBUG_INFO_BTF
 prepare: tools/bpf/resolve_btfids
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0a4fdd8bd975..efcedeb207b7 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -182,10 +182,10 @@ cpp_flags      = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 
 ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
 
-ifdef CONFIG_OBJTOOL
-
 objtool := $(objtree)/tools/objtool/objtool
 
+ifdef CONFIG_OBJTOOL
+
 objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
 objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
 objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+= --hacks=skylake
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index fcae1e432d9a..a1bef0638ecb 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -65,7 +65,8 @@ ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 # Final link of vmlinux with optional arch pass after final link
 cmd_link_vmlinux =							\
 	$< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)" "$@";	\
-	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
+	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true);	\
+	$(if $(CONFIG_HAVE_OBJTOOL_FTR_FIXUP), $(objtool) --ftr-fixup --link $@, true)
 
 targets += vmlinux.unstripped .vmlinux.export.o
 vmlinux.unstripped: scripts/link-vmlinux.sh vmlinux.o .vmlinux.export.o $(KBUILD_LDS) FORCE
-- 
2.54.0


