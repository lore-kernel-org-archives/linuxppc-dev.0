Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD1E606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Uofx2RJR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc7gC21kCz2xLm;
	Sat, 28 Nov 2026 22:42:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795866135;
	cv=none; b=WENIxEFr54B+UA44uvuT6MMb05pceZmUh3cwXAj0mDGdDqRCWGVS3Iw0mJTERYPq3Hwulfl6qcUNH575b1HBckS8GLUvOviIAzAUnh17Jkrlqjfoc4hphd/NI5hdvbR2V5mVIAJLdky7NSMtkIoAEeXuR7kVp96ACLkYiAK2E1FlOejo9nHfkrwB5wNm4sHqudiH3/aWq3LeXi/9coed9zNF+b/TtprMn6oGik+uWh3VNtsMNG1ck2F0s4Iq1MOgwrZ1ccTSnFL8KhvKJpspDt0zMJ7cDU9F6LRqlNnanJOPE5D6nTqjWH1V81tdMgYu+USmWBxaahrMyhPftAju7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795866135; c=relaxed/relaxed;
	bh=7yQKnrlJHsEJ6Hc3OYHTvpVEhul+YJ2o07LXysE+q0w=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=lGAFo46e/ocr97aeD2FGZVrhwCfkkLKWMRioNYOWON+6hvZhR4qNG6tJfFOQe1AfdIY3099RfO1ahYVoAha/H2tdJg+q0nvBkRotkTYWklW+qVwq4U1V2yNafWLPNnb4qyM4N7RP84J8sGBq0+pJX9sxA9hzrXx6K9MmnFP6sWjHV68/USZ/GZx5ley113XmJKyUn+vJ+jOOiRXxQt2oMdYxPK5L3GZyUaDBDuxGbv8yATWScuXG/pqVkK9CPWDGio8z7UN0t0NKr6yUZVTH6t4Z44Ufnhmckz0Y6H9nhPVk/MMJRzemwRGy8SNeHkse1/vRjE1MFjRVLrkV3b4jZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Uofx2RJR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Uofx2RJR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc7gB0v14z2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 22:42:13 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ASAZHED1633316;
	Sat, 28 Nov 2026 11:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7yQKnrlJHsEJ6Hc3OYHTvpVEhul+YJ
	2o07LXysE+q0w=; b=Uofx2RJRz97VCzE4RUpSnoCCpBitJqUNXFYc8QKq44ONQz
	V/EcQSMY88l//h3dqS8t3EzuAq/jy4qd3euhjvXhHUEOseSTgkT0CbaKieEYRySD
	I9MJpIK1hjMbqkK1QBNw13bptNSut4DtC+hGmE9bFJ69s7ZTHU6nIXJ1TMQSbWs2
	cFdeOVqE5krCFrWytzSLrUQu+EZ+VZjVMSUnIDe8od2XYA+lNkiyXB5qH4g3x9E6
	VyxL0lJZnCtQhxiV0ivmGywLNBHKmPRdB9zw0BD91RVn6l5eG666WmPG5aywjfTj
	/RbNnksAgqoNrVvm7CBU+Q4FycP5JMz4s569+pew==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j7pf3h41s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 11:42:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ASAJYRa979321;
	Sat, 28 Nov 2026 11:42:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6uccx3sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 11:42:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ASBg4d532899636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Nov 2026 11:42:04 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B820158055;
	Sat, 28 Nov 2026 11:42:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B377758043;
	Sat, 28 Nov 2026 11:41:56 +0000 (GMT)
Received: from [9.124.208.189] (unknown [9.124.208.189])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 28 Nov 2026 11:41:56 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------vSubtPqLM6EfGitbpjjC1530"
Message-ID: <3c25ecaf-202e-4187-b7e7-4938189a4938@linux.ibm.com>
Date: Sat, 28 Nov 2026 17:11:53 +0530
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI4MDA0NiBTYWx0ZWRfX7R9u/uCwMpge
 170AlK6yqd7AEcSQGfgEeI8k5r0m1W+Ig42SHrgl9zguqp1duzI3fv/yQGTd+32LIdhoXEL3g/b
 FC3SSeBzoQcLtJp+fs40F08blnnZfjM=
X-Proofpoint-ORIG-GUID: MHqQ2Bt38CgYWV7f-fkbOYcPc1JmDbic
X-Proofpoint-GUID: QOeweShkHvrHuawhc7BKRaiAoJJ4GI9s
X-Authority-Analysis: v=2.4 cv=R6eWitRX c=1 sm=1 tr=0 ts=6b0abe0f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=RyoXfTChUDZ5n2tJ4yAA:9 a=QEXdDO2ut3YA:10 a=DnKhKxHaaOjCy7Ko70YA:9
 a=UchmfdrJjBHIZtCe:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI4MDA0NiBTYWx0ZWRfX5kF3oojFM5ho
 Cu54JPVkuCTL8Ew7n7WdsTVFyuNV4snWv6B/B8LHSNzqwnY2xtu5AmU0KtGz5e1fcgVwn0BqDnB
 27VsnwmILVgLCNo/uttdzQtnd+aKsAhC2pJ36lOyfymZSjp2Juk85IqqZ30us9bEr6sfbPf469o
 gUNzgKmG+fvWyKUVTQTyOqKPTWBZnaYukbFUD51ED9EBD+FZ1W6rw19b0ntCZVAWt+7s4rmJcY5
 kzvg63i+jH8Po48xIh9w2+kd9stucToRJ1iFbzcM+peRYXrt+K+R3RcAkLzM5/SkUY7UNqjZ5bf
 Sni7ZikeYEvZ8H6P1Y/u7665MiPy6FsRzBpFAxkkA1k1vpgVmRCUfgwtzVpVt5gKIghsh9yQ+2P
 IFXnJfHeEe8BVMH6+9TQ1OnOR6D6jQRd8mowWNlH+Yh7UIf6FunZ4acmnEbtMwkQhNVMaT+y7/Z
 qEHHudzGk1IgbH9lXJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-28_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611280046
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------vSubtPqLM6EfGitbpjjC1530
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


     


     

Hi Athira, Setup: - gcc 11.5.0 - Base: torvalds/linux master at 
7cd8495c0f16 - perf built with libLLVM on. The default disassembler 
order puts LLVM first, so I set annotate.disassemblers = objdump in a 
private perfconfig file to make perf use objdump. "perf annotate -v" 
printed "Disassembled with objdump". Test: A small loop built with -O2 
-mcpu=power10 -mpcrel -mprefixed, which contains prefixed instructions 
(pli at the start of main, pla in the loop preamble). Recorded with 
"perf record -e cpu-clock", then "perf annotate --stdio main". Results: 
- Without the patch, the output stops after the first prefixed 
instruction (11 lines). The last line is: 10000440: 68 59 00 06 pli 
r8,1500000000 and everything after it is lost, including the "blr" at 
the end of main. - With the patch, the output has 32 lines. The 
continuation words appear as raw-byte lines with no mnemonic (10000444 
and 10000454), and the function is shown through to "blr" at 10000490. 
There is no "(null)" in the output. - I also ran "perf annotate" under 
valgrind on both builds. The error counts were identical (same 103 
contexts), and I saw no invalid read, write or free tied to the new 
code. I tested only this patch, on its own on top of master. I did not 
test the rest of the build-id series. Tested-by: Tejas Manhas 
<tejas05@linux.ibm.com> Thanks, Tejas Manhas

--------------vSubtPqLM6EfGitbpjjC1530
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

    </pre>
    <pre><span
style="font-family: -apple-system, &quot;system-ui&quot;, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Hi Athira,

Setup:
  - gcc 11.5.0
  - Base: torvalds/linux master at 7cd8495c0f16
  - perf built with libLLVM on. The default disassembler order puts
    LLVM first, so I set annotate.disassemblers = objdump in a private
    perfconfig file to make perf use objdump. "perf annotate -v"
    printed "Disassembled with objdump".

Test:
  A small loop built with -O2 -mcpu=power10 -mpcrel -mprefixed, which
  contains prefixed instructions (pli at the start of main, pla in the
  loop preamble). Recorded with "perf record -e cpu-clock", then
  "perf annotate --stdio main".

Results:
  - Without the patch, the output stops after the first prefixed
    instruction (11 lines). The last line is:
      10000440:  68 59 00 06  pli  r8,1500000000
    and everything after it is lost, including the "blr" at the end of
    main.
  - With the patch, the output has 32 lines. The continuation words
    appear as raw-byte lines with no mnemonic (10000444 and 10000454),
    and the function is shown through to "blr" at 10000490. There is
    no "(null)" in the output.
  - I also ran "perf annotate" under valgrind on both builds. The error
    counts were identical (same 103 contexts), and I saw no invalid
    read, write or free tied to the new code.

I tested only this patch, on its own on top of master. I did not test
the rest of the build-id series.

Tested-by: Tejas Manhas <a class="moz-txt-link-rfc2396E"
    href="mailto:tejas05@linux.ibm.com" moz-do-not-send="true">&lt;tejas05@linux.ibm.com&gt;</a>

Thanks,
Tejas Manhas</span></pre>
  </body>
</html>

--------------vSubtPqLM6EfGitbpjjC1530--


