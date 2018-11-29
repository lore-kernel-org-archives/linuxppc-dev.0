Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668DBC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 11:07:58 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB61F2081B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 11:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB61F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435F9k6fYTzDrBG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 22:07:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435F672Hq5zDrBw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 22:04:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 435F664nVkz9s8J;
 Thu, 29 Nov 2018 22:04:46 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/boot: Copy serial.c in Makefile
In-Reply-To: <87woow7apx.fsf@linkitivity.dja.id.au>
References: <20181128043417.24784-1-dja@axtens.net>
 <87woow7apx.fsf@linkitivity.dja.id.au>
Date: Thu, 29 Nov 2018 22:04:45 +1100
Message-ID: <87zhts2lgy.fsf@concordia.ellerman.id.au>
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
Cc: Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi dja,

Daniel Axtens <dja@axtens.net> writes:
> Right, so as both 0-day and snowpatch tell me, this patch is wrong.
>
> It turns out that this:
>>  $(obj)/serial.c: $(obj)/autoconf.h
>> +	$(Q)cp $< $@
> is identical to:
> cp arch/powerpc/boot/autoconf.h arch/powerpc/boot/serial.c
>
> (Clearly my make mastery is inadequate.)
>
> Amusingly this which works for my 64e uImage but obviously not for
> anything that actually needs code from serial.c.
>
> Further analysis suggests that making with -j1 triggers the issue, but
> everything works with -j2 and above. That would make sense with the
> timeline of when I discovered the issue because I changed my build
> script to not build in parallel.

I don't get why -j makes a difference, but that does explain why we
haven't seen it, none of my tests use -j 1 :)

I don't think we actually want to copy serial.c, we just want to specify
a dependency, does this work for you?

cheers

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 39354365f54a..ed9883169190 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -197,7 +197,7 @@ $(addprefix $(obj)/,$(libfdt) $(libfdtheader)): $(obj)/%: $(srctree)/scripts/dtc
 $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
 	$(Q)cp $< $@
 
-$(obj)/serial.c: $(obj)/autoconf.h
+$(srctree)/$(src)/serial.c: $(obj)/autoconf.h
 
 $(obj)/autoconf.h: $(obj)/%: $(objtree)/include/generated/%
 	$(Q)cp $< $@
