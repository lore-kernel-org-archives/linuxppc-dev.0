Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485CE606A321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=SNbFhRbH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbRwJ3Cggz2yMP;
	Fri, 27 Nov 2026 19:51:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795769472;
	cv=none; b=JODJgLBvTWxYgCY35wB23ueGQok7RWZmUF45zyNkpPQ7hteA3NUREnHaRnHpxhF8L1njvjjSUbYTMoHZ0KOQ5VNdxL9+tp7iykUNr2RuiHmtiZUhQAIc1F/t3CwFa11FDNwExiw1liGqmAYedBnwVx0jxlDwHGngHKRR1GnAzupcaTROrtGaBRQKemYVTsczH4TL5FD/So5RTZYVoxN15IVUjTSS8mbPfnLCUpQFmHEi2tailLJlnej/ZSoQBBgIatkX2POXJkZHbaRVsCvWX1QlMfV8zrPrnmu6LkNPaBQiim549YqMiPqT7Z9nHPnHF/gBcvkLV5+d6/yxD1MPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795769472; c=relaxed/relaxed;
	bh=njh3SQBBAQE61UxliWgOlIeTiJ2q96ejV3+knyCCvnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNw7lr0h2qDzfwMvRtDJ8upNyWs3+m/M+qOZy3KzBLDVdxVPYVm3wa82KANcvfxTU94zyI5MU4mXvxljxCZtq/yRb0H9MbiH5EpMUe58PXups9wiWrcfZE5ZBybpEHw59kQ1Of5BBRq/clEoyUVxiSSvn8jsPdZV3CO+oM2jCfQ893ebpJXvWtTX37uXmNy9bKeoU/yEGUGbMuV+D4Wl12fF5k+qBXhnbsqSmw8x6JtmlKfIAeorSqqW1/gHuYrg63QU8MH4fDpRHKzaV9Gf+Io8/a40QAlX4LO+w+/HcyU+A4q6d7DB8OyM+lPdhHAM0MwQQzbR2VJBnWZpK/YpOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; dkim=pass (2048-bit key; unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=SNbFhRbH; dkim-atps=neutral; spf=pass (client-ip=128.30.2.78; helo=outgoing2021.csail.mit.edu; envelope-from=srivatsa@csail.mit.edu; receiver=lists.ozlabs.org) smtp.mailfrom=csail.mit.edu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=SNbFhRbH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csail.mit.edu (client-ip=128.30.2.78; helo=outgoing2021.csail.mit.edu; envelope-from=srivatsa@csail.mit.edu; receiver=lists.ozlabs.org)
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbRwF4Pm2z2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 19:51:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=njh3SQBBAQE61UxliWgOlIeTiJ2q96ejV3+knyCCvnY=; t=1795769469; x=1796633469; 
	b=SNbFhRbH2/lGq9ww505p5B9iVSIiZKdL7CuUz+dLNTPs+kDwaZldOY6CSptidGwHl8hbVfPlkvG
	c9A5syw4Ms8jecCRU/PgHnBPwtWBnhFijq4zhMAOb+vYoIbTbz6Ce2lhYCvl3AUT9uGEB0LFujz5M
	Iygb8Ti2Xb7tohUgkV4NrzTydn+jPFV6pGo2gNzH3NBg5Lg/yOIksxi4Fb04zJmk9QUXTRkQwx8Fg
	MYxKcfsk7ipnSyQNul07DDXX2r/w6cvur4qqaQ+rzv1Iq/mE9B4/D6qmPJqusxgSXdr9vrty7KvhK
	XI95e4zW5DI1eAj5yWXizl1TcsWz5xxCCQ1Q==;
Received: from [167.220.238.14] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1xWreR-007Btx-5B;
	Fri, 27 Nov 2026 03:49:51 -0500
Date: Fri, 27 Nov 2026 14:19:20 +0530
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Richard Cheng <icheng@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <awlEEAmT4k7fvQck@csail.mit.edu>
References: <20261127-fix-rename_cpuhp_remove_multi_state-v1-1-097db4564cbd@csail.mit.edu>
 <awk6TGp9riwDD55i@MWDK4CY14F>
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
In-Reply-To: <awk6TGp9riwDD55i@MWDK4CY14F>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Richard,

On Fri, Nov 27, 2026 at 04:09:11PM +0800, Richard Cheng wrote:
> On Fri, Nov 27, 2026 at 01:07:40PM +0800, Srivatsa S. Bhat (Microsoft) wrote:
> > The multi-instance CPU hotplug state setup API is named as
> > cpuhp_setup_state_multi(), whereas the corresponding remove API is
> > currently named as cpuhp_remove_multi_state(). Rename the latter as
> > cpuhp_remove_state_multi() to fix the asymmetry. This also helps
> > maintain consistency in the API names by letting them share a common
> > prefix, i.e., cpuhp_setup/remove_state_*() across all the variants
> > [none|nocalls|nocalls_cpuslocked].
> > 
> > Signed-off-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>
> 
> Hi Srivatsa,
> 
> Not sure whether this is really needed, it doesn't harm anything,
> but IMHO it doesn't really brings us benefit.
> 

I agree, this is not intended to be a functional change. The cleanup benefit is
on the side of the CPU hotplug core API to provide better consistency in terms
of the API naming pattern, but the current callsites that consume this API
should see no functional difference as a result of this change. The consistency
will help future callsites though!

Regards,
Srivatsa

