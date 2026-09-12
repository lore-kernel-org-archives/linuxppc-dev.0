Return-Path: <linuxppc-dev+bounces-27176-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F9FC88E56
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 16:02:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhx5S2YYsz2yYd;
	Sun, 13 Sep 2026 02:02:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789228972;
	cv=none; b=PEp63u2k3gAtmnmZUCk8w7lUbyET7tjTK1csKXLAbG/76IFw4O/UyZle4bPNIXn/narXjEypvT6vpzpGw4p9H3sDySK5yneas2C6Q5H0rpNStVY2S4l3f+SczS0qI75vlZrDjnV+Bmg9PNLA51pJ1Xty1RIlnfdD1qWpor39K67fsgChaVUkGlvGTlrADJtAHOMUFT/ccq+huIpT8o67Fha1PJOh8luk8rsZD4eIFR4OR1QicMMVH/emytHhQlHXdeWWJNzjiolQc9l3SR8X/uejrEB1zjfe7vsQbwNo9hXvTuUOacwwR87jr27X0e3tKvBDYRG+S5V42qbdYl1qVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789228972; c=relaxed/relaxed;
	bh=lTCdta7tqo18hZwWAZEXcR+HjTit0+vU2+AYaLl5MMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQFZ3H8+D/ZigWqPpFTYWIwR4S3BU4gz/754wWaFrIG1aM7Aq5hR6mXXS8Dn2jfLqutlhmZjZU/27VPywyedw5SABs6QQfAo+3acQdHN8pyGejwTAimnH8MN6glCu9TkubnZTVZKegCRV4WtXMEPEVFejxRErgBCCFALZU1QD3Xf3E+61qUw6zC4Mo9X3B/JmnwR80JfYfS0YMpF8Gv23Qih2KyU2Un+i8k9FYoy6jGFf/HBSuO4cvEi8rCLOh3mv8RCt9WADVr4f1zvV8qmSmv6rZxV9ckscAwFr7kDAFWyj5G3rHlMWtpKVzhCijTshG7Ydeoo8ex2eI4DOkX0LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uhzmuwkj; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uhzmuwkj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhx5R317qz2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 02:02:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3F184414E3;
	Sat, 12 Sep 2026 16:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297271F000FF;
	Sat, 12 Sep 2026 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789228968;
	bh=lTCdta7tqo18hZwWAZEXcR+HjTit0+vU2+AYaLl5MMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uhzmuwkjcR4Cn1VGp0NG1Iq762w0jhbauMQ2ioj6k7vfHjaP+Y29MNV2q7w5nR4TY
	 7dulHslt6JTshFGE7CsDPWNvstl65P0xfgEOmNYhmLnUYgXEvVXMFwDejA0ZG65eqr
	 HRNQXecsSV5uDbUpWAQqC9GkGvMpMsBspOgrsyFo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ian Rogers <irogers@google.com>,
	Disha Goel <disgoel@linux.vnet.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 0493/1191] perf tests stat_bpf_counters: Fix usage of == to address shellcheck warning
Date: Sat, 12 Sep 2026 08:53:41 +0200
Message-ID: <20260912065559.304319358@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912065548.086904252@linuxfoundation.org>
References: <20260912065548.086904252@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

[ Upstream commit d10eedd87bb3e7678c3a0f77a5cfe7150a318ee2 ]

Running shellcheck on stat_bpf_counter.sh generates below
warning:

   In tests/shell/stat_bpf_counters.sh line 34:
   if [ "$base_cycles" == "<not" ]; then
                       ^-- SC3014 (warning): In POSIX sh, == in place of = is undefined.

   In tests/shell/stat_bpf_counters.sh line 39:
   if [ "$bpf_cycles" == "<not" ]; then
                      ^-- SC3014 (warning): In POSIX sh, == in place of = is undefined.

Fix this by using "=" instead of "==" to work for
all shells.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lore.kernel.org/r/20230709182800.53002-10-atrajeev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: b02027776ac5 ("perf tests: Fix flakiness in BPF counters test on hybrid systems")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 6bf24b85294c7..a87bb2814b4c6 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -31,12 +31,12 @@ if ! perf stat -e cycles --bpf-counters true > /dev/null 2>&1; then
 fi
 
 base_cycles=$(perf stat --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
-if [ "$base_cycles" == "<not" ]; then
+if [ "$base_cycles" = "<not" ]; then
 	echo "Skipping: cycles event not counted"
 	exit 2
 fi
 bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
-if [ "$bpf_cycles" == "<not" ]; then
+if [ "$bpf_cycles" = "<not" ]; then
 	echo "Failed: cycles not counted with --bpf-counters"
 	exit 1
 fi
-- 
2.53.0




