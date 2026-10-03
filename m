Return-Path: <linuxppc-dev+bounces-28823-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBCECA5FE3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 10:28:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxhgx29S2z2xr2;
	Sat, 03 Oct 2026 20:28:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::78"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791016134;
	cv=none; b=Fn1ngsBIhl4j+grctctM/Jal0h+sxI4X3i7ZBfzx1ybP5SH/X2k7mIiQoC0hS0jrJj+AJiwdRawtZyy72oxUd2430GMl1tniEr101TOs06Q5mdGntKmB+WpkkShlyJtv5eluzC2yfVd2NzZ+8dwGj0bKmKSpOBjUsXRt1KLaiSr9BklbD20J481+Cpy+EzD08wsRY6chABHbzoGSGa4GXJidFwqkkCUrNyWwVoyi1AWJApd9PrV5zRBwuUfRx0hvL7bKQhKPUaJ1887J/2UKFvahWWvSXAGN7btXZ7012duvajNle/S4Sx28p4ZbRcjoKNwo8kogTHcuM8jWhLSfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791016134; c=relaxed/relaxed;
	bh=l5nOvv8bzfrrpbtfuqWOKuDSa+AYmiqtret/1cRKVaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNUsiiyBl0xDqEy+BrJqbagcACGZdEyI7WmcVBiM7BHEnYQUe9/XJ64EpqhCewidIC3QjFvQ/mH1/zO98iohnUo7Z+sheyN0qrQXRDpKyUdd1E9Elh/NxtABin10Fxmn2ctve4oLJdTKbVTa57L2PqpvOhhq5m1cnBS0FHFNg9nD5PEhUnreCNpRvOU+b2/lfFgPk+zvZW2O85HNNMaBSMpQlCexqzCA8NZSAB7qcIm6DGu3ljf2kx08DaE+E6si27sWnVF3YFqhphpnky5Lu3sD8XmgJu8L+iRj/4Tl/tC6LdvNdAv34TXLH469QdWjyTcMHxhFOVPi2QFkNsY52w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rvSIuolH; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::78; helo=mta0.migadu.com; envelope-from=chen.yu@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rvSIuolH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::78; helo=mta0.migadu.com; envelope-from=chen.yu@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 79 seconds by postgrey-1.37 at boromir; Sat, 03 Oct 2026 18:28:49 AEST
Received: from mta0.migadu.com (out-120.mta0.migadu.com [IPv6:2001:41d0:1004:224b::78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxf1s3KhLz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 18:28:49 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=qTDcL7ZGZXpqyBImCymnV5HwYb1medCgU94t18ZKIYQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791016111; v=1; x=1791620911;
 b=rvSIuolHF6FS2q54hGLq60E2BoCZSC+PocUChUcriQr/GV/jNoarF3INzgNJQqipZqgiG2lp
 yAVltOliXHwU1vJcJjg0z/5fyxCj2j/whH/q9n1IXx+YHPYkOoE5YJDjDwth+VtrkljCmaFGFhP
 zeMESz+m6dS/8qimFdTeLmYw=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 2a8746d844f124a8;
	Sat, 03 Oct 2026 08:27:05 +0000
X-Mizu-Trace-ID: 2a8746d844f124a8
X-Migadu-Flow: FLOW_OUT
Date: Sat, 3 Oct 2026 16:27:26 +0800
From: Chen Yu <chen.yu@linux.dev>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev, driver-core@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v3 09/13] x86/cpu/topology: Initialize sbm topology
 after topology parsing
Message-ID: <asC8bgvYsVkkcVlO@three-body>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-10-kprateek.nayak@amd.com>
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
In-Reply-To: <20261001192849.74788-10-kprateek.nayak@amd.com>

Hello Prateek,

On Thu, Oct 01, 2026 at 07:28:45PM +0000, K Prateek Nayak wrote:

[ snip ]

> +static __init void init_sbm_topology(u32 max_apicid)
> +{
> +	u32 sbm_shift = x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN] - 1;

As sashiko reported, and also mentioned here:
https://lore.kernel.org/lkml/20260510155920.2587431-2-yu.c.chen@intel.com/
Maybe x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN - 1] ?

> +	int num_sbm_instances, max_threads_per_instance;
> +
> +	/*
> +	 * On Intel systems, memory controllers are present at TOPO_DIE_DOMAIN.
> +	 * On newer AMD and Hygon systems, LLC is at TOPO_TILE_DOMAIN so use
> +	 * that instead.
> +	 */
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +		sbm_shift = x86_topo_system.dom_shifts[TOPO_TILE_DOMAIN] - 1;

Ditto.

thanks,
Chenyu

