Return-Path: <linuxppc-dev+bounces-2769-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1965DE677F8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Nov 2024 10:20:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XgYdF2Xj8z2xpn;
	Sat,  2 Nov 2024 21:20:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.6.53.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730542801;
	cv=none; b=eM5EWStert6AWzKTTxyg9Fjt/B70pAAUgw/KW8s4axJKN4WQ+DQBUMUcnevGiWfyRKBhqNFIEv8FFfGjllNnWcykAG/kr1YjbXOxzt45oNivNPHrxHV762dXF5dYg5+A9BpuHGmNqfFmejlEVs1jdHHC//EsDleE3Dcfu1DkY2USx5/MS5zTmNrWPIc6efsYm08jgBMPQe1NXtlutGAt1gBZU801TtDfI8f9bkWPJoxmy2X4Mc/eeG8nbMQmvQBE+ZuhyqaqtaztyBT77z0mRpy8G0CtVuFhXGeiFCP9Z0sE+eBFCuKf8gy/KuGr/Hq4C42Nq0/RTvsGf3aRBEfWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730542801; c=relaxed/relaxed;
	bh=yYa+7XoJuDdb76oEmaiyHNPbnto6CbOy5cbqLih549g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo7AubT8PAcsjXWg770mi38IJx4fMy6pYmVjREKOBzu207k5GFul0kqaOT3/qQp5AkuuTMJApF+NIepz4qX9C6IUa4C3jIRifiOrn+nblRhI4dOuOjToCV002Hfx127KHABPxHtrOtoxf5YL4JMSSrvIuMqwgAygifWruN4yPLe2085x3lVviGvooHgA0U1+ziEnpL1a3Hy9yUmis/ide6wIdfKKb7neyOaeR+wIdrP0dbs6rNBpaDLRRHRnZH2NhG6bhFFM2D8B/SD9LBcR4XsoJ5pwB1Y5P9w7tyeLFaN1bLfY54wGbRUg5HH42rCLLnsKn0IVYsiD0at001LuNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=IxqSkCyy; dkim-atps=neutral; spf=pass (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=IxqSkCyy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XgYdD27Y0z2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Nov 2024 21:20:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yYa+7XoJuDdb76oEmaiyHNPbnto6CbOy5cbqLih549g=; b=IxqSkCyyTRJ8QPfyWdRdr2qHrJ
	tpnjvWqxXTt+J7vxVmfkjrXd/rdKT+0RFdwGzbsRsMR9EdmzQEnFrsAgTnaI9+pdPBY3Pn9re79Nj
	57c2proTZGddCmA7w8N1JXHF1QdjpqJ+rO1URQev5azBEyB5hCBbYGnbLrSwTrfwTX1ksXWj0DUCf
	yuXLmD7dk6/d8YNZezbMYQ6VdXKIYeLQYq1Pq312XFyr1DfhbY4I3pSC7QOr5wrJ+HBrserJJF9gW
	0q+8FZncsHy0y1xio+hERsUI6SlHqDVBhozBkFMWrc3INF748cH6QiBntZMGgC5ZBSYXHEMi51PKW
	hRrho1rQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1t7BEX-00Dy0V-01;
	Sat, 02 Nov 2024 18:19:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 02 Nov 2024 18:19:52 +0800
Date: Sat, 2 Nov 2024 18:19:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 04/18] crypto: crc32 - don't unnecessarily register
 arch algorithms
Message-ID: <ZyX8yEqnjXjJ5itO@gondor.apana.org.au>
References: <20241026040958.GA34351@sol.localdomain>
 <ZyX0uGHg4Cmsk2oz@gondor.apana.org.au>
 <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>
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
In-Reply-To: <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>

On Sat, Nov 02, 2024 at 10:58:53AM +0100, Ard Biesheuvel wrote:
>
> At least btrfs supports a variety of checksums/hashes (crc32c, xxhash,
> sha) via the shash API.

OK, given that btrfs is still doing this, I think we should still
register crc32c-arch conditionally.  Having it point to crc32c-generic
is just confusing (at least if you use btrfs).

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

