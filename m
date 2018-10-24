Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EF7C67863
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 09:00:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC3B20824
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 09:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="T0jxbwQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC3B20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42g43N0BbJzDrM8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 20:00:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=globallogic.com header.i=@globallogic.com header.b="T0jxbwQ/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=globallogic.com
 (client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com;
 envelope-from=maksym.kokhan@globallogic.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none)
 header.from=globallogic.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=globallogic.com header.i=@globallogic.com
 header.b="T0jxbwQ/"; dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42g40Q3skPzDrJv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 19:57:57 +1100 (AEDT)
Received: by mail-qk1-x743.google.com with SMTP id q184-v6so2654650qkd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=globallogic.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P5D5+wbYvFpm0tdJgRcE+2WrrJ+FHACmNE2eQnVA+Rs=;
 b=T0jxbwQ/IMtXTPmiRhxrz1dyHOaxB0otLcS6qSCgIoj/ZIb3gqrvQ8n0BBzlqTgQtv
 n2w94rrDc0HbzNRZo3fF9wCbHhKFY/okTC0mLazTecjsg6yeew3DOh6ZQFMB5gT8jiSm
 fbe+ePGG5l0r9wTKn+fKuAJC1lbS5y/F81yJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P5D5+wbYvFpm0tdJgRcE+2WrrJ+FHACmNE2eQnVA+Rs=;
 b=jCmWao1rf/SoWqtO5YskJ2W1nKDuotZ9+uAiRLIphVBnn9hdsRUBBE/2iyrIp542pm
 qcgIqvNiz7MJbJiyGwmg56lDZu+4NGtAqGJLBgJB8lbpqDS+GAoctmvKXdsWR/CmP2w+
 md4cnHfSNUuDmXQF+yzBQMe6YpN8t/vytZdoawWd92sNsz9FKklkGOteim5WC5sMHXVb
 RtY2IYgXcTilZZm5lBbPebN4zHA6dcOZtG148Tl2oHUzEzbBju6slYeVVtAhjXMM2p39
 uRuUXPmO70xohDzkSlCZcFtQd5I4iWeaWET6h1b70GBqSy72g5YobgLlcJGDShrA3O06
 1bqA==
X-Gm-Message-State: AGRZ1gK9pyQcZ+zKSaNotZ7AUmWi1zdEDOyP9eATzpdqNxYrdPKj0lIi
 /QNAuQNUpMDnK0bWHK2nXmqQdhO7lf063BF80WJEjw==
X-Google-Smtp-Source: AJdET5e9VvhF6uwwaf7KJaXHG6ft6oCIpV7twnhvj5/91jdS+1Uk2+5SdTALGVsyBN2FJrWuHdYEDwZOODMoFMEZNEI=
X-Received: by 2002:a37:1b46:: with SMTP id b67mr1512491qkb.144.1540371475912; 
 Wed, 24 Oct 2018 01:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <20180929181725.GB27441@fifo99.com>
 <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
 <CAMT6-xj1rjVAy1AWFiMHc5wH36eu=TUSMtdKU=-qRtUbwr9bkg@mail.gmail.com>
 <20181023144815.GP30658@n2100.armlinux.org.uk>
In-Reply-To: <20181023144815.GP30658@n2100.armlinux.org.uk>
From: Maksym Kokhan <maksym.kokhan@globallogic.com>
Date: Wed, 24 Oct 2018 11:57:44 +0300
Message-ID: <CAMT6-xhvqy5PeQmkQ8tsLRiML_pNJTxyq7dizRRvZTEqc7uzgg@mail.gmail.com>
Subject: Re: [PATCH 0/8] add generic builtin command line
To: Russell King <linux@armlinux.org.uk>
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
Cc: linux-mips@linux-mips.org, linux-efi@vger.kernel.org,
 Ruslan Bilovol <rbilovol@cisco.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Daniel Walker <dwalker@fifo99.com>, Frank Rowand <frowand.list@gmail.com>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Daniel Walker <danielwa@cisco.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Bordunov <aborduno@cisco.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Do you mean, that you haven't seen patch for ARM, which I sent on
September 27 along with cover and patch 1? It is strange, because
you was the one from recipients. If so, you can see this patch here:
https://lore.kernel.org/patchwork/patch/992779/
On Tue, Oct 23, 2018 at 5:48 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 23, 2018 at 05:43:18PM +0300, Maksym Kokhan wrote:
> > We still have no response to patches for x86, arm, arm64 and powerpc.
> > Is current generic command line implementation appropriate for these
> > architectures?
> > Is it possible to merge these patches in the current form (for x86,
> > arm, arm64 and powerpc)?
>
> You may wish to consider your recipients - I seem to only have received
> the cover and patch 1 (which doesn't include any ARM specific bits).
> It may be that you're not getting responses because people haven't seen
> your patches.
>
> Thanks.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
