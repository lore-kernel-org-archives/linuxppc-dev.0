Return-Path: <SRS0=TkHQ=65=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B1AC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 02:04:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90E8206A5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 02:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TL3gbeBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90E8206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49NWtP38KVzDqyx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 12:04:13 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49NWrQ5QxhzDqxF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2020 12:02:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=TL3gbeBL; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49NWrP5nt7z9sSk;
 Fri, 15 May 2020 12:02:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1589508150;
 bh=XWak7VT7DTMrDbCJFicTzgUG9iU5bXMoPyEnMjmgnFU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=TL3gbeBLuLjYBE9Zs2KavOXM0sooQjhO+SwVXmFgS+BjDx+ZfwaQgkFpFds3fPRzW
 NUHe5U4XhtNb43NpQRpM5VHSPq+nIjuq7dXUGte0X+BfLzGSxRoLju/fCEOVKT9vFt
 ZHKgNQBjGcaO3sT3PQ/BH0+LR5z1wIX2u4eZ2PkiWNcfYNwZ6YZYVbysF+/5DoZVqT
 ogSu+ckiuS9YHZFO+Jr4c559EMNu8Ol9so69KpUqxG7VTYKWML7iM3b0Va0Do0eS8c
 s7zOPMPITgPxHi/X1BcEVE2NzHLamRK1l31XbHGRgeez/rgWZnYfkVxmaUQ7vbw+bT
 D80lqVlOsPrpw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH v2 7/9] powerpc/ps3: Add check for otheros image size
In-Reply-To: <4e8defeb49d62dd9d435e5ea3ddc5668e56fa496.1589049250.git.geoff@infradead.org>
References: <cover.1589049250.git.geoff@infradead.org>
 <4e8defeb49d62dd9d435e5ea3ddc5668e56fa496.1589049250.git.geoff@infradead.org>
Date: Fri, 15 May 2020 12:02:50 +1000
Message-ID: <87y2pu9cqd.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Emmanuel Nicolet <emmanuel.nicolet@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Geoff,

Geoff Levand <geoff@infradead.org> writes:
> The ps3's otheros flash loader has a size limit of 16 MiB for the
> uncompressed image.  If that limit will be reached output the
> flash image file as 'otheros-too-big.bld'.
>
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/powerpc/boot/wrapper | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 35ace40d9fc2..ab1e3ddc79f3 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -571,7 +571,20 @@ ps3)
>          count=$overlay_size bs=1
>  
>      odir="$(dirname "$ofile.bin")"
> -    rm -f "$odir/otheros.bld"
> -    gzip -n --force -9 --stdout "$ofile.bin" > "$odir/otheros.bld"
> +
> +    # The ps3's flash loader has a size limit of 16 MiB for the uncompressed
> +    # image.  If a compressed image that exceeded this limit is written to
> +    # flash the loader will decompress that image until the 16 MiB limit is
> +    # reached, then enter the system reset vector of the partially decompressed
> +    # image.  No warning is issued.
> +    rm -f "$odir"/{otheros,otheros-too-big}.bld
> +    size=$(${CROSS}nm --no-sort --radix=d "$ofile" | egrep ' _end$' | cut -d' ' -f1)
> +    bld="otheros.bld"
> +    if [ $size -gt $((0x1000000)) ]; then
> +        bld="otheros-too-big.bld"
> +        echo "  INFO: Uncompressed kernel is too large to program into PS3 flash memory;" \

This now appears on all my ppc64_defconfig builds, which I don't really
like.

That does highlight the fact that ppc64_defconfig including
CONFIG_PPC_PS3 is not really helpful for people actually wanting to run
the kernel on a PS3.

So I wonder if we should drop CONFIG_PPC_PS3 from ppc64_defconfig, in
which case I'd be happy to keep the INFO message because it should only
appear on ps3 specific builds.

The other option would be to drop the message, or only print it when
we're doing a verbose build.

Thoughts?

cheers
