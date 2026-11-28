Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956B606A31F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rO+Inwfs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc6J51DKMz2xLm;
	Sat, 28 Nov 2026 21:40:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795862437;
	cv=none; b=gUgMWQjyBh3opETFd5NJfQctkDkFCsdCDs/BTQbhOYE0r5+h1pd6zho6Gwfippfpq9QAXG7BiolwiEgX8hV5sczAUGb1bIZxKq6qiwXbOaZ2ke0k9zwSx3+vD6Q+c57kQ6+Rl5gFpwZ7SKthoQ7/H5NAwWYNWTGQrMaNPt0LJo/F4CH0YbfhH1hPVlSH5IRvBlwmL5YOGnOSI2AAHk87noNDNw75DiFeXjOh3r/vXa9zsboHvsV8APl+W7ddMBpHUNuxC1RRGsKx9zMOU0cYbLL0OqoI6lIbRwHikVkAcYEUUHl3bLV/xa4M8SlHXsTxX8V9FyscP2OIwtK79h7UtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795862437; c=relaxed/relaxed;
	bh=lTQ5jRA1x5EX1hFqXoQA8az5WQ9cPFui2pIGxqX9VsU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=R0qoegFtj8RhZfKH4kzPpTFqevYS/2r1uCuRpznpK+ry6wa7Lf7FMriFrI9ZfghEIojmZKIyQ3yaDjbFzao8IhClko6O/qrntkA8JcXkdw02oobs39nHWtnOt35SjNsFIR/HxhJz/IxygBh16N42K6D3LcqZkOF7Ju9mP744udd6eqDFkBYvH48EqNHoJlx/gSl/lRhiQxTwl045SgEArR40LNVWccj3qsVeFVH7lDBytaY46Ls3cFrllfJxkqrZzp4wdqhUd30Ds9r0Ke1qQ1ndt0T/ympi6p1cWQNPiocn+F+FpJUPkKJGZiTCmI/zoEhxnca4hVZp1cwqIHnk3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rO+Inwfs; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rO+Inwfs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc6J33Qykz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 21:40:34 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ASAZ2nK1479247;
	Sat, 28 Nov 2026 10:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lTQ5jRA1x5EX1hFqXoQA8az5WQ9cPF
	ui2pIGxqX9VsU=; b=rO+InwfsOI+7/eiFt0rm2kaLa6oIbwRZZz0YGveICOxRSx
	QzNuEK8FayiKfNXmC2F309P2yU9StpFoZe8p+SXwhGaOCByeOD8J2yAei0P/PVWX
	rE6bdU3bE9+ZxSwtAzQO3homsGxz9hrSfG2T5UFeQstVA+nTvOl0wrHaeiaLeMmH
	+/JCTr5sO2gQCG/EvXygEHcORQ7D4ybXXvl8j6YEa8LmnTjZJo0uLgMVAk2d9Na5
	Z2ZmLHAWH8TZ+UB9ZqxQM3EV3hUhmVrewNA1w4arbcbozfVueLdaJe98fd9l7dZZ
	BuacbcOGsmVw1j3wJyd6bI3yhBsLRB2mRWbCtRRA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j7pktrx9r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 10:40:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ASAJNx42144264;
	Sat, 28 Nov 2026 10:40:25 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6mjg7fn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 10:40:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ASAeNNL17957428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Nov 2026 10:40:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42DB158043;
	Sat, 28 Nov 2026 10:40:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B1F258059;
	Sat, 28 Nov 2026 10:40:15 +0000 (GMT)
Received: from [9.124.208.189] (unknown [9.124.208.189])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 28 Nov 2026 10:40:14 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------WV5B2tG2fTs0r10yZvSA5rPv"
Message-ID: <f46bbaf2-2c30-44a4-bfd0-ed0de70cf8b7@linux.ibm.com>
Date: Sat, 28 Nov 2026 16:10:12 +0530
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
X-Authority-Analysis: v=2.4 cv=KZZHIgYD c=1 sm=1 tr=0 ts=6b0aaf9a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=RyoXfTChUDZ5n2tJ4yAA:9 a=QEXdDO2ut3YA:10 a=DnKhKxHaaOjCy7Ko70YA:9
 a=5TUZgkD5xrT8xjf4:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI4MDA0MiBTYWx0ZWRfX7tnNmVnAJeud
 vM9iR3aH1DfF7CHoBQ1gXCsx/B94kvnST30aCTHyb/HzROTrP6MpyXqqPcyT7l9FKei1Ah9fURl
 9J/Qs/tFdHd3TG+a8JGkklPnK4r4h6OLVb0O/zno902kRoVLwGHEF40lPHO5VGPcVix8LscmQ7J
 +7TTMGQTG3+8rRQPLSg0v9IqNNg8fFqGEcA83mo0yS3RhngY5ITBRpKd9rkwFuQQraHJolxaHqw
 mCwCOW+mu7dA8T4H8XBN8gDGSJyVTo4Wm+mUwLrh4S5wTMnCDwitPz0Rd1bJH0kIp8Zp2+aZ+y/
 nKUo/kej/yIJ1M7WYKvTrZs7rZVqzAVTV/IYcsTEhOJynOgT4xm7PSXTxM5i6o6OhOrnbV1UkcG
 9+bm9ti7HIyM8tyz4VtUB7ukyLKDYvlKoCTPr0X1oJFVUwG/rnyJnifSdsviIa8tNqtCT333bDU
 a4GqA/udbm5RftfF1PQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI4MDA0MiBTYWx0ZWRfX7VMBzX6MpGKj
 QSdqz3y44aUICn2SKtdBjlM/8I81Uo98mfM4v63mrmik5rWN9mZHqJQQGXr1/hkggn2tb3+BFXz
 UGbPMq0QS4/+7NNKUUXhDuvD96nMfRY=
X-Proofpoint-ORIG-GUID: Az-2dxdArIGLcZACrOHhEZMXWFy_bRUB
X-Proofpoint-GUID: SQLmUJbbxxexNs9SpAIQDW3LvdKGGQRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-28_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611280042
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------WV5B2tG2fTs0r10yZvSA5rPv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 07/09/26 10:44 am, Athira Rajeev wrote:

> Power10 introduces prefixed instructions that are 8 bytes wide.  objdump
> emits these as two lines: the first carries both the raw bytes and the
> mnemonic, while the second carries only the raw bytes of the second word
> with no mnemonic:
>
>    1020900c:  0b 00 10 06  pla  r31,757280  # 102c1e2c <cctki_vi_ML_CCZ4>
>    10209010:  20 8e e0 3b
>
> disasm_line__parse_powerpc() calls disasm_line__parse() on the mnemonic
> portion of the line.  disasm_line__parse() returns -1 when the name
> string is empty, which causes disasm_line__new() to return NULL, which
> causes symbol__parse_objdump_line() to return -1, which immediately
> breaks the objdump output parsing loop in symbol__disassemble_objdump().
>
> The result is that annotation of any function containing a prefixed
> instruction stops at the continuation word and all subsequent
> instructions in the function are lost.
>
> Fix this by treating an empty mnemonic as a valid case in
> disasm_line__parse_powerpc(): skip the call to disasm_line__parse() and
> set the instruction name to an empty heap-allocated string instead,
> allowing parsing to continue to the next line.
>
> Reported-by: Narendra Nalli<narnalli@in.ibm.com>
> Reported-by: Vijay Puliyala<vpuliyal@in.ibm.com>
> Signed-off-by: Athira Rajeev<atrajeev@linux.ibm.com>
> ---
>   tools/perf/util/disasm.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index e263a2a8715d..8dca703a5c74 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -884,10 +884,24 @@ static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_ar
>   	if (name_raw_insn[0] == '\0')
>   		return -1;
>   
> -	if (disasm)
> -		ret = disasm_line__parse(name, namep, rawp);
> -	else
> +	if (disasm) {
> +		/*
> +		 * Power10 prefixed instructions are 8 bytes and objdump emits
> +		 * the second word on its own line with raw bytes but no
> +		 * mnemonic, e.g.:
> +		 *   1020900c:  0b 00 10 06  pla  r31,757280
> +		 *   10209010:  20 8e e0 3b
> +		 *
> +		 * Treat a missing mnemonic as an empty instruction name rather
> +		 * than a parse failure, so that parsing continues past it.
> +		 */
> +		if (name[0] != '\0')
> +			ret = disasm_line__parse(name, namep, rawp);
> +		else
> +			*namep = strdup("");
> +	} else {
>   		*namep = "";
> +	}
>   
>   	tmp_raw_insn = strndup(name_raw_insn, 11);
>   	if (tmp_raw_insn == NULL)


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

--------------WV5B2tG2fTs0r10yZvSA5rPv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <pre class="moz-cite-prefix">On 07/09/26 10:44 am, Athira Rajeev wrote:
</pre>
    <blockquote type="cite"
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
 	if (tmp_raw_insn == NULL)</pre>
    </blockquote>
    <p><br>
    </p>
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

Tested-by: Tejas Manhas <a class="moz-txt-link-rfc2396E" href="mailto:tejas05@linux.ibm.com">&lt;tejas05@linux.ibm.com&gt;</a>

Thanks,
Tejas Manhas</span></pre>
  </body>
</html>

--------------WV5B2tG2fTs0r10yZvSA5rPv--


