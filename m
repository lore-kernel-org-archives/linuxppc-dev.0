Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F8AC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 00:06:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496F721471
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 00:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNSSFzsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496F721471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PKF14ZsQzF3Cf
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 10:06:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PNSSFzsP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PNSSFzsP"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PKBR6rs2zF3BG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 10:03:59 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id t70-v6so90552pgd.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 17:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xeHgDQBQ2ohGZrQUEhL11gafNtiWE3w+q59WLAiHfjQ=;
 b=PNSSFzsPzxKcnYCQgHSB77W4vdCto+ifLyjDwxL8YOGpKlZmCavRRxC7fJpOuQIjlQ
 lS3LqHd2j+fyRWslPDt3mDqAHtleCakkcurgs8eePIc91I6EJEQV2GOljFI+VLdMduCt
 K1eDiFqV9T6EVq2s//ni/lxEMI3OqQ8yJ5sgzm1d2F0KMgts6jrdG9kRXxna77gswtMf
 APAnPGyZi1heq14bRTCRsxAGQhHmCG6u7PQOYw6RzMyUTouYPbGkRLAfnvE7CByCxADm
 5AZwEMIJYU53kvcHFHY4FxGZCA8dsoObz0aNsvqUeXwoUyTzHPS++adUyZzjzMCuNBEN
 uN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xeHgDQBQ2ohGZrQUEhL11gafNtiWE3w+q59WLAiHfjQ=;
 b=rfyEFf209/3IGQLrwfY+P0uXMpZNNQ/eM/bwGtKgLm2hOlxCgR7BfR4e4AnYEYdTz4
 454td7Sw3MoNidmb8yJaYv1f+DAVRAIJ6ObxQs4T3x7Xb4UC0DVNI8XnGCOyQ9j0+ClF
 Y+f90qyKPA3KjNfGZV8HA4ehNvAOhH9NVeyRkA5eaqlQC0LClv8gSOyop5FPoAgExLxi
 hERCJLdDV4UlKFXbCKvJbMvOk6TNUdcEIwQmQWDLIKgPZ5sTEBYgDfqOfqZzfwNtwExq
 HPbQ76XuSy4cCiX5BUl1suk0sGN2iUQIZQ7/xI4aX8/fxL6eo77zU5vIu35cZPIVTeLZ
 NyMg==
X-Gm-Message-State: ABuFfogllFd2h3kerioZ9cbbc2HAKDBgET8MPYITudYAYTysQa2U9x5s
 M0PGmPrdBigHd/mD4JFwsoY=
X-Google-Smtp-Source: ACcGV60tc9DdvlMCGfK45WHeK9R3Xb7NWtDlx5oQfPc/iC52uDipRXLevPjxIrc7mWNagBlpYrYPIw==
X-Received: by 2002:a62:d110:: with SMTP id
 z16-v6mr11923269pfg.229.1538438638087; 
 Mon, 01 Oct 2018 17:03:58 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id 8-v6sm18249844pgu.10.2018.10.01.17.03.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 01 Oct 2018 17:03:57 -0700 (PDT)
Date: Tue, 2 Oct 2018 10:03:51 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64: Increase stack redzone for 64-bit
 kernel to 512 bytes
Message-ID: <20181002100351.3be12db7@roar.ozlabs.ibm.com>
In-Reply-To: <CAEUhbmUW4jUwLEM7_gDXHVqso7sfX5_YvAuWXfKh4ckKH6NKWQ@mail.gmail.com>
References: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
 <1538288720-14910-2-git-send-email-bmeng.cn@gmail.com>
 <20181001092715.0a2696bd@roar.ozlabs.ibm.com>
 <CAEUhbmUih9irf-A8E4rouvpWKjeqg78Vzg+xm5TzUVB_vLPr=g@mail.gmail.com>
 <20181001122256.7cfdf186@roar.ozlabs.ibm.com>
 <CAEUhbmUW4jUwLEM7_gDXHVqso7sfX5_YvAuWXfKh4ckKH6NKWQ@mail.gmail.com>
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

On Mon, 1 Oct 2018 20:41:19 +0800
Bin Meng <bmeng.cn@gmail.com> wrote:

> Hi Nick,
> 
> On Mon, Oct 1, 2018 at 10:23 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Mon, 1 Oct 2018 09:11:04 +0800
> > Bin Meng <bmeng.cn@gmail.com> wrote:
> >  
> > > Hi Nick,
> > >
> > > On Mon, Oct 1, 2018 at 7:27 AM Nicholas Piggin <npiggin@gmail.com> wrote:  
> > > >
> > > > On Sat, 29 Sep 2018 23:25:20 -0700
> > > > Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >  
> > > > > commit 573ebfa6601f ("powerpc: Increase stack redzone for 64-bit
> > > > > userspace to 512 bytes") only changes stack userspace redzone size.
> > > > > We need increase the kernel one to 512 bytes too per ABIv2 spec.  
> > > >
> > > > You're right we need 512 to be compatible with ABIv2, but as the
> > > > comment says, gcc limits this to 288 bytes so that's what is used
> > > > to save stack space. We can use a compiler version test to change
> > > > this if llvm or a new version of gcc does something different.
> > > >  
> > >
> > > I believe what the comment says is for ABIv1. At the time when commit
> > > 573ebfa6601f was submitted, kernel had not switched to ABIv2 build
> > > yet.  
> >
> > I see, yes you are right about that. However gcc still seems to be using
> > 288 bytes.
> >
> > static inline bool
> > offset_below_red_zone_p (HOST_WIDE_INT offset)
> > {
> >   return offset < (DEFAULT_ABI == ABI_V4
> >                    ? 0
> >                    : TARGET_32BIT ? -220 : -288);
> > }
> >
> > llvm does as well AFAIKS
> >
> >   // DarwinABI has a 224-byte red zone. PPC32 SVR4ABI(Non-DarwinABI) has no
> >   // red zone and PPC64 SVR4ABI has a 288-byte red zone.
> >   unsigned  getRedZoneSize() const {
> >     return isDarwinABI() ? 224 : (isPPC64() ? 288 : 0);
> >   }
> >
> > So I suspect we can get away with using 288 for the kernel. Although
> > the ELFv2 ABI allows 512, I suspect at this point compilers won't switch
> > over without an explicit red zone size flag.
> >  
> 
> Thanks for the info of gcc/llvm codes. I suspect for the red zone size
> gcc/llvm still uses ABIv1 defined value which is 288. If we get way
> with kernel using 288, what's the point of having user as 512 (commit
> 573ebfa6601f)?

See Segher's reply -- they are two different things here. 288 bytes is
the red zone that compilers may use. But there is another region out to
512 bytes which can be used by other system code (not compilers). So
the kernel always has to assume 512 for user.

The kernel code itself knows that it does not use any red zone beyond
288 bytes, so it does not have to preserve any more for its own stack.

Thanks,
Nick
