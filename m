Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C75C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 16:36:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4A72080D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 16:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FORkOE5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4A72080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nFhJ5tMCzDqVv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:36:00 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nFfY6cFbzDqHd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 02:34:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="FORkOE5H"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44nFfY5DpLz8tPZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 02:34:29 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44nFfY4bqnz9sB3; Mon, 22 Apr 2019 02:34:29 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="FORkOE5H"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44nFfY24JRz9s9h
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2019 02:34:26 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0003120651;
 Sun, 21 Apr 2019 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1555864464;
 bh=cRDFC0AQwDEYAgoZ01HaDi1TZCJIGdzOBZ/KbQRT/+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FORkOE5HTQdiC6PE1ZHwGiiNPwTLL2EBnZanoiLGAYZGkFKrjv+ttMtv880/EmPiX
 pDETbH0J6XAsvY+giPu0omcwDL9/kPWesYprUjFShHgmmQdARwIJKYH1USch7vlw4l
 Nxa+6kFwvybIU8rc3w7m62fYqyL++pA56CMvFR+o=
Date: Sun, 21 Apr 2019 18:34:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH stable v4.4 00/52] powerpc spectre backports for 4.4
Message-ID: <20190421163421.GA8449@kroah.com>
References: <20190421142037.21881-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421142037.21881-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: npiggin@gmail.com, diana.craciun@nxp.com, linuxppc-dev@ozlabs.org,
 stable@vger.kernel.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 22, 2019 at 12:19:45AM +1000, Michael Ellerman wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Greg/Sasha,
> 
> Please queue up these powerpc patches for 4.4 if you have no objections.

why?  Do you, or someone else, really care about spectre issues in 4.4?
Who is using ppc for 4.4 becides a specific enterprise distro (and they
don't seem to be pulling in my stable updates anyway...)?

I'll be glad to take these, just want to make sure that someone actually
will use them :)

thanks,

greg k-h
