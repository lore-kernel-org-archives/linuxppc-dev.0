Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4D4C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 07:50:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407EA20873
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 07:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="viMfo1K1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407EA20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433wtT2S8dzDqf4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 18:50:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="viMfo1K1";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=zkqh=og=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="viMfo1K1"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433wkq6jSFzDqdm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 18:43:31 +1100 (AEDT)
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AE5EC20873;
 Tue, 27 Nov 2018 07:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543304610;
 bh=KMUuDeFxIIAT6StFc5ffKRNYDVzzYQhrih4Pz/zc3P0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=viMfo1K1Ji6Q196am/85M0PmwdMK6SHnqU+eHY6U5cdxIOcZvwOHifzfuO1hvqMIE
 xHCK4VOOAuevJWwUHme+KukzuOkF/tUgpWQqfBEm+P9zgQcsEfo758z630/INYb15u
 9F8oxVgKlKfRywZR+qdEDiJ1C3I4uNmJnKrW3viM=
Date: Tue, 27 Nov 2018 08:43:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] lkdtm: print real addresses
Message-ID: <20181127074327.GD13965@kroah.com>
References: <edfe11c6d1f9bb0a7c2cee655895dfeedc1dda5e.1541613057.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edfe11c6d1f9bb0a7c2cee655895dfeedc1dda5e.1541613057.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.0 (2018-11-25)
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
Cc: linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 07, 2018 at 08:14:10PM +0000, Christophe Leroy wrote:
> Today, when doing a lkdtm test before the readiness of the
> random generator, (ptrval) is printed instead of the address
> at which it perform the fault:
> 
> [ 1597.337030] lkdtm: Performing direct entry EXEC_USERSPACE
> [ 1597.337142] lkdtm: attempting ok execution at (ptrval)
> [ 1597.337398] lkdtm: attempting bad execution at (ptrval)
> [ 1597.337460] kernel tried to execute user page (77858000) -exploit attempt? (uid: 0)
> [ 1597.344769] Unable to handle kernel paging request for instruction fetch
> [ 1597.351392] Faulting instruction address: 0x77858000
> [ 1597.356312] Oops: Kernel access of bad area, sig: 11 [#1]
> 
> If the lkdtm test is done later on, it prints an hashed address.
> 
> In both cases this is pointless. The purpose of the test is to
> ensure the kernel generates an Oops at the expected address,
> so real addresses needs to be printed. This patch fixes that.

I am pretty sure this is intentional.  Kees?

