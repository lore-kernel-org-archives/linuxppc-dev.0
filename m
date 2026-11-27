Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C077B606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=x2Pr7EfF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbQSq19qJz2y2h;
	Fri, 27 Nov 2026 18:45:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795765547;
	cv=none; b=oQwtdaxl68GHl9mlycPjrNlclbqHKotnBP8KtuaKlNJbLlvCman/y2ChkFofvaHkBWayx8FwQKh84AxsGrEBqTpEG7fz7PQWXxFrinOBHFEW6+njqG4d79nnw2o32NjmjFQPQamQSL0om73c8KxkAnfGb8cdFUFfTVzZWfTqLGntAgSjYxMgSX2IYAsZsroq4ERJQ/ubU3mZJSFnZeoLp7Qmr2KBkfkLxVl2B5U15u/EYZoajJrLwSpBVLLOBFVr3voYWw7bkLDxjCgJ9CnHCYE/ClEowQXZLqH21SiyJhAMrdo2s+7UfLsoqrIdGMQyOw6ZzZ2he1Sb3hQW2to6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795765547; c=relaxed/relaxed;
	bh=kWtt4J80wKcGIrTczzzJ5vqcfxic++6ySZn4Y5POe30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfpCYAv1824tPh3DPnYwnmeYyqVe7f4sqSPxyFr0Tz1YGWZNJyOj7iCtpgblme4afR9FjzOjHjolErZAkV34GgHBjDDGfjVuUx8hMEVDaoZBQB8mcK9tVhi9YCRrXzhRqErCsZ1F5Q5ywJ4leeIX73N0SfU7K6f0FlZmr7aL8+f5PRFxBH4fxdK5PkgBhuQTAfIOHSnFWCe2j8iBaAUaBSD2ehgDAmoY88a9DhoO/g/tkmSNo/ExmVuUO92eAh3/h8MdJKoERJpBeojxf7sCyBjGg086HouqG6UQ/YH3Y4iP3BTzDK2e2Dz1pf7//dAM9DQwMiegQ5LUvmRKW5enTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; dkim=pass (2048-bit key; unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=x2Pr7EfF; dkim-atps=neutral; spf=pass (client-ip=128.30.2.78; helo=outgoing2021.csail.mit.edu; envelope-from=srivatsa@csail.mit.edu; receiver=lists.ozlabs.org) smtp.mailfrom=csail.mit.edu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=x2Pr7EfF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csail.mit.edu (client-ip=128.30.2.78; helo=outgoing2021.csail.mit.edu; envelope-from=srivatsa@csail.mit.edu; receiver=lists.ozlabs.org)
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbQSn3Qydz2xqh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 18:45:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kWtt4J80wKcGIrTczzzJ5vqcfxic++6ySZn4Y5POe30=; t=1795765545; x=1796629545; 
	b=x2Pr7EfFan8GQLGYLpzDpYd45KQjGrfeDVeAKHbQ/YYBwAEBgmsiuNBaSa5FGoFn3G3fa8iMJ98
	c1oMNooOkzYRB485yWHsdxk6Xj+pl/24DTKgAJtDZxjMrHHTiV+6n7UDqO39kX/iKGpVwi7D18rNY
	ajKRYvN2E681Iklmph3+hE3DA1X4Ljlg41+3KaqKs3cTNjNnYDvP89Wm3QwzjZj121irRZ3a3V7Um
	4ZZTpETA8UrkffiMWZqNQgpS82MIo4cUxQonF3C7EjbgZD92Jkg3/l6q/tlJfQj4gJ55hwFEhMVJi
	68K8EhNoxHVteTdWYXn/CnuH212TWz4vmPOQ==;
Received: from [167.220.238.14] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1xWqdU-006z5N-OT;
	Fri, 27 Nov 2026 02:44:49 -0500
Date: Fri, 27 Nov 2026 13:14:17 +0530
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Sizhe Liu <liusizhe5@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>, Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>, Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Frank Li <Frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yushan Wang <wangyushan12@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org,
	coresight@lists.linaro.org, iommu@lists.linux.dev,
	linux-raid@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
	nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-cxl@vger.kernel.org, imx@lists.linux.dev,
	linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH] cpu/hotplug: Rename cpuhp_remove_multi_state to be
 symmetric with setup
Message-ID: <awk00RK93iRx3e3S@csail.mit.edu>
References: <20261127-fix-rename_cpuhp_remove_multi_state-v1-1-097db4564cbd@csail.mit.edu>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127-fix-rename_cpuhp_remove_multi_state-v1-1-097db4564cbd@csail.mit.edu>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 01:07:40PM +0530, Srivatsa S. Bhat wrote:
> The multi-instance CPU hotplug state setup API is named as
> cpuhp_setup_state_multi(), whereas the corresponding remove API is
> currently named as cpuhp_remove_multi_state(). Rename the latter as
> cpuhp_remove_state_multi() to fix the asymmetry. This also helps
> maintain consistency in the API names by letting them share a common
> prefix, i.e., cpuhp_setup/remove_state_*() across all the variants
> [none|nocalls|nocalls_cpuslocked].
> 

I think the prefix in the patch title should have been "treewide:" instead of
"cpu/hotplug" given that it does a treewide-sweep to perform the rename.

I can do that in a v2 later if there are other any other comments/suggestions to
address as well.

Thank you!

>  Documentation/core-api/cpu_hotplug.rst       | 6 +++---
>  drivers/block/zram/zram_drv.c                | 6 +++---
>  drivers/devfreq/event/rockchip-dfi.c         | 2 +-
>  drivers/fpga/dfl-fme-perf.c                  | 4 ++--
>  drivers/hwtracing/coresight/coresight-trbe.c | 4 ++--
>  drivers/hwtracing/ptt/hisi_ptt.c             | 4 ++--
>  drivers/iommu/iova.c                         | 2 +-
>  drivers/md/raid5.c                           | 4 ++--
>  drivers/net/ethernet/ibm/ibmvnic.c           | 8 ++++----
>  drivers/net/ethernet/marvell/mvneta.c        | 8 ++++----
>  drivers/net/virtio_net.c                     | 8 ++++----
>  drivers/nvdimm/nd_perf.c                     | 6 +++---
>  drivers/perf/alibaba_uncore_drw_pmu.c        | 4 ++--
>  drivers/perf/arm-ccn.c                       | 4 ++--
>  drivers/perf/arm-cmn.c                       | 4 ++--
>  drivers/perf/arm-ni.c                        | 4 ++--
>  drivers/perf/arm_cspmu/arm_cspmu.c           | 2 +-
>  drivers/perf/arm_dmc620_pmu.c                | 4 ++--
>  drivers/perf/arm_dsu_pmu.c                   | 4 ++--
>  drivers/perf/arm_smmuv3_pmu.c                | 4 ++--
>  drivers/perf/arm_spe_pmu.c                   | 4 ++--
>  drivers/perf/cxl_pmu.c                       | 4 ++--
>  drivers/perf/dwc_pcie_pmu.c                  | 4 ++--
>  drivers/perf/fsl_imx8_ddr_perf.c             | 4 ++--
>  drivers/perf/fsl_imx9_ddr_perf.c             | 4 ++--
>  drivers/perf/fujitsu_uncore_pmu.c            | 4 ++--
>  drivers/perf/hisilicon/hisi_pcie_pmu.c       | 4 ++--
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 4 ++--
>  drivers/perf/hisilicon/hisi_uncore_pmu.c     | 2 +-
>  drivers/perf/hisilicon/hns3_pmu.c            | 4 ++--
>  drivers/perf/marvell_cn10k_ddr_pmu.c         | 4 ++--
>  drivers/perf/marvell_cn10k_tad_pmu.c         | 4 ++--
>  drivers/perf/marvell_pem_pmu.c               | 4 ++--
>  drivers/perf/nvidia_t410_c2c_pmu.c           | 2 +-
>  drivers/perf/nvidia_t410_cmem_latency_pmu.c  | 2 +-
>  drivers/perf/thunderx2_pmu.c                 | 4 ++--
>  drivers/scsi/lpfc/lpfc_init.c                | 4 ++--
>  include/linux/cpuhotplug.h                   | 4 ++--
>  kernel/padata.c                              | 2 +-
>  kernel/trace/trace.c                         | 2 +-
>  mm/zswap.c                                   | 2 +-
>  41 files changed, 82 insertions(+), 82 deletions(-)
> 

Regards,
Srivatsa

