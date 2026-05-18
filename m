Return-Path: <linuxppc-dev+bounces-21072-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E18CD4F4A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 07:33:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJqL23kzSz3c7S;
	Mon, 18 May 2026 17:33:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779085941;
	cv=none; b=JhwdfsHZhMJTuSs7le7R0i2osgzyYwTKVmM9cxrty3c5GN1fl+CDLg0Qlf7m+y+ocKoVlpOIV/I8MymIq7Hwx76e7D8E1YvNoDZvzLSsQQT2jAAf72UmAM8bxOBuUEjMu/HFw4FNNeZpGWjBn2Z/oCWRjIGBLlp63KF9m8BoEa+s5ONHrIZda+WPCnpEvkHzArXNLnCdsjJBEPLwW1JyLyVek9rs2hrjKxzwsDDaFbBA4nSWrJQjGo1PldzQaUzVKFcW1t8dPXxLjXz6xRyzPcN1UTBnnqG25whYtgBw2JFdcvgQplkB4JDh7WjX7jV7acbYod5h9KwAXD5Ig0CysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779085941; c=relaxed/relaxed;
	bh=iAJlNxr/IKeDG/LJ1nw0blOP94g2w/wIOP76Kg2DJJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4ORj0p8E3gxGEXScF9Ft5SjyTaQXi9AHxaapUb0VOBBml0PC29Yc3Tk2kdMqg67JwT7aEPPruJZnPUOTpXb7L/XIbl3l8GokDNttE/ItKlD21qtzDK+YZx0uhsBdc5ytqT8ZcrW31kgOXIee8urjVgCsDxW6D86ZgPn7JQWxYzs1HnLxv6JHycvHAJ0oUby693zsbcdioSg822fcvArFZ3LlaXThoQLSN0CwpU7WYB+YsIi+3Es29GWPLTv6C7Pyxzif2djgpJibB0631XfUwGBeA4FS3EO6e7guH+XoCq71QkAt7HjLmFRXxqo3/Wbbl6S0YKr/E6OjeYBqQ8h6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dWhipG0O; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dWhipG0O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJnz85MG6z2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 16:32:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ADBDD42A6B;
	Mon, 18 May 2026 06:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D750C2BCB7;
	Mon, 18 May 2026 06:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779085938;
	bh=/4HjBH+vAOnnqBO0QRSTltroD0Fs684VyTY2lkm/ndI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWhipG0OKFjQXNg7FkzE3XUnINSnZYONNmPsmlJSf29XR6GyBdPA3zqKBvpBMEHRQ
	 pR5uMp9WaorOy9wK+kZWKsJLZ8eEjbKj7NRsykGQNrIP68nyLDUipJ7AY2iDs7aIWC
	 WTX2BOJQG4oaQCSOS7L/Ko0Tx7Kn9vL48CKbByqTzn93VfBlf79o1vav5tXGiP8yi7
	 pj0gHkJALulY7DdgUCaWv3GaQMVB3qOPKn4YrRTpNWpYhvbo++AE9Mh+DeY9QNM8jy
	 6+JJKPaAZNCTCQ3ftGGF/ujWsUNRSQL6dmnodg3pepeJfq++rREkBW/EBXs28+P0Sz
	 Y3RLctNR3M4Pw==
Date: Mon, 18 May 2026 08:32:07 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/69] mm/mm_init: Defer sparse_init() until after
 zone initialization
Message-ID: <agqyZ2g-EA8Wl_WM@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-9-songmuchun@bytedance.com>
 <agqxs2-EQ06mFKun@localhost.localdomain>
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
In-Reply-To: <agqxs2-EQ06mFKun@localhost.localdomain>

On Mon, May 18, 2026 at 08:29:07AM +0200, Oscar Salvador (SUSE) wrote:
> On Wed, May 13, 2026 at 09:04:36PM +0800, Muchun Song wrote:
> >  void __init mm_core_init_early(void)
> >  {
> > +	int nid;
> > +
> >  	hugetlb_cma_reserve();
> >  	hugetlb_bootmem_alloc();
> >  
> >  	free_area_init();
> > +
> > +	sparse_init();
> > +	for_each_node_state(nid, N_MEMORY)
> > +		sparse_vmemmap_init_nid_late(nid);
> 
> Would it not make more sense to hide sparse_vmemmap_init_nid_late()
> within sparse_init() and have it called at the end of the function?
> 
> The flow would be:
> 
>  sparse_init()
>   sparse_init_nid
>    sparse_vmemmap_init_nid_early
>    ...
>   sparse_vmemmap_init_nid_late
> 
> I think it is better to have sparse stuff all together in one place instead of scattered.

Ah, I see that you later remove this stuff, so disregard this please.



-- 
Oscar Salvador
SUSE Labs

