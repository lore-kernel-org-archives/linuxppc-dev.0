Return-Path: <linuxppc-dev+bounces-21335-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAB1CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 14:18:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLr990VHlz2xqJ;
	Fri, 22 May 2026 00:18:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779373084;
	cv=none; b=PY7b9CT5tWcEzXkukVyvFBNKQkFiK8qd+3KxPjPZDLOX7AtZIow5vxbGThiShCD0UIpCVuOLwujHxl2rRneuxQcRZ+eeX2ualESr9nU67HLpyuQCODwofq8nccbBDPrtYiOnMPe9ibaYLynzdL5zRm/6FKQt0aqPbrhvf/O6mqc2UjLdknUF8MHxox6/sh2pvzZbAZGyyy8WY+3s+ugEqfabO9ocI07W289rbdJE6XABasUNkbzYe1fCbTeFjez1noBb5GqWeyloBY1Su8tMJWg7aE15rhcsrsVAsNV997Ihxve6XWeSDHj33JTrlJMxs0EKffteg0LV4KAGfcU7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779373084; c=relaxed/relaxed;
	bh=CU7Jj/X6QYmcmszy64Ym5CLJFYdXggn2LGX/XrIXs6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mi4XYvJPP7ffikgJT2qorGH7i36jjEt7oKsfuq/KrLV2sCyP3alT4gwTCTvn1oVkbsdwyRXmyW5qrPU0r4wsWU5JzIjatJwlpZQNmaU21YjL3HthqQQ0yJTWHHuESgBRpRidT9yZCfmVXBuzH+QcKt4/YqOM4aacMX0oSJxhQ8hnoYf2lpPRsuNKO+Em0jEZr9NPZ1F/0z38jt1kpa+6L9soR/bqdUUprIgkCBeEGMI3LYWbO15zcJvpzQ2LnWatAo3xMjZ7IoAD7XQW1+y1mtD88uo8vOayLWP9Z9y4jOcm8/RWyJVW/JMHuGFte/2J3A2L4kRHrLKKrolJ6u5Ywg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEw4Oz5F; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEw4Oz5F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLr9800C3z2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 00:18:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A4DCF600C3;
	Thu, 21 May 2026 14:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30191F000E9;
	Thu, 21 May 2026 14:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779373081;
	bh=CU7Jj/X6QYmcmszy64Ym5CLJFYdXggn2LGX/XrIXs6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AEw4Oz5FwLp5Q4ZQCje3wIdhbs4n701tJg1D6NntHxCY1enISj0o/kIYTYiycJHBK
	 n0y2N9/nYiQWGEDW6eCtizXtfL0z9Z4nPhMR1FEvyJR6+b7Al+8DTBrzzqwJO2RX65
	 4kAqp0NHgZPVGYXaV+KAdFAlhWJfD9T21T+KAGyPBCWtzcSRSYGw7H5Pz37Xl4h2HM
	 1YsrjrK2Br8MBQJyr+Bca4TJOp6VBsgzaCYT/Y07XxzoGiN/StSuaow94UZ7gzHvsn
	 0CknFojpO0wbLHIINZoQvZHT7YZSrHA4ygG2W/LL5iEB5aoVjQ+xl1PAXLnsjD2b7W
	 ZSBYHUCqJf8Vg==
Date: Thu, 21 May 2026 11:17:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	jolsa@kernel.org, adrian.hunter@intel.com, mpetlan@redhat.com,
	tmricht@linux.ibm.com, maddy@linux.ibm.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
	Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: Re: [PATCH] tools/perf/sched: Update process names of processes in
 zombie state for both -s and -S options
Message-ID: <ag8UFqPmRu8v4g_9@x1>
References: <20260426093930.47809-1-atrajeev@linux.ibm.com>
 <ae76k1BvfgcYI18K@google.com>
 <230801A2-5F9C-42A6-9390-B44786309E30@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230801A2-5F9C-42A6-9390-B44786309E30@linux.ibm.com>

On Thu, May 21, 2026 at 02:02:53PM +0530, Athira Rajeev wrote:
> > On 27 Apr 2026, at 11:26 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > On Sun, Apr 26, 2026 at 03:09:30PM +0530, Athira Rajeev wrote:
> >> In redhat perftool testsuite, observed fail for this test:
> >>    -- [ FAIL ] -- perf_sched :: test_timehist :: --with-summary (output regexp parsing)
> >> 
> >> This led to analysis of "perf sched timehist" summary options.
> >> 
> >>  # perf sched record -a -o ./perf.data -- sleep 0.1
> >>   This will record using perf sched record
> >> 
> >> perf sched timeliest has two options "-s" and "-S"
> >>  # perf sched -i ./perf.data timehist -S
> >> -S : Captures summary also at the end
> >> 
> >>  # perf sched -i ./perf.data timehist -s
> >> -s : Captures only summary
> >> 
> >> The test saves -s result which has only summary and compares with
> >> summary which comes at the end from -S . Since there is a difference
> >> in these two, test fails.
> >> 
> >> Checking the behaviour change in -S and -s results, difference is:
> >> 
> >>                  rcu_sched[16]       2          4        0.013      0.001       0.003       0.006   33.23       0
> >>               migration/11[73]       2          1        0.006      0.006       0.006       0.006    0.00       0
> >>                migration/3[33]       2          1        0.006      0.006       0.006       0.006    0.00       0
> >> -               :216753[216753]      -1          1        0.041      0.041       0.041       0.041    0.00       0
> >> +                 sleep[216753]      -1          1        0.041      0.041       0.041       0.041    0.00       0
> >>                migration/8[58]       2          1        0.005      0.005       0.005       0.005    0.00       0
> >>            NetworkManager[811]       1          2        0.089      0.028       0.044       0.060   36.06       0
> >>               migration/13[83]       2          1        0.005      0.005       0.005       0.005    0.00       0
> >> 
> >> Here 216753 is pid for sleep which is a zombie process. This is
> >> happening in latest kernel due to an update in "-S" result.
> >> In -S, the process name appears in the results "sleep[216753]",
> >> where as in the -s, only pid is present in the summary result
> >> ":216753[216753]".
> >> 
> >> After commit 39f473f6d0b2 ("perf sched timehist: decode process names
> >> of processes in zombie state")
> >> for -S option, if process name is using pid, it uses different way to
> >> set it. So that we get the process name and not just Pid.
> >> 
> >> This change went in only for timehist_print_sample() function.
> >> Add this improvement in generic place so that even -s option (which
> >> captures summary) also will have meaningful information.
> >> 
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Thanks,
> > Namhyung
> Hi,
> 
> Can we please have this pulled in, if the patch looks fine ?

Can you please check applying it on top of current perf-tools-next?

Thanks,

- Arnaldo

