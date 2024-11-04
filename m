Return-Path: <linuxppc-dev+bounces-2839-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE85D1BDC2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2024 16:20:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XhxXR6F3zz2yNv;
	Tue,  5 Nov 2024 03:20:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730737239;
	cv=none; b=RqKCVlDDNHYOhf10lS+VoDWAY6sh1pIGMBbwUWDfeBuwVKIpxvlO8dygqjlpyLsDlYBqiyMzVv6scS9OWjmCaoqzX3DLqpS5q6Qaew3NAaWz4NzpVAy8uL4699KF2eUltPr7T/M8J7APbfliFi1VwV0c/cEUkemmg+PK4DZBk+oNv3B3ztWZsfVlQlNffXXaKdqPJXqwx+t2kSXqQooYqfm5Em6KqZzfZPF4Z5rgUPTiarqyKAe45Bddv4BRpYrRPf/HUDLp7utyW0ujCeOgc6FsfYUgmS8h718+X32exPOCVVwy1wYukrjRHsDaR9Z2NFs6SL7SlJJsJ1C6AtxbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730737239; c=relaxed/relaxed;
	bh=MfBLldae6HpVT/J0uH6IxgYAl1BDd58WeCFp8bpuhVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GydQPDUyCskzSClTdAK5L2nRi2+XY4zGcIgOSgotj1ueXu21ybuk6Xp5Aa8kX1HrylI3CbmNPOMLt5Wk+xYhwvUWa5fCk+eRoNHX9vciqVHvkwmvgnt7H0hKYpiDrpNpYTj0fEEPnIpay3CGxyM9gmiex5n00XuqSo3r/X6VKalvyeCR31FhPunSu8Pc70k9N6rDxmAf0E3JkkiFODWl4Lod3c6hiOycA2jEpDzxDnDSRv1W4tqXfLvKkjlKOIKVLNRoFTR3IWDVAkcuTAQfaJ1chZYnlYLWaGtAHPGYmpOTMQglcjGLwDXuOPNvoduE7yTEMDT1/nynVsppHJTe+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mit.edu; dkim=pass (2048-bit key; unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=B0Gfw9hb; dkim-atps=neutral; spf=pass (client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu; receiver=lists.ozlabs.org) smtp.mailfrom=mit.edu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=B0Gfw9hb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mit.edu (client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu; receiver=lists.ozlabs.org)
X-Greylist: delayed 163 seconds by postgrey-1.37 at boromir; Tue, 05 Nov 2024 03:20:38 AEDT
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XhxXQ0cr6z2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2024 03:20:37 +1100 (AEDT)
Received: from cwcc.thunk.org (pool-173-48-115-131.bstnma.fios.verizon.net [173.48.115.131])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A4GHDZq005094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 11:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730737037; bh=MfBLldae6HpVT/J0uH6IxgYAl1BDd58WeCFp8bpuhVM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=B0Gfw9hby54Mawf3nVtoZfShOFAGukbl6ZTbcBRlBYtaOGsQCDtF0qrCRjYcyueMN
	 kV3YMqvlfKnXp0p4fCWynaSg163bApSkqyhJqyYAnlJGmGsBqD0LP+xC7Ub8B3AkMW
	 fCaW+bTFL4V+NDN7Mwtj3eK4pBVhp1exceawLgFrmz6mC17UMOrLmM35q5gxC4WiPa
	 dU/am5SfTEXUCGkYocIUCIDjggZimNzSIcTYzrac8AXMHympLwlrhdp6OGCVFYpanm
	 7zZxGz70mRgKnWKu+qePBhSgO7AcPnfmUhE92pXrgqBwyRWdRGP2hoQHMO6YFDD2gt
	 W9K47pAC0MkrA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8C6D915C02FA; Mon, 04 Nov 2024 11:17:13 -0500 (EST)
Date: Mon, 4 Nov 2024 11:17:13 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 15/18] ext4: switch to using the crc32c library
Message-ID: <20241104161713.GA43869@mit.edu>
References: <20241103223154.136127-1-ebiggers@kernel.org>
 <20241103223154.136127-16-ebiggers@kernel.org>
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
In-Reply-To: <20241103223154.136127-16-ebiggers@kernel.org>

On Sun, Nov 03, 2024 at 02:31:51PM -0800, Eric Biggers wrote:
> Now that the crc32c() library function directly takes advantage of
> architecture-specific optimizations, it is unnecessary to go through the
> crypto API.  Just use crc32c().  This is much simpler, and it improves
> performance due to eliminating the crypto API overhead.
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Theodore Ts'o <tytso@mit.edu>

Thanks for the cleanup!


