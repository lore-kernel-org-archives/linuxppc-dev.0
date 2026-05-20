Return-Path: <linuxppc-dev+bounces-21218-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF299CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 08:51:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL4z63Krlz2xqv;
	Wed, 20 May 2026 18:51:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ee9:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779267106;
	cv=none; b=OzlOkUBAjQ8m6zs0GUaceL//BmU5KfRPC0Ge4kmVyRmDSo0h1ghB267lQrHC2BkcLowV2rtZpA8H4ANMjVzGqwiKB5dK90WM/Dan6zZ+WdvbtPLAYLZOVonISxnYWh763C0iEppP5XghmxhWYY/4KOQbzM5hPG3O6hq+7yVemrEZSzz1LzIR3Dzevh+Wx7PR01CnEMSIO3VdK50AeWLZ16aMFs7zHL+lvX7U5mrKxwzSzPiZJxQCYnAWL9DD6YiRPpyGn8TnCVMriMN7OGa1tE+KQjFpd9JMYWKM0k5jeS6PIT2u9nE5BTi3OzgU0gfYh9D65XwWB1fy466OXqVPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779267106; c=relaxed/relaxed;
	bh=wVHTMU3Nb+wXRLp69i3q+mt+UxaHuBodePJL/UKpJZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+qd6EGmZ6loVJkV4/eKlwy1FbQrWTJYqy3NiA7NH3b+OMFYiiwJCXB5/9DHez0nKjFK/mAXiVDJEummp1OCABOR7dVzmeus936Ub4fvXqMSjC+HLQGeKy59LAeVPfUibzQbnKf3O9OUDdxM3OtTZ1n4nKFjuNsJWDPTrXS7b+BO7qfo7j5v/VubVyrogx8v6THg6NNa3KapX9Thb4yeAyn0EywrECSaUXy8QZ8OSHOnDe2zxTKalz8IQzdQK/qRztjkfBH+pUYheqGCG89ztriDpA5Cre6E+7ILAIY1+j+2oF/d12UmYv6jluMoInwxpYv/DynE6HKSK6qtirJBvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 477 seconds by postgrey-1.37 at boromir; Wed, 20 May 2026 18:51:44 AEST
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL4z45mcGz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 18:51:44 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 4A3BB10625;
	Wed, 20 May 2026 10:43:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 38FD1602E4CC; Wed, 20 May 2026 10:43:36 +0200 (CEST)
Date: Wed, 20 May 2026 10:43:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Yury M." <yurypm@arista.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
Message-ID: <ag10ON5pZ4ymPT9U@wunner.de>
References: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>
 <agwzHzF3bpPM6jcC@wunner.de>
 <3633b587-5782-4cfa-b967-997de86866bb@arista.com>
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
In-Reply-To: <3633b587-5782-4cfa-b967-997de86866bb@arista.com>

On Tue, May 19, 2026 at 05:05:20PM +0100, Yury M. wrote:
> Root port can detect AER error with source 0000:00:00.0.
> 
> In this case, we call find_source_device -> find_device_iter. The
> 'multi-error' flag is not set, and we are looking for the first error (not
> all). This means that for any error with the 0000:00:00.0 source on the root
> port, we will report the error for the first device on the bus.

No, is_error_source() considers bus number 0 as a bogus number
and will iterate over all devices on the bus.

> In my case, an AER error reported by 0000:06:08.0 will be logged as an error
> reported by 0000:06:07.0 if AER recovery constantly fails.

The problem is that 0000:06:08.0 reports an Advisory Non-Fatal Error,
i.e. it sets the ANFE bit in the Correctable Error Status Register
and signals (only) a Correctable Error, even though it also sets bits
in the Uncorrectable Error Status Register.

The kernel lacks support for ANFE handling and will only clear the bits
in the Correctable Error Status Register.  It neglects to also clear
(and report) the bits in the Uncorrectable Error Status Register.

There was an effort two years back to bring up ANFE support but it
fizzled out.  I talked to the submitter and he's now busy with other
things:

https://lore.kernel.org/r/20240620025857.206647-1-zhenzhong.duan@intel.com/

It's on my todo list to respin his series but I can't promise when
I'll get to it.

Thanks,

Lukas

