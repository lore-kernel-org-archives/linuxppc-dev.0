Return-Path: <SRS0=fxYp=XU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC8C432C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 12:14:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996E8217F4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 12:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0naPQpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996E8217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46dcSX2gt0zDqkX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 22:14:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::243; helo=mail-lj1-x243.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="e0naPQpn"; 
 dkim-atps=neutral
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46dcPW26HtzDqdX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2019 22:12:12 +1000 (AEST)
Received: by mail-lj1-x243.google.com with SMTP id q64so5364739ljb.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2019 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hUmVUwvSY/aeCErtOWtkiU7kxhgjU/DkZwXUVKfeXYI=;
 b=e0naPQpnh4JE/4pzdBeJlRoIgqUi6C/PmOHgsKHfsCSmwrfN9C/j9k46bbLakdQgtK
 NzyyALh2M4uqHkB4On8gEHIrvbwKUNNiu3zZ2lOeoXUiFudrKwoaCTbU97PgilT1l5iG
 BNvpNxJ3L2WwmKsrub8I/gHS221tUzLfviv94tbG+vMGMDoFLa5u8CB7VOGTEKPYce1l
 Cf3u6sYzxHRkaIjp/6i4jUz79T0kliSiD1RIQYnsEdRcWu0lLuAcfKmvxGsweCWvJ0nX
 0eOjvMQ1r+HHshdYbA3cDvsghoueNpOxeniug7pMPTULgl1lMmy+tRc55+GZxrbOt31A
 IWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hUmVUwvSY/aeCErtOWtkiU7kxhgjU/DkZwXUVKfeXYI=;
 b=NPF67qzsouusKkvnhJt95QZ6mLsebLDROy7Ics9ud69Kj5fpyWVz825ahYG7C2DjIr
 aahgicq+Dbi/icoAv2L9qX1LUvl+/PcItfBiQav/Bn5RwvSJlHzZ7wouMhj0btrOrR56
 JtD0MYNUKiS67RkByc9maeCqYgn5Aea75+y/YKIBHFFhD0Evj8D+jZZm+P3vFrRDpkUK
 gIxlDAHES4uI9x6bCZQAU+5LcCAd54dOWwcl7MWNTtZcJPwQoFF+s/UNALSTXI5gDzNv
 hdCjwEbxupMv5dj3f+HNmaL9ayvr+NV33hVyjaT4ZvZ5DAIHOXiehimxs7OdZUjd2li5
 gm0Q==
X-Gm-Message-State: APjAAAUL1AfAPBnI3Gmqb5SqWnEeoHKL6c99/26VSpJqDEtQ0NKsOBJi
 LafN/th8NlBanRJOJhjXbaE7+GgUugNugEc5ImQ=
X-Google-Smtp-Source: APXvYqyQ9DDK1T7Dnq+bpI71Ik4P0Io7FbZdAq9brFueaElkRY2A7GJR4saQwrvMTiDWN1ujjgcBluE//8NebHfr57o=
X-Received: by 2002:a2e:a316:: with SMTP id l22mr6207823lje.211.1569413529490; 
 Wed, 25 Sep 2019 05:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
In-Reply-To: <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Sep 2019 09:12:18 -0300
Message-ID: <CAOMZO5A_U4aYC4XZXK1r9JaLg-eRdXy8m6z4GatQp62rK4HZ6A@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Refine memblock API
To: Adam Ford <aford173@gmail.com>
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

Hi Adam,

On Wed, Sep 25, 2019 at 6:38 AM Adam Ford <aford173@gmail.com> wrote:

> I know it's rather late, but this patch broke the Etnaviv 3D graphics
> in my i.MX6Q.
>
> When I try to use the 3D, it returns some errors and the dmesg log
> shows some memory allocation errors too:
> [    3.682347] etnaviv etnaviv: bound 130000.gpu (ops gpu_ops)
> [    3.688669] etnaviv etnaviv: bound 134000.gpu (ops gpu_ops)
> [    3.695099] etnaviv etnaviv: bound 2204000.gpu (ops gpu_ops)
> [    3.700800] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
> [    3.723013] etnaviv-gpu 130000.gpu: command buffer outside valid
> memory window
> [    3.731308] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
> [    3.752437] etnaviv-gpu 134000.gpu: command buffer outside valid
> memory window

This looks similar to what was reported at:
https://bugs.freedesktop.org/show_bug.cgi?id=111789

Does it help if you use the same suggestion and pass cma=256M in your
kernel command line?
