Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D875DC43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:09:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35362067D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35362067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qgZP1k5nzDqT5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 01:09:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=angband.pl
 (client-ip=2001:41d0:602:dbe::8; helo=tartarus.angband.pl;
 envelope-from=kilobyte@angband.pl; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=angband.pl
X-Greylist: delayed 1375 seconds by postgrey-1.36 at bilbo;
 Fri, 26 Apr 2019 01:00:25 AEST
Received: from tartarus.angband.pl (tartarus.angband.pl
 [IPv6:2001:41d0:602:dbe::8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qgN94x68zDqKw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:00:25 +1000 (AEST)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
 (envelope-from <kilobyte@angband.pl>)
 id 1hJfUo-0007iI-Ms; Thu, 25 Apr 2019 16:37:06 +0200
Date: Thu, 25 Apr 2019 16:37:06 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 3/4] powerpc/boot: Add bzip2 support for uImage
Message-ID: <20190425143706.GA28476@angband.pl>
References: <2d3a59015307d368d6ac1a62fe7e47f5b39e2fe2.1556028978.git.christophe.leroy@c-s.fr>
 <ce215ac5f428b7fd01bf73a543f3db087e5a537e.1556028978.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce215ac5f428b7fd01bf73a543f3db087e5a537e.1556028978.git.christophe.leroy@c-s.fr>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 23, 2019 at 02:20:43PM +0000, Christophe Leroy wrote:
> This patch allows to generate bzip2 compressed uImage

Please don't add bzip2 support, that's a waste of your time as we're trying
to remove it kernel-wide.  There's a patchset to retire compressors beaten
by alternatives on the whole speed-to-size curve; reposting it is overdue.

It does:
* add ZSTD (fast and strong)
* remove BZIP2 (obsolete, only user in kernel)
* remove LZMA (redundant with XZ, uses a private copy of its library)
* makes Kconfig prose talk badly about LZO (used elsewhere in the kernel)

I believe only three compressors are worth using here: XZ, ZSTD, LZ4.
GZIP must stay because of ubiquitous support, the rest should go.

> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -199,6 +199,7 @@ config PPC
> +	select HAVE_KERNEL_BZIP2		if DEFAULT_UIMAGE
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -23,6 +23,7 @@ all: $(obj)/zImage
> +compress-$(CONFIG_KERNEL_BZIP2)   := CONFIG_KERNEL_BZIP2
> @@ -259,6 +260,7 @@ endif
> +compressor-$(CONFIG_KERNEL_BZIP2) := bz2
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -137,7 +137,7 @@ while [ "$#" -gt 0 ]; do
> -        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "lzma" -o "$1" != "none" ] || usage
> +        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "lzma" -o "$1" != "bz2" -o "$1" != "none" ] || usage
> @@ -149,6 +149,9 @@ while [ "$#" -gt 0 ]; do
> +	if [ $uboot_comp = "bz2" ]; then
> +		uboot_comp=bzip2
> +	fi
> @@ -377,6 +380,9 @@ if [ -z "$cacheit" -o ! -f "$vmz$compression" -o "$vmz$compression" -ot "$kernel
> +    .bz2)
> +        bzip2 -f "$vmz.$$"
> +	;;


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ 10 people enter a bar: 1 who understands binary,
⢿⡄⠘⠷⠚⠋⠀ 1 who doesn't, D who prefer to write it as hex,
⠈⠳⣄⠀⠀⠀⠀ and 1 who narrowly avoided an off-by-one error.
