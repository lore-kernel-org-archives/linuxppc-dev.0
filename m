Return-Path: <SRS0=3D1i=7S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5258DC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 16:17:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897F1206DB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 16:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="mRfN3HoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897F1206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49dnqV04KHzDqxL
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jun 2020 02:17:42 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49dnn90xPGzDqxH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jun 2020 02:15:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=mRfN3HoR; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49dnn83DHYz9sSf;
 Sat,  6 Jun 2020 02:15:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1591373740;
 bh=jcr7LlLyLuC9RdDIx2jIvkK3mc4bOXJo/Uo1kZ44K6c=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=mRfN3HoR+s0Y26j2hln8pRGWlQaeWI3TuleYbzcCGrsSPQTsoi5Qt/ZfY/lBku47u
 0Dc72yQkFS2PT7oT37W7yPmQz4kJHGC86ngs0D+X4ZVyibd/cFdOJ/TfA611fooxlH
 rPFd8iQ7zrzyrtPvRhk/Bw2LEtMrjr5weAAiCkKa0bceKHmrrBZhwvOeFVMj/JW+hy
 LdDnJRkCr6L1vjvn8ljGGydh2bMeo9zgb+DicPDkYO/GdNNTXo6Z9Tw3h/raY02fa5
 0yQgK0LewWui2BnSyXlZcDpdd6vnMcw6E710sMPbbUllGsXzTZ0w4L9Y2f63aHe4mn
 b/WZ6Bu/9pCsQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] cxl: Remove dead Kconfig option
In-Reply-To: <20200602070545.11942-1-ajd@linux.ibm.com>
References: <20200602070545.11942-1-ajd@linux.ibm.com>
Date: Sat, 06 Jun 2020 02:16:03 +1000
Message-ID: <87img5h4jg.fsf@mpe.ellerman.id.au>
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
Cc: fbarrat@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andrew Donnellan <ajd@linux.ibm.com> writes:
> The CXL_AFU_DRIVER_OPS Kconfig option was added to coordinate merging of
> new features. It no longer serves any purpose, so remove it.
>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
>
> ---
> v1->v2:
> - keep CXL_LIB for now to avoid breaking a driver that is currently out of tree

Sorry I already merged v1.

cheers

