Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C106606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=a43eJgmn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc91j2X9vz2xjP;
	Sat, 28 Nov 2026 23:43:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::1b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795869801;
	cv=none; b=V9+E/9rYEoXzPozBZ7eyc9lhMhvIgxBXMIEX0EKM9oekODC9S2aJ3ZRckotQyH33unMUWmgXZ1PlVIRiLqM1k714FKDumu0dG3yjR6JuJpaw3FqVk6aRrme0FZrkoMLdr903rnpzA4sC20rZIM07XEPN/aLWwY0U10KveFmHftCwuPVe5DHHJ3Cb4Hlq0wKLINcOE4+CIMgmAivLuGks/QAg1gIY8S39s6k9L9uPXfKW44nJvkFEfiG+w+qMP+8AajFqDtuDEd2+OVGzzD6N/LYbSNgBj0xCum5O55OtM7RJS++5vNCrB1OtoJZG+FKlTddRRPjGOW50pgtgb2SC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795869801; c=relaxed/relaxed;
	bh=mcSnvFjvFQU6PiHrX1TmhgXI2s7ud5WUWAo4YI1LSXM=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=aweTFFk6J1tzYdhJo8aRVpaerfWX9VVEbHxkoiEF4JM0Hq/oscWMyadIhuC+5UsUPlc5BFFrTc5guPF7RHEagbyH6HID9T7UT1pBxnAQgOGaDKBmQE1iPx0e4U+z6M2gGz1HbdqAMEZ/AxiOJVqbE4AZgkU2XIy8xpJnfP2g93PuZEwTm8vsNKrsEz6e5+tGQC3ZdaZ9pyFsMRYkWTkP4bRKTvOQ7Y3wywjKjG9u35nUY05HV0m5g5aA6gZ5FQOV0MaTzUb4ydmy2UgSpWssqGRJ4o8Y0MqHao1t6TL4uqxG+VgnDO1YZzRAfqHVYJws3GvEKByCcr63KyCK7oYUlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=a43eJgmn; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::1b; helo=mta0.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=a43eJgmn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::1b; helo=mta0.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-27.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc91f0NPZz2xRm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 23:43:16 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=dBjXip2DbBfZmo4Rbdun8IWodbOJKv0ncQqSEzyjc3M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795869773; v=1; x=1796474573;
 b=a43eJgmnjy+zI/eZ2rboGVD9vtfffxcKGEYGHlzd5RWe3jLE+2NmfKJGDJnO1QTn8nXxyAbP
 TUpMMvGwXySaGi/pxmLivDuvcQTlcPFUw7PVUFmn7DSTLB4My9r1dx1WOCAu4FXAYss/+QtL9BW
 vh2eR43f8IK6gU5SaOh85T7Q=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 9f8eb6a363332ba6;
	Sat, 28 Nov 2026 12:42:53 +0000
X-Mizu-Trace-ID: 9f8eb6a363332ba6
X-Migadu-Flow: FLOW_OUT
Date: Sat, 28 Nov 2026 12:42:52 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: atrajeev@linux.ibm.com
CC: acme@kernel.org, adrian.hunter@intel.com, hbathini@linux.vnet.ibm.com,
 irogers@google.com, jolsa@kernel.org, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, namhyung@kernel.org,
 narnalli@in.ibm.com, tejas05@linux.ibm.com, tshah@linux.ibm.com,
 venkat88@linux.ibm.com, vpuliyal@in.ibm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_perf_disasm_powerpc=3A_handle_Pow?=
 =?US-ASCII?Q?er10_prefixed_instruction_continuation_lines?=
In-Reply-To: <20260907051429.29080-1-atrajeev@linux.ibm.com>
Message-ID: <A6D85F06-F669-4788-A450-01B8DD686197@linux.dev>
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

On 7 September 2026 06:14:29 BST, Athira Rajeev <atrajeev@linux.ibm.com>
wrote:
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
>Reported-by: Narendra Nalli <narnalli@in.ibm.com>
>Reported-by: Vijay Puliyala <vpuliyal@in.ibm.com>

yes, thanks

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>


Tested-by: Bradley Morgan <bradley.morgan@linux.dev> # Power10


>Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
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
> 
>-	if (disasm)
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
> 
> 	tmp_raw_insn = strndup(name_raw_insn, 11);
> 	if (tmp_raw_insn == NULL)
>

--- Thanks!

