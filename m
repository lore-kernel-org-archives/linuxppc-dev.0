Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F1EC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 14:28:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84118208D9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 14:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84118208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P4Q32httzF38t
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 00:28:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=diac24.net
 (client-ip=2a07:2ec0:2185::; helo=eidolon.nox.tf;
 envelope-from=equinox@diac24.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=diac24.net
Received: from eidolon.nox.tf (eidolon.nox.tf [IPv6:2a07:2ec0:2185::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P4N006M4zF0PM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 00:26:23 +1000 (AEST)
Received: from equinox by eidolon.nox.tf with local (Exim 4.90_1)
 (envelope-from <equinox@diac24.net>)
 id 1g6z9O-002VUL-8q; Mon, 01 Oct 2018 16:26:18 +0200
Date: Mon, 1 Oct 2018 16:26:18 +0200
From: David Lamparter <equinox@diac24.net>
To: Scott Wood <oss@buserror.net>
Subject: Re: [PATCH ppc-next] powerpc/fsl-booke: don't load early TLB at once
Message-ID: <20181001142618.GQ487685@eidolon.nox.tf>
References: <20180920224856.GJ487685@eidolon.nox.tf>
 <1537489893.7689.38.camel@redhat.com>
 <20180921010019.GL487685@eidolon.nox.tf>
 <20180922054516.GA19015@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922054516.GA19015@home.buserror.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
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
Cc: York Sun <york.sun@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 Scott Wood <swood@redhat.com>, David Lamparter <equinox@diac24.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Sep 22, 2018 at 12:45:16AM -0500, Scott Wood wrote:
> I don't suppose you're running a relocatable kernel at a non-zero

# CONFIG_RELOCATABLE is not set

> address, and/or are running in an environment that sets
> HID0[EN_L2MMU_MHD] (neither standard U-boot nor Linux sets this bit,

It's u-boot v2018.09-rc3;  bit "33" / 30 isn't even defined as a
constant, much less touched anywhere.  HID0 in u-boot seems to be
0x80000080 aka EMCP | EN_MAS7_UPDATE.

> though they probably should)?  On 32-bit, we're already running in an AS1
> trampoline when loadcam_multi() is called, but loadcam_multi() sets up
> its own.  This happens to not be catastrophic in standard scenarios, but
> it does add a duplicate TLB entry, and we return to AS0 sooner than
> expected.  I think your patch, plus ifdefs to make the change 32-bit
> only, is the appropriate fix.

I'll resend it with ifdefs inserted.  Meanwhile, still trying the
default config as mentioned in my previous mail.

> I also got an earlier udbg for e500 working (and happened to decide to
> test it with a relocatable kernel); I'll send that out once I've cleaned
> it up (or sooner with the extra TLB dumping included if the above doesn't
> explain why you're hitting this bug).

Thanks & Cheers,


-David
