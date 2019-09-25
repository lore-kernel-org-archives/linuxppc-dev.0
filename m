Return-Path: <SRS0=fxYp=XU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C204BC432C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 12:23:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF0E20640
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 12:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUVK92GE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF0E20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46dcdw0NcSzDqmf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 22:23:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=aford173@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iUVK92GE"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46dcWK0Vk9zDqkT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2019 22:17:16 +1000 (AEST)
Received: by mail-io1-xd41.google.com with SMTP id r26so13149920ioh.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2019 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y4RvotBfrNK4XtLNNLx8Pazo7kMyOm8WMNbLFH6FEEU=;
 b=iUVK92GEmBGCZJyRo/Zd1KGKYtVYyBQQZ/qadZsMHtgdBqOIEJTGes/jFXUJbsxPYf
 arbgI67CVRtjqzv9KbtoPjbnRd+NNaoZROuAK65Afp+qrjeu4taq1FiOikitUOgqwDx8
 fioo5IrGYuhVH0YvNqEwrFk0OelIti4ramwaMIdGU4NyJep+562IHM+KmC8sSycW/lGl
 6hw22I7QH199NqTHihVI1jILF/7aomQpGPobiyR3J6OdLD8RebyLMuWN2U0+NXMFCX56
 jcF4Oyc8LIMBAV7TynSwH8rI44zROllFOPxhK0YNDBYQo27LHn7/o72CQFX3jXNFDaC5
 kGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y4RvotBfrNK4XtLNNLx8Pazo7kMyOm8WMNbLFH6FEEU=;
 b=mTpnVRVk2IJO3dYEdcq6YxbnssLIKSwrpO3q7nn5aKcdDC/QgL0ghlZ+9OA84iiNah
 /1m7HG1w0xO4ul0KUq0RH2YeKLTiEUCKVY9gZIZVPg5TmjQ2Pz1QhPakuR4zmjxDoFAK
 V0/TgbxIuNcjkNZfcEM7MeyvWCMGUyNN8hHIE9HEv7imWMVdX9Nukpn450M3+XcmRDHS
 sZc6nhhYancQLdv6Lm6S24uhP1Y7vhtV86v8YI8Fmd4YU3JQSS8GgLmJ7BuJXDKloVMA
 0HjKkRR64DHP+8eBUoccJ8jCOabciJNeMy47eh8WZxsUoCbKyEWVIiurcaQAAnD9wJED
 qF2A==
X-Gm-Message-State: APjAAAWRadzkyfJZxwBZWoqlfV2NUjkdCekEhNVl6/WEmT8t2no0wpUz
 /i1nnQOJT/Y8uCtzvQHO4YUyxXtEqGKyc4ImmT8=
X-Google-Smtp-Source: APXvYqxS45l3zihhw3tYCzgwBmyCEU+INEqloepYzMma/aNO63dr/UcHcVyi8UcvHnJD8dRs3xdWT6wqG8jXwm/qXD0=
X-Received: by 2002:a02:65cd:: with SMTP id u196mr4900191jab.3.1569413832794; 
 Wed, 25 Sep 2019 05:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <CAHCN7x+Jv7yGPoB0Gm=TJ30ObLJduw2XomHkd++KqFEURYQcGg@mail.gmail.com>
 <CAOMZO5A_U4aYC4XZXK1r9JaLg-eRdXy8m6z4GatQp62rK4HZ6A@mail.gmail.com>
In-Reply-To: <CAOMZO5A_U4aYC4XZXK1r9JaLg-eRdXy8m6z4GatQp62rK4HZ6A@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 25 Sep 2019 07:17:02 -0500
Message-ID: <CAHCN7xJdzEppn8-74SvzACsA25bUHGdV7v=CfS08xzSi59Z2uw@mail.gmail.com>
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

On Wed, Sep 25, 2019 at 7:12 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Adam,
>
> On Wed, Sep 25, 2019 at 6:38 AM Adam Ford <aford173@gmail.com> wrote:
>
> > I know it's rather late, but this patch broke the Etnaviv 3D graphics
> > in my i.MX6Q.
> >
> > When I try to use the 3D, it returns some errors and the dmesg log
> > shows some memory allocation errors too:
> > [    3.682347] etnaviv etnaviv: bound 130000.gpu (ops gpu_ops)
> > [    3.688669] etnaviv etnaviv: bound 134000.gpu (ops gpu_ops)
> > [    3.695099] etnaviv etnaviv: bound 2204000.gpu (ops gpu_ops)
> > [    3.700800] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
> > [    3.723013] etnaviv-gpu 130000.gpu: command buffer outside valid
> > memory window
> > [    3.731308] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
> > [    3.752437] etnaviv-gpu 134000.gpu: command buffer outside valid
> > memory window
>
> This looks similar to what was reported at:
> https://bugs.freedesktop.org/show_bug.cgi?id=111789
>
> Does it help if you use the same suggestion and pass cma=256M in your
> kernel command line?

I tried cma=256M and noticed the cma dump at the beginning didn't
change.  Do we need to setup a reserved-memory node like
imx6ul-ccimx6ulsom.dtsi did?

adam
