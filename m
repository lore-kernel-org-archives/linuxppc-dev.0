Return-Path: <SRS0=TUcR=HG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2876C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 18:03:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD0164F38
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 18:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD0164F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DWmcW6gtZzDwtT
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Feb 2021 05:03:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=M4sNZmII; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DWmZ45DkvzDrRS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2021 05:01:00 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FE1864E27;
 Thu,  4 Feb 2021 18:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612461657;
 bh=gQE4gnuMAcYDrBdptHws1DsAHJJIKtASdxyvgH4xSbM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M4sNZmIIjkH/I8JbrSSfLBPzSKLOtuIthLKtCptYO7u4ILwpFk/eu2Uy4+iXMLEkR
 26pEPWTeVIUhmjDhWe0TizT4NPMm5aaWBG6oSCkzBIq2qjWO+3fYZr5tycWI1HSvAW
 LEu1/YKpbpRZ/ET+eRQSGKgX9uIqSiCdpQxxEoW46Uw7To5t1H7kuMjnqH71Co1x9s
 rCK5qE3UUa9LXnQZp9ghzE2NuZEah4fSe4qeQ9hQy3fknYcdyoKPlnEA91Oy/Twm0v
 msP+PqCYakHyGo9GvpJZfedykDyJZGJmni/A42MW4dvmXbF44ZGacz7JpqDjZ1Gns1
 QzKm21vn/oBaw==
Date: Thu, 4 Feb 2021 18:00:49 +0000
From: Will Deacon <will@kernel.org>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Re: [PATCH v16 10/12] arm64: Use OF alloc and free functions for FDT
Message-ID: <20210204180048.GD21303@willie-the-truck>
References: <20210204164135.29856-1-nramas@linux.microsoft.com>
 <20210204164135.29856-11-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204164135.29856-11-nramas@linux.microsoft.com>
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
Cc: mark.rutland@arm.com, bhsharma@redhat.com, tao.li@vivo.com,
 zohar@linux.ibm.com, paulus@samba.org, vincenzo.frascino@arm.com,
 frowand.list@gmail.com, sashal@kernel.org, robh@kernel.org,
 masahiroy@kernel.org, jmorris@namei.org, takahiro.akashi@linaro.org,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 serge@hallyn.com, devicetree@vger.kernel.org, pasha.tatashin@soleen.com,
 prsriva@linux.microsoft.com, hsinyi@chromium.org, allison@lohutok.net,
 christophe.leroy@c-s.fr, mbrugger@suse.com, balajib@linux.microsoft.com,
 dmitry.kasatkin@gmail.com, linux-kernel@vger.kernel.org, james.morse@arm.com,
 gregkh@linuxfoundation.org, joe@perches.com, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 04, 2021 at 08:41:33AM -0800, Lakshmi Ramasubramanian wrote:
> of_alloc_and_init_fdt() and of_free_fdt() have been defined in
> drivers/of/kexec.c to allocate and free memory for FDT.
> 
> Use of_alloc_and_init_fdt() and of_free_fdt() to allocate and
> initialize the FDT, and to free the FDT respectively.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 37 +++++++-------------------
>  1 file changed, 10 insertions(+), 27 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
