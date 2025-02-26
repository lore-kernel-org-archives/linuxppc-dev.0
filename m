Return-Path: <linuxppc-dev+bounces-6515-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF19C021B8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2025 19:45:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z34hX0XGbz3bn1;
	Thu, 27 Feb 2025 06:45:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740599147;
	cv=none; b=Bui52KgARPaVYe8AH0FGK+vi4ikkveVrSAqIWuvWosZqhKc04ZKLwH9jVjFdqUNZIdHO99A/brJsJryIMWcJpe/3o+oEDicL54ZoTGlEqH+weMF050JXaAw8Io9IGbnReoNzuf4CJIPncwNSNDtWiigeESFhBaZvD+CKemgk0+gqIwTs5JzlTCjhAulkdWpEx1Vyxo412w3uyrLJViX7f4iQwMqt+wtDbITB2O73Nstb3Tu1LwzHERwKi+qA4+SShslmaNrdWQctXOBlh9l1Ccm/Vo0+xU9+qCMJuUBlnnkY067Pi10CwXl5eGfoLAgTpoeYwAoUISQcPg3+M1Bjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740599147; c=relaxed/relaxed;
	bh=+cs+O6IewfhH3J+CsXQGOrD1WcQj4HqMnezeH9Gc7Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtgZkqhrB7hnC3F/WeEJ5UKunHtIfNdC3owMaRnB69YbvGYrOrQROwgKRrC/Gc6iXPwPUowWw6apcGJcaj+5IT+2NGMBR9O/TKd41Enq68YpvT5LQbRGv6zc8DM16ASnV6OOf7Z0VJGC+ntt1c1FjV1qG59palA2ZbtErcSI0lK88Bal7etkjWeTJHO3roaroAXgZ/UfdBqlUwRdSnBB3ayyZqhV8cC3KK3eoeEnVm1FiSJtap9m4UaTM+CYXWn2XlEVzihg5zBcyE85Rfi+ru0VKtnaC9D96R8dL7pw+xfU3sweo4HiuKoDwQ85wzIaKQZ+JaBik/+Eo5R8cz371A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cmarinas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cmarinas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z34hV5SpGz30MY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2025 06:45:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C58876112C;
	Wed, 26 Feb 2025 19:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4275C4CED6;
	Wed, 26 Feb 2025 19:45:40 +0000 (UTC)
Date: Wed, 26 Feb 2025 19:45:38 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH V3 3/5] docs: arm64: Drop PTDUMP config options from
 ptdump.rst
Message-ID: <Z79vYibFJl7--Tmw@arm.com>
References: <20250226122404.1927473-1-anshuman.khandual@arm.com>
 <20250226122404.1927473-4-anshuman.khandual@arm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226122404.1927473-4-anshuman.khandual@arm.com>

On Wed, Feb 26, 2025 at 05:54:02PM +0530, Anshuman Khandual wrote:
> Both GENERIC_PTDUMP and PTDUMP_CORE are not user selectable config options.
> Just drop these from documentation.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

