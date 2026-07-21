Return-Path: <linuxppc-dev+bounces-24614-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1B9C4452B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 18:57:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4RT912xFz2xqM;
	Wed, 22 Jul 2026 04:57:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784660237;
	cv=none; b=LcXcdfVPQnGYCZ95pyzkoShXmqxotV2OkBox4icFs1D/0ehae3wiqsqi+QsWq3TaMyDytZWU/5OWqNZvyz7tVb3eZ50ZVloCSE71MGGo71xy+JEMImW8zLd4c6NozRhrK5+1E+TlBeJ4kjOa6KV8mPgEaZEG70+N6KUx7bZCLF1sNx0gfZfoKQMnp4MB9OWUflrlvdtGhx+qBdlUXkOukCvio27a9I5cN6McpNBQMuqhfjPVLqFxaAyWPcn8oMC+RiBiSpYUs2BR7/kcYZH+BUhfFYDfIkREa67wA76808CiHYFphBmujlPBCbKOgKPcGVHoqq3t8T0J8jbxwql0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784660237; c=relaxed/relaxed;
	bh=KoT2TsS6gtGe74KLPWSGIUIoVkvWimK3dE2FWgygnh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgu89GSRZtH/7kz/1SOLE15rZGEbbHzIUF+AzJifQ7avnIDodW9NzbkftYuuJJN9zMzzX7b0G+aNqRaD13I5SbYsnZ335z4Wda9E/+Jt2AjBtvcBCklmbnxP1trt9f4cEgR9+81L0cKiB/8JAmY+eO4+ahGt2NXualHU9G7HL5h4NI4njQRW0WBj7DlOvAZb1IOaU/lpY1fJG1ZUIrAtxrikHZTTjT1hCRJbZb8hLPsmC67OVjdrlV++qmI1PDQfLuQZxcD7vUsQXe/ulxDAsysWTpVY48X4AfDNGmcFOHRsOK2su2zFfviaISOdzGvC40TjoeOGnSJmj8pg8cHwLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qLaitttU; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qLaitttU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4RT75Txfz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 04:57:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4ED82600D8;
	Tue, 21 Jul 2026 18:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5DB1F000E9;
	Tue, 21 Jul 2026 18:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784660232;
	bh=KoT2TsS6gtGe74KLPWSGIUIoVkvWimK3dE2FWgygnh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qLaitttUKP1kkMKUiYajS0ZobTYQ3s5ukfeb2Umb4lTEqZ47NJP7LLLBNI4XuwpZS
	 TmdNv+kVD+RDjV6eg1GjtP0L4ZNZIcZtcddMjbL98rlJIoq7nbjJh8OfarP137Xr9z
	 joytXDV0CrUBvLaERSJRYz75K/Y1g6BM8xJvkSIA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Hari Bathini <hbathini@linux.vnet.ibm.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Shivani Nittor <shivani@linux.ibm.com>,
	Tanushree Shah <tanushree.shah@ibm.com>,
	Tejas Manhas <tejas.manhas1@ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1 0901/2077] powerpc tools perf: Initialize error code in auxtrace_record_init function
Date: Tue, 21 Jul 2026 17:09:34 +0200
Message-ID: <20260721152614.070795462@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721152552.646164743@linuxfoundation.org>
References: <20260721152552.646164743@linuxfoundation.org>
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

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Athira Rajeev <atrajeev@linux.ibm.com>

[ Upstream commit 789d22d77879eabb042627f6627cdb62787bc142 ]

perf trace record fails some cases in powerpc

 # perf test "perf trace record and replay"
 128: perf trace record and replay                                    : FAILED!

  # perf trace record sleep 1
  # echo $?
    32

This is happening because of non-zero err value from
auxtrace_record__init() function.

 static int record__auxtrace_init(struct record *rec)
 {
        int err;

        if ((rec->opts.auxtrace_snapshot_opts || rec->opts.auxtrace_sample_opts)
            && record__threads_enabled(rec)) {
                pr_err("AUX area tracing options are not available in parallel streaming mode.\n");
                return -EINVAL;
        }

        if (!rec->itr) {
                rec->itr = auxtrace_record__init(rec->evlist, &err);
                if (err)
                        return err;
        }

Here "int err" is not initialised. The code expects "err" to be set from
auxtrace_record__init() function.

Update auxtrace_record__init() in arch/powerpc/util/auxtrace.c to clear
err value in the beginning.

- Clear err value in beginning of function. Any fail later will
set appropriate return code to err.

- Even if we haven't found any event for auxtrace, perf record
should continue for other events. NULL return
will indicate that there is no auxtrace record initialized.

- Not having "err" set here will affect monitoring of other events
also because perf record will fail seeing random value in err.

Set err to -EINVAL before invoking auxtrace_record__init() in
builtin-record.c

With the fix,

  # perf trace record sleep 1
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.033 MB perf.data (228 samples) ]

Fixes: 1dbfaf94cf66ec4b ("perf powerpc: Add basic CONFIG_AUXTRACE support for VPA pmu on powerpc")
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Shivani Nittor <shivani@linux.ibm.com>
Cc: Tanushree Shah <tanushree.shah@ibm.com>
Cc: Tejas Manhas <tejas.manhas1@ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/arch/powerpc/util/auxtrace.c | 6 ++++++
 tools/perf/builtin-record.c             | 1 +
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
index e39deff6c857a8..4600a1661b4fe3 100644
--- a/tools/perf/arch/powerpc/util/auxtrace.c
+++ b/tools/perf/arch/powerpc/util/auxtrace.c
@@ -71,6 +71,12 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 	struct evsel *pos;
 	int found = 0;
 
+	/*
+	 * Set err value to zero here. Any fail later
+	 * will set appropriate return code to err.
+	 */
+	*err = 0;
+
 	evlist__for_each_entry(evlist, pos) {
 		if (strstarts(pos->name, "vpa_dtl")) {
 			found = 1;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4a5eba498c0259..708825747af5da 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -865,6 +865,7 @@ static int record__auxtrace_init(struct record *rec)
 	}
 
 	if (!rec->itr) {
+		err = -EINVAL;
 		rec->itr = auxtrace_record__init(rec->evlist, &err);
 		if (err)
 			return err;
-- 
2.53.0




