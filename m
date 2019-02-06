Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8DFC282CB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 02:57:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB15E218A1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 02:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRXu8Biv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB15E218A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vR246953zDqPc
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 13:57:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::a41; helo=mail-vk1-xa41.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sRXu8Biv"; 
 dkim-atps=neutral
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com
 [IPv6:2607:f8b0:4864:20::a41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vR0N1h0NzDqLv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 13:56:03 +1100 (AEDT)
Received: by mail-vk1-xa41.google.com with SMTP id t127so1303652vke.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Feb 2019 18:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jyYa+dnct96MCe0p8mnyg6Kxz97EvONG5+L2aZOQX80=;
 b=sRXu8BivgCfLOj+nH50X6ZXGL8LeOmWOzM9GI2gJFv57gpomJITjcl8tcw26fhsY5u
 g7iCMDjiVdFvhgcjYSxORlIOtoDdqCRngCVK2elHE9x8xg2HIiuNZv3DoiCMqBmday5q
 601upOIHJhg7C87s8Ri0zTZCULHaIqNZPI/KD2y91M70Sf+R5R9/foHd9pYFstAtOVtZ
 nVjR7Ho9AX66WuBDFGgj+Y4MYCOHOF/sC6EzC0eJ2eqEGjYlSw1XZYg0EivRe5W+5oLB
 n4/FixRv+1MozVrC2ZeTwZ5trTIuIR4w5B114rd9ktqLNH46ZZGAXqlxUmCYQTln2fLO
 Ecfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jyYa+dnct96MCe0p8mnyg6Kxz97EvONG5+L2aZOQX80=;
 b=tJXa+1ZCoFfbv9rih2RtX+7Ge4QIceuWTkqSm3fVeovgD9lvU5uYVtR7FJPMLlqU+B
 z2jr+EOVh7GwvM5Ww3qOJ/+Ky6dHE0qXP7tJxbMZKdS0+VvTv5zjU47ln1MHTBMEOpVs
 uFfLPNAPYs0CVLjX96q1lyxUZ18j+f6YYCqVVnp0yA3D7LC4F6DCjvZiGbfGdw8EZGUN
 D99SD27vxIoY+Ebp+Y6j4gZmG7K59GD4Gl/C66ghm4J1dmrOVyCk7ly5Ow136X0E3ueo
 aHr81ViB6WeosbzICoQjX9XpenbtuVX49nyAiPXgd2RMwwAvIoWlQf9qGSXH2UNZeXU2
 dnhw==
X-Gm-Message-State: AHQUAuaNkbggJuQQ2R1k/pCozc5apsnQL+UUJjqyqx52gHMVnWS0Umix
 V+6fwdmxnt2HLRkKmaZKhZHQqjMrvOOUQTJOXMM=
X-Google-Smtp-Source: AHgI3IZOOpT6eO8jFMiJDNa9569DVkpgsIvE1qPHHPeNZ3H2QBUt+hsjUZLigDfkJu6flyrKXmdgAfcsxp1Sb2dCP7o=
X-Received: by 2002:a1f:8784:: with SMTP id j126mr2325579vkd.84.1549421761186; 
 Tue, 05 Feb 2019 18:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20190131103022.10218-1-peterx@redhat.com>
 <20190131171106.GD19324@redhat.com> <3013350.qntrAZtlsQ@townsend>
In-Reply-To: <3013350.qntrAZtlsQ@townsend>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 6 Feb 2019 13:55:49 +1100
Message-ID: <CAKTCnzmC74fQ_NCGvvXY3sv--hp-C094jVy8JfCUYqwp_wcBAg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv/npu: Remove redundant change_pte() hook
To: Alistair Popple <alistair@popple.id.au>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Wang <jasowang@redhat.com>,
 Mark Hairgrove <mhairgrove@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Peter Xu <peterx@redhat.com>, Jerome Glisse <jglisse@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 "open list:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 5, 2019 at 2:52 PM Alistair Popple <alistair@popple.id.au> wrote:
>
> On Thursday, 31 January 2019 12:11:06 PM AEDT Andrea Arcangeli wrote:
> > On Thu, Jan 31, 2019 at 06:30:22PM +0800, Peter Xu wrote:
> > > The change_pte() notifier was designed to use as a quick path to
> > > update secondary MMU PTEs on write permission changes or PFN changes.
> > > For KVM, it could reduce the vm-exits when vcpu faults on the pages
> > > that was touched up by KSM.  It's not used to do cache invalidations,
> > > for example, if we see the notifier will be called before the real PTE
> > > update after all (please see set_pte_at_notify that set_pte_at was
> > > called later).
>
> Thanks for the fixup. I didn't realise that invalidate_range() always gets
> called but I now see that is the case so this change looks good to me as well.
>
> Reviewed-by: Alistair Popple <alistair@popple.id.au>
>
I checked the three callers of set_pte_at_notify and the assumption
seems correct

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
