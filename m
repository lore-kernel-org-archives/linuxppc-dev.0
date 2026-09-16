Return-Path: <linuxppc-dev+bounces-27510-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7351FC982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 22:50:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlYxj5lTSz2ynZ;
	Thu, 17 Sep 2026 08:50:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789599017;
	cv=none; b=gZzB6UeopROB//LKw1YQqZs7YQQsmw3BkUfqMvEFaZ7jl0pwZVM/Tw59vKilPz8GrDEjG8AJthzq2N5XecdWFsqxCdkBDTKSnAXRdDH1OBuc+KYhhfNkfmgjDrgGhjfOC2cj5WK4LAZlmRjL6EqZwP2RwpcEWKcmojlLg0brT/WdDty2yRadweKBYUDeNM8p0h9GIsf6LDCcQeNEHgx6IwQc7aeuD3N5qtn7iS7K947yl6hPQP5oFZCNLyvGKJOHoymk6mL2VY5ySBjXpCZuYEP7TQXX/Z2bVq4cHinJcPkbyTb95EnjciNcun30qbgM1I20OYQlIiHHRODsqOqhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789599017; c=relaxed/relaxed;
	bh=8veXm3vxjyl1KtjiainHK0MBYnJKTd1H1YON35xITO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBJ4PfEMS/9PVMJFZLc6NT+pIt8RMNQRB/1bLvyQ9k6W07WPTFOSjWhRAPxntRUaa+YU8xmRKtQkmNJyYvMHcehFrJ2JGMhslet5wXvxyqFwF+DWsiqGESKdPGBDZ7KBXAHZOxWdJuTJpPmrwJDO+NWBFBeaS7x8iiM7LvcyjQXusTB02zkapvIFQiEVzRHzjbZCuFR3StzbcoAG2UzwwH/myBDu6KZZdfMbfGALb1igBj4VTol9UbUeyqKt2QJqZMlXxHvvAQr/OnHlCvnFuxb7eWm2ceHXC94i3eoavAMKA1qHUX1F1VHynBikqBXCmshFI5Y9urxhVafe4OfewQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwqLFUSz; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwqLFUSz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlYxj0XXjz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 08:50:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E44FF43695;
	Wed, 16 Sep 2026 21:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE951F000FF;
	Wed, 16 Sep 2026 21:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789594390;
	bh=8veXm3vxjyl1KtjiainHK0MBYnJKTd1H1YON35xITO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YwqLFUSzT/KekrAVvsfVWaKDcVLAF5vqu+u2ErYbgMT6QiAlwmwjgU2LraDGw7zNV
	 NZS1uiERxDpu7CsmZx4UmXfR6pDTTAMQxhEQsDmoXTOwRaZ62VkMtiEhnx9KMuXdKF
	 h+lt84HgYI8x+WcUf0vPphEo+Zxk+5UrvdGFNGSjDm3RHLfnp91fV/ZfGYNXhw3CVE
	 nGJzdhTRDBzK2rFLrO1vEVyUvQ23CxMThtzCZkNOWXl4QjLHndiQNc81ySIHCzfvrz
	 0GcwGBoEF8ghnhmFlduUKL0aVfVVmHXMqPoDqhE1NKZgDhMXiOgS4+zPzupF+81gXz
	 OzmwbkOIYikig==
Date: Wed, 16 Sep 2026 16:33:08 -0500
From: Rob Herring <robh@kernel.org>
To: Haren Myneni <haren@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	saravanak@kernel.org, ritesh.list@gmail.com, hbabu@us.ibm.com
Subject: Re: [PATCH 2/2] powerpc/pseries/dlpar: Remove DT entries if failure
 from CPU ADD notifier
Message-ID: <20260916213308.GF1926857-robh@kernel.org>
References: <20260916043249.2062676-1-haren@linux.ibm.com>
 <20260916043249.2062676-2-haren@linux.ibm.com>
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
In-Reply-To: <20260916043249.2062676-2-haren@linux.ibm.com>

On Tue, Sep 15, 2026 at 09:32:49PM -0700, Haren Myneni wrote:
> For CPU ADD, the device tree entries are retrieved with
> configure-connector RTAS call and attached to the device tree.
> Then the CPU is added as part of DT node notification. If the CPU
> ADD notifier returns failure, the corresponding CPU node entries
> should be deleted from the device-tree. See pseries_add_processor()
> for the possible failure cases.
> 
> The current code does not remove CPU node entries during CPU ADD
> notifier failure and causing the following issues:
> - Can not add this CPU later since already present in the
>   device-tree.
> - Trying to free memory allocated to CPU node without detaching
>   the node and it causes freeing its sibling node (existing CPU
>   nodes).
> 
> This patch fixes this issue by calling of_detach_node_no_notify()
> for the failure from CPU ADD notifier which removes CPU node
> entries without calling CPU REMOVE notifier.

Would using the of_changeset_ API directly solve your issue? It's better 
designed for handling reverting a changeset. The of_attach_node/ 
of_detach_node() APIs have limited users and I'd really like to remove 
them. Or make them PPC specific perhaps. Looks like there is 1 non-PPC 
user that snuck in.

Rob

