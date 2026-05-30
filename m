Return-Path: <linuxppc-dev+bounces-21754-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478EDCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 May 2026 00:01:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gS0l14lWpz2y2B;
	Sat, 30 May 2026 10:01:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780099309;
	cv=none; b=OslIqGj7HTUKC3eLI61Ur+2CatFp1jmNxgiDEcw79i0hhaxTGRVtP7O+yQPwnuedVDXuQRCn9OCBKQ1JYF8Mo+M1XarjWmbYsnAGfzn6ecDa5dPT1j2CK8OzFV38698f3cMvQi+bL8Ku1zhhx4rxySLy2FDbhMpxAMx0q6tHxIKnqSJBrI1XM1opvccL6hkilTbuQmHroEGDy9uYqQ3vyYIBUegEgn2F00yyqsoMoRNc9yTNkIFr4GQhRIjebVD8KZXRQxZifIQ5uIWWUrJopShewuHf38pUwKnHIVwwkGgmE5j0/Ccj97hA7fSDdBU668rBCpO36R5OnS984nyoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780099309; c=relaxed/relaxed;
	bh=D7djoSGosrfa+muilz6GgByxSVGvd52+1HJJvvuJ18E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlzTogk2MYpLTF+lNqwoDklNE+yThDD0HJvn2moWF/iFmMJ9hrAyf6GJOMewhtkUKPmx5VgT27mMhqsLdPWEzQie5XHxpFsxzqJSi8gzbOEfr1QVeLwNXZNszj5UM2/+s9ol4SfMKkahUpnQrLI5sDwa/a5Aso7vxJD+qm7PbdTh0vG6WerI7HCqmMH4bsntWM0+hI/I+xvVL3R673EjKIqs6eQUjpxA0Fo/V7TKJANXkUeJA7638/wA6G+dtwWM8YuaE6W2NJY02WqFIRpgv6x0J/aWpWrKkgg1bb5TUYekzLMRc2ZLO1c4pXFR1jTKGdO+8j3Ym51wEbvC2KVhpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChyQpitP; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChyQpitP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gS0l05gpTz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 10:01:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E46E44524;
	Sat, 30 May 2026 00:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDAD1F00893;
	Sat, 30 May 2026 00:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780099306;
	bh=D7djoSGosrfa+muilz6GgByxSVGvd52+1HJJvvuJ18E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ChyQpitPiqWnIx0Nb8Lf1UGm93rS8OURyYiFBTu5X0V5gvrXXUpQ8FLpjpAkhvXRY
	 KozcQ/JGrGWhmwJVxgHYuFxM6fqrkgOg8CooVIeLxSMGT5QGlO4Il5VKJVcT1cnbur
	 qz/uKcdFVtSoXpf9Bd+emBDbhMUqTWos/oLo3xOTZUHvwyDUJYr2d1qYjw1Wdk3SZp
	 IeLnwIECrkTkPr2VvmWTILYOBtb7+dWkB8ZOjIiXYLK2m5bZxsBH3yM/boAG3MpTXC
	 QusmEKp8HKecTgW3bcOFw7g4spSQJ3TJ5uwgJE/tY70dYBuVRgDB/6OKslKPydcdb5
	 F7nQmGu2ca5/g==
Date: Fri, 29 May 2026 21:01:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tejas Manhas <tejas05@linux.ibm.com>
Cc: Gautam Menghani <Gautam.Menghani@ibm.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	atrajeev@linux.ibm.com, Gautam Menghani <gautam@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script powerpc: Update the hcall list with new
 hcalls
Message-ID: <ahoo5dI-6fVlFvvR@x1>
References: <20260512084654.57729-1-Gautam.Menghani@ibm.com>
 <61c8d600-72b4-4320-a1ff-18e061569f24@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61c8d600-72b4-4320-a1ff-18e061569f24@linux.ibm.com>

On Wed, May 20, 2026 at 09:25:08AM +0530, Tejas Manhas wrote:
> From: Gautam Menghani [1]<gautam@linux.ibm.com>
> 
> Update the hcall list with the hcalls in bcc's ppchcalls script [1].
> 
> [1] : [2]https://github.com/iovisor/bcc/blob/master/tools/ppchcalls.py
> 
> 
> Hi Gautam,
> 
> This patch doesn't seem to resolve the issue where numbers are seen instead of h
> calls.
> I have applied to the latest upstream but the numbers are still visible in perf
> script.
> Also the command doesn't recognise python-audit already present in the system.
> 
> Please find logs below for better understanding.

Any progress on this?

- Arnaldo
 
> before patch
> # perf record -a -e powerpc:hcall* sleep 10
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.343 MB perf.data (2388 samples) ]
> [root@ltcden14-lp10 perf]# perf script  -s ./powerpc-hcalls.py -i ./perf.data
> Install the python-audit package to get syscall names.
> For example:
>   # apt-get install python3-audit (Ubuntu)
>   # yum install python3-audit (Fedora)
>   etc.
> 
> hcall                            count   min(ns)   max(ns)   avg(ns)
> --------------------------------------------------------------------
> H_VIO_SIGNAL                       614       376     14068      1644
> 584                                 36      1094     16120      2839
> H_ADD_LOGICAL_LAN_BUFFER             9       660      3572      1320
> H_STUFF_TCE                        132       632     12530      1310
> H_PUT_TCE                          236       466      5500       865
> H_RANDOM                             4       446      3300      1168
> H_PUT_TCE_INDIRECT                  53       648     14318      2066
> H_SEND_CRQ                         108       848      7754      1983
> after patch
> # yum install python3-audit
> Updating Subscription Management repositories.
> Unable to read consumer identity
> 
> This system is not registered with an entitlement server. You can use subscripti
> on-manager to register.
> 
> rhe12_debug1                                    8.4 kB/s | 1.5 kB     00:00
> rh102_base_upd                                   41 kB/s | 2.7 kB     00:00
> rh102_app_upd                                    14 kB/s | 2.8 kB     00:00
> rh102_crb                                        14 kB/s | 2.7 kB     00:00
> rh102_srcbase                                   7.6 kB/s | 1.5 kB     00:00
> rh102_srcas                                     6.9 kB/s | 1.5 kB     00:00
> rh102_debug                                     7.1 kB/s | 1.5 kB     00:00
> rhe102_debug1                                   7.1 kB/s | 1.5 kB     00:00
> Package python3-audit-4.0.3-5.el10.ppc64le is already installed.
> Dependencies resolved.
> Nothing to do.
> Complete!
> # ./perf script -s scripts/python/powerpc-hcalls.py -i ./perf.data
> Install the python-audit package to get syscall names.
> For example:
>   # apt-get install python3-audit (Ubuntu)
>   # yum install python3-audit (Fedora)
>   etc.
> 
> hcall                            count   min(ns)   max(ns)   avg(ns)
> --------------------------------------------------------------------
> H_VIO_SIGNAL                       533       404     13154      1638
> 584                                 37      1034     14722      3178
> H_ADD_LOGICAL_LAN_BUFFER             8       802      2602      1217
> H_SEND_CRQ                          11       926     17536      4105
> H_STUFF_TCE                         13       658      5306      1974
> H_PUT_TCE                           18       476      5034      1476
> H_PUT_TCE_INDIRECT                   5      1698      8934      4370
> [root@ltcden14-lp10 perf]#
> 
> Please add the tag below.
> Reported-by: Tejas Manhas [4]<tejas05@linux.ibm.com>
> 
> Thanks & Regards,
> Tejas
> 
> References
> 
>    1. mailto:gautam@linux.ibm.com
>    2. https://github.com/iovisor/bcc/blob/master/tools/ppchcalls.py
>    3. mailto:gautam@linux.ibm.com
>    4. mailto:tejas05@linux.ibm.com

