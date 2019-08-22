Return-Path: <SRS0=ljjX=WS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59E2C3A59D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 05:43:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD760233A0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 05:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qh9NTAxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD760233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DYNL0DGnzDqWX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 15:43:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DYLP3WNLzDqmh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2019 15:41:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qh9NTAxS"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46DYLP2rmpz8tTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2019 15:41:33 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 46DYLP2c23z9sML; Thu, 22 Aug 2019 15:41:33 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qh9NTAxS"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46DYLP1S6pz9s7T;
 Thu, 22 Aug 2019 15:41:32 +1000 (AEST)
Received: by mail-io1-xd41.google.com with SMTP id j5so9431871ioj.8;
 Wed, 21 Aug 2019 22:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hn6rxeyfQPsYnbNUt5MSgWQtbToPh9tKf9jba7m/Mb0=;
 b=qh9NTAxShXjNLbP7aaKIkgSdqONWOprq9JZrxoqc5kVXFAF5XJO5QWJ5FTba1FYzh3
 y+OtXi6NNfMAbQe96n5PTZ2GLN8Ybf570q7QcCkXQwkR3A2jqYHPWQTtLJDyCxxQ8vpd
 FzSSFLB6V/D5k3rOIAg7WfBgNX8of0+VO6VwIiUvUCxse5vr2s4F3MMKuILFAbFrOqNJ
 lS+1sHQf8TtPAnMc9+mI5kOv/1frTd1/wywNNNTIIz42s5GGVf1QxgFPRhvXI6dIUv/7
 myvqsmGFBPQngRg+CXIaw4wu72oAay3IjQyGlN2B4sBh6xhEnbbur+SeKGMAfsOPCbsP
 1RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hn6rxeyfQPsYnbNUt5MSgWQtbToPh9tKf9jba7m/Mb0=;
 b=JBU5l0gDjVikaxq51a8vYtBxzLalHvFbu6APpInrFn6UH9/ULeHGbJYqrevNdE4Cdu
 PKANjtG2GcoXZw0BeBdr37RNFBLTAw9AgrnUL0bYm07cI+V2jJ6SFU0dkw4e+9LAdrUR
 G1DXtf7GNyCrF2gWYg+YCsp/S1Nf69BML4+Bvaq7tRcH9DaznEf7vRxgyybb+PaBcrPk
 w4uPDZsjpBEfeond4uuSqtIGbVONXGI9zHilJPkK7NcMtrau3rruQh0mkLEP8KKCoXH+
 DrRF00hEIVAfW/7EO0C/JVRa4SYYTHljytGVukAZ3GT0xKHPAEICNY7cRnLCGIo4Oesr
 BsvQ==
X-Gm-Message-State: APjAAAVJJi6/rkwRRDAZBO3pxem34UuJfB4qSRoICpQU9omqH9Xeg0rC
 PhTS609ZH8kyBY6U3AuGEuYFswSR0/zrHtfjXDU=
X-Google-Smtp-Source: APXvYqy6nIsjmdyjJU/y7Jt/ct3pwz+lpQCAmPtDtYRpTMGX/1uH9hIhwQwdQXVE23y8PT5ZqJiCE/t5E0jsquqbZXI=
X-Received: by 2002:a6b:6e0e:: with SMTP id d14mr25453232ioh.18.1566452488810; 
 Wed, 21 Aug 2019 22:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <1566400103-18201-1-git-send-email-nayna@linux.ibm.com>
 <1566400103-18201-2-git-send-email-nayna@linux.ibm.com>
 <eda9210b56ab220519642d272079eeca60a18265.camel@gmail.com>
In-Reply-To: <eda9210b56ab220519642d272079eeca60a18265.camel@gmail.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 22 Aug 2019 15:41:17 +1000
Message-ID: <CAOSf1CHOsnnC94DxHhG4opZfYjV7u_ndrE2B3Cr6ZV58RAxoWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] powerpc/powernv: Add OPAL API interface to access
 secure variable
To: Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>, 
 linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Eric Ricther <erichte@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 Elaine Palmer <erpalmer@us.ibm.com>, George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 22, 2019 at 3:02 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>
> On Wed, 2019-08-21 at 11:08 -0400, Nayna Jain wrote:
> > diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> > index aba443be7daa..ffe6f1cf0830 100644
> > --- a/arch/powerpc/platforms/powernv/opal.c
> > +++ b/arch/powerpc/platforms/powernv/opal.c
> > @@ -32,6 +32,8 @@
> >  #include <asm/mce.h>
> >  #include <asm/imc-pmu.h>
> >  #include <asm/bug.h>
> > +#include <asm/secvar.h>
> > +#include <asm/secboot.h>
> >
> >  #include "powernv.h"
> >
> > @@ -988,6 +990,9 @@ static int __init opal_init(void)
> >       /* Initialise OPAL Power control interface */
> >       opal_power_control_init();
> >
> > +     if (is_powerpc_secvar_supported())
> > +             secvar_init();
> > +
>
> The usual pattern here is to have the init function check for support
> internally.
>
> Also, is_powerpc_secvar_supported() doesn't appear to be defined
> anywhere. Is that supposed to be is_opal_secvar_supported()? Or is this
> series supposed to be applied on top of another series?

To answer my own question, yes it depends on the series at [1] which
adds IMA support. Turns out actually reading the cover letter helps,
who knew.

That said, I'm still not entirely sure about this. The implementation
of is_powerpc_secvar_supported() in [2] parses the DT and seems to
assume the DT bindings that OPAL produces. Are those common with the
DT bindings produced by OF when running on pseries?

[1] http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=125961
[2] http://patchwork.ozlabs.org/patch/1149257/

>
> >       return 0;
> >  }
> >  machine_subsys_initcall(powernv, opal_init);
>
