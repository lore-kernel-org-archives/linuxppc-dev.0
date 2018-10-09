Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985C6C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 16:05:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181C72087D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 16:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181C72087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V2BF0xbhzF0Pl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 03:05:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.215.194; helo=mail-pg1-f194.google.com;
 envelope-from=bart.vanassche@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=acm.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42V0l30pyxzF3K5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 01:59:55 +1100 (AEDT)
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so959096pge.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 07:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nq9GZPvKr4eCvweILtRVPCKDQEyys82xvpkFAbURPuk=;
 b=ScdK2mYoIvEeV2l/p1h6qLFJB+8Pjy3kOvZ+SXqbwVNJt368FMyvQtZhwNKFFWHGj7
 hs7Nk9Z0CLkBPw4iLDd4FLqWY4YQo27MObJMD5Hz+vuR15Ob8jUk/Tzbhs3EKdTn2t7t
 MO+x5UcWYG7tsnoySALa/ZzyqJbbXpXK5KHVOgTgeNpiphJxcAHwWr1qBjmeFr0kItqP
 AkeOj16wI1F3SzoznvZruOEOnqRDGwUheVnsCaZYZjuFOEX67kvK+qZTracp0s7EbQGl
 hQ1Qaqz8jyvOVuUDqPWeZklYBuX5igFc//tZh+qd34MuI/XHFAeokePFy2z8R1wIQeKK
 w9qw==
X-Gm-Message-State: ABuFfoj4BguGKW2yCKUiU5GO/JdluuFeJ9hgV78SNJ8IkWPOGWkIQkOG
 PYTbvvxec4UEKKee7qgKQj4=
X-Google-Smtp-Source: ACcGV61Ho4S+AM6FMbTDsHgGjj2y4pLOolIdDjB8+lgF2EVafYiogn3dTtcsLZ9ddxI+ZS4xsBqPqw==
X-Received: by 2002:a63:e05:: with SMTP id
 d5-v6mr25843252pgl.272.1539097193611; 
 Tue, 09 Oct 2018 07:59:53 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5?
 ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
 by smtp.gmail.com with ESMTPSA id o76-v6sm32462734pfi.162.2018.10.09.07.59.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 Oct 2018 07:59:52 -0700 (PDT)
Message-ID: <1539097191.64374.44.camel@acm.org>
Subject: Re: [PATCH v3 03/24] drivers/block/z2ram: use ioremap_wt() instead
 of __ioremap(_PAGE_WRITETHRU)
From: Bart Van Assche <bvanassche@acm.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Bartlomiej Zolnierkiewicz
 <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Dominik Brodowski
 <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens
 Axboe <axboe@kernel.dk>,  Kumar Gala <galak@kernel.crashing.org>, Li Yang
 <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood
 <oss@buserror.net>,  aneesh.kumar@linux.vnet.ibm.com
Date: Tue, 09 Oct 2018 07:59:51 -0700
In-Reply-To: <0d489a2c917d6e8528fad099023eac3d5a516787.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <0d489a2c917d6e8528fad099023eac3d5a516787.1539092111.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-10-09 at 13:51 +-0000, Christophe Leroy wrote:
+AD4 +AF8-PAGE+AF8-WRITETHRU is a target specific flag. Prefer generic functions.
+AD4 
+AD4 Acked-by: Geert Uytterhoeven +ADw-geert+AEA-linux-m68k.org+AD4
+AD4 Signed-off-by: Christophe Leroy +ADw-christophe.leroy+AEA-c-s.fr+AD4

Hi Geert,

All patches that have been applied to this driver since 2005 are API refactoring
patches. I haven't found any patches in the history of this driver that seem to
have been submitted by a user of this driver. Do you perhaps know whether anyone
is using this driver?

Thanks,

Bart.

