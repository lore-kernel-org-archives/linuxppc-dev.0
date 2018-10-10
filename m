Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A66AC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 12:33:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04ABF2085B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 12:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04ABF2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VYRs1jWszF1RM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 23:33:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VYKZ4CpGzF0Q7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 23:28:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42VYKZ1DqBz9s7W;
 Wed, 10 Oct 2018 23:28:18 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/boot: Expose Kconfig symbols to wrapper
In-Reply-To: <20181009232803.15072-2-joel@jms.id.au>
References: <20181009232803.15072-1-joel@jms.id.au>
 <20181009232803.15072-2-joel@jms.id.au>
Date: Wed, 10 Oct 2018 23:28:14 +1100
Message-ID: <87in2a2dgh.fsf@concordia.ellerman.id.au>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joel Stanley <joel@jms.id.au> writes:
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 0fb96c26136f..eeed74e0dfca 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -197,9 +197,14 @@ $(obj)/empty.c:
>  $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
>  	$(Q)cp $< $@
>  
> +$(obj)/serial.c: $(obj)/autoconf.h
> +
> +$(obj)/autoconf.h: $(obj)/%: $(srctree)/include/generated/%
> +	$(Q)cp $< $@
> +

This gives me:
  make[2]: *** No rule to make target '../include/generated/autoconf.h', needed by 'arch/powerpc/boot/autoconf.h'.  Stop.

The ../ is $(srctree).

cheers
