Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDC3C004D2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 02:25:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B192083C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 02:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxOwSRV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B192083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42NmMr0G93zF26H
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 12:25:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CxOwSRV7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="CxOwSRV7"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NmKP61LVzF35w
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 12:23:05 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id n31-v6so8313911pgm.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 19:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Szguqu1+pnw0T8qAonEvyY+8S8SROfSFf95BgCbriTk=;
 b=CxOwSRV7YbVGl2BT19HfUs9STA0cENfJFpCHYf7UFctmWDZApEh4zc0qOJDnzNzszK
 9oYHlAiJENMy1doNUEZeVKDdgBusCCi2KuRMlxmLZa+ht8vX0eJvDObcw+U775JntAQp
 I2W1ABYDajlxOGh+vs2KhzX6Q6RqR8SinM9bkogaHxP5f6smWdSJmAXvGi40jSFQep6G
 NyVH3+DjD0EAxajVungo1rM0/xtQo7tL0kg3ogUifwhXX8SR/GzBbc8IULGJYWHtep61
 SXUn8G1s/ybwqeRYQCEpwArU/6QgXdpj8e2iwuMVxBPCmlBUI6nGmS+YSo5Kx6FjDe/o
 4BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Szguqu1+pnw0T8qAonEvyY+8S8SROfSFf95BgCbriTk=;
 b=ER7Rgq3C5qSB6fmcI+ycv5qKKo4wlq8rfDu0NnWHWEkwAetU3CQFy2NWUzNZTfp6tY
 LeJQCVzelZftp63KrI4uKzoiNsu/Td3psB95ga8DxaILvsODaCbNzqGpHDBuF1OSY4Kd
 85Gvj5r15wVyY9IgVZPCUMQhauax4uLDNAMG5v2I2pRyK5Ik1HPnmWv9g822LXwrH98T
 jXZx68VuZmuPrpVyyM2WZz7XL/L+BBgiP3QNGepgPkFyGHBS533OOhiyzwYnAL3pxjF4
 XfWNt2yoOqG3jDXpu7Ylr3HYaWua26jOSNlAsjS+YaLLlAIMfNvcdV9iXgStm+F7pW6i
 D23Q==
X-Gm-Message-State: ABuFfojv6cuA3lytuQzlI3Mxz9pb5DSXs/ECnpV6/B+mrU3yTcPsYRwJ
 k2qc/WoqlX6IQF139LsOGok=
X-Google-Smtp-Source: ACcGV62m/Q/Obce1UW8qpngBbnlM3dYeO/Xul0Jkhp7AvWsa/89xfdVw6n9RVI/jicS/CJDhNHjteg==
X-Received: by 2002:a17:902:e185:: with SMTP id
 cd5-v6mr9306948plb.224.1538360583537; 
 Sun, 30 Sep 2018 19:23:03 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id g12-v6sm15710336pfo.50.2018.09.30.19.22.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 30 Sep 2018 19:23:02 -0700 (PDT)
Date: Mon, 1 Oct 2018 12:22:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64: Increase stack redzone for 64-bit
 kernel to 512 bytes
Message-ID: <20181001122256.7cfdf186@roar.ozlabs.ibm.com>
In-Reply-To: <CAEUhbmUih9irf-A8E4rouvpWKjeqg78Vzg+xm5TzUVB_vLPr=g@mail.gmail.com>
References: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
 <1538288720-14910-2-git-send-email-bmeng.cn@gmail.com>
 <20181001092715.0a2696bd@roar.ozlabs.ibm.com>
 <CAEUhbmUih9irf-A8E4rouvpWKjeqg78Vzg+xm5TzUVB_vLPr=g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 1 Oct 2018 09:11:04 +0800
Bin Meng <bmeng.cn@gmail.com> wrote:

> Hi Nick,
> 
> On Mon, Oct 1, 2018 at 7:27 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Sat, 29 Sep 2018 23:25:20 -0700
> > Bin Meng <bmeng.cn@gmail.com> wrote:
> >  
> > > commit 573ebfa6601f ("powerpc: Increase stack redzone for 64-bit
> > > userspace to 512 bytes") only changes stack userspace redzone size.
> > > We need increase the kernel one to 512 bytes too per ABIv2 spec.  
> >
> > You're right we need 512 to be compatible with ABIv2, but as the
> > comment says, gcc limits this to 288 bytes so that's what is used
> > to save stack space. We can use a compiler version test to change
> > this if llvm or a new version of gcc does something different.
> >  
> 
> I believe what the comment says is for ABIv1. At the time when commit
> 573ebfa6601f was submitted, kernel had not switched to ABIv2 build
> yet.

I see, yes you are right about that. However gcc still seems to be using
288 bytes.

static inline bool
offset_below_red_zone_p (HOST_WIDE_INT offset)
{
  return offset < (DEFAULT_ABI == ABI_V4
                   ? 0
                   : TARGET_32BIT ? -220 : -288);
}

llvm does as well AFAIKS

  // DarwinABI has a 224-byte red zone. PPC32 SVR4ABI(Non-DarwinABI) has no
  // red zone and PPC64 SVR4ABI has a 288-byte red zone.
  unsigned  getRedZoneSize() const {
    return isDarwinABI() ? 224 : (isPPC64() ? 288 : 0);
  }

So I suspect we can get away with using 288 for the kernel. Although
the ELFv2 ABI allows 512, I suspect at this point compilers won't switch
over without an explicit red zone size flag.

Thanks,
Nick
