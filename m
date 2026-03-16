Return-Path: <linuxppc-dev+bounces-18215-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CF7EFCBB6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 06:26:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ4qM4my7z2ygh;
	Mon, 16 Mar 2026 17:26:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773642383;
	cv=none; b=HlZHiOSmX7e9EGDH8Jl6zQ2EoiLFkpO4DQik2unxToEr5o9idqaT+2nD72+k2mahqoI8594FZXrGJ1JxJeBGf8sHCAW2gG+kiuh1CuceZ5LXimYJ8jO0tUVAQaZEaaAPHGlkhJDnTtEM5QMCxNfPtvOyE395EPL0Th1ffZv4ifcGKeHtDaGzzThhXq8Hg/g9il1wnmj7ksFAKA2lwotIpyakfx1mMqbGLDazomvJsbeOiIyr4QukU+Soa6LJTfQpRk7+OMYFEVPACFiR+sp6faV4qpXZwmD/cABnJlJfBWChI7etfsa5YxXGT8ekkPHAhuHGewaepL+SEGOxWJ+P7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773642383; c=relaxed/relaxed;
	bh=AgqxpQVmCwUwsQP4eYZ7Z8OFdXuN/UY+6udpEMl9Tf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/9v0g/jkCWUsfIugxrPqR0VPMpb4DsmUrfj/h1dyK2FerKoSrp7KXS4jCGueiTmRaca1PKxR4P/vAFRJA+o9JD4E4HFmvj6pV7FBdxVR7R7X4tECMdrpFGJ4ABKHJE/g/tekIIPmFeybmjl8jTfpWbLGr5dCtwVgehhHAa4/P/VumNzuqylVaMeCUvPDrxJXT/74P7cGfcSdag3myXHfEbLWR1z3pAmZiG/APWmTWlGJ7ZSFKmrg7ZWL/PCf/0Rd/TcfSIIhqCRFhc97L7+M7wlVPfHIYaJ6Wb39lA8wX9uWvqUItX/c03xKVZfNFX9oHFMh5lPIrdraO33/o2TDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oSFLc72w; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oSFLc72w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sv@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ4qL72Qhz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 17:26:22 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G14CND1188734;
	Mon, 16 Mar 2026 06:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AgqxpQVmCwUwsQP4e
	YZ7Z8OFdXuN/UY+6udpEMl9Tf8=; b=oSFLc72wVhEYcQgeAQVpSO8EeBxXN3AWv
	VaftQcxZwCMe1e9nCeawwy1Gpzz1KD9vkI4rGB8sDxBbuMgFQtbWZkjM9lKZg+qG
	8lHr3OMThQM/Pq/7pNVmBjBkPZbARvEkybY9dt3ZyJIkx1DejjKc/0AQP4PkXCer
	RjepSvjqbArBkXKwlu/58SoJSwav7s2hnPMKC5Z0IUaNzFflgZHslanKXvLq2f4E
	6UEfe1zMw8AebLujo42kh+s9j/9zsjhU1+IwLcyZ0pM2Ei7qXQPt7ILk6yHTK57I
	JPxLJd5lqYP15wJDdFpAXAswGSbdcmIfgBsRE0vpvQXUzaFQ2gmtQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vf8skh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 06:26:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G4dTYP014011;
	Mon, 16 Mar 2026 06:25:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxuspa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 06:25:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62G6PtWv35717490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 06:25:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1F3520049;
	Mon, 16 Mar 2026 06:25:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3D8B20040;
	Mon, 16 Mar 2026 06:25:51 +0000 (GMT)
Received: from li-2fa77bcc-2701-11b2-a85c-cd621c23b6bd.bl1-in.ibm.com (unknown [9.123.13.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 06:25:51 +0000 (GMT)
From: Sathvika Vasireddy <sv@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nathan@kernel.org, masahiroy@kernel.org, kees@kernel.org,
        naveen@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, maddy@linux.ibm.com, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu, mingo@kernel.org, mpe@ellerman.id.au,
        sv@linux.ibm.com, nsc@kernel.org
Subject: [RFC PATCH v4 5/6] kbuild: Add objtool integration for PowerPC feature fixups
Date: Mon, 16 Mar 2026 11:52:36 +0530
Message-ID: <20260316062237.30948-6-sv@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: hcagTk-zsqxwONzvp47iQ595Aq-776Ks
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b7a279 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=k1iL6ZPSiERSBASioQUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA0NSBTYWx0ZWRfX4mwLllTvZ/im
 Rca5hVzY6Gl+5zr1LJ/5SQ5I3AjEzZuv5P5Bq/V2tgF2kIt8clM9eGkpaHmctRONb98lg1Psxbe
 uVDRsKO6xF0B8Ka5V9Anv3krWQaLAlZBjibObwFqxb+SzR+1m6VW0KUrQl/56x41v5DsfgF2QPS
 at4ZLbo+WmN86Jc6DoikwESeKdhr/HLVI3LkPZWtr/yC+EjTh0BbQBuzzlnq6ddwYFCc8Y7+wY+
 oNdn9ZUSD2QLMMFANr438/evSh7ydL8QHSy9Q9IVtUoRmVDuypnKWDspeLpecSA2KAnr11Kl36s
 B993qIX50OGw1v9kYj9+Z+LYBuuiLaXX7hw4AWxZ+48h3WwbcbD77DziTagvzcsYlkmQca5DlmG
 5CZx8QfSwDOz6Ato5cvIiSUJf4Xpy0LHG6PhMhyVvduQjj+MKWMHUb9v1y4tNCPhBU+FwEDQGQ5
 spvHzUd5N+42D682uLg==
X-Proofpoint-GUID: rR38sSfWR2jvZFCMdskex73pGmE8QcPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160045

Add build system support for PowerPC feature fixup processing:

- Add HAVE_OBJTOOL_FTR_FIXUP config option for architectures that support
  build-time feature fixup processing
- Integrate objtool feature fixup processing into vmlinux build

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 Makefile                 | 7 +++++++
 scripts/Makefile.lib     | 4 ++--
 scripts/Makefile.vmlinux | 3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 83ed80595378..861f5bec655c 100644
--- a/Makefile
+++ b/Makefile
@@ -1467,6 +1467,13 @@ ifdef CONFIG_OBJTOOL
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
index e429d68b8594..c9478c717574 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -179,10 +179,10 @@ cpp_flags      = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 
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
2.43.0


