Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD6CC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 12:39:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A302082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 12:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvGEXVy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A302082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4343JR2Tn6zDqmX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 23:39:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qvGEXVy+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qvGEXVy+"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4343C31x3hzDqlF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 23:34:55 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id c73so8279385pfe.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 04:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y45q130fS/TxDRFjsRk4GQsRQWsmPIxqlM2WlMei9JA=;
 b=qvGEXVy+TmVHiDzQ6vk2+gkFO7+PC7KYLy04bPHCIgsk04EIEq+hVczwQdtICeROzA
 9cd2Sxpwnain8o9Jksg+Mqh8QLPfeqCGNRnyV3VPMP+2Q1WrnDU++csAzusonO6v88LI
 gJgS1gM4lHeRAzin0wfJNeKV2ypFRhjzNYf9ootqK0FR3Tdm+xPan2B8CB+aJ+VVyDfL
 oTs9rSEYqAC0WO6kcPbjoULQJ3nTWi/ataYrDTthBLL3xcs01voiN7akKHzZzVSVxid3
 amWd5lw3h+xL/B++R8lr45zczRycKQk+FX4AKpfs0BU9xxz+BW6Bq5R+EkBWvoy7kL69
 xZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y45q130fS/TxDRFjsRk4GQsRQWsmPIxqlM2WlMei9JA=;
 b=hQd9/6lRjFMLtfBa840XTComqnfIN+wQYx4aKRHhyH0dazP3jSWplgwa0tuL3tUZ/S
 FrIr80xv/sLXlsGXSDqUpm40DWUu/N6aOnJf4lKsixnnLq1WpMrsjaFcsqtj8zpQPcMO
 XpjYnEOXDxAckFTLhQscqB8PM3khOLQ2nb2AcwPzJG2z+nshy+jiX1uwlCxXBMBFKvGO
 6GMSzIGid0OvlH8vRr4VHxeZcXb1KZMdsQW5/PLPU8Gwcrb/mkachQlXr/T5sKVgEZfo
 yYNgnuiaku5qae0CWx80E7n9EHV5yOqUTaE40XmSy6yv1h/WGBuKxB+x6Srez7oIeCKs
 /wbw==
X-Gm-Message-State: AA+aEWaQWXrCB4UUjv9d+MGlK2hkPVJc5CfhbzP3pBssMz0pNJ+/KQUz
 wItY7RCdBCYBYnWPlAImsXBzLQiPHOdYo6xcGAQ=
X-Google-Smtp-Source: AFSGD/WUOf5DakCu9tDqJpZdbiE2MnMSBasGV0QI7FaRvcuOE1sg3HAFCXNpaQ6FKxZxF8G6aCI9KoAqgXspnh9ke7c=
X-Received: by 2002:a63:6506:: with SMTP id z6mr28940347pgb.334.1543322093121; 
 Tue, 27 Nov 2018 04:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20181108144259.10817-1-Tianyu.Lan@microsoft.com>
 <CAOLK0pyvtfhoGM+D7h=gXwNpNjXGZiDJKpuVi9HOwb++4asCXw@mail.gmail.com>
 <20181127121129.GR3088@unbuntlaptop>
In-Reply-To: <20181127121129.GR3088@unbuntlaptop>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Tue, 27 Nov 2018 20:34:41 +0800
Message-ID: <CAOLK0pzL6wKbGEH_EPQ9cO8NByx4URO09=XAuYo-vEgaYjtVBQ@mail.gmail.com>
Subject: Re: [PATCH V5 00/10] x86/KVM/Hyper-v: Add HV ept tlb range flush
 hypercall support in KVM
To: dan.carpenter@oracle.com
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
 Radim Krcmar <rkrcmar@redhat.com>, will.deacon@arm.com,
 "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, kvmarm@lists.cs.columbia.edu,
 sthemmin@microsoft.com, the arch/x86 maintainers <x86@kernel.org>,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
 Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com, jhogan@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
 devel@linuxdriverproject.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, christoffer.dall@arm.com,
 ralf@linux-mips.org, paul.burton@mips.com, Paolo Bonzini <pbonzini@redhat.com>,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 27, 2018 at 8:12 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Nov 27, 2018 at 07:59:22PM +0800, Tianyu Lan wrote:
> > Gentile Ping...
> >
> > On Thu, Nov 8, 2018 at 10:43 PM <lantianyu1986@gmail.com> wrote:
> > >
> > > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > >
> > > Sorry. Some patches was blocked and I try to resend via another account.
>
> The patches were still blocked?  They didn't show up on driver-devel.
>
> regards,
> dan carpenter
>

Hi Dan:
            Thanks for reminder. I double check kvm maillist archive
and this series is available.
https://marc.info/?l=kvm&m=154168821118117&w=2

-- 
Best regards
Tianyu Lan
