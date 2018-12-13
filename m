Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2653C67839
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 07:50:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0584F20870
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 07:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpqAYoYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0584F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Fm7558hQzDqWs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 18:50:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TpqAYoYw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TpqAYoYw"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Fm4K2t0kzDqRR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 18:47:45 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id z23so671259plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 23:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U1kdblOkJeUGCFzl5KLv1H49TEpdl9qC6nK7L+3L29c=;
 b=TpqAYoYwMe1TJDoCr58p8u4c15c86tjuJio3/1Um7s9VeQMthzh84tY1nz/a74ZQxf
 MyvzBmj+EE/ZiEYbonVNj+PmNsVClYy1b14oQJAv2onUlwDS55YdHkWpnj4dpPAnvacM
 o/AoSNObkNYx66T/5FmPq3PhYzTv4hcle+nY6WzqoRFufR5Eah8MI/wyE3vfwgwidnYf
 OKSIbP0njF4oFHHqh5W8kGbIRdfQMhgyR3i6XX0CnAjkRvqvu3mTZikVUMzlNpAYrrMg
 aJVyi0JQfUAh5R5hZ3KxSiXN+eBjSOAQYWJOnRjfQ0dH003JGBrhvSkxJau7Z3UuXV6h
 8IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U1kdblOkJeUGCFzl5KLv1H49TEpdl9qC6nK7L+3L29c=;
 b=TlwgjN4fThPV5SIkdffsjQ08Cqe7JodVbTB2oFrXY9aO9eweAf88jivjzg3DJMefzg
 cEh9Bs0a+8BLSdQNTGFvjHH4r86X0HEurKmJRp7fuxbLQmnDGX5yOEoI8orK3k3CVWO7
 czBmh9anmrVZ2n27WXQIKlrUngXzHN1mj5K6nZpU1vQ6oHYJaT9c6qVytbgYove1RJJB
 nAzKUKkn42GT+Q0JsUyOfKUgqBkCLNChhe3/mCQNsLU6eXiLxAXO6SZZbqzotISKuiyI
 /VJ5VCcdRw30rK+7zn16ZDXD1/PQhSlYacKsavK0M4RrRqoTk+19YUVo2mkqfVYVzyFV
 M58A==
X-Gm-Message-State: AA+aEWanXTW7KkHxGfD26UH7GiOP2d0xHRcdRqD2dxlbMA002q0fPHuj
 ZmKMB636IHUgUDgKL+jfrtMka+osUy9+zmd9rQU=
X-Google-Smtp-Source: AFSGD/XaHQurPfiJZl0nifD8SVpllsWxHwP1gQEAMsEgMubG9uFN1wv4BtJUNE8J6a9nm+2+ylSuJ8ODlQsaQfiABOY=
X-Received: by 2002:a17:902:d806:: with SMTP id
 a6mr21675813plz.172.1544687262841; 
 Wed, 12 Dec 2018 23:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
 <20181206132113.2691-8-Tianyu.Lan@microsoft.com>
 <20181212050353.GF22265@blackberry>
In-Reply-To: <20181212050353.GF22265@blackberry>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Thu, 13 Dec 2018 15:47:31 +0800
Message-ID: <CAOLK0pyKsS2hLagZ6pumMdfRokPig2P+KJambVOq7p+NU-OqgA@mail.gmail.com>
Subject: Re: [Resend PATCH V5 7/10] KVM: Make kvm_set_spte_hva() return int
To: paulus@ozlabs.org
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
Cc: linux-mips@linux-mips.org, kvm <kvm@vger.kernel.org>,
 Radim Krcmar <rkrcmar@redhat.com>, catalin.marinas@arm.com,
 will.deacon@arm.com, christoffer.dall@arm.com,
 "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, the arch/x86 maintainers <x86@kernel.org>,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
 Ingo Molnar <mingo@redhat.com>, jhogan@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
 ralf@linux-mips.org, paul.burton@mips.com, Paolo Bonzini <pbonzini@redhat.com>,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Paul:
             Thanks for your review.
On Wed, Dec 12, 2018 at 1:03 PM Paul Mackerras <paulus@ozlabs.org> wrote:
>
> On Thu, Dec 06, 2018 at 09:21:10PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > The patch is to make kvm_set_spte_hva() return int and caller can
> > check return value to determine flush tlb or not.
>
> It would be helpful if the patch description told the reader which
> return value(s) mean that the caller should flush the tlb.  I would
> guess that non-zero means to do the flush, but you should make that
> explicit.

OK. Thanks for suggestion and will update in the next version.

>
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
>
> For the powerpc bits:
>
> Acked-by: Paul Mackerras <paulus@ozlabs.org>



-- 
Best regards
Tianyu Lan
