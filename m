Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E69FC6786F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 22:40:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BB4205F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 22:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CyyABaBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BB4205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42l5z939Z5zF25b
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 09:40:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CyyABaBW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::e43; helo=mail-vs1-xe43.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="CyyABaBW";
 dkim-atps=neutral
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com
 [IPv6:2607:f8b0:4864:20::e43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42l5hW6xNqzF27h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 09:28:11 +1100 (AEDT)
Received: by mail-vs1-xe43.google.com with SMTP id l6so8795312vsj.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AqTfYKV/PN6tpipO01Cdw/TMa+qHwi9432jSG/gesvY=;
 b=CyyABaBWYxdfD5jBmJfkaC05s4UGGrYnPnmnABccJ/fqRBCdi/DudqdFL8rvX8I4l8
 wzb7HFJJi4cK0lyQzBzFa3tytEpCk6tbo4rvIII4LwUc4l9Azi8hKCa5uld9pHcjOEBf
 afa1AyDniOpnh9vg6oqcO7mTFSCJ5Mg+GwSJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AqTfYKV/PN6tpipO01Cdw/TMa+qHwi9432jSG/gesvY=;
 b=P+mmHRCmCE360IhMW9Me6tVEn09DUl5/g83+AB6VU8/GqGYsjp7hhsg247xMndK4Hz
 aLrlV6N/PjP5oeB7mFQ/yuFS5a8fJPenC0lVHMxzzW8QmWKhW7GGVKUfXhE075Qlad8Y
 fSJlFBMNVs7dErn1mr4Qkbu+t+3RjKZrSSscIQZQ726ZZQl6YjFglDZ2zN/+TQd9/y4k
 cLZrv+suyZ2k78/2PR+xx19f/4AjZSkFVcx1J+yMRttD9JVxXsYGlVBuPbndMQ97PC5Y
 fL5bIYZ0UeXqlAuSDBvki6ndtu+Qmp2rGVAAaHzw+22K9plcNy8lwdMB7eggd2lfQEPO
 dxaw==
X-Gm-Message-State: AGRZ1gJW0/QIoFmbx+bs0ZTrBRiOh04HMn9Jy0Jwa840qTtdx6kBg21+
 agEg/iLOIakK/aTINGCcVa7sFMjtG88=
X-Google-Smtp-Source: AJdET5eeiT3KMv1bWaKvj6mzeCFxGMqqlIKoMrkRqSFX5m5BtJho5AUSVhcjCxgSpVNzqv+Mh+EuKg==
X-Received: by 2002:a67:e002:: with SMTP id c2mr295292vsl.34.1540938489426;
 Tue, 30 Oct 2018 15:28:09 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com.
 [209.85.221.171])
 by smtp.gmail.com with ESMTPSA id a77-v6sm2438497vka.20.2018.10.30.15.28.09
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Oct 2018 15:28:09 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id h20-v6so3442625vke.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 15:28:09 -0700 (PDT)
X-Received: by 2002:a1f:e3c7:: with SMTP id a190mr274756vkh.66.1540938026209; 
 Tue, 30 Oct 2018 15:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
In-Reply-To: <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Oct 2018 15:20:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=URwUFep2UA7Xs1TxK6cZst+W-pfY2_BfKMZnGECHPZqw@mail.gmail.com>
Message-ID: <CAD=FV=URwUFep2UA7Xs1TxK6cZst+W-pfY2_BfKMZnGECHPZqw@mail.gmail.com>
Subject: Re: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep
 splats w/ kgdb
To: Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 31 Oct 2018 09:38:28 +1100
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
Cc: Nishanth Menon <nm@ti.com>, linux-mips@linux-mips.org, dalias@libc.org,
 vigneshr@ti.com, linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 mhocko@suse.com, paulus@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 Ingo Molnar <mingo@kernel.org>, marex@denx.de,
 Stephen Rothwell <sfr@canb.auug.org.au>, ysato@users.sourceforge.jp,
 linux-hexagon@vger.kernel.org, x86@kernel.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Tony Lindgren <tony@atomide.com>, Ingo Molnar <mingo@redhat.com>,
 joel@jms.id.au, linux-serial@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, jhogan@kernel.org,
 rolf.evers.fischer@aptiv.com, asierra@xes-inc.com,
 linux-snps-arc@lists.infradead.org, Dan Carpenter <dan.carpenter@oracle.com>,
 ying.huang@intel.com, Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 riel@surriel.com, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 frederic@kernel.org, pombredanne@nexb.com, rppt@linux.vnet.ibm.com,
 bp@alien8.de, luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, andrew@aj.id.au,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 rkuo@codeaurora.org, paul.burton@mips.com, Vineet Gupta <vgupta@synopsys.com>,
 Jeremy Kerr <jk@ozlabs.org>, Jason Wessel <jason.wessel@windriver.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>, kstewart@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Tue, Oct 30, 2018 at 4:56 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 11:07:00AM -0700, Douglas Anderson wrote:
> > Looking back, this is pretty much two series squashed that could be
> > treated indepdently.  The first is a serial series and the second is a
> > kgdb series.
>
> Indeed.
>
> I couldn't work out the link between the first 5 patches and the last 2
> until I read this...
>
> Is anything in the 01->05 patch set even related to kgdb? From the stack
> traces it looks to me like the lock dep warning would trigger for any
> sysrq. I think separating into two threads for v2 would be sensible.

Yes, sorry about the mess.  Splitting this into two series makes the
most sense.  Then I can focus more on trying to get the CCs right and
people can just get the patches that matter to them.

OK, I've sent v2 of both series out now.  Please yell if you can't
find them for whatever reason.

-Doug

-Doug
