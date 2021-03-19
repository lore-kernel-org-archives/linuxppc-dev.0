Return-Path: <SRS0=qtcn=IR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5544C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 10:59:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3363A64F1C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 10:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3363A64F1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F21BK2PRFz3c6P
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 21:59:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=I+cO51PE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=I+cO51PE; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F219v2n96z2yRF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2021 21:59:31 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4F219t6QK8z9sW1;
 Fri, 19 Mar 2021 21:59:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1616151571;
 bh=u+zIru9QhtXL5Nj/u0sXAbCn9PF+0edmKqZ7DBy43/A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=I+cO51PEdWtUfNEX46rlyE1WAkUmEagvYUqZTBNPggWmTpa2IGaDj5QZHgWzV5wcy
 K9XnmyAxpgFPJ8ATRzfKjpF67ghRB/7yuZ22WOCMGr8LIEjNLuWLq4ECaU+ah7LdIs
 CeLjpPix7UFBzm1mdI+OXZk5rneeO7Nqsee62MydeRDLAfneWAG9E/VprFjx79iT24
 2vWzfnq0PiMR7uXbEIDpB2xlD/+9FtxPUiwsJ/kWXxYJ7QOwBUYUfTP9cHygHtNCDI
 Qx//CL76VanjqhliGRYsk/GUsfCQftf3gpuj1RUQJ+ciaoy7Ilduhoyd0l2CwDJwTH
 zXWBCMoxUeF4A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Daniel Axtens <dja@axtens.net>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 7/8] powerpc/purgatory: drop .machine specifier
In-Reply-To: <1616119361.tyoejtbh8j.astroid@bobo.none>
References: <20210225031006.1204774-1-dja@axtens.net>
 <20210225031006.1204774-8-dja@axtens.net>
 <20210225155836.GG28121@gate.crashing.org>
 <1616119361.tyoejtbh8j.astroid@bobo.none>
Date: Fri, 19 Mar 2021 21:59:29 +1100
Message-ID: <87czvv8l4e.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, llvmlinux@lists.linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Excerpts from Segher Boessenkool's message of February 26, 2021 1:58 am:
>> On Thu, Feb 25, 2021 at 02:10:05PM +1100, Daniel Axtens wrote:
>>> It's ignored by future versions of llvm's integrated assembler (by not -11).
>>> I'm not sure what it does for us in gas.
>> 
>> It enables all insns that exist on 620 (the first 64-bit PowerPC CPU).
>
> Same question for this, why do we have it at all?

I sent a patch to drop it.

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210315034159.315675-1-mpe@ellerman.id.au/

cheers
