Return-Path: <SRS0=LDiU=PI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723D2C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 12:33:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4B120828
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 12:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4B120828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43SxYV53nCzDqK3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 23:33:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43SxTm6nXvzDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 23:30:04 +1100 (AEDT)
Received: by mail-qt1-f193.google.com with SMTP id y20so29150079qtm.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 04:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wyBGgV7y89Nappfs2uMQN0NgbtoaB2ye+s9iy3PwtU0=;
 b=Uw3ciiqnuogKYXivAHmeHdOPjMdutornlE13tUHfH+b25ZV05TZSdYq6EmLfigzh0q
 B03ICI4mWfefB4NUF4jTOU4OMFVgknlcxr/XI4pfzGbXN53MrzLP4gpVnBoANcdgROXH
 D4Sc7/NiNa64jW+pU4CGDkv5ZH2BM/nTesSr95SEWhsNQnl96/0g9b/9KDiX9YwvOEk3
 fQrTVtPCKWR6vRtHuBXA0ti+U745F4EtBGmnQA9GI4+VWfiOSc0q/rucpPfnVY2y3hwj
 4BhTJrinycGwGTJ6b3zRp7tGqjQNP3HgX7QF+WixRIEPDB0q/wMXAWMGzVhXBCYCH29T
 a1xQ==
X-Gm-Message-State: AJcUuke8DlrfYCM+PlTnjtpEIsjctertRsrJdLU8rlZvGPJ0e8cGGXY+
 cxGi9FcrguQp4bzoTdNbV04fVkWImlF1QDJTwSc=
X-Google-Smtp-Source: ALg8bN78nzpr6RAfn9K/xDHDkUTXDA60lmFIoF+U5fm48QizoiYb4CvGD9Nx9cJscaTquq2Gl/bPgkBR7DJoywRiZWc=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr8484244qtl.343.1546259402640; 
 Mon, 31 Dec 2018 04:30:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <7e8eb87ea829c03941c895c968df2ebd0f80512f.1545784679.git.fthain@telegraphics.com.au>
 <20181229180236.Horde.idY3gOIzkSWywjIrqlXJMA1@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812301024400.215@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812301024400.215@nippy.intranet>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 31 Dec 2018 13:29:46 +0100
Message-ID: <CAK8P3a3645im4aFDi2mNjwcCe=jvmDLkKK_ZSwG1POOLUq=+QQ@mail.gmail.com>
Subject: Re: [PATCH v8 20/25] powerpc, fbdev: Use arch_nvram_ops methods
 instead of nvram_read_byte() and nvram_write_byte()
To: Finn Thain <fthain@telegraphics.com.au>
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
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 30, 2018 at 12:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:

>
> Is there some benefit, or is that just personal taste?
>
> Avoiding changes to call sites avoids code review, but I think 1) the
> thinkpad_acpi changes have already been reviewed and 2) the fbdev changes
> need review anyway.
>
> Your suggesion would add several new entities and one extra layer of
> indirection.
>
> I think indirection harms readability because now the reader now has to go
> and look up the meaning of the new entities.
>
> It's not the case that we need to choose between definitions of
> nvram_read_byte() at compile time, or stub them out:
>
> #ifdef CONFIG_FOO
> static inline unsigned char nvram_read_byte(int addr)
> {
>         return arch_nvram_ops.read_byte(addr);
> }
> #else
> static inline unsigned char nvram_read_byte(int addr) { }
> #endif
>
> And I don't anticipate a need for a macro here either:
>
> #define nvram_read_byte(a) random_nvram_read_byte_impl(a)
>
> I think I've used the simplest solution.

Having the indirection would help if the inline function can
encapsulate the NULL pointer check, like

static inline unsigned char nvram_read_byte(loff_t addr)
{
       char data;

       if (!IS_ENABLED(CONFIG_NVRAM))
                 return 0xff;

       if (arch_nvram_ops.read_byte)
                 return arch_nvram_ops.read_byte(addr);

       if (arch_nvram_ops.read)
                 return arch_nvram_ops.read(char, 1, &addr);

      return 0xff;
}

(the above assumes no #ifdef in the structure definition, if you
keep the #ifdef there they have to be added here as well).

      Arnd
