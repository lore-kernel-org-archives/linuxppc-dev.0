Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3562BC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 12:56:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D402084C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 12:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQbF/jJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D402084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P2Mz5Fg6zF0wf
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:56:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQbF/jJv";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQbF/jJv"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P23341BQzF35s
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 22:41:35 +1000 (AEST)
Received: by mail-ed1-x544.google.com with SMTP id c22-v6so445150edc.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 05:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EzWP5N7joT8dCGKElIenLmA4Qlb9ymLZblXC2podw5o=;
 b=hQbF/jJv+qrtQ5bnK3N2+j0wEfp/dxUczg32oaSWG5tfMiADZP2C6wi8K9WGriRHZe
 ck566bYyowlCnWrgyhBSC2x1U7uw6SOxOEvYEIsqA5+CKPFl8AyaAvq1xwafh9TM7/Ft
 IezDboC0Mhqn4cUeChH+CEguJwgY7lXVbbGk4nGF2yKxYXwD7+iewHP8TSPMHJVN/vMY
 L7q4mXfvu8SAFq9e0/VEUUdcUY/EinNhV6MxY3aRyQG7hzLVbjVXF+qiQJbf56nV+KN/
 T/LO+RlvIlUlk3b5PGXC9mdc1Hjz2Bm+5XtG23J0eW75XfZJGKF2rxgF1TQiYVDJE+KJ
 o93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EzWP5N7joT8dCGKElIenLmA4Qlb9ymLZblXC2podw5o=;
 b=YWuZaiX9uVSFjBJOQKySN5L15t/NKNSmZkBal5NW7TlfPK41pSsro+UqMlhz4D5CSM
 SuevKpHvL6Av9VXCkSs/qqMVYTY+WO///F1ejiOTYCS7o1NS8SNFaaGZ5+GjsdiGWCBC
 lmqRSvrVdHtnKDAISjO1XykIv2k3lkOinjo7ZAM6YfKopldMTt9Gac57BvANMWEeVsvI
 0SRczMs0Bu1L4pMMFuy0fqRkHqBZCotKnUxrfjX8i2WK6uruXYhoK4gJiEQjgxQYh7yk
 BDrxe+zD3GV5UMqGL8ffWwGQYU6ZliVZirZDcHltD+hDSCTAjfVZ35rXR2/TPqrTC8vH
 m9Qg==
X-Gm-Message-State: ABuFfogttjHiP5Szlf2xygzsTsDBNMcfwTBPMNinnVHpUDY2sMLYfNrh
 vR/V5WyaQ6rMxNFa4VlvN+X1nk5ktvCJuWTk1Gs=
X-Google-Smtp-Source: ACcGV63TK8GpRfODtezGdN+GlUflrvUpWa6NEDueM1Ky7UIqFWv+iBxb0y2sValOoxjl3fVnooGrN2U/169xGh+ERh4=
X-Received: by 2002:a50:fb8f:: with SMTP id
 e15-v6mr18027298edq.153.1538397692531; 
 Mon, 01 Oct 2018 05:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
 <1538288720-14910-2-git-send-email-bmeng.cn@gmail.com>
 <20181001092715.0a2696bd@roar.ozlabs.ibm.com>
 <CAEUhbmUih9irf-A8E4rouvpWKjeqg78Vzg+xm5TzUVB_vLPr=g@mail.gmail.com>
 <20181001122256.7cfdf186@roar.ozlabs.ibm.com>
In-Reply-To: <20181001122256.7cfdf186@roar.ozlabs.ibm.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 1 Oct 2018 20:41:19 +0800
Message-ID: <CAEUhbmUW4jUwLEM7_gDXHVqso7sfX5_YvAuWXfKh4ckKH6NKWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64: Increase stack redzone for 64-bit kernel
 to 512 bytes
To: npiggin@gmail.com
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Nick,

On Mon, Oct 1, 2018 at 10:23 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Mon, 1 Oct 2018 09:11:04 +0800
> Bin Meng <bmeng.cn@gmail.com> wrote:
>
> > Hi Nick,
> >
> > On Mon, Oct 1, 2018 at 7:27 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > On Sat, 29 Sep 2018 23:25:20 -0700
> > > Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > > commit 573ebfa6601f ("powerpc: Increase stack redzone for 64-bit
> > > > userspace to 512 bytes") only changes stack userspace redzone size.
> > > > We need increase the kernel one to 512 bytes too per ABIv2 spec.
> > >
> > > You're right we need 512 to be compatible with ABIv2, but as the
> > > comment says, gcc limits this to 288 bytes so that's what is used
> > > to save stack space. We can use a compiler version test to change
> > > this if llvm or a new version of gcc does something different.
> > >
> >
> > I believe what the comment says is for ABIv1. At the time when commit
> > 573ebfa6601f was submitted, kernel had not switched to ABIv2 build
> > yet.
>
> I see, yes you are right about that. However gcc still seems to be using
> 288 bytes.
>
> static inline bool
> offset_below_red_zone_p (HOST_WIDE_INT offset)
> {
>   return offset < (DEFAULT_ABI == ABI_V4
>                    ? 0
>                    : TARGET_32BIT ? -220 : -288);
> }
>
> llvm does as well AFAIKS
>
>   // DarwinABI has a 224-byte red zone. PPC32 SVR4ABI(Non-DarwinABI) has no
>   // red zone and PPC64 SVR4ABI has a 288-byte red zone.
>   unsigned  getRedZoneSize() const {
>     return isDarwinABI() ? 224 : (isPPC64() ? 288 : 0);
>   }
>
> So I suspect we can get away with using 288 for the kernel. Although
> the ELFv2 ABI allows 512, I suspect at this point compilers won't switch
> over without an explicit red zone size flag.
>

Thanks for the info of gcc/llvm codes. I suspect for the red zone size
gcc/llvm still uses ABIv1 defined value which is 288. If we get way
with kernel using 288, what's the point of having user as 512 (commit
573ebfa6601f)?

Regards,
Bin
