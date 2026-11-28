Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D68606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HvAsDFCF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc98Q1S65z2xLg;
	Sat, 28 Nov 2026 23:49:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::dc"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795870150;
	cv=none; b=cHW5bSEYtssCEmcDTET6yanVD5MnjD0mPkP/F0d9IPdDiAmjlFdWjuLIYx5GSjrkNjiq+DNnGfgk//jNe3Q7sFCtJy1OM/pKCtSCuL+O0/nCEas/ohNktaam7JNYaFjDfgt1flfuRMuCoK/Jj/EZAo2vUnQ85cIBnjx3awBtCo/wU45IIc1D5JvsFFzFuBN0wUwVx+ixL4fdAtlkISjeCMhPA7zMhX6dXFTRrSbn87REO/5wpinuRPXn7NhjW676gKe3oO58ebBOJ7oNHXPH/Lm5kfPuTP8MAph6Cmh5jahaaWprQcClLeebT4iwIJOKHhP2uCo3Qbmz/u4nCAILiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795870150; c=relaxed/relaxed;
	bh=gIfvq51oA720HhwU0F1GHigwl6rmqBP3+0n65Dv1fLs=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=MojjHucEpf/aAo7GhQPELvxJXI9CeOpFlvuTnA9H/GOtWr10WFI1uaQ94ib7K+HxrJUUBSyLL5qgS03Yl5eHq3ytt2GEyYbNv+UzAePyYo/S0YLkwV8/cn3GAO3xocMY20YWwO9psPhd+tWIeHIjUgCrAHpSczc3OCS7VZ338gMqyjo4WWZ45Vh94mvurKKrmSfDxPn1OhJZmBY99vlyqKFTrL7ADYCAeQBEr4oPJ+EZkEQWic9gI1Pxyq9IT5e5GC5Rp1tI4GDcmKEflbUtrO701bLAgXcuUepBhaqjTk9iG3AHVsbThe8bPcO2H2ahZCGJA0naIxe3BwrBmiaM5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HvAsDFCF; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::dc; helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HvAsDFCF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::dc; helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 79 seconds by postgrey-1.37 at boromir; Sat, 28 Nov 2026 23:49:09 AEDT
Received: from mta1.migadu.com (out-220.mta1.migadu.com [IPv6:2001:41d0:203:375::dc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc98P0k4Zz2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 23:49:08 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=c1Ffl/QbgcGiLRawBnVlHFy51A2apNsBSzK92C4svPg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795870130; v=1; x=1796474930;
 b=HvAsDFCF8hKWad8Xi+eChaE2k+aju0fudiTT88tWe1qbcPQGYi8yyJBGl3OdJQbHRoHdHT4i
 3ILaK17IC89oow2PwyAbMGgvFDu2rt62thS1QWDqbg2h9oezsX5uJKfQomFxICHXkWw7VBCeZKC
 q5m/AqFJEnL7bDZ6ZYMCQHhY=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id a5187c36e3798bf9;
	Sat, 28 Nov 2026 12:47:30 +0000
X-Mizu-Trace-ID: a5187c36e3798bf9
X-Migadu-Flow: FLOW_OUT
Date: Sat, 28 Nov 2026 12:47:26 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: tejas05@linux.ibm.com
CC: acme@kernel.org, adrian.hunter@intel.com, atrajeev@linux.ibm.com,
 hbathini@linux.vnet.ibm.com, irogers@google.com, jolsa@kernel.org,
 linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, namhyung@kernel.org, narnalli@in.ibm.com,
 tshah@linux.ibm.com, venkat88@linux.ibm.com, vpuliyal@in.ibm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_perf_disasm_powerpc=3A_handle_Pow?=
 =?US-ASCII?Q?er10_prefixed_instruction_continuation_lines?=
In-Reply-To: <f3bd50a1-1735-4e68-ba34-f8c8862c7e14@linux.ibm.com>
Message-ID: <37618F0D-7C1D-445E-BD05-F4D7BF613C44@linux.dev>
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
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28 November 2026 12:43:57 GMT, Tejas <tejas05@linux.ibm.com> wrote:
>On 07/09/26 10:44 am, Athira Rajeev wrote:
>
>Power10 introduces prefixed instructions that are 8 bytes wide.  objdump
>emits these as two lines: the first carries both the raw bytes and the
>mnemonic, while the second carries only the raw bytes of the second word
>with no mnemonic:
>
>  1020900c:  0b 00 10 06  pla  r31,757280  # 102c1e2c <cctki_vi_ML_CCZ4>
>  10209010:  20 8e e0 3b
>
>disasm_line__parse_powerpc() calls disasm_line__parse() on the mnemonic
>portion of the line.  disasm_line__parse() returns -1 when the name
>string is empty, which causes disasm_line__new() to return NULL, which
>causes symbol__parse_objdump_line() to return -1, which immediately
>breaks the objdump output parsing loop in symbol__disassemble_objdump().
>
>The result is that annotation of any function containing a prefixed
>instruction stops at the continuation word and all subsequent
>instructions in the function are lost.
>
>Fix this by treating an empty mnemonic as a valid case in
>disasm_line__parse_powerpc(): skip the call to disasm_line__parse() and
>set the instruction name to an empty heap-allocated string instead,
>allowing parsing to continue to the next line.
>
>Reported-by: Narendra Nalli<narnalli@in.ibm.com>
>Reported-by: Vijay Puliyala<vpuliyal@in.ibm.com>
>Signed-off-by: Athira Rajeev<atrajeev@linux.ibm.com>
>---
> tools/perf/util/disasm.c | 20 +++++++++++++++++---
> 1 file changed, 17 insertions(+), 3 deletions(-)
>
>diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
>index e263a2a8715d..8dca703a5c74 100644
>--- a/tools/perf/util/disasm.c
>+++ b/tools/perf/util/disasm.c
>@@ -884,10 +884,24 @@ static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_ar
> 	if (name_raw_insn[0] == '\0')
> 		return -1;
> -	if (disasm)
>-		ret = disasm_line__parse(name, namep, rawp);
>-	else
>+	if (disasm) {
>+		/*
>+		 * Power10 prefixed instructions are 8 bytes and objdump emits
>+		 * the second word on its own line with raw bytes but no
>+		 * mnemonic, e.g.:
>+		 *   1020900c:  0b 00 10 06  pla  r31,757280
>+		 *   10209010:  20 8e e0 3b
>+		 *
>+		 * Treat a missing mnemonic as an empty instruction name rather
>+		 * than a parse failure, so that parsing continues past it.
>+		 */
>+		if (name[0] != '\0')
>+			ret = disasm_line__parse(name, namep, rawp);
>+		else
>+			*namep = strdup("");
>+	} else {
> 		*namep = "";
>+	}
>  	tmp_raw_insn = strndup(name_raw_insn, 11);
> 	if (tmp_raw_insn == NULL)
>
>Hi Athira,
>
>Setup:
>  - ppc64le, gcc 11.5.0
>  - Base: torvalds/linux master at 7cd8495c0f16
>  - perf built with libLLVM on. The default disassembler order puts
>    LLVM first, so I set annotate.disassemblers = objdump in a private
>    perfconfig file. "perf annotate -v" printed "Disassembled with
>    objdump".
>
>Test:
>  A small loop built with -O2 -mcpu=power10 -mpcrel -mprefixed, which
>  contains prefixed instructions (pli at the start of main, pla in the
>  loop preamble). Recorded with "perf record -e cpu-clock", then
>  "perf annotate --stdio main".
>
>Results:
>  - Without the patch, the output stops after the first prefixed
>    instruction (11 lines). The last line is:
>      10000440:  68 59 00 06  pli  r8,1500000000
>    and everything after it is lost, including the "blr" at the end
>    of main.
>  - With the patch, the output has 32 lines. The continuation words
>    appear as raw-byte lines with no mnemonic (10000444 and 10000454),
>    and the function is shown through to "blr" at 10000490. There is
>    no "(null)" in the output.
>  - Under valgrind, both builds report the same error totals
>    (8290 errors in 103 contexts).
>  [- A -mcpu=power9 program, with no prefixed instructions, produces
>    identical "perf annotate" output with and without the patch.]
>
>I tested only this patch, on its own on top of master.
>
>Tested-by: Tejas Manhas<tejas05@linux.ibm.com>

You've sent 5 messages, what?

>
>Thanks,
>Tejas Manhas
>

--- Thanks!

