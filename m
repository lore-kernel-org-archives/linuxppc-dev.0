Return-Path: <linuxppc-dev+bounces-24741-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8A0C531CA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:47:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5XVY2FS0z2yFg;
	Thu, 23 Jul 2026 23:47:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784814437;
	cv=none; b=K9b5bv62XHuqT5RGurPHkEbfXZSfeqTMBGHRNu5k1qwLTPM8Z/FfFLPlMPwVZZR4vcwh2IM5vv/20309mA2Vu7OOwiz+shRRkBJrOt2LW1vO0zRL3xgnzrxix1+nOz2hsO9lLI4pzH3VK/MDN3qd/M53vqAaS6/hlAzZr8fNPFzNGTldOhWBhxDilJDFLIvzDJ+vS/3Gy45vtZZS90EmdnoguW8aKMpZjXMFSCpNTNHx33GWLyW9kCi9WEGqSYXWU/6Zi0VopH2Z9k5rbeFFA9oeRt754xLh7vwQ3KajfdRkps16S4/zjg4awvaHvDURDgNHLYM3/Mwx8Hu/RmRcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784814437; c=relaxed/relaxed;
	bh=7Fpk2WKAWM+YPzh7ROaNhvy+pn5sojtp4vaQLCD7QZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN8wr0I2IxK0GLbOtPlxMpCQQFfKkyxjB5r5Uuq1toBzEDvQp/yPU1VioUSLj5y+OWb8BWAhAqVu6ia1E8BolWFECdYoPNgBXgnfAIwjO7Td3EEhKQHdVrJradZ68uCHcNzhJHPZhEFNGZrm8ZQw0S5ocow+8Pt0y61DwTZP5u4Wrs9qQk2QqEJhqDpTb3ZTWE2+sUzTuCqG3BhvBpi8xL5YgXs4tlKSn+leMLc+AvM6YxjbJNj2vlRL27m4PHAaThc8c7isq0qL00OskXVq1144rZPgy3VNM9NS7/RThMklq+rudAwKahgkpmpCVgmAR0V6cYVQEhbE7JPHcqeWWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hzAcQYqK; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=ak@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hzAcQYqK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=ak@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5XVT5T07z2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 23:47:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784814434; x=1816350434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TTOiuNpKd3ZCkUsJNnXQtcBfFIarUNgpz9bYK41z5To=;
  b=hzAcQYqK5MCdNZfwPhP5eVAaebBUP7Sm7uUGUNRVWvxlACURug9Jqko4
   dBahUMnYPEXVXLx0r5lXY00UFMADJ3MApg5KTQqLKg4GoI1ciAH2VRyXy
   IbMUE7Ft0imKx4f/2Os2UYGMhnWJsYRbcGC7qOnl50p9FGz3srfpXCnEw
   IwA9GTmTaywK2jNZccy/FeSRzcQIDX7JalyFXFbOysnjyTYos6ATVh0UL
   TMd98oZJy4KwPRtAUD4svP6Vhm6AVjqTc0PTPcKpQ8YaPV4V0pswsYJEE
   LPP2DEFWUN0RUNTjYgIZr+ZvQiVi35kGGctCusWilOy+yb7pZgppOy5VF
   w==;
X-CSE-ConnectionGUID: 7WWzoI5pRI2+rr4YuLnyyw==
X-CSE-MsgGUID: ubQuNgi2T6WMkWTD7BwM2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="88008497"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="88008497"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 06:47:07 -0700
X-CSE-ConnectionGUID: 5I8g06L0RzW2DP7JqA5g0A==
X-CSE-MsgGUID: b1+2gPZ+TkuUBaWrc2aoow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="261962172"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 06:47:07 -0700
Date: Thu, 23 Jul 2026 06:47:00 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: acpica-devel@lists.linux.dev, bpf@vger.kernel.org,
	coresight@lists.linaro.org, kvm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, mptcp@lists.linux.dev,
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	virtualization@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Christian =?iso-8859-1?Q?Borntr=E4ger?= <borntraeger@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Chun-Tse Shao <ctshao@google.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	David Matlack <dmatlack@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Geliang Tang <geliang@kernel.org>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Joe Damato <joe@dama.to>,
	John Garry <john.g.garry@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Kent Gibson <warthog618@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Len Brown <lenb@kernel.org>, Leo Yan <leo.yan@linux.dev>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@arm.com>,
	Mina Almasry <almasrymina@google.com>,
	Mykyta Yatsenko <yatsenko@meta.com>, Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Monnet <qmo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Song Liu <song@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Tomas Glozar <tglozar@redhat.com>,
	Vipin Sharma <vipinsh@google.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Will Deacon <will@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willy Tarreau <w@1wt.eu>, Yonghong Song <yonghong.song@linux.dev>,
	Zhang Chujun <zhangchujun@cmss.chinamobile.com>,
	Zhang Rui <rui.zhang@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tools: Use fputc() calls in some functions
Message-ID: <amIbVOIsOeZgcBZF@tassilo>
References: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>
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
In-Reply-To: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>

On Thu, Jul 23, 2026 at 12:25:25PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 23 Jul 2026 11:13:30 +0200
> Subject: [PATCH] tools: Use fputc() calls in some functions
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Single characters should occasionally be transferred into the output.
> Thus use the corresponding function “fputc” (or even “putchar”).
> 
> The source code was transformed by using the Coccinelle software.

gcc already does this transformation automatically.

