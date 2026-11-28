Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C5606A31F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=muvSKStr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc92t5gy7z2y2B;
	Sat, 28 Nov 2026 23:44:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795869862;
	cv=none; b=OdCZtFgN33YI03NRGOaJs4lQKF6NEl5x4Q56EFD11UDBfG+m6EVbJYoUV8KfNPoHgmR76PrSi/rvVPl+rHqq/h4pT8FW9ZJocsnZIiZ4vL+hN6CKE53MCrh/37Al9hL+lglnrNR6zOYPguVaI7+zts9n0abBDX76YDxZoc4htNdc+wsulD8siLSVzXDTufWQH8qHyivS+wc5SYJRx1/I2UkoWb6F5R2trsIhAudIL2Z6+mE1GvgT4K3Lseue7k6ySqm0brkvQpsFmKBypKqMQa7FCr2xJBcOgurCfYPGgFo+/qGXODxXUOaaXc+m2ROI4s2hjCr2ZtubrX7RsRI9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795869862; c=relaxed/relaxed;
	bh=mHOPRRbZTSR5133Yoo5RkuBvuhnOIihibA5We42S4QU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=EeuSfrHv/sDRze17NFNb2hoMSbKSevRm0oEMrLbZ8VLPKL8UKDp1TiitSJT6pH4Ckq8wpadvQUW5xfAs+iIz47mvd6WzAOhmp7z/lzc9uP8A1v3ay3ZqZUGDrpZJKHc2IaP7q0WVYjudswKY8po54bN4KgoLeyq5PL1nVUZoqJWhud3H8MNVf9WRe0YuP9qOggMO5XbPhCn3II+liQV6IWDsOAv+JTxMeKWFt7Uo5g13kx192ziE3orJ2sAGNV2C8h6BcSDJmiE0l2IU89m0j75d8Iw+1H7VgOBuc6pKEPmQTcrHMM91ARy/uF2xpk1fG4/C4gsQM6AaIRpOKLOJDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=muvSKStr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=muvSKStr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc92s6wC2z2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 23:44:21 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ASAZNvs1452438;
	Sat, 28 Nov 2026 12:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mHOPRRbZTSR5133Yoo5RkuBvuhnOIi
	hibA5We42S4QU=; b=muvSKStrmPmsRhoLCysKg1vhyJzrrInx7bMBA1DpNcUY2w
	SL86NcELji9CsTd8VpNucygUqA9ct6RS0mGuBotQh3IKfstQEuLcMUbBPa9XFApj
	POUVqzzprpQONy9nXC1VNx5uKaRSJj/TxQm6Y8shJTJlq1hvpB0VK6FDyOzRgHoS
	tCQ6FsNZGxVbpMuQIbeyS7dtSx8HVsbbqHRhh1hCSI5uX6C4g1ivMKPGv3GrdRyb
	egufB4Gxnfhr3ouId5m2UpWM9z8gn27USB+toW3fHWwIfd4/J9OTf8oweNZiX4Pg
	0+YGzOKZNmPtTwD+SwAPV6r6G78IE5l4L8PMpcHQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j7mck1gam-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 12:44:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ASAJKAQ337845;
	Sat, 28 Nov 2026 12:44:11 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxxcf8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 12:44:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ASChGw566453864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Nov 2026 12:43:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09F8C58055;
	Sat, 28 Nov 2026 12:44:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA03D58043;
	Sat, 28 Nov 2026 12:43:59 +0000 (GMT)
Received: from [9.124.208.189] (unknown [9.124.208.189])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 28 Nov 2026 12:43:59 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------egCFxmqtTZ8AqtpGZmd8WTCs"
Message-ID: <f3bd50a1-1735-4e68-ba34-f8c8862c7e14@linux.ibm.com>
Date: Sat, 28 Nov 2026 18:13:57 +0530
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
From: Tejas <tejas05@linux.ibm.com>
In-Reply-To: <20260907051429.29080-1-atrajeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI4MDA1MCBTYWx0ZWRfX6jW9E9nP8h8h
 WDMN7HCKzKmbgC4dbxoC/+mJU98/BuyuZGfB3K19+xv4i6FglMx5EJ6FqvIBQHE+X11QAYYbpaU
 KDNo0ICA2FTdV8t9ugLwmP9BoWL6Sac=
X-Authority-Analysis: v=2.4 cv=MtfHeGae c=1 sm=1 tr=0 ts=6b0acc9c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=M5FQagozYrj46aOEjNgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=fOtGz01nnzjBLY0iox0A:9 a=iL7U6MYlty-rRZFQ:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI4MDA1MCBTYWx0ZWRfX/y7rpH4xQr0T
 g3S5q6KAdOXU2t9LUqwaO0mHZ4qxPN5Kslhi7fjphGC/ySjlGTrOREmaSp200T9bElMbaxtlNgf
 5wfFUIA7Tx5ND9ZVItwTUxu4DCNB51SM3x2Q3xg9y66lJF2+/80bkylYaBJ/DjjUOMs+yjHcR9t
 RurqNR7r/Qe6MirTKYUJ83PIa2Qw21q4o4XiNMF4i1dh7QRRlSva6lkD44TNRvcakQThXA002PA
 2VL2+HdTkImIRxXY3B/yyNuCTl6titL8bLjtwIR7t7AbvvZoLExfOavoQWJ6gAWKj6va9v75Guj
 fQoq2YKlnBqmnLjvR+pFcuiLWDK/GVxVo8qViUh4JISUTHtlu94OsFw5hjmQs7Rxyy9IPXDIY7D
 iozqWzuQ5MChjefOCq+zQCm+GaHvAJ9eTfoznwbgZbjfCtYGvdqkD6LWQ2+P02iXIbQTEfNdzU7
 GLc4mo97pBDZ0wmBTSQ==
X-Proofpoint-GUID: nGEMp9E4SUyCaUGXLD5sd0u7BDS_RKXv
X-Proofpoint-ORIG-GUID: 6_tHWFfTLPEDxgJ0YhOfso8JYPpju2Go
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-28_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611280050
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------egCFxmqtTZ8AqtpGZmd8WTCs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

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
       10000440:  68 59 00 06  pli  r8,1500000000
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

--------------egCFxmqtTZ8AqtpGZmd8WTCs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
    cite="mid:20260907051429.29080-1-atrajeev@linux.ibm.com"><pre
    wrap="" class="moz-quote-pre">Power10 introduces prefixed instructions that are 8 bytes wide.  objdump
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

Reported-by: Narendra Nalli <a class="moz-txt-link-rfc2396E" href="mailto:narnalli@in.ibm.com">&lt;narnalli@in.ibm.com&gt;</a>
Reported-by: Vijay Puliyala <a class="moz-txt-link-rfc2396E" href="mailto:vpuliyal@in.ibm.com">&lt;vpuliyal@in.ibm.com&gt;</a>
Signed-off-by: Athira Rajeev <a class="moz-txt-link-rfc2396E" href="mailto:atrajeev@linux.ibm.com">&lt;atrajeev@linux.ibm.com&gt;</a>
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
 	if (tmp_raw_insn == NULL)</pre></pre>
    <pre>
</pre>
    <pre>Hi Athira,

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
      10000440:  68 59 00 06  pli  r8,1500000000
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
    <pre type="cite"
    cite="mid:20260907051429.29080-1-atrajeev@linux.ibm.com"><pre
    wrap="" class="moz-quote-pre">
</pre></pre>
  </body>
</html>

--------------egCFxmqtTZ8AqtpGZmd8WTCs--


