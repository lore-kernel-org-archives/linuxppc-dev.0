Return-Path: <SRS0=hyM8=TB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310FAC004C9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 06:46:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59B820651
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 06:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59B820651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44v87M4DBpzDqVK
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 16:46:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44v85W4556zDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2019 16:44:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44v85V4jQNz9sNQ;
 Wed,  1 May 2019 16:44:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH] cxl: Add new kernel traces
In-Reply-To: <1520933440-24652-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1520933440-24652-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Wed, 01 May 2019 16:44:45 +1000
Message-ID: <87muk6ad2a.fsf@concordia.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Lombard <clombard@linux.vnet.ibm.com> writes:

> This patch adds new kernel traces in the current in-kernel 'library'
> which can be called by other drivers to help interacting with an
> IBM XSL on a POWER9 system.
>
> If some kernel traces exist in the 'normal path' to handle a page or a
> segment fault, some others are missing when a page fault is handle
> through cxllib.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/cxllib.c |   3 ++
>  drivers/misc/cxl/fault.c  |   2 +
>  drivers/misc/cxl/irq.c    |   2 +-
>  drivers/misc/cxl/trace.h  | 115 ++++++++++++++++++++++++++--------------------
>  4 files changed, 72 insertions(+), 50 deletions(-)

Sorry this no longer builds:

drivers/misc/cxl/cxllib.c:215:35: note: each undeclared identifier is reported only once for each function it appears in
drivers/misc/cxl/cxllib.c:215:41: error: 'flags' undeclared (first use in this function); did you mean 'class'?
  trace_cxl_lib_handle_fault(addr, size, flags);
                                         ^~~~~
                                         class

cheers
