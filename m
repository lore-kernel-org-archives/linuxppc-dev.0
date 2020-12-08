Return-Path: <SRS0=iKYh=FM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAC9C433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 09:04:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A6D23A7F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 09:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A6D23A7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CqvPl3cTPzDqLw
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 20:04:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CqvMZ6Bt3zDqCM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2020 20:02:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=pXld9tk0; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4CqvMZ4xrLz9sWR; Tue,  8 Dec 2020 20:02:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CqvMZ0yzzz9sWQ;
 Tue,  8 Dec 2020 20:02:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1607418154;
 bh=1JsjWFPNaV7qbLNXrHlyg89qbEGvqxuYkxQMK5KbnFQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=pXld9tk0Xub1pSabCDtKvca714+NbQwOXMwQwQEQjZvKG501Wx/3eEWcqIXCwXKa5
 3JfDe14HYXGruM22k+uuC7cVDxAhQEptFDtatXqCm2eTB0YhvkvLPQ9lQ951Rz+2GU
 9QXjyAenMl7KYCJJXU2PjLfoknRM0BSOSK5EMCe5uwjUZ33dmaFmAVB9EtJBXrFh1U
 rvwCRBWhcqALRvef4SyjYiPajb2V/Br2pxdLyb1XW+02DA45AngtfucrsCoSRyAw/X
 8lxQaj2Zvagm5DMUd088l1jfGIkuM7+6T0PIeifxbco4CyT7LOGcZZilBk9TRlmfnY
 OOgbegDG0C0LQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] EDAC/mv64x60: Remove orphan mv64x60 driver
In-Reply-To: <20201207111727.GC20489@zn.tnic>
References: <20201207040253.628528-1-mpe@ellerman.id.au>
 <20201207111727.GC20489@zn.tnic>
Date: Tue, 08 Dec 2020 20:02:31 +1100
Message-ID: <874kkwu0uw.fsf@mpe.ellerman.id.au>
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
Cc: tony.luck@intel.com, rric@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, james.morse@arm.com, mchehab@kernel.org,
 linux-edac@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Borislav Petkov <bp@alien8.de> writes:
> On Mon, Dec 07, 2020 at 03:02:53PM +1100, Michael Ellerman wrote:
>> The mv64x60 EDAC driver depends on CONFIG_MV64X60. But that symbol is
>> not user-selectable, and the last code that selected it was removed
>> with the C2K board support in 2018, see:
>> 
>>   92c8c16f3457 ("powerpc/embedded6xx: Remove C2K board support")
>> 
>> That means the driver is now dead code, so remove it.
>> 
>> Suggested-by: Borislav Petkov <bp@alien8.de>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  drivers/edac/Kconfig        |   7 -
>>  drivers/edac/Makefile       |   1 -
>>  drivers/edac/mv64x60_edac.c | 883 ------------------------------------
>>  drivers/edac/mv64x60_edac.h | 114 -----
>>  4 files changed, 1005 deletions(-)
>>  delete mode 100644 drivers/edac/mv64x60_edac.c
>>  delete mode 100644 drivers/edac/mv64x60_edac.h
>
> Gladly taken and applied, thanks!

Thanks.

cheers
