Return-Path: <SRS0=XoDG=ZE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB56C43331
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Nov 2019 07:16:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E489214E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Nov 2019 07:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WMGkKeOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E489214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47BzZC0lRgzF5Gr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Nov 2019 18:16:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::242;
 helo=mail-lj1-x242.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="WMGkKeOZ"; dkim-atps=neutral
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47BzWm5XzJzF3cQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2019 18:14:26 +1100 (AEDT)
Received: by mail-lj1-x242.google.com with SMTP id d5so7039033ljl.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2019 23:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=moBLNgsFkEFILNTGmzFVRskFLWF0bywiqBaR+demKl0=;
 b=WMGkKeOZSZv4nK3kYqjUDbJgm6OIX8/Pp5ul5RcMLv8HRndoSur1Gj5yp8uTwr6viK
 8pIe3W5+rvA5uDSH0I+6oPAWY7C94jtjF9Ot+31Ik/dH+uPG7MB8lgizP93vIMt3xMc5
 N+J/WomRl5rVfra1rtwsIIzgkQZcJ0HySeqwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=moBLNgsFkEFILNTGmzFVRskFLWF0bywiqBaR+demKl0=;
 b=Je2EFLhOwH465ATgSf9MvBQEplVeciChmQAxKsJW8MWkcmyi8R4qmyLHbAAwHSBVY0
 rVp8Nu+mz04YsRUPNQWz9SNL0JBx6ReRcUQ47mOCzHPIglwrTP/YnKO9SAMvSIV9g2xd
 QFWzusc2Pt0/GaxqhuRl3OrVxwSaUrky4L58Bk3LHr3s9B9ao//y0jIBFphyl1sVfG26
 eQqXuTRbSclwG215pSG9PebDgCN87oW1WbacOOPy3N4wp6sAx6a453KjLqfW4RVPyHat
 JEDWPqE4OxGvEAM+v35o4kPdEAsRhxV4BqJa6be38wK03265AMyJX3DqzVjCgB0ukZQt
 2JyA==
X-Gm-Message-State: APjAAAXJwQ5GoGVaOmoRptFKWCd60i1U1r7LNJ98HMCAPHYVcqsXvyCn
 G3Gd4DrmyqusABReaNCXxg/erA==
X-Google-Smtp-Source: APXvYqyGJCHfIoWOsBaNjhwiw9M0OJ8bZPYtuCumKkdWcGPrH+aj9AtA3dwPCKUzoK1SUKCQ1cmZMA==
X-Received: by 2002:a2e:8544:: with SMTP id u4mr2947819ljj.25.1573542862167;
 Mon, 11 Nov 2019 23:14:22 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id p193sm12765748lfa.18.2019.11.11.23.14.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Nov 2019 23:14:21 -0800 (PST)
Subject: Re: [PATCH v4 04/47] soc: fsl: qe: introduce qe_io{read,write}*
 wrappers
To: Timur Tabi <timur@kernel.org>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-5-linux@rasmusvillemoes.dk>
 <CAOZdJXU35+G5CMrS3247mgMjQH7__MxP8wpW6yjn1_MLD-sGqw@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e37d24c5-6d4f-c8bf-1c38-f3e8b8e85eeb@rasmusvillemoes.dk>
Date: Tue, 12 Nov 2019 08:14:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOZdJXU35+G5CMrS3247mgMjQH7__MxP8wpW6yjn1_MLD-sGqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: lkml <linux-kernel@vger.kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Qiang Zhao <qiang.zhao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/11/2019 06.17, Timur Tabi wrote:
> On Fri, Nov 8, 2019 at 7:03 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> The QUICC engine drivers use the powerpc-specific out_be32() etc. In
>> order to allow those drivers to build for other architectures, those
>> must be replaced by iowrite32be(). However, on powerpc, out_be32() is
>> a simple inline function while iowrite32be() is out-of-line. So in
>> order not to introduce a performance regression on powerpc when making
>> the drivers work on other architectures, introduce qe_io* helpers.
> 
> Isn't it also true that iowrite32be() assumes a little-endian platform
> and always does a byte swap?
> 

No. You're probably thinking of the implementation in lib/iomap.c where
one has

#define mmio_read32be(addr) swab32(readl(addr))
unsigned int ioread32be(void __iomem *addr)
{
        IO_COND(addr, return pio_read32be(port), return
mmio_read32be(addr));
        return 0xffffffff;
}


#define mmio_write32be(val,port) writel(swab32(val),port)
void iowrite32be(u32 val, void __iomem *addr)
{
        IO_COND(addr, pio_write32be(val,port), mmio_write32be(val, addr));
}

but that's because readl and writel by definition work on little-endian
registers. I.e., on a BE platform, the readl and writel implementation
must themselves contain a swab, so the above would end up doing two
swabs on a BE platform.

(On PPC, there's a separate definition of mmio_read32be, namely
writel_be, which in turn does a out_be32, so on PPC that doesn't
actually end up doing two swabs).

So ioread32be etc. have well-defined semantics: access a big-endian
register and return the result in native endianness.
