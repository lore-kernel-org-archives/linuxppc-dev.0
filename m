Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA17C54E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2024 21:43:39 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h6/UN6Dd;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TrN8p0nh1z3vfG
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2024 08:43:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h6/UN6Dd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TrN7x49LQz30GC
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2024 08:42:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C921BCE233C;
	Thu,  7 Mar 2024 21:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5321C433F1;
	Thu,  7 Mar 2024 21:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709847769;
	bh=8XuCVPF590rPxYXu7ldG9ZXSXyPh8TaCqTdhQ8IANrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6/UN6DdfOsJsNGmfnzXYMCgBGPlJvcjNckhZgIRgoh2u07kuVeRK/HYaRxWJcpWy
	 lyR8w5F12v8+Qos5W7JU1+EtXyXU2y03etFcD6m0HA7t46l/QB+ALkTCpSlS/f3Kt3
	 NIcSPG2I8WfQb276HDQ52lhfDvRVzN6IP+Np0wglKRKiqnBwHRY1yoLbQlv7TlXI79
	 2QBhmf0httu9RA9NaggO8HlkmkCF3k/8X1b9Gx5RUKUqK+GYs7JPrz2h7S8nyd3h3s
	 C+01rVNmlNzRBJ4SHRrOgy1xcU9AVQj7mFfqhpd7RxR5Dyv1du5+O+am+MdFDhod50
	 2po77yHPtX6zg==
Date: Thu, 7 Mar 2024 15:42:45 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH 0/2] Preserve TPM log across kexec
Message-ID: <20240307214245.GA3110385-robh@kernel.org>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <b6f74cd0-d1c8-4a6f-a05d-364595c5b079@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f74cd0-d1c8-4a6f-a05d-364595c5b079@linux.ibm.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org, jarkko@kernel.org, linux-integrity@vger.kernel.org, viparash@in.ibm.com, linuxppc-dev@lists.ozlabs.org, peterhuewe@gmx.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 06, 2024 at 11:08:20AM -0500, Stefan Berger wrote:
> 
> 
> On 3/6/24 10:55, Stefan Berger wrote:
> > This series resolves an issue on PowerVM and KVM on Power where the memory
> > the TPM log was held in may become inaccessible or corrupted after a kexec
> > soft reboot. The solution on these two platforms is to store the whole log
> > in the device tree because the device tree is preserved across a kexec with
> > either of the two kexec syscalls.
> > 
> FYI: This was the previous attempt that didn't work with the older kexec
> syscall: https://lore.kernel.org/lkml/4afde78d-e138-9eee-50e0-dbd32f4dcfe0@linux.ibm.com/T/#m158630d214837e41858b03d4b025e6f96cb8f251

Doesn't everyone else still need that? Is powerpc the only ones that 
care about the old kexec syscall?

Rob
