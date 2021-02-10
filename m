Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FBCC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 17:29:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0F064E7C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 17:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0F064E7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbRZf6LHFzDwjJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 04:29:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PYxXK7GD; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbRWt6rBHzDsYd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2021 04:26:50 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75CF064E05;
 Wed, 10 Feb 2021 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612978007;
 bh=L+9ZY6K3T2erGZBQk5+t7RI7BYJvkEJbar4mTVy5H0U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PYxXK7GDNBqNxrfsDcFg0krA6Xt4Z+erkFS7v3V7XiOxi5ybzH73uGmPfgz0KgzGV
 rYVPv2YB0pV8PGQnVJDaECb58s8GPGHBB1IiiU2QfmIMkmrt/HUQKdx49BOzdWGqqK
 ZOb1/dAJnElc+yDzDkvYGXVnu5zGnyPuSpzO6wsakYFMQzZWpUV5ftndbWZ+HwSdhO
 3/Ba9fYhBMru5owRfcT3fK4u4/TNUdgbHrsyHHiuP+4dOmA78huCa4/v87+JFG0FKn
 d+mpcP5/OBABfK6ng6UpK+7/MvRQifQjt1Bysohv2GIBVhgLKgriM8l6blDbGj/Vlh
 P/szDaZsUQ0mA==
Date: Wed, 10 Feb 2021 17:26:39 +0000
From: Will Deacon <will@kernel.org>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Re: [PATCH v17 03/10] arm64: Use common of_kexec_alloc_and_setup_fdt()
Message-ID: <20210210172638.GA29087@willie-the-truck>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-4-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209182200.30606-4-nramas@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mark.rutland@arm.com, tao.li@vivo.com, zohar@linux.ibm.com,
 paulus@samba.org, vincenzo.frascino@arm.com, frowand.list@gmail.com,
 sashal@kernel.org, robh@kernel.org, masahiroy@kernel.org, jmorris@namei.org,
 takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, serge@hallyn.com, devicetree@vger.kernel.org,
 pasha.tatashin@soleen.com, prsriva@linux.microsoft.com, hsinyi@chromium.org,
 allison@lohutok.net, christophe.leroy@c-s.fr, mbrugger@suse.com,
 balajib@linux.microsoft.com, dmitry.kasatkin@gmail.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, gregkh@linuxfoundation.org,
 joe@perches.com, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 09, 2021 at 10:21:53AM -0800, Lakshmi Ramasubramanian wrote:
> From: Rob Herring <robh@kernel.org>
> 
> The code for setting up the /chosen node in the device tree
> and updating the memory reservation for the next kernel has been
> moved to of_kexec_alloc_and_setup_fdt() defined in "drivers/of/kexec.c".
> 
> Use the common of_kexec_alloc_and_setup_fdt() to setup the device tree
> and update the memory reservation for kexec for arm64.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 180 ++-----------------------
>  1 file changed, 8 insertions(+), 172 deletions(-)

I mean, of course I'm going to Ack that!

Acked-by: Will Deacon <will@kernel.org>

Will
