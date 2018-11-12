Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7E3C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 04:30:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1AB21527
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 04:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzrSRQ+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1AB21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42td9T3fnDzF25X
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 15:30:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VzrSRQ+J";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VzrSRQ+J"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tczM2BFJzF3Fg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 15:22:07 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id z13-v6so7753763wrs.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 20:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=02S7gP8CBtLu/d2vn+LP1VB7jEPtnklyU3WqzRNVQTc=;
 b=VzrSRQ+JM8AQLv7s6XcDBlE0ZdMcRcFn+6R+TNTqMLem6BSiFRB3dsOATP099IGwpd
 ujEP/GRork6e1NAWzbnuRxVWZlTp4B/TA1/FsIBQ152QWUAbp1Z2iJpWUmkG6G3pcNVp
 3D4bZk3y4+eGJM1qVcwn9yq7zT/LunSQnwxjx7/CvV4cp++6YMRnPfWGXpaFozbhxDB0
 xil5IcRk1ThTK9AnTHYQm1HWfxj3mAuAJihoW5G1NBvfVqzcMYi79X6YkAtryz5UweP0
 fVc37qOiSTUvs6rpobcLPxKINjBBLEPgoKVeOTEwZHBu0C0YQLSY0epaeHqSXAHbW2Ys
 RE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=02S7gP8CBtLu/d2vn+LP1VB7jEPtnklyU3WqzRNVQTc=;
 b=MlqdNMTkm1+wtmVKgCdmFcN8dk7WOfgfErQ+zsgAClY+2NdsNm6Z/pCilEXOqqGfxN
 nv4lNX15X8A47hAFVUMKIR2Cdr3IiHMN8k4NVl2k5+mPOrz+k4ptTJVK1grcPE/3grHS
 jV4TlydDVf52rIAJgqX5zKVaznNWyKfZQAnTE0tIWD9siBtIueICRlYMKUV4rQa8oLRp
 sUw07Hy/WdBF0MMBVPJb3QiMzWdXI0sIohdfi+NchClsFXb9V4f8ZkJGsNlAm8s3HRA9
 VDoF39GVL2hZkMgFhTZ1yb0ckilHgh7RpJ6hzyHJ6Su+gMTG51QsozU3VtFOyCwPqXrx
 5Juw==
X-Gm-Message-State: AGRZ1gJCKyclfFlX5/pUOSl13C+0VaaiiIDmYxrf7fpmUWr4dgLjuamU
 ZZThDFLGSh8RM7kqre1NZCc=
X-Google-Smtp-Source: AJdET5dqo97oNvVhbeHeAC8ILm3BUif2kLLNwLcv0IBPSdLDjvuMRio/jZQQxfkfSCWQWlB8F0MuNQ==
X-Received: by 2002:adf:df0a:: with SMTP id
 y10-v6mr14821319wrl.127.1541996524481; 
 Sun, 11 Nov 2018 20:22:04 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id j189-v6sm26136436wmf.18.2018.11.11.20.22.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 11 Nov 2018 20:22:03 -0800 (PST)
Date: Mon, 12 Nov 2018 05:22:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH 02/17] x86: Add support for ZSTD-compressed kernel
Message-ID: <20181112042200.GA96061@gmail.com>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
 <20181109190304.8573-2-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109190304.8573-2-kilobyte@angband.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, James Hogan <jhogan@kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-xtensa@linux-xtensa.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Nick Terrell <terrelln@fb.com>, openrisc@lists.librecores.org,
 Borislav Petkov <bp@alien8.de>, Stafford Horne <shorne@gmail.com>,
 Chris Zankel <chris@zankel.net>, linux-parisc@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


* Adam Borowski <kilobyte@angband.pl> wrote:

> From: Nick Terrell <terrelln@fb.com>
> 
> Integrates the ZSTD decompression code to the x86 pre-boot code.
> 
> Zstandard requires slightly more memory during the kernel decompression
> on x86 (192 KB vs 64 KB), and the memory usage is independent of the
> window size.
> 
> Zstandard requires memory proportional to the window size used during
> compression for decompressing the ramdisk image, since streaming mode is
> used. Newer versions of zstd (1.3.2+) list the window size of a file
> with `zstd -lv <file>'. The absolute maximum amount of memory required
> is just over 8 MB.
> 
> Signed-off-by: Nick Terrell <terrelln@fb.com>
> ---
>  Documentation/x86/boot.txt        | 6 +++---
>  arch/x86/Kconfig                  | 1 +
>  arch/x86/boot/compressed/Makefile | 5 ++++-
>  arch/x86/boot/compressed/misc.c   | 4 ++++
>  arch/x86/boot/header.S            | 8 +++++++-
>  arch/x86/include/asm/boot.h       | 6 ++++--
>  6 files changed, 23 insertions(+), 7 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 4c881c850125..af2efb256527 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -526,8 +526,14 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
>  # the size-dependent part now grows so fast.
>  #
>  # extra_bytes = (uncompressed_size >> 8) + 65536
> +#
> +# ZSTD compressed data grows by at most 3 bytes per 128K, and only has a 22
> +# byte fixed overhead but has a maximum block size of 128K, so it needs a
> +# larger margin.
> +#
> +# extra_bytes = (uncompressed_size >> 8) + 131072
>  
> -#define ZO_z_extra_bytes	((ZO_z_output_len >> 8) + 65536)
> +#define ZO_z_extra_bytes	((ZO_z_output_len >> 8) + 131072)

This change would also affect other decompressors, not just ZSTD, 
correct?

Might want to split this change out into a separate preparatory patch to 
allow it to be bisected to, or at least mention it in the changelog more 
explicitly?

Thanks,

	Ingo
