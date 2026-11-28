Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402E6606A31F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iDD/wq0j
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc8wM4scfz2xLm;
	Sat, 28 Nov 2026 23:38:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795869523;
	cv=none; b=G0RbgAW4ZgH9hOqfQeMMe+O7z1MVqYsR/X/lf2wbq6VSihP/AA/lF2VCOR2hB3ViWOjFITOetxTejoT+EE+76mOKpP44k5j/YQdPoH3Mi9iK6Q3qefAGOiIcKn6hbyL6nSeS7CMDCtz8ufPgz8u9uP/OQdtGwvrQqMF2BmK3T52FtwfSQYSmRTIZvwOHTBVwiJLlDXy6LQ/CF1F47S5gBqyB2S+LxxDMo5tWXwyEnaM44O0YvHiM7E3DWxVrfgCYIvPodlu3O1Us0rKIbX9YNdUF3r0Uv5m18U/3Ik08aZTmFlys5JHo4p8BvZVGd2JbCsPdPZJcIjI4cAzpfmZ/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795869523; c=relaxed/relaxed;
	bh=T1Zm8E+CkKo7t2RFuBhrrqCOgUq9hNvKPEGnderBtHg=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=YSI34x49H5BVjxDHssMPnC/ke5o1YVeGRP7aStNYrOi70vcFXRrt/Rj07uc9bCk2jNb5dIHdLmXlNlLoXvJycdF6XIjNGmZo8rPlbsmDWYEYpyCy4KmLuazhygLTw3HNjV75zKgwq7kjPh36KwtuO/yNGsJEIl+nFo05/tyP6mtAkdCUyAN/F7QKeodhaldy0rQR45EiAZ8eWW8tyq+OGCKflgD75H+JZWTlBTb4IcITDnnw1lPjjQywv41/DOpBCYqjY8T23p9CdnbFjWSn4lW2B0Tnk4nDOXsDxHxaYCQyUVvHGDAuSdI8UgYJQv4XXm3uesYMOJ0/1Z7dYMFp9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iDD/wq0j; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iDD/wq0j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc8wL6GZSz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 23:38:42 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ASBqdRb393675;
	Sat, 28 Nov 2026 12:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=T1Zm8E+CkKo7t2RFuBhrrqCOgUq9hN
	vKPEGnderBtHg=; b=iDD/wq0jOH5vMI/qr2KlSmxeX+3lAcUgk1wafRGhkAdU5h
	s6LwdIG6QwBgXyG5mBTivR7UHakVetjtI7An2D2k3dmO+RaVhP2ayQA1W6kXBBBv
	5iOPZ7GtMI7hECqeU8hX3xY4dBfDn92AJCCJKJs+v+jQoGQ2fgVLXgsiKLd3ecWf
	lDq3uZG+ikakaDSMghPIG9pKxdIaAL30oqjkmi5XUixq5Lvg7SZUAlwLyjIxyuc4
	AwhuX7MFcfKfywVSRomQ/M+p+Q84uxveAF8qQY+JZKlzQDg/+5oYMGSZB4gXMOEC
	AKXrh1+dcArP8f/hlFMa0EdiCmpTagwaK7ra8PHQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j7nch9b1w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 12:38:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ASAJDFt1087213;
	Sat, 28 Nov 2026 12:38:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6x3h5s6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 12:38:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ASCcWKC16646658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Nov 2026 12:38:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E736F58055;
	Sat, 28 Nov 2026 12:38:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3C8B58043;
	Sat, 28 Nov 2026 12:38:23 +0000 (GMT)
Received: from [9.124.208.189] (unknown [9.124.208.189])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 28 Nov 2026 12:38:23 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------Yk2vRfYm0gGLg3ej2CrQGz2k"
Message-ID: <0e197dfc-d81f-4dd9-b034-00ec683715b6@linux.ibm.com>
Date: Sat, 28 Nov 2026 18:08:20 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tejas <tejas05@linux.ibm.com>
Subject: Re: [PATCH] perf disasm powerpc: handle Power10 prefixed instruction
 continuation lines
To: Athira Rajeev <atrajeev@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, maddy@linux.ibm.com, irogers@google.com,
        namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hbathini@linux.vnet.ibm.com, tshah@linux.ibm.com,
        venkat88@linux.ibm.com, narnalli@in.ibm.com, vpuliyal@in.ibm.com
References: <20260907051429.29080-1-atrajeev@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260907051429.29080-1-atrajeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI4MDA1MCBTYWx0ZWRfX9PgLDlQKVrmU
 sXg2S/kTSpKYxgn4Wbx1Q+zvzIYPxU/FFw8AYO3aeQ9ER0TTg36qGA4IIDiJOL19gTzCyNAjwtU
 fguwojPYdA/bvBt+kad7+Bgkr594i1cdmHEpgahlK/QomjPTHwqjapWHavmmE3c1eRhpSlWcI4S
 VvQVhMT7lPSce4Isg/uGLosbrd9g3pLBPMNvm92FzYVGYXwPQNxqntVNOs0ZRGK5xt53vi/se/P
 bLofix5/Nh5m7Wd8xeKKmDQ1jrSYc43Gwg0wjrcjaDQ8qWsAoKrcSX4U47UnLvtZb3GMx+JzNJb
 tMGKPondH6qJEnxMw7Cb7c5Mk7C5AXqotPbEkKglM35lZ+aw015Ng+UtHNTBEJ21RBo+oWwzlQO
 bPC2pdbcaXqTsSCCMjMCdD+17Agfo6fEG4vnBb9bQltQxSa++Ssfw6sh23Pp3k/xND7G85PTldY
 j3dIxRXVlzMxzojAg4A==
X-Authority-Analysis: v=2.4 cv=Tt5zFzXh c=1 sm=1 tr=0 ts=6b0acb4c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=t3HgwEvd1mtBUPFIqT8A:9 a=QEXdDO2ut3YA:10 a=DnKhKxHaaOjCy7Ko70YA:9
 a=ZgxTx3mifuSziNpL:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-ORIG-GUID: ZTqB2TjPPbzm7Yj03AzCqDKaypXUWpV-
X-Proofpoint-GUID: W_hfg6Wti78fKObYk-yu14QMOqqX5dLK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI4MDA1MCBTYWx0ZWRfXyhlJ4mQ2fYIX
 KULpWVXXHV2n9Zh5rQDGEZlsGlp3yhlPu6I1fY/ykC8TRQoXD3EK2uLoBCl4FIbNSjdjxIsuqJ6
 uiSQ5yIoIBncZ1HYFsWTZuyTuIrAd6o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-28_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611280050
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------Yk2vRfYm0gGLg3ej2CrQGz2k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


     

On 07/09/26 10:44 am, Athira Rajeev wrote:

       

Power10 introduces prefixed instructions that are 8 bytes wide.  objdump
emits these as two lines: the first carries both the raw bytes and the
mnemonic, while the second carries only the raw bytes of the second word
with no mnemonic:

   1020900c:  0b 00 10 06  pla  r31,757280  # 102c1e2c <cctki_vi_ML_CCZ4>
   10209010:  20 8e e0 3b

disasm_line__parse_powerpc() calls disasm_line__parse() on the mnemonic
portion of the line.  disasm_line__parse() returns -1 when the name
string is empty, which causes disasm_line__new() to return NULL, which
causes symbol__parse_objdump_line() to return -1, which immediately
breaks the objdump output parsing loop in symbol__disassemble_objdump().

The result is that annotation of any function containing a prefixed
instruction stops at the continuation word and all subsequent
instructions in the function are lost.

Fix this by treating an empty mnemonic as a valid case in
disasm_line__parse_powerpc(): skip the call to disasm_line__parse() and
set the instruction name to an empty heap-allocated string instead,
allowing parsing to continue to the next line.

Reported-by: Narendra Nalli<narnalli@in.ibm.com>
Reported-by: Vijay Puliyala<vpuliyal@in.ibm.com>
Signed-off-by: Athira Rajeev<atrajeev@linux.ibm.com>
---
  tools/perf/util/disasm.c | 20 +++++++++++++++++---
  1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index e263a2a8715d..8dca703a5c74 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -884,10 +884,24 @@ static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_ar
  	if (name_raw_insn[0] == '\0')
  		return -1;
  
-	if (disasm)
-		ret = disasm_line__parse(name, namep, rawp);
-	else
+	if (disasm) {
+		/*
+		 * Power10 prefixed instructions are 8 bytes and objdump emits
+		 * the second word on its own line with raw bytes but no
+		 * mnemonic, e.g.:
+		 *   1020900c:  0b 00 10 06  pla  r31,757280
+		 *   10209010:  20 8e e0 3b
+		 *
+		 * Treat a missing mnemonic as an empty instruction name rather
+		 * than a parse failure, so that parsing continues past it.
+		 */
+		if (name[0] != '\0')
+			ret = disasm_line__parse(name, namep, rawp);
+		else
+			*namep = strdup("");
+	} else {
  		*namep = "";
+	}
  
  	tmp_raw_insn = strndup(name_raw_insn, 11);
  	if (tmp_raw_insn == NULL)


     


Hi Athira,

Setup:
   - ppc64le, gcc 11.5.0
   - Base: torvalds/linux master at 7cd8495c0f16
   - perf built with libLLVM on. The default disassembler order puts
     LLVM first, so I set annotate.disassemblers = objdump in a private
     perfconfig file. "perf annotate -v" printed "Disassembled with
     objdump".

Test:
   A small loop built with -O2 -mcpu=power10 -mpcrel -mprefixed, which
   contains prefixed instructions (pli at the start of main, pla in the
   loop preamble). Recorded with "perf record -e cpu-clock", then
   "perf annotate --stdio main".

Results:
   - Without the patch, the output stops after the first prefixed
     instruction (11 lines). The last line is:
       10000440:  68 59 00 06  pli  r8,1500000000
     and everything after it is lost, including the "blr" at the end
     of main.
   - With the patch, the output has 32 lines. The continuation words
     appear as raw-byte lines with no mnemonic (10000444 and 10000454),
     and the function is shown through to "blr" at 10000490. There is
     no "(null)" in the output.
   - Under valgrind, both builds report the same error totals
     (8290 errors in 103 contexts).
   [- A -mcpu=power9 program, with no prefixed instructions, produces
     identical "perf annotate" output with and without the patch.]

I tested only this patch, on its own on top of master.

Tested-by: Tejas Manhas<tejas05@linux.ibm.com>

Thanks,
Tejas Manhas

--------------Yk2vRfYm0gGLg3ej2CrQGz2k
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>

    </pre>
    <pre class="moz-cite-prefix">On 07/09/26 10:44 am, Athira Rajeev wrote:
</pre>
    <pre type="cite"
    cite="mid:20260907051429.29080-1-atrajeev@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">Power10 introduces prefixed instructions that are 8 bytes wide.  objdump
emits these as two lines: the first carries both the raw bytes and the
mnemonic, while the second carries only the raw bytes of the second word
with no mnemonic:

  1020900c:  0b 00 10 06  pla  r31,757280  # 102c1e2c &lt;cctki_vi_ML_CCZ4&gt;
  10209010:  20 8e e0 3b

disasm_line__parse_powerpc() calls disasm_line__parse() on the mnemonic
portion of the line.  disasm_line__parse() returns -1 when the name
string is empty, which causes disasm_line__new() to return NULL, which
causes symbol__parse_objdump_line() to return -1, which immediately
breaks the objdump output parsing loop in symbol__disassemble_objdump().

The result is that annotation of any function containing a prefixed
instruction stops at the continuation word and all subsequent
instructions in the function are lost.

Fix this by treating an empty mnemonic as a valid case in
disasm_line__parse_powerpc(): skip the call to disasm_line__parse() and
set the instruction name to an empty heap-allocated string instead,
allowing parsing to continue to the next line.

Reported-by: Narendra Nalli <a class="moz-txt-link-rfc2396E"
    href="mailto:narnalli@in.ibm.com" moz-do-not-send="true">&lt;narnalli@in.ibm.com&gt;</a>
Reported-by: Vijay Puliyala <a class="moz-txt-link-rfc2396E"
    href="mailto:vpuliyal@in.ibm.com" moz-do-not-send="true">&lt;vpuliyal@in.ibm.com&gt;</a>
Signed-off-by: Athira Rajeev <a class="moz-txt-link-rfc2396E"
    href="mailto:atrajeev@linux.ibm.com" moz-do-not-send="true">&lt;atrajeev@linux.ibm.com&gt;</a>
---
 tools/perf/util/disasm.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index e263a2a8715d..8dca703a5c74 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -884,10 +884,24 @@ static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_ar
 	if (name_raw_insn[0] == '\0')
 		return -1;
 
-	if (disasm)
-		ret = disasm_line__parse(name, namep, rawp);
-	else
+	if (disasm) {
+		/*
+		 * Power10 prefixed instructions are 8 bytes and objdump emits
+		 * the second word on its own line with raw bytes but no
+		 * mnemonic, e.g.:
+		 *   1020900c:  0b 00 10 06  pla  r31,757280
+		 *   10209010:  20 8e e0 3b
+		 *
+		 * Treat a missing mnemonic as an empty instruction name rather
+		 * than a parse failure, so that parsing continues past it.
+		 */
+		if (name[0] != '\0')
+			ret = disasm_line__parse(name, namep, rawp);
+		else
+			*namep = strdup("");
+	} else {
 		*namep = "";
+	}
 
 	tmp_raw_insn = strndup(name_raw_insn, 11);
 	if (tmp_raw_insn == NULL)</pre>
    </pre>
    <pre>

Hi Athira,

Setup:
  - ppc64le, gcc 11.5.0
  - Base: torvalds/linux master at 7cd8495c0f16
  - perf built with libLLVM on. The default disassembler order puts
    LLVM first, so I set annotate.disassemblers = objdump in a private
    perfconfig file. "perf annotate -v" printed "Disassembled with
    objdump".

Test:
  A small loop built with -O2 -mcpu=power10 -mpcrel -mprefixed, which
  contains prefixed instructions (pli at the start of main, pla in the
  loop preamble). Recorded with "perf record -e cpu-clock", then
  "perf annotate --stdio main".

Results:
  - Without the patch, the output stops after the first prefixed
    instruction (11 lines). The last line is:
      10000440:  68 59 00 06  pli  r8,1500000000
    and everything after it is lost, including the "blr" at the end
    of main.
  - With the patch, the output has 32 lines. The continuation words
    appear as raw-byte lines with no mnemonic (10000444 and 10000454),
    and the function is shown through to "blr" at 10000490. There is
    no "(null)" in the output.
  - Under valgrind, both builds report the same error totals
    (8290 errors in 103 contexts).
  [- A -mcpu=power9 program, with no prefixed instructions, produces
    identical "perf annotate" output with and without the patch.]

I tested only this patch, on its own on top of master.

Tested-by: Tejas Manhas <a class="moz-txt-link-rfc2396E" href="mailto:tejas05@linux.ibm.com">&lt;tejas05@linux.ibm.com&gt;</a>

Thanks,
Tejas Manhas</pre>
  </body>
</html>

--------------Yk2vRfYm0gGLg3ej2CrQGz2k--


