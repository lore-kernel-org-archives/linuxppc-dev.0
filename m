Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE62606A31F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RL18gJ+p
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jB9k96qGCz2y8m;
	Sat, 24 Oct 2026 04:58:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792778321;
	cv=none; b=dHZOZLiaPYw2aaXQxCIiB15SbqTBd5eOn/yo6VQb+TWK7uI6ZhCu0/wHSwEJXz3Kv0Pw1Mg7foGdnZrIwZ9b8Z9/l5iiBJbMz36HBzWgyif2dxksHdYIgEsyOYSJxGuGN9WGcffRCBsigfciNoktH0y0rFNlXgVTZu0LByXWD6q2LJq7Yf2kaUKo9tvhnTL6aowxfuf+kBUW89CesvogR+u7DoTg945lqxHj3ZnF30EBRmY7VymTej0Jfi/QXSbSW0UHye6/shc2f3QBhRe4M1T+ZKcQI+34eufkdGMeLx5K6qHUEHeyNksw/WURTYcxQ53mo7Q7YjZulbDBGhttgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792778321; c=relaxed/relaxed;
	bh=1Dyo+5P9jqyyV0erlVw7mVKkjTRbY/LB2EHolQl7fOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gIyVMdRrGiE5K3+AvBV9bUvTF8EaXe5A0fkipmr5+pLjEbb3cVi6ndHgj9v2Z+x0o6ES5JI6pmtYJJUPAeDJF8L2BHDlyrRaKQea4pIwz2gRrJDzi998/jhRWrsE2SA4bhWTqAkOeU8x/RKk/bj8oYkbgPaDZcpW6ldT8OAc+mGObFM99AOzz2ea2Gj7npMYKO0c1GV42ingShHUMqUhOGwLSa+QEwuI6HG3xuAVch2BjNZXZ3+KLEdBvwBlwOKeQUCCzY8kRiFAbOhb99EJR25RjAFVeuR2GByrhbqGmUqANXJu82/Yd9QjaX9vOqE/t1DHRjyCUbmvL/pG8yBouA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RL18gJ+p; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=tim.c.chen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RL18gJ+p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=tim.c.chen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jB9k72F3Lz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 04:58:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792778319; x=1824314319;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3ZrsNEX2uX6PaXIi7xcmX121TOH6INDYHDj9zh11wrA=;
  b=RL18gJ+pAGRCF1Qbq0AVyrVmsj1W5U4o30F7W3yVVxVN/6fEvT+xZAoQ
   b9tr7GhELJHvHDoDHKlBw0aURk++E16Dm2tUble5obN0TV9ODlVhM9NRv
   xkkWc5vjrTY1l4dyXeOWiL1IVeRgQUHWmU4PxE6ioSxIu8MpaMVg/S4Qz
   WpNNNomRKisn/GIGwz4PnJslBtHU5+yL00fsFje8IceVVU+X/dJmI/PnL
   XpHm+EPol7WBNxnnHd14ZecQRIAjvDIB+dvuOj2sjpQN6UM7Z7rstvNbw
   2vpDL5EEaXv7cRCgGNrXnTcuwrg9S3cPuKNE03oCzmmZYrYb72TmttwGq
   g==;
X-CSE-ConnectionGUID: uel+eMZnT7SpLv/AaHxUJA==
X-CSE-MsgGUID: cnVBqseJQ5+eqGkmUHSOtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1571371"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1571371"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 10:58:34 -0700
X-CSE-ConnectionGUID: RWnG4AmLRcmQZ90DhOOfQw==
X-CSE-MsgGUID: 3hMl4LsxSsCknPcPjIg2mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3700573"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.32]) ([10.125.108.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 10:58:17 -0700
Message-ID: <4a71f654cdc03973f309754a2f61810b4547a471.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/4] powerpc/topology: Introduce llc_override kernel
 parameter
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, peterz@infradead.org
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, 
	ritesh.list@gmail.com, kprateek.nayak@amd.com, yu.c.chen@intel.com, 
	vineethr@linux.ibm.com, vincent.guittot@linaro.org, srikar@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au
Date: Fri, 23 Oct 2026 10:58:16 -0700
In-Reply-To: <20261023131646.2907938-1-sshegde@linux.ibm.com>
References: <20261023131646.2907938-1-sshegde@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-10-23 at 18:46 +0530, Shrikanth Hegde wrote:
> Provide an option for users to enable cache aware scheduling on powerpc
> via a command line parameter.
>=20
> More details of the problem and context is in cover-letter of v1.
> v1: https://lore.kernel.org/all/20261012102037.2477378-1-sshegde@linux.ib=
m.com/
>=20
> v1->v2:
> - Move to kernel parameters from debugfs. This helps to keep
>   llc_id consistent which doesn't change across sched domain
>   rebuilds. (Tim Chen)
> - Update arch_llc_mask to reflect the override (Tim Chen)
> - Limit only to mc, pkg (Srikar Dronamraju)
>=20
> Notes:
>=20
> - A selftest for the functional validation of cache aware scheduling
>   is a good idea as we discussed in v1. It is a significant change on
>   its own and likely takes time. I am thinking it might be good idea to
>   revisit selftests for scheduler in general. (We have very few).
>   Maybe worth a discussion in coming OSPM.=20
>=20
> - I am on parental leave. This version is pretty much what I had last wee=
k
>   and I haven't gotten any chance to update since. just sending it out.
>   Sorry if I have missed to address any comments.
>   Please expect delays in my response.

Thanks for sending this while on leave, and congratulations!

The updated approach with boot parameters looks good to me.
Some minor points:

1. llc_bytes. As Chen Yu noted, get_effective_llc_bytes() returns 0
   on powerpc because the generic cacheinfo is not populated. With
   NUMA balancing on and the default llc_aggr_tolerance, any process
   with a footprint then fails exceed_llc_capacity(), so cache aware
   scheduling still does not engage.=20

2. Bisection. Patch 2 moves SD_SHARE_LLC to MC/PKG, but
   arch_llc_mask() only follows in patch 3, so a kernel at patch 2
   booted with llc_override=3Dmc has sd_llc at MC with per-L2 llc ids,
   causing mismatch. It may be better to squash 2 and 3.

3. llc_override is only written at boot. Making it
  =20
        static int llc_override __ro_after_init;

   and then you don't have to worry about READ_ONCE and WRITE_ONCE
   to it as Chen Yu pointed out.

Tim

>=20
> Shrikanth Hegde (4):
>   powerpc/topology: Introduce llc_override kernel parameter
>   powerpc/topology: Update mc/pkg flags based on llc_override
>   powerpc/topology: update arch_llc_mask based llc_override
>   Documentation/powerpc: Add details about llc_override
>=20
>  .../admin-guide/kernel-parameters.txt         | 15 ++++
>  arch/powerpc/include/asm/topology.h           |  8 +--
>  arch/powerpc/kernel/smp.c                     | 69 +++++++++++++++++--
>  3 files changed, 81 insertions(+), 11 deletions(-)

