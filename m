Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC2C4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 12:04:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6618D60E8C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 12:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6618D60E8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWSg569lcz30Nj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 22:04:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=VunPNjPI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=VunPNjPI; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWSfb0yCKz302M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jul 2021 22:04:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GWSfR5Vqtz9sXM;
 Fri, 23 Jul 2021 22:04:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1627041861;
 bh=WEE70A1SmlcnlIsv9nVnRGPp1lz7FMXEUMxrnsgf+IU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=VunPNjPI5UTxmlZmtF6HnK+D0Dif1lwUaNWcXlVbCnOy3zlfgpBXZRcdGvCjeSpTD
 9GtJzMFZAjmswf1Hvf+Shhuu3DtNGBXMNTQoMka2kFXjYcF/zGbOVaCZOBpwbNaHMV
 epX/8JSDuS2F3jGKGPdB1wvzULNj0TkI4wo+Z5qZ8TF2KuuqLjMk0XTObjG1udah19
 U1CpdO9KIVSiwPBast1gIEWa3fuADmNkO9j6lepWMRmuG+MHxyeWmwMTljc1HY+qcN
 iPuTprU1H6rO2uX1bsNbdVNf6qs+BaSKB5njML9F9aEsaaPNMQrnX9vJgFwZ5rtJUH
 0p1oAfMTFZbgA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Will Deacon <will@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] Revert "mm/pgtable: add stubs for
 {pmd/pub}_{set/clear}_huge"
In-Reply-To: <162686329170.980657.905966885675716231.b4-ty@kernel.org>
References: <20210720202627.Horde.vlszNhxkKrLIg0-3Sn2ucw5@messagerie.c-s.fr>
 <87r1fs1762.fsf@mpe.ellerman.id.au>
 <162686329170.980657.905966885675716231.b4-ty@kernel.org>
Date: Fri, 23 Jul 2021 22:04:10 +1000
Message-ID: <87o8at1bk5.fsf@mpe.ellerman.id.au>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
 Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Will Deacon <will@kernel.org> writes:
> On Wed, 21 Jul 2021 17:02:13 +1000, Michael Ellerman wrote:
>> This reverts commit c742199a014de23ee92055c2473d91fe5561ffdf.
>> 
>> c742199a014d ("mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge")
>> breaks arm64 in at least two ways for configurations where PUD or PMD
>> folding occur:
>> 
>>   1. We no longer install huge-vmap mappings and silently fall back to
>>      page-granular entries, despite being able to install block entries
>>      at what is effectively the PGD level.
>> 
>> [...]
>
> Thank you Michael! I owe you a beer next time I see you, if we don't go
> extinct before then.

No worries, thanks to Christophe for identifying the solution while on
vacation!

Beers seem a long way off, but hopefully one day :)

cheers
