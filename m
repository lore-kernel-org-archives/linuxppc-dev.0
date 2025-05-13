Return-Path: <linuxppc-dev+bounces-8545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3D5C3ABC9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 May 2025 21:13:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zxq2R5F8Hz2yF1;
	Wed, 14 May 2025 07:13:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747170799;
	cv=none; b=BWDmu6ivFWn2W2kNTCuweWMAusqwRSAAWn1JyEstIwTR3DaO25e3JVgUopMzh3OOY2jpOXHyLTQoUl4nv8k46h3IepyJLDJIuZlR0wYvdRHQW3LG1LSaG4SCjvV+X8FMMMvnJFAjLFoUHejFkySERcSgtHeE4KiEnL7Zwu4g8+I+BKjCGZc3ZmehmK5aXZQYNpWuSGx/C/Pyts/xECtVBciI/eHsaGISEnWupyrhH1BLLq7jCbgmRH523xycC8GLCo+W8sQdZ6fRgyhhD7MQ2bRsUoATuZI2qo0R5Q1ARTzbUZWc0V2GdUNO3X2vKYH+ygD3msKhHfbYZOLFiuvsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747170799; c=relaxed/relaxed;
	bh=fmR+vqrG33JgjIfayDRCw6pxb1N0duN+lxNJzXsw7m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izu9Ie71mddLp72V1OiCez95S36Yqw4QQbbt97dq27Hveizx7TmCfjqDNX6NyMnOutbkPggNLfseGXgL6NEA/wPj2nlhtpR8DW5rO+HmEILA/mjIzGd3sPEjAYT3d9uBzpGvoyAMamkBUrpGAq0mtMDGaBfopUqVP1C1gIsBEegKdhRJnaE02J6fbn8JkO4hlPfvaaCQ9/KFVjY5CC0JYT3nGojS6q2c9Qi0mdMLR+lGHGF30ovBB9OwzKoeE6XknLLORhQPqEGp11fI1zzj/0y6P3JXmp6wqY3Dt99DH3wvqJ+vMXup9CaIeipJZG3XUfZn59x9OZcdlK7DeZg3uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m0A/21tC; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m0A/21tC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zxq2Q3ZZqz2xs7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2025 07:13:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 85DBDA4DACC;
	Tue, 13 May 2025 21:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBFEC4CEE4;
	Tue, 13 May 2025 21:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747170794;
	bh=lSO4G0MjFvkGxsdN+DqSJNonGJ8MvH7A4Iu1Mc6BmP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0A/21tCQi6vmsNbJWgrgIkhRnXXsZZZFp29g0KlyDxWe8VKPnCzSGMky3IYKe0Rl
	 fmYCvX3Xq0jG6/vyPYhEi4ETHBbyTs0ULaTOYOEP/6BnBTkx7TOJMx1GBRdpHfTS/9
	 +tcApLMg1oKpQLNZsNeZUHb+mmj7h1ngiy2vHRuTILBExPY/mxIieRt2x8mNJuSag1
	 CaPF1umLUhOuazh2viAt8m14uuL2wg5BVLV65zOhR/fkrWBZC8wUuNbkIckjjoU1k3
	 fvbpzRexfWzyBgqHdgXAgMJGQQ8DlnIwVCsmdjDY4VpPBRPF8vVEL50anM0rKcFdpn
	 dkCtoehopzuiQ==
Date: Tue, 13 May 2025 18:13:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	Likhitha Korrapati <likhitha@linux.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH] tools/lib/perf: Fix -Werror=alloc-size-larger-than in
 cpumap.c
Message-ID: <aCO156Qh5mbeR4Sk@x1>
References: <20250406163412.897313-1-likhitha@linux.ibm.com>
 <E58C5DCA-5F52-4B61-A816-DE932BA40FDA@linux.ibm.com>
 <baad9d65-07b1-4a19-aea6-5ba5d60da98e@linux.ibm.com>
 <1b1450a8-f091-4091-981d-76b27f61be24@linux.ibm.com>
 <D1C1E5D6-085A-41D1-85AB-52809C956BFB@linux.ibm.com>
 <aAvKg8K2fyrZ6zy4@x1>
 <wqewmdha3bx7pmxqwbna26qnl55fcejqsjs4b2zhuciddpb3b5@7ztolpf6erwo>
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
In-Reply-To: <wqewmdha3bx7pmxqwbna26qnl55fcejqsjs4b2zhuciddpb3b5@7ztolpf6erwo>

On Fri, May 02, 2025 at 01:14:32PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Fri, Apr 25, 2025 at 02:46:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > Maybe that max() call in perf_cpu_map__intersect() somehow makes the
> > compiler happy.

> > And in perf_cpu_map__alloc() all calls seems to validate it.
 
> > Like:

> > +++ b/tools/lib/perf/cpumap.c
> > @@ -411,7 +411,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
> >         }
> >  
> >         tmp_len = __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(other);
> > -       tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> > +       tmp_cpus = calloc(tmp_len, sizeof(struct perf_cpu));
> >         if (!tmp_cpus)
> >                 return -ENOMEM;

> > ⬢ [acme@toolbx perf-tools-next]$

> > And better, do the max size that the compiler is trying to help us
> > catch?

> Isn't it better to use perf_cpu_map__nr. That should fix this problem.

Maybe, have you tried it?
 
> One question I have, in perf_cpu_map__nr, the function is returning
> 1 in case *cpus is NULL. Is it ok to do that? wouldn't it cause problems?

Indeed this better be documented, as by just looking at:

int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
{
        return cpus ? __perf_cpu_map__nr(cpus) : 1;
}

It really doesn't make much sense to say that a NULL map has one entry.

But the next functions are:

bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map)
{
        return map ? __perf_cpu_map__cpu(map, 0).cpu == -1 : true;
}

bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *map)
{
        if (!map)
                return true;

        return __perf_cpu_map__nr(map) == 1 && __perf_cpu_map__cpu(map, 0).cpu == -1;
}

bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
{
        return map == NULL;
}

So it seems that a NULL cpu map means "any/all CPU) and a map with just
one entry would have as its content "-1" that would mean "any/all CPU".

Ian did work on trying to simplify/clarify this, so maybe he can chime
in :-)

- Arnaldo

