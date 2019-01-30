Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE21C282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 11:45:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604A220882
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 11:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604A220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qM4V3rH2zDqQQ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 22:45:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qM2J2NzpzDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 22:43:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qM2H5TVHz9sC7;
 Wed, 30 Jan 2019 22:43:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@au1.ibm.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Does SMP work at all on 40x ?
In-Reply-To: <5c170dab-4f0b-8be2-e99a-9afd0fa02394@c-s.fr>
References: <5c170dab-4f0b-8be2-e99a-9afd0fa02394@c-s.fr>
Date: Wed, 30 Jan 2019 22:43:32 +1100
Message-ID: <871s4uqskb.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> In transfer_to_handler() (entry_32.S), we have:
>
> #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> ...
> #ifdef CONFIG_SMP
> 	CURRENT_THREAD_INFO(r9, r1)
> 	lwz	r9,TI_CPU(r9)
> 	slwi	r9,r9,3
> 	add	r11,r11,r9
> #endif
> #endif
>
> When running this piece of code, MMU translation is off. But r9 contains 
> the virtual addr of current_thread_info, so unless I miss something, 
> this cannot work on the 40x, can it ?
>
> On CONFIG_BOOKE it works because phys addr = virt addr

AFAIK 40x can't be SMP:

  config SMP
  	depends on PPC_BOOK3S || PPC_BOOK3E || FSL_BOOKE || PPC_47x


But this stuff is all before my time.

The commit that added the SMP block was clearly only meant for BookE:

  4eaddb4d7ec3 ("[POWERPC] Make Book-E debug handling SMP safe")

cheers
