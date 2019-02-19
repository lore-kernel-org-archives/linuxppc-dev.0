Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C59C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 01:04:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1744921738
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 01:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1744921738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443MvN6sHQzDqGc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 12:04:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443MsW3KzhzDqDx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 12:02:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 443MsW2SCJz9sMl; Tue, 19 Feb 2019 12:02:39 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 443MsW1n4Pz9sDn;
 Tue, 19 Feb 2019 12:02:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Meelis Roos <mroos@linux.ee>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning
In-Reply-To: <0ef0b01c-e5e0-5295-3ccd-ff539dc82681@linux.ee>
References: <20190215061400.20302-1-mpe@ellerman.id.au>
 <0ef0b01c-e5e0-5295-3ccd-ff539dc82681@linux.ee>
Date: Tue, 19 Feb 2019 12:02:37 +1100
Message-ID: <8736okr3o2.fsf@concordia.ellerman.id.au>
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
Cc: malat@debian.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Meelis Roos <mroos@linux.ee> writes:

>> Rather than relying on that we can pass an explict end_pos based on
>> the sizeof(vrsave). The result should be exactly the same but it's
>> more obviously not over-reading/writing the stack and it avoids the
>> compiler warning.
>
> It works on my PowerMac G4 with Debian-ports unstable with gcc 8.

Thanks.

cheers
