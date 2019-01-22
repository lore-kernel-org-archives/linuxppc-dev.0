Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF846C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 09:21:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273E721721
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 09:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWOGU/l5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273E721721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kNFW6tZCzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 20:21:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=915k=p6=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZWOGU/l5"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kNCb34n6zDqNZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 20:19:22 +1100 (AEDT)
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5CB8420823;
 Tue, 22 Jan 2019 09:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548148760;
 bh=IByZdug91o7KmZHLYdv1kXlr1lb8QU4slF/JJJsfa+0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZWOGU/l52F1XFxguERzt2DGuzdlPNLo8BA+TMJBMqBG0qySpLPyVJV9K/AIZT2eHw
 bqPa8Wppx//uY3LkuZS3P0Qbe5XfBMU40qz+92bdZOx1m456RNoIyeyenF5zraF/Tk
 B3hc/FPe4EtutJHH5f81rEBeedrt2RpjFVqIWvVI=
Date: Tue, 22 Jan 2019 10:19:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH v9 15/22] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
Message-ID: <20190122091917.GA16612@kroah.com>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
 <fc5f13c7e60b846f533de41b179d904a95f58aea.1547525936.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5f13c7e60b846f533de41b179d904a95f58aea.1547525936.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.11.2 (2019-01-07)
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 15, 2019 at 03:18:56PM +1100, Finn Thain wrote:
> A multi-platform kernel binary has to decide at run-time how to dispatch
> the arch_nvram_ops calls. Add a platform-independent arch_nvram_ops
> struct for this, to replace the atari-specific one.
> 
> Enable CONFIG_HAVE_ARCH_NVRAM_OPS for Macs.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
> Changed since v8:
>  - Adopted nvram_read_bytes() and nvram_write_bytes() where possible.

This patch fails to apply to my tree, what did you make it against?

I tried against 5.0-rc1 :(

Can you rebase this series against the char-misc-next branch of my
char-misc.git tree and resend so that I can apply the whole series?

thanks,

greg k-h
