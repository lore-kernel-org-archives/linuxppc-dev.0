Return-Path: <linuxppc-dev+bounces-16572-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A254EE8B39C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 04:56:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5Sjh1bPPz2xqD;
	Wed, 04 Feb 2026 15:56:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770180968;
	cv=none; b=RLG7sb/Q8TKAaTvPo2KvOnsEV3E+wGVyv9cN3YfDRQ12LtKUdIqNElK4iJq/9QRrlatXBZ/+nNnaKBFSM9V1PWzmy3sB/aLm0voC5QISPEVAEpUFivRe8gp8nR/ZDr6qCvKb051C36fEyD5/0CUeKok7wX1rykDa5sKD0zL28Gxx0dWXG36zwbAbJXivQOuswFRKJW3I5iUDt7Tz2c7qvQ8XFXQ361AEmgGln/u9oLI1bsAqgBXLaWo2XvhfI2AWUYbHFJUzReTSgDLT3q/I7RS+0UTJ/q0hodqMTqk/U2Lqdf4XJz+wnlO/rhB/EYrjUKIRZiu76CRqyjjtck3zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770180968; c=relaxed/relaxed;
	bh=brr/J2EOgJ2TOEABdIK6FjJERPy3YjEqZWn5qvvuZe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKWC56Sc932QFXfe2dGyllpkCLIM6K43LtfgDwjjEKy2tN8Qb4lgYMvRowJccp++EBjHjZQX3qwoXFw2WiWIqhfP6FRqf6o3xhzdiDakI5nmh9WKYT49h23ocLHk2yFbkgn+X1f5lYyf1ehcmTV9Lhtji3KSU3U4Fr1WsqZGLxraQtNzRuj2bv0WQd3Dp3OUe6lTK1BXXbDOH4fdiuF218kZ1ryqLD6J2qNszK2Jnk640nDuTabbJ6ZbbItRl8fgJquU0Z7Swxz0ZHgAkt9K+UyCg+UcFO3+PRfmdasR4n1eC/mLcZL/MLza8wQcJsCdw7aDFS/M2lXh9/8Qjhxqvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cAGRuogC; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=ricardo.neri-calderon@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cAGRuogC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=ricardo.neri-calderon@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5Sjd4B2Dz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 15:56:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770180966; x=1801716966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K8kS8LTj7SacAhbR8Lm57iCY0N8iq2KDeT/Xb2+vjLw=;
  b=cAGRuogCbXLI7v5g6z5EpQrnYKGVZkYwKTlhKMSG+T3zGden8FWT1UCg
   GsJwZn6G0XEE2vEsOd28VWFFiMvW8pYRItRkQPVI53ArhpVFlWxVCjvD3
   fY59zBhUFR592QoqJx2XDxeZoOywjT/PoxOqwau4Ncz3Oqhz53ixqacv8
   fO0Z8NhfJSio36Ba9LHMh9IRTjc6ZJwG3y8nm7kldF7j1EA/Iqi/KisAT
   0k8wRPr9xhN2jNj/IxzsqoJzW8C1JrqZU1bLL3lEuceyywCwrjJDTDbxt
   NjQv3xqMsrDWZd4F2UqO6/q0nrB5PuD98c+ZqrN05BwUmeqzXTTYJtRvn
   g==;
X-CSE-ConnectionGUID: +KrBdA2lQSOCuh94QRaf5A==
X-CSE-MsgGUID: rwSgbRxdRAeRUupv58OO4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70382590"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="70382590"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 20:56:00 -0800
X-CSE-ConnectionGUID: U8O4G4VkRhiTWmO+8Oi4kA==
X-CSE-MsgGUID: KGpyjR7UQ8WugpKpjJ1iqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214757473"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 20:55:59 -0800
Date: Tue, 3 Feb 2026 21:02:05 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH v7 00/24] x86: Implement an HPET-based hardlockup detector
Message-ID: <20260204050205.GA31059@ranerica-svr.sc.intel.com>
References: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
 <20230413035844.GA31620@ranerica-svr.sc.intel.com>
 <874inx4y4m.ffs@tglx>
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
In-Reply-To: <874inx4y4m.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Feb 03, 2026 at 04:58:49PM +0100, Thomas Gleixner wrote:
> On Wed, Apr 12 2023 at 20:58, Ricardo Neri wrote:
> > Hello, checking if there is any feedback on these patches that I plan to
> > send to the x86 maintainer.
> 
> Seems this completely fell through the cracks. Alexander reinvented this
> recently with all mistakes made before, which made me come back to this.
> 
> This needs to be respun against current mainline.

Sure, I will rebase it on mainline.

> Most rejects for the x86 preparatory patches are trivial,

I am going through your feedback and will update the series as needed.

> just the AMD IOMMU code has changed significantly.
> I haven't tried to apply the core watchdog stuff at all.

I'll look into the needed changes.

> 
> I'll go through the x86/HPET side quickly and comment on what might need
> to be still address.

Thank you!

