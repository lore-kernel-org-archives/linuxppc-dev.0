Return-Path: <SRS0=Ic/D=XV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B046C352A9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Sep 2019 13:12:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E2B222BE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Sep 2019 13:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0MOZVUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E2B222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46fFhd05F4zDqq7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Sep 2019 23:12:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com;
 envelope-from=aford173@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="M0MOZVUz"; 
 dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46fFdr2LFLzDqNt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2019 23:10:06 +1000 (AEST)
Received: by mail-io1-xd43.google.com with SMTP id c25so6251815iot.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2019 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FZIPxOACSyBTtRH5A7Lgyz9YR30y4W13jpD2I+1mgJM=;
 b=M0MOZVUz4t6WU55SoJjNSOp7QYn65o/NCOkDutq5p4891fxVHa6jIYc0GzSPoE5NgC
 Y/F31CMUMd8X4Qdqfc4MGmYyhNuR+uHG233WadTHQa0xsWxFJv5rl8RVwaE3bu3pB7qr
 wri0795JXn4yi9BdL9A4kIX8Eq3Xd1Myt3BkKJ+99RFh8if3n6D0lMDd1/A4PUTHHLSY
 mi041pBhTLwJRt9cj7XQ/sDkCPZZAFKFgXm6Ri5VzL7A0Gk1JZg/oHQRycR2/sZb03c2
 lzEE4rwwCW+uRuqgQOz+nrJU3ZVzQbE+b9nB1IS53yKZV5lYYrQXdFhuW1+ZKBjhKOVA
 lysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FZIPxOACSyBTtRH5A7Lgyz9YR30y4W13jpD2I+1mgJM=;
 b=UJDb5gjXU/tuDF2NF9OyRKoUQM6wx7xkNi22VyKkuZohmwdXju23FysIs7MXHvoRyO
 4VeQ1YiAfDdVvZgifhMonW/JemQgGr+5xRxVandXvAUfwnp7LnECBvNJws/EIMJJaaDu
 IPudoCMzzzg0zigypY+59Y3B5m/2iqK7TvevVVmL/1VyQs5FidaoanJANwcELoap6XMp
 1ycd3Iuvk4uyqxmq8Y5efZUNVoRiBnyD0MTWr/k+N9ZrY0dk3jSXwTfoqy8c5E4xML3Y
 0z7A1jOpkJ3aerPyuwABGBEFJtWkzjYFs35Wo8FsSseRlS78myqGevsEU7pUXe0mkD50
 n14w==
X-Gm-Message-State: APjAAAVWpxouIj47qmAG/VnuYbdY/YeRaYRXr7I+YczvcmIu1qQ+2Nu1
 ho8VwhJ3BNz8HtRx4g9nkbsWGyAW+LrYCVJREIA=
X-Google-Smtp-Source: APXvYqzlyCi4JSGY6XghEeQ/E8vAIH7ViuIHrzxvUyMsua1GZWLVjXjlSiGwrvjIiebbaCWFI8rRhtB8cjRotnhYNKg=
X-Received: by 2002:a6b:d601:: with SMTP id w1mr3118098ioa.158.1569503404009; 
 Thu, 26 Sep 2019 06:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
 <CAOMZO5A_U4aYC4XZXK1r9JaLg-eRdXy8m6z4GatQp62rK4HZ6A@mail.gmail.com>
 <CAHCN7xJdzEppn8-74SvzACsA25bUHGdV7v=CfS08xzSi59Z2uw@mail.gmail.com>
 <CAOMZO5D2uzR6Sz1QnX3G-Ce_juxU-0PO_vBZX+nR1mpQB8s8-w@mail.gmail.com>
In-Reply-To: <CAOMZO5D2uzR6Sz1QnX3G-Ce_juxU-0PO_vBZX+nR1mpQB8s8-w@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 26 Sep 2019 08:09:52 -0500
Message-ID: <CAHCN7xJ32BYZu-DVTVLSzv222U50JDb8F0A_tLDERbb8kPdRxg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Refine memblock API
To: Fabio Estevam <festevam@gmail.com>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, devicetree <devicetree@vger.kernel.org>,
 Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev <kasan-dev@googlegroups.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>,
 Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org,
 Chris Healy <cphealy@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
 The etnaviv authors <etnaviv@lists.freedesktop.org>,
 linux-m68k@lists.linux-m68k.org, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 arm-soc <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 25, 2019 at 10:17 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Sep 25, 2019 at 9:17 AM Adam Ford <aford173@gmail.com> wrote:
>
> > I tried cma=256M and noticed the cma dump at the beginning didn't
> > change.  Do we need to setup a reserved-memory node like
> > imx6ul-ccimx6ulsom.dtsi did?
>
> I don't think so.
>
> Were you able to identify what was the exact commit that caused such regression?

I was able to narrow it down the 92d12f9544b7 ("memblock: refactor
internal allocation functions") that caused the regression with
Etnaviv.

I also noticed that if I create a reserved memory node as was done one
imx6ul-ccimx6ulsom.dtsi the 3D seems to work again, but without it, I
was getting errors regardless of the 'cma=256M' or not.
I don't have a problem using the reserved memory, but I guess I am not
sure what the amount should be.  I know for the video decoding 1080p,
I have historically used cma=128M, but with the 3D also needing some
memory allocation, is that enough or should I use 256M?

adam
