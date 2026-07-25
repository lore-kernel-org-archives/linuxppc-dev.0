Return-Path: <linuxppc-dev+bounces-24830-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86FCC531C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 19:17:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6vkq4Y1xz2yfH;
	Sun, 26 Jul 2026 05:17:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785007059;
	cv=none; b=Cd0Rgc8khf2b/JBWa5S/rZyjoIgiiQomYbp5es++fAu3rc6j1Yujoh+FI/tvp30GZcM3ecZ82tp1iieYzfWteCVLo4plfDcQxvxsk+KmlLYy2wBmpXPR1aEvEaO3AGH2EUuXeCLS4VStcHaWIUCUbv8WLXx64ok+wHAdv95HhII6fLSReWE/tBR674A88ivCJzi1Mycps/uGjfwJkXyJY4g8RcgTePpYLUncz2zpnOtv8HF8KzOM9qgy8lF+EGaS0p8VW3X97azNQwXa2/iVYi6eQvqeGNdkxHMgm+nEgUBXXovfJjyT9v3O98Ms1ZAT8op8P6b1e6/4WIHswLNomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785007059; c=relaxed/relaxed;
	bh=GEciWD0V5OYIPDh79eg/c7FaJ+tihJi9MT5y5NYVOQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkJAZWPdPCrYu2Vg/Q5lNtOpE/Ry+NCoBFKgB7kdWSfw1wcyJLT6FtjabjqYr9J2YzPSo4ZBLr4mjZuu6NVkHxniQE+cMOkq9o11zV/wfH5uoh8O9Zq+fCFncRhQmn+wmj78/dlCqKFCSOLsLe6InS5a7iQVfVqpMOQeYq2Ejh6NLRRtks4gVCARw9aB2P2ZI90Ss1vl/s2RQHFrkXbE76kmjqkDcujhcXI3B7Tx8XKXDhmFUx7Ilpnk5Q4CwcOq3TH/UxvUpdODi/P3QweXPAKEE+7VVrqhHjWlAbLwHmBTrz/XoSj8rpsIwnmpLjypDwsCvyq8WoLRyImrHb/cfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a9kpkihT; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a9kpkihT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6vkp1g9wz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 05:17:37 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PHIC0N1107103;
	Sat, 25 Jul 2026 19:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GEciWD0V5OYIPDh79
	eg/c7FaJ+tihJi9MT5y5NYVOQ8=; b=a9kpkihTNRzIR3dDI439wSczBhAyiwgvX
	QIy/iVJPGTMci5sJS84HeqK4+wnD/pLxtGKbMGBdhvq9I3tSVSz6795TsyYMqTvD
	TvM+bh9jTgRoIMfU5HD8/+XkIf5hKmg2BYjFOeDj9rs8wIJ+RNqbSlYcC3YeQFBD
	lGFblDCFororsplOabEOGiKIa/N9S7w3l1Nx6WiqpYhPwiZWw6W1g4S6l2N73Rcr
	Pi3Km8JVmVAkDO1SYOXn0QmuT+uJEnvIefA3S5HxpYj7aMxKMZt8xG5Jk6tVcsva
	x3YmRr2AiEtnE0pdJp4N9VWb04JpsBq86LVIxHlTmFIio1Cs+NOYw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0n94p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 19:17:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PJBHSQ002293;
	Sat, 25 Jul 2026 19:17:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn2c2a96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 19:17:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PJHR5J14418274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 19:17:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D10DF2008F;
	Sat, 25 Jul 2026 18:50:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC7BA2008B;
	Sat, 25 Jul 2026 18:50:28 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.45])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 18:50:28 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v4 4/5] perf trace-event: Fix heap overflows in read_ftrace_printk()/read_saved_cmdline()
Date: Sun, 26 Jul 2026 00:19:52 +0530
Message-ID: <20260725184953.234759-5-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725184953.234759-1-tshah@linux.ibm.com>
References: <20260725184953.234759-1-tshah@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE4MyBTYWx0ZWRfX4JbxvaI1/zsz
 D3Gco3QHB9wdpOpdrzaBfGlIE+yNw1D4H3PbkaNwGsemcAtPODIhWK+tk5AKP2z3dzw3xXWcxJy
 bJZUd44rS2hxDMqbaC4NVbz5OslNoFE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE4MyBTYWx0ZWRfX8DIXKIWNuis7
 yGtiTbwM2QJPSNqXbHs5TUOG3cTrkZnrm441qJUt9tm8IRwwcV+DSMBOvscbKn0GQPXI1BndcEi
 f6JJm3pRYeEKeChPWfEjmSv4ez6L8YRL02vacpXwdUmzQUlElqNHd2CklCUrJZPYCBycRwtIZqs
 I66mrRBUIl8AcwGdkStjHLhp5Ld3QuNlp2TmdLmt0ebg+zYVaDb/l/JFixI6XPg71F4ztjp+nm4
 472z8NLmOpCo9L5iDX0ecXWltwx9TZ+FM9tUkZtegDRUv8/Cz1Mp7sdlaxRPEXX89k55HIEPXGm
 P8k3+MayU7FX8M4+uIzA/zlLJgA6SieH+4btagZQk+GLyIwFzo+4sw4rxr7pUe2xjI0P3GtvOE+
 bw/Hn7LA2Axej2R5ABN37D/hLGKqCGVeBjTQ4Og+0/bMt+3g8iryrUEeNnbaOY2ww00cbGO4Ge0
 m6FErc8bLwD6ZYPziWg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a650bcc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-9rAvs5ZirYhReQkXt4A:9
X-Proofpoint-GUID: yzb88wVWrMOWqAzmFh18bvCsB1VinSBr
X-Proofpoint-ORIG-GUID: yzb88wVWrMOWqAzmFh18bvCsB1VinSBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250183

Both functions read an attacker-controlled size directly from the
input file and pass size + 1 to malloc() before reading size bytes
into the result:

read_ftrace_printk(): size is an unsigned int from read4(). When
size == UINT_MAX, size + 1 overflows to 0, so malloc(0) returns a
minimal allocation while size itself remains UINT_MAX.

read_saved_cmdline(): size is an unsigned long long from read8().
When size == ULLONG_MAX, size + 1 overflows to 0 the same way.

In both cases, do_read(buf, size) then attempts to read the full,
unwrapped size into the tiny allocated buffer, a heap buffer
overflow.

This was previously masked by do_read()'s size parameter being
'int': passing these values truncated them, which the read()
syscall's own boundary checks rejected before any data was read.
Fixing that truncation (widening do_read() to size_t) is correct
on its own, but it removes this accidental protection and exposes
the pre-existing missing bounds check in both functions.

Reject the one value that causes the overflow before it's used, in
each function.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event-read.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 52ed496d92c3..53f1920c3fcb 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -15,6 +15,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
+#include <limits.h>
 
 #include "trace-event.h"
 #include "debug.h"
@@ -180,6 +181,11 @@ static int read_ftrace_printk(struct tep_handle *pevent)
 	if (!size)
 		return 0;
 
+	if (size == UINT_MAX) {
+		pr_debug("invalid ftrace printk size\n");
+		return -1;
+	}
+
 	buf = malloc(size + 1);
 	if (buf == NULL)
 		return -1;
@@ -357,6 +363,11 @@ static int read_saved_cmdline(struct tep_handle *pevent)
 	if (!size)
 		return 0;
 
+	if (size == ULLONG_MAX) {
+		pr_debug("invalid saved cmdline size");
+		return -1;
+	}
+
 	buf = malloc(size + 1);
 	if (buf == NULL) {
 		pr_debug("memory allocation failure\n");
-- 
2.47.3


