Return-Path: <SRS0=zMZh=62=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF67AC47255
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2020 02:00:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB9820675
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2020 02:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="q+DNTToN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB9820675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49LgxD2X7rzDqmb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2020 12:00:16 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49LgsZ1zwZzDqpB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2020 11:57:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=q+DNTToN; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 49LgsX5r2jz9sSW; Tue, 12 May 2020 11:57:04 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49LgsX2JJwz9sRY;
 Tue, 12 May 2020 11:57:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1589248624;
 bh=ORN8HryrSgbZGLzC/893lA1G+tC/DDpQ79ckFy+UR8U=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=q+DNTToN2la2jNK0pgNsZojp3s48IJwSpy2TCSElAE69Hs6AjhWRNjrg2ymZDBDYy
 pa5RMvt68LJH5H9xXfLRZnLzn+hOvQnpsJV8XVdyzL1oEsJYstHQYbmqv4oEOp87PL
 Yob52vAylrLPLbnTiBsIXANNcPd41QaOULtfXcqtGlP2EXJUPH8S+D085eLUBc2XTt
 ovoLX64PGPkQTDAXxeO48RlX19IeASb2tb/3WFprjAprMcSPeF6reAtqUjTu8/5Uk2
 7/vNCjX/vk0/9Z5thUl4ycSd2VKUNSUMlMzU9m/WGny2l6UAbuQ6j6Cb8RJ69yDlLI
 Zatli5+67v1/g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org,
 Benjamin Herrenschmidt <benh@ozlabs.org>, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH RFC 3/4] powerpc/microwatt: Add early debug UART support
 for Microwatt
In-Reply-To: <20200509050340.GD1464954@thinks.paulus.ozlabs.org>
References: <20200509050103.GA1464954@thinks.paulus.ozlabs.org>
 <20200509050340.GD1464954@thinks.paulus.ozlabs.org>
Date: Tue, 12 May 2020 11:57:24 +1000
Message-ID: <87pnb9c3uj.fsf@mpe.ellerman.id.au>
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

Paul Mackerras <paulus@ozlabs.org> writes:
> Currently microwatt-based SoCs come with a "potato" UART.  This
> adds udbg support for the potato UART, giving us both an early
> debug console, and a runtime console using the hvc-udbg support.

Can y'all get a real UART?

There's more code here than in the platform itself.

cheers
