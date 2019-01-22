Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528B4C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 09:26:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A5E218D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 09:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiR3edAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A5E218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kNMl6Tl2zDqNf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 20:26:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=915k=p6=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="FiR3edAX"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kNJD1jTGzDqN5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 20:23:24 +1100 (AEDT)
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E8847218D4;
 Tue, 22 Jan 2019 09:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548149002;
 bh=tvfSfixV9M/zFUAZ25eiE9ftJmocefhGyeG7bJ1p+wc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FiR3edAXBVFUN7hzroBaOdWPtGHJ4PvajGPuamdx3G45qsVh4pQCSBGYHxHhWCvGG
 UcxdFStjA+N+NgMGE/+jFBsRbGP+55MuNl0zqtSVFzpqWRf+oOcWl4sK+Qh8NEzL9d
 5uAQ8uVHQZ3QkihfTDVeHr2RmnOHtQsEHcXatTxU=
Date: Tue, 22 Jan 2019 10:22:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH v9 00/22] Re-use nvram module
Message-ID: <20190122092234.GA15813@kroah.com>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
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
Cc: Michael Schmitz <schmitzmic@gmail.com>, linux-fbdev@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 15, 2019 at 03:18:56PM +1100, Finn Thain wrote:
> The "generic" NVRAM module, drivers/char/generic_nvram.c, implements a
> /dev/nvram misc device. This module is used only by 32-bit PowerPC
> platforms.
> 
> The RTC "CMOS" NVRAM module, drivers/char/nvram.c, also implements a
> /dev/nvram misc device. This module is now used only by x86 and m68k
> thanks to commit 3ba9faedc180 ("char: nvram: disable on ARM").
> 
> The "generic" module cannot be used by x86 or m68k platforms because it
> cannot co-exist with the "CMOS" module. One reason for that is the
> CONFIG_GENERIC_NVRAM kludge in drivers/char/Makefile. Another reason is
> that automatically loading the appropriate module would be impossible
> because only one module can provide the char-major-10-144 alias.
> 
> A multi-platform kernel binary needs a single, generic module. With this
> patch series, drivers/char/nvram.c becomes more generic and some of the
> arch-specific code gets moved under arch/. The nvram module is then
> usable by all m68k, powerpc and x86 platforms.
> 
> This allows for removal of drivers/char/generic_nvram.c as well as a
> duplicate in arch/powerpc/kernel/nvram_64.c. By reducing the number of
> /dev/nvram char misc device implementations, the number of bugs and
> inconsistencies is also reduced.
> 
> This approach reduces inconsistencies between PPC32 and PPC64 and also
> between PPC_PMAC and MAC. A uniform API has benefits for userspace.
> 
> For example, some error codes for some ioctl calls become consistent
> across PowerPC platforms. The uniform API can potentially benefit any
> bootloader that works across the various platforms having XPRAM
> (e.g. Emile).
> 
> This patch series was tested on Atari, Mac, PowerMac (both 32-bit and
> 64-bit) and ThinkPad hardware. AFAIK, it has not yet been tested on
> pSeries or CHRP.
> 
> I think there are two possible merge strategies for this patch series.
> The char misc maintainer could take the entire series. Alternatively,
> the m68k maintainer could take patches 1 thru 16 (though some of these
> have nothing to do with m68k) and after those patches reach mainline
> the powerpc maintainer could take 17 thru 22.

I just took the whole series, thanks for doing this, looks good.

greg k-h
