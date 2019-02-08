Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C03C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:49:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3E920869
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqhwopEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3E920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wxPp4nJBzDqD3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 00:49:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SqhwopEF"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ww9m6Jw2zDqW6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 23:54:20 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id i145so8424738ita.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5ygcQA52Ds3/dhrl7dlNYFsuWoz9998GehDgMJ74dX8=;
 b=SqhwopEFm7cfd6sYITzKJHaR73ki7EyuKyl7pKXZmM9RO0a290cLxDSgkHkeLXbH8r
 iypSY7xaXayfPg8ceDxbwk9nzi341ssEGI3GapoX18K7N2wN2p3cjedUw26HN2VNJdm/
 M6VVJs9qS4Wsb6SCt8Rb6wIu+Igxp7bHk0LPOXI3I/SETQIwrfaYXIWYA3OsWh107GSI
 7Og+BFB0R4tjd2K+PbA2wPYtu/l6e1nKvT8OCME7ht1PXG4BH28oABb/fpGXTYuwA9Uc
 KTmQ1VDbLo6OUBqn8QRKvbysz5zGj5faCu8oBExOBVW2PdL28LNNzgjMtKo2kfxhbDON
 V6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5ygcQA52Ds3/dhrl7dlNYFsuWoz9998GehDgMJ74dX8=;
 b=AHHNifU/X2Pf32X/lxiM1f5hnEDfz4Egn46Z+XHQBIU6w9R1FvrLGSNl3P4sI5JKfn
 WP9S70c+ASFYJ1Cy7oyisW2XPeF8CPqleWm8l971ObaAFWPuDbzBp9vpl6L47WZX3Npa
 mMcoSp+5SI1BHvVsqkXzW9zZUHSYWjcLk+B+0E23DY7tNWVaQGJe5VeQTbMoJMvjCuD2
 ctNL6h8JCZP+41gpFTIJRJvKF3AHzdPKJrwaRw/t6FNFXNd6WFFQC5Ry8bcqu1u0syjU
 eAXELwRFTaRcGrpAXVIwETTxrVCazCcaEJgFPZo8PR0/tQFPYBn07PGJZb3bJAx+8mXX
 gdMA==
X-Gm-Message-State: AHQUAub68RCNB+UP2sw+OLvVx465Rdv4Nn1p7128OKRK1XIVGAt/pxIk
 OaA89AGdCPLBinLvZukwV4NSemE+TPnVsFHV5/M=
X-Google-Smtp-Source: AHgI3Ib9Q9mG7E/ScxGMTWTvGhzjd3/PDl9gRdoO1n82rEtoMeqPKnVNMgzrUfPnhpR72SwPaIfS1ykMh/wYOw7GB6g=
X-Received: by 2002:a24:2b83:: with SMTP id h125mr3169800ita.4.1549630458954; 
 Fri, 08 Feb 2019 04:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20190208030802.10805-1-oohall@gmail.com>
 <20190208030802.10805-5-oohall@gmail.com>
 <8736oyk3gz.fsf@concordia.ellerman.id.au>
In-Reply-To: <8736oyk3gz.fsf@concordia.ellerman.id.au>
From: Oliver <oohall@gmail.com>
Date: Fri, 8 Feb 2019 23:53:54 +1100
Message-ID: <CAOSf1CFJsbqHpnntEhiruvhRp_J9ikTO4xaoH02JK6tEsc2x_Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] powerpc/pci: Add pci_find_hose_for_domain()
To: Michael Ellerman <mpe@ellerman.id.au>
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

On Fri, Feb 8, 2019 at 8:57 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Oliver O'Halloran <oohall@gmail.com> writes:
> > diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> > index aee4fcc24990..149053b7f481 100644
> > --- a/arch/powerpc/include/asm/pci-bridge.h
> > +++ b/arch/powerpc/include/asm/pci-bridge.h
> > @@ -274,6 +274,8 @@ extern int pcibios_map_io_space(struct pci_bus *bus);
> >  extern struct pci_controller *pci_find_hose_for_OF_device(
> >                       struct device_node* node);
> >
> > +extern struct pci_controller *pci_find_hose_for_domain(uint32_t domain_nr);
>
> I know we use "hose" a lot in the PCI code, but it's a stupid name. Can
> we not introduce new usages?

I was tempted to call it pci_find_horse_for_domain(), but neigh.

>
> It returns a pci_controller so pci_find_controller_for_domain()?

ok

>
> cheers
