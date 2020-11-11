Return-Path: <SRS0=kIvJ=ER=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A84CC388F9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 14:07:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA0F2072C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 14:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rzNsu/t5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA0F2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CWRQL6MffzDqS5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 01:07:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=rzNsu/t5; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CWQvV1w7bzDqNF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2020 00:44:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=g1I41NQbwOIjGBdwjkC+j3mhwkFAgihVuGwfeKOpVXw=; b=rzNsu/t5CsZEaMWoYXHzDbNrPL
 /TAv4GnYapw/nguBJc/zUT6Iv6zn+HStz9N+isLCC57QHu+J6pG15Djaz3zcKpfAbyPp/kSlEaa3W
 mEbFjlVD+sJU7HecHv2/8dQq6r0tSBizpXPqf3dISnGaOJKD8jk4j/JfAwfIhV//EaUaJPiDZnprs
 36YVfqJuWOvquFAkXNiPDWzE5spUp9Bm9cqOmy7E735N2Z9bVxucoC+VF7FfvHug3zuqqoZvTdl+W
 0JzO6UOZENZZWndygSO5ujxeVcZ8pcVOPDG434D8SY+GvGbqGm7ztvF0fyIVm6ToWlsqLr/y/rmPk
 BTx/HJEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcqQ4-0007Ne-3t; Wed, 11 Nov 2020 13:44:16 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 77B7C300238;
 Wed, 11 Nov 2020 14:44:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 619C42BDF9699; Wed, 11 Nov 2020 14:44:12 +0100 (CET)
Date: Wed, 11 Nov 2020 14:44:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] asm-generic/atomic64: Add support for ARCH_ATOMIC
Message-ID: <20201111134412.GT2611@hirez.programming.kicks-ass.net>
References: <20201111110723.3148665-1-npiggin@gmail.com>
 <20201111110723.3148665-2-npiggin@gmail.com>
 <3086114c-8af6-3863-0cbf-5d3956fcda95@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3086114c-8af6-3863-0cbf-5d3956fcda95@csgroup.eu>
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Will Deacon <will@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 11, 2020 at 02:39:01PM +0100, Christophe Leroy wrote:
> Hello,
> 
> Le 11/11/2020 à 12:07, Nicholas Piggin a écrit :
> > This passes atomic64 selftest on ppc32 on qemu (uniprocessor only)
> > both before and after powerpc is converted to use ARCH_ATOMIC.
> 
> Can you explain what this change does and why it is needed ?

That certainly should've been in the Changelog. This enables atomic
instrumentation, see asm-generic/atomic-instrumented.h. IOW, it makes
atomic ops visible to K*SAN.
