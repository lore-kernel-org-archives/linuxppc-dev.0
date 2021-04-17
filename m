Return-Path: <SRS0=JxsT=JO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF7FC433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 12:30:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA0E61019
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 12:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA0E61019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FMsqr6pX3z3c4W
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 22:30:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=aCXQ421y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=aCXQ421y; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FMsqN5ccgz300S
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Apr 2021 22:30:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FMsqJ1ckGz9vG3;
 Sat, 17 Apr 2021 22:30:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1618662620;
 bh=mtQXXNJfragy4YQoBiwVomNkLwmcNxRqSSFA0RO5LCo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=aCXQ421yZApjtSXo4wDJS5qyT1JaMFSEi8NEckR1sYexHW87ktiqBKTQh9rp4jq4B
 b3RAJU5OL25nzAG9tJ/ylT8EjLNhIJeahLFUNn5ZaCnS6FES6iHeBq0pk4wPjiYnx6
 iNwXBy/HK60pJlzELKvX1eyq8QWlGZOMjxAB7XSamDg7JqbFawr9Is+d6i4jNvqKiP
 n41xrIzhRWrwW5XFQ6oobgw0u66Qz+LouPxrvvuv//RrfLT4aln0SI206UUVgWkTJs
 /RJ+8l7g6MGSVIxx8L0/odoo8YM041S2FV3bD4zfpnH4Zbl4JaEGK+9LPn0//nSdqH
 bSJUoxa3H5cGg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Add shutdown() to vio_driver and vio_bus
In-Reply-To: <f326def4-0db0-f924-1700-dd7be3154153@linux.ibm.com>
References: <20210402001325.939668-1-tyreld@linux.ibm.com>
 <f326def4-0db0-f924-1700-dd7be3154153@linux.ibm.com>
Date: Sat, 17 Apr 2021 22:30:14 +1000
Message-ID: <87im4ldrft.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> On 4/1/21 5:13 PM, Tyrel Datwyler wrote:
>> Currently, neither the vio_bus or vio_driver structures provide support
>> for a shutdown() routine.
>> 
>> Add support for shutdown() by allowing drivers to provide a
>> implementation via function pointer in their vio_driver struct and
>> provide a proper implementation in the driver template for the vio_bus
>> that calls a vio drivers shutdown() if defined.
>> 
>> In the case that no shutdown() is defined by a vio driver and a kexec is
>> in progress we implement a big hammer that calls remove() to ensure no
>> further DMA for the devices is possible.
>> 
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
>> ---
>
> Ping... any comments, problems with this approach?

The kexec part seems like a bit of a hack.

It also doesn't help for kdump, when none of the shutdown code is run.

How many drivers do we have? Can we just implement a proper shutdown for
them?

cheers
