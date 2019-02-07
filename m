Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E76C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:35:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBFA2175B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBFA2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w58t0md0zDqPC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 15:35:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w56s5zYSzDqMx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:33:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43w56s4PGvz9sN9;
 Thu,  7 Feb 2019 15:33:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/mm: move a KERN_WARNING message to pr_debug()
In-Reply-To: <20190205202133.5048-1-lvivier@redhat.com>
References: <20190205202133.5048-1-lvivier@redhat.com>
Date: Thu, 07 Feb 2019 15:33:57 +1100
Message-ID: <8736p0kyiy.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Laurent,

I'm not sure I'm convinced about this one. It seems like we're just
throwing away the warning because it's annoying.

Laurent Vivier <lvivier@redhat.com> writes:
> resize_hpt_for_hotplug() reports a warning when it cannot
> increase the hash page table ("Unable to resize hash page
> table to target order") but this is not blocking and
> can make user thinks something has not worked properly.

Something did not work properly, the resize didn't work properly. Right?

> As we move the message to the debug area, report again the
> ENODEV error.
>
> If the operation cannot be done the real error message
> will be reported by arch_add_memory() if create_section_mapping()
> fails.

Can you explain that more. Isn't the fact that the resize failed "the
real error message"?


> Fixes: 7339390d772dd
>        powerpc/pseries: Don't give a warning when HPT resizing isn't available

This should all be on one line, and formatted as:

Fixes: 7339390d772d ("powerpc/pseries: Don't give a warning when HPT resizing isn't available")

See Documentation/process/submitting-patches.rst for more info and how
to configure git to do it automatically for you.

cheers
