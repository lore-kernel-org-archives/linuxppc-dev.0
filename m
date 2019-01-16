Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72853C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 14:33:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC542063F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 14:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC542063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fqSC03KRzDqSx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 01:32:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.221.196; helo=mail-vk1-f196.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com
 [209.85.221.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fq6T4mB3zDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 01:17:37 +1100 (AEDT)
Received: by mail-vk1-f196.google.com with SMTP id 197so1449096vkf.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 06:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vUoQNGZurxEieeNNkZzDAFHiiSFH7qL1lJ5rxrPcqZQ=;
 b=dBnNHSj/GrhyQjrn29kMCJptKWb4psKKbAZ7p7tRVZcuiXBE40rXXOued+eurKAp4u
 mFf+0JiMLJVu+3Qlb+xdRB2HLQEbeLuMeJUj9ND00l570YtIZYMLyQ4vPDrIY6wsMBod
 h7SFZi1eEqN89F1CNtW3V0N0JIsJ65DvZ3Ye5rrZbfWrsaPDSL7ruCsFJ1qfxBJ1cdEr
 1El9TV1NxddZhvNk0O3TZZsLcoy+gZosJ/iUm01goOtKqIt65qGI2WTzJpvDHwLwM965
 tc/yV85XrEqbo5ASXKZ4Eik8KzN/eoMN3p+5xLKKty6TLqbb9rzSb7DinH0Om158I2n7
 P0pA==
X-Gm-Message-State: AJcUukdoD5p6ZHx6jzfjTDnznUlvlvbZzgAAjSy2aEvWHM8o4a5KRrZ1
 jxSLKpehdCPoFef3P3wtxnbSL8Vq4z74mqPhn5s=
X-Google-Smtp-Source: ALg8bN5i1YrhP7vEzWfAblym8WHD9rDPmIjtAsXIX2+EXB6htxAQHG2ya7Av+N0ySlQVktSH89EOjOgISmgR9ezPUnY=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr3570847vkd.74.1547648254958; 
 Wed, 16 Jan 2019 06:17:34 -0800 (PST)
MIME-Version: 1.0
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-14-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1547646261-32535-14-git-send-email-rppt@linux.ibm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Jan 2019 15:17:22 +0100
Message-ID: <CAMuHMdXt8fPgAGp3KPGM=qVT_QzU=FJS7f5XUbK2hGXYdE9Yeg@mail.gmail.com>
Subject: Re: [PATCH 13/21] arch: don't memset(0) memory returned by
 memblock_alloc()
To: Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 the arch/x86 maintainers <x86@kernel.org>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, Linux-sh list <linux-sh@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Greg Ungerer <gerg@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 alpha <linux-alpha@vger.kernel.org>, linux-um@lists.infradead.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Linux MM <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 Openrisc <openrisc@lists.librecores.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 16, 2019 at 2:45 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> memblock_alloc() already clears the allocated memory, no point in doing it
> twice.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

>  arch/m68k/mm/mcfmmu.c       | 1 -

For m68k part:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/m68k/mm/mcfmmu.c
> +++ b/arch/m68k/mm/mcfmmu.c
> @@ -44,7 +44,6 @@ void __init paging_init(void)
>         int i;
>
>         empty_zero_page = (void *) memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> -       memset((void *) empty_zero_page, 0, PAGE_SIZE);
>
>         pg_dir = swapper_pg_dir;
>         memset(swapper_pg_dir, 0, sizeof(swapper_pg_dir));

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
