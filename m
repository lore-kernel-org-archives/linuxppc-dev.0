Return-Path: <linuxppc-dev+bounces-27180-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914E7C88E56
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 18:36:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hj0W42yQwz2y2h;
	Sun, 13 Sep 2026 04:36:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789238208;
	cv=none; b=Fg+8SEyWVtlalJT45oUAu0zoPvneFEQ3YE60jVm0Vkef1Qcyrhpvrnfgyy3mtRjBpX/L2JNUY4qy++ParxovE6yJ79V+6ukK2lCGYq4zGnUr8QXQsYsHryouF0xbVpjC0Fw9qTuneh0d8/4Q+buhs440H7pKeV7TsizoqRb00Awr43ryG/T1wAlDX3rehflyvUxeICZgsCooKejFI2pjM9wxfRj2/INx5FsEDLuO+POlWW+UDsBqRJX2VLN/AoSb051dJrxqdOhsbA1BmRnYu7N4zw7bUtOzDmLch2I01eJFX6iFwg9/C4ggsTuYdsO2cw6w9EMP0hyCgwzYAKCfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789238208; c=relaxed/relaxed;
	bh=iejkqyzbVlmMHi77zsN8XyyqvQVmT9k74+Bf1WSDee0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPm4YLi70wLsBuNLRvbP15W3uGro3mtjGgkdF9NajSJMRfIzsGJmLpH0aj3g/ibWyaWxrGcLxYizgTzJl7tCPBejLQkYq/KiZAbGy5qsyYygAG6K4tfot3mUofkERL+Ui/dvv7Qj5cfQdFqAOhnwPskXovDnOObbMsnTFd3W075DQvjIoA19jbhqw3YnSTWoNywJ6vhszFljMf4g5D1ngB6UDUlDgYQZ2okM6w0foDpJX5tAK6rZMzUHRuvDJIjU4ZwuLrKU8jXxyisi8AOcr0qj0dcKMcjNM0DLkXYA/FcKpQPZZs7qvUw6u/ILeY+3RANEfhTRaoqOIftsoqT4KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZtMkhcjB; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZtMkhcjB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hj0W30CXvz2xWV
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 04:36:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5291960232;
	Sat, 12 Sep 2026 18:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24011F000FF;
	Sat, 12 Sep 2026 18:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789238203;
	bh=iejkqyzbVlmMHi77zsN8XyyqvQVmT9k74+Bf1WSDee0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZtMkhcjBKMeqPP+hbL40sZuUWxmQbZO0VdS0EIgM9RVgh+KHbDuvlUpATeiBt9zVr
	 N/W3f9A1J7NfuAEw1Sg0zRuVuCBQRCXCaUVcsR3g5ci40bdOg9xULkQ4sYGj9pPABU
	 4ZerJC4vmdguxR/p7rtCezEtjThZa789JcEaFXdA=
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
Subject: [PATCH 5.15 415/935] perf tests stat_bpf_counters: Fix usage of == to address shellcheck warning
Date: Sat, 12 Sep 2026 08:57:25 +0200
Message-ID: <20260912065536.341381366@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912065526.833703348@linuxfoundation.org>
References: <20260912065526.833703348@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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




