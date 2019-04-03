Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8273AC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 13:22:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1912084C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 13:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1912084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z6Fn1QnbzDqS7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 00:22:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z6Ct4gRszDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 00:21:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44Z6Ct3Kr6z9sSP; Thu,  4 Apr 2019 00:21:14 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44Z6Cs5jdRz9sRW;
 Thu,  4 Apr 2019 00:21:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Claudio Carvalho <cclaudio@linux.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Enabling secure boot on PowerNV systems
In-Reply-To: <20190402181505.25037-1-cclaudio@linux.ibm.com>
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
Date: Thu, 04 Apr 2019 00:21:12 +1100
Message-ID: <87r2aj1ayf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Nayna Jain <nayna@linux.ibm.com>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Claudio,

Thanks for posting this.

Claudio Carvalho <cclaudio@linux.ibm.com> writes:
> This patch set is part of a series that implements secure boot on
> PowerNV systems.
>
> In order to verify the OS kernel on PowerNV, secure boot requires X.509
> certificates trusted by the platform, the secure boot modes, and several
> other pieces of information. These are stored in secure variables
> controlled by OPAL, also known as OPAL secure variables.
>
> This patch set adds the following features:
>
> 1. Enable efivarfs by selecting CONFIG_EFI in the CONFIG_OPAL_SECVAR
>    introduced in this patch set. With CONFIG_EFIVAR_FS, userspace tools can
>    be used to manage the secure variables.
> 2. Add support for OPAL secure variables by overwriting the EFI hooks
>    (get_variable, get_next_variable, set_variable and query_variable_info)
>    with OPAL call wrappers. There is probably a better way to add this
>    support, for example, we are investigating if we could register the
>    efivar_operations rather than overwriting the EFI hooks. In this patch
>    set, CONFIG_OPAL_SECVAR selects CONFIG_EFI. If, instead, we registered
>    efivar_operations, CONFIG_EFIVAR_FS would need to depend on
>    CONFIG_EFI|| CONFIG_OPAL_SECVAR. Comments or suggestions on the
>    preferred technique would be greatly appreciated.

I am *very* reluctant to start selecting CONFIG_EFI on powerpc.

Simply because we don't actually have EFI, and I worry we're going to
both break assumptions in the EFI code as well as impose requirements on
the powerpc code that aren't really necessary.

So I'd definitely prefer we go the route of enabling efivarfs with an
alternate backend.

Better still would be a generic secure variable interface as Matt
suggests, if the userspace tools can be relatively easily adapted to use
that interface.

cheers
