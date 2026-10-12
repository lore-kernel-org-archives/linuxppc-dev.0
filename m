Return-Path: <linuxppc-dev+bounces-29334-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6161CA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:15:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3Vcl5zyHz2xwP;
	Tue, 13 Oct 2026 08:15:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791839751;
	cv=none; b=F1KlnQ/cxiJp5zzCzzytsvxOErp4RlWBvbpSGWkAK9M9tb7i0Wm97PVN0+t4R1+pcdGiju1Oq5Qa+nYQSjPn7CGHnMJHHho3dQArpB0i2NPpricqIFte9vhEkjVJmseaTVngnGGOqOTfGT3gtvWTzSolWAV548eZNJHS10mLXqn7EfromFQSsFyKOfEd7i2q7o9oy50YDzIFUA/8L2LQfFJrNA3zuK9I43DMx2KxIh0UlKthjbj2aLCNqBAbBmG4Eo+0Z46hfU41Mj5LhlkAdYqiyJavBehlb1YR0EiMC6jnL+q7mX9kBLf7UJXFjTC8t8LR7IafYRUbzIp6SG0YTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791839751; c=relaxed/relaxed;
	bh=IzU1r7+TJV+1GRyQGwQyIAR97tOoRaolqHOy5rbawEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CpQGdD+JYdkd/ZZR6UcF7QbSnbZV/UGBCHsbsLG7YuSYpFCsMquoR26rw/6JNTzmz8bP34TbGMw+7L+ih64CF12QXDxdW5qSUiklILWO6C2/6l5couSbgUW76Fful1I33YOdK0bT8UDVX6fI++ZuSgfWPS32Heu4GVB07qlvQwynr2s5Mm8QDLyUVl7ZbewqBkIZ5bTxNWQUeiLfo31ulPivzXn8WHW1lL7xrd1Gfb5/P82Wvvmlfy/XhHusD2XBfmnqZCuRhyYaK6CqsWeLuh09xWcmba6uEXm+/JSaDb75rlzitnMPkdBPcx5occZHqAsL87SJDfMWuLzfbBUS0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UzQDFRd1; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=tim.c.chen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UzQDFRd1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=tim.c.chen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3Vcj0GRqz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 08:15:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791839749; x=1823375749;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=OvNfoi5TfPg0aDxWnEIBfeyompPiV9OHwqDMJHAE7kg=;
  b=UzQDFRd1t79lUevB0dZtI3E+NerMs+7Wu6wJdH0GVyVYWJZKEmStsFmj
   IPXJMmuHzRO8cANQhglCJTwSTW8xWGZP3FmcxV7HUKbGn+QN6MbBMiY/q
   rf89DqIgMbwbyFQVQXXByahUjur6Z3B9eYDApIS6F5WXw3f8YxG2as41u
   vYLampuE3SgYeb54JangfRKU7q2+IoVRKJ59pxkU36RnxtEtOXSz4toSJ
   CuWdiD5eEIOH0cLqyNWCFYUHFgaFwK8o+vfxy4E4a7kGtwDV9YXU2y+PB
   mnv6OKavEy3yty2lIBLJuFgKjyflDAjsQfPcq/xTVOWUZxspX4agSeqOy
   Q==;
X-CSE-ConnectionGUID: rMjMgcqDQbmBo3UvMZ/q6Q==
X-CSE-MsgGUID: ei9yg1HYQoG8Yk7tuknJFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="454777"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="454777"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:15:43 -0700
X-CSE-ConnectionGUID: QD+0puqZR8ybGqNIS7c+pg==
X-CSE-MsgGUID: f4SdzYWoT/+67DJLSxRvPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="928002"
Received: from unknown (HELO [10.241.242.105]) ([10.241.242.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:15:44 -0700
Message-ID: <0cbd60fcf328ffcb317739f60d327da3af6145f1.camel@linux.intel.com>
Subject: Re: [PATCH 0/4] powerpc/topology: Introduce llc_override debugfs
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, peterz@infradead.org
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, 
	ritesh.list@gmail.com, kprateek.nayak@amd.com, yu.c.chen@intel.com, 
	vineethr@linux.ibm.com, vincent.guittot@linaro.org, srikar@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au
Date: Mon, 12 Oct 2026 14:15:42 -0700
In-Reply-To: <20261012102037.2477378-1-sshegde@linux.ibm.com>
References: <20261012102037.2477378-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
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

On Mon, 2026-10-12 at 15:50 +0530, Shrikanth Hegde wrote:
> There is a new feature in scheduler called as Cache Aware Scheduling [1].
> It tries to keep related tasks within the same LLC domain while
> keeping the system reasonably balanced.
>=20
> Cache Aware Scheduling assumes that the scheduler LLC domain is large eno=
ugh
> to be a useful placement target. This is true on many systems where an LL=
C spans
> several cores, but not on PowerPC systems where the scheduler-visible LLC=
 is at
> the SMT level. In that case, sd_llc_size is effectively the SMT width.
>=20
> This becomes visible in the capacity check:
>         return !fits_capacity((mm->sc_stat.nr_running_avg * cpu_smt_num_t=
hreads),
>                               scale * per_cpu(sd_llc_size, cpu));
>=20
> As a result, Cache aware scheduling may be enabled but has no room to ope=
rate.
>=20
> Hence provide a debugfs option to set LLC at specific domain so that
> one can try experiment their workload with cache aware scheduling.
> This also provides ways to explore it on system with SMT=3D4 to see if
> there are any opportunities to improve or uncover bugs if there is any.
>=20
> Note it is a debug option and it is recommended to keep it disabled.
> There is no performance guarantees across different values.
>=20
> [1]: https://lore.kernel.org/all/cover.1778703694.git.tim.c.chen@linux.in=
tel.com/

Shrikanth,

This is an interesting idea. One question from a quick look at the code.

The override moves sd_llc, sd_llc_size and sd_llc_shared, but not
sd_llc_id. The id comes from arch_llc_mask(), which is
cpu_l2_cache_mask() on powerpc, so after your patches it is still
unique per core. It is also sticky: build_sched_domains() assigns it
only when it is -1, and it is reset only on CPU offline. So a rebuild
from the knob keeps the old ids.

Cache aware scheduling uses this id as the identity of an LLC:
p->preferred_llc, nr_pref_dst_llc/llc_counts[], and the
llc_id(cpu) =3D=3D llc_id(grp->cpu) check in task_cache_work(). In that
loop the occupancy is now summed over the MC span, but the id check
rarely matches and is broken.

To make this work, arch_llc_mask() needs to follow the override, and
the llc ids need to be reset when the topology is forced to rebuild.

>=20
> Tim, Chenyu, Peter,
> Are there any selftest or patches which is used for
> functional validation of cache aware scheduling?

We haven't created one. We validate mostly with workloads such as
hackbench, schbench and yogini (which can vary the number of threads
over time and track CPU assignment). I agree they are not ideal for
functional checks of the load balance path.

> per-LLC occupancy in /proc/{PID}/schedstat may not tell the full
> story when there are multiple processes and multiple LLC's.
>=20
> Atleast for functional verification, we might need one if there is
> not one already. The reason being,
> - At present, we may need a custom workload. hackbench/schbench are
>   wakeup intensive and typically bail out even before load balance.
> - stress-ng is per process. So doesn't get cache aware scheduling.
> - A selftest could spwan specific number of threads till llc size etc
>   and ensure packing happens till core_count(llc_size) by default.
>   This could also be used for tunable verfifications.
> - Provide an ability to observe how much of the workload was contained
>   within the LLC due to cache aware scheduling or number of load
>   balances stopped due to preferred llc.

A selftest would be great and much welcomed. =20

Tim

>=20
> These are some initial thoughts I had. If it sounds ok, I can try to add
> a new selftest/kunit test.=20
>=20
> Shrikanth Hegde (4):
>   powerpc/topology: Introduce llc_override debug knob
>   powerpc/topology: Add docs for llc_override
>   powerpc/topology: Update mc/pkg flags based on llc_override
>   powerpc/topology: Rebuild sched domains on llc_override change
>=20
>  Documentation/arch/powerpc/index.rst    |   1 +
>  Documentation/arch/powerpc/topology.rst |  27 +++++
>  arch/powerpc/kernel/smp.c               | 128 +++++++++++++++++++++++-
>  3 files changed, 151 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/arch/powerpc/topology.rst

