Return-Path: <SRS0=uOHI=ZR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB678C432C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Nov 2019 05:09:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D6320679
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Nov 2019 05:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzgjf+15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D6320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Lw771l7JzDqGk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Nov 2019 16:09:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::143;
 helo=mail-il1-x143.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gzgjf+15"; 
 dkim-atps=neutral
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47LvTL5drqzDqXT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Nov 2019 15:39:50 +1100 (AEDT)
Received: by mail-il1-x143.google.com with SMTP id s5so12958118iln.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Nov 2019 20:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eCYFT6TGZD0y/qQ6ga3jz2EXsTuOpcRjvnAzBbU9vZc=;
 b=gzgjf+15qsDZepOBOZlYG68Sk1m+yceYLeTmQl6CC3X6n0CXOo2cSAGp5qdc3TPxVU
 IfmgTP5LcSpuQjkAXZ5T+QTMjizd4Olz0Kbzv4+egjBRysywzmg8G0pseus9M3PQWllb
 1sxfUGL9OdsHsVFVTlEa8ZqyI21eWWitTu62pwO4M/T+3bCOypUywZDiErZDeEpwW9nw
 eyEmccPY/NNqGXhv3hfaW2morr2mdOgdCPO7MurvfSDktd8cbTgTpfvRHL+9xRcCYiXq
 xeg91vhSDo+bRG+96SnnrLH1OF10o4/Sa2Qs/dOuBf+HPbErIip38nKC62uNssMNgt3h
 mVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eCYFT6TGZD0y/qQ6ga3jz2EXsTuOpcRjvnAzBbU9vZc=;
 b=RePnvuYB1mjU3blrls3LiA85Rx0FDG1ws6jZlFCAnKGwAs7J804D8QaDlCwXISjEFV
 O7yKEoun9AiZiczyZQgUpEQNfwMS3T7xdW4iC4kifqC06N/G5uvgHgsOhEHBt3wJEYfL
 n3rmfWkPVF6Mj+SKWFI/OluQNhmY9xT6jkriIlz4t3htLLV1G//9zaHRRChWyhtEsEY9
 B5/n8rXUWrdiCU7L0n32ln1Eq8jHGoYAzuRMm3N1UZGpMLG31iyPPDMjnUT5cRbGFVzF
 9ah0HPiYXQ9iqhIzkDMxbgNsbGxX4tl9drocYehzuw4WWXmnAd00yfo4Dvj9yLZm04UC
 yvnw==
X-Gm-Message-State: APjAAAWSiXXrvplDXLRmsieZJkvewC/e+9Gm5QhzMTvjeqandHi2OsoQ
 AN6VsxWjcN3SZSpw/okpCK/pXiHSXO5HdtTgrH8=
X-Google-Smtp-Source: APXvYqzw3XgnbeAo8GOX3zjnouDOdCk9h29fAaJqcnsEwBh4/yPch4WCdmPQxy+okTsEIYozAGzlpHztxgPjuGEEzhw=
X-Received: by 2002:a92:3943:: with SMTP id g64mr15429932ila.298.1574656787336; 
 Sun, 24 Nov 2019 20:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20191120012859.23300-1-oohall@gmail.com>
 <20191120012859.23300-7-oohall@gmail.com>
 <20191121074855.GC17209@infradead.org>
In-Reply-To: <20191121074855.GC17209@infradead.org>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Mon, 25 Nov 2019 15:39:36 +1100
Message-ID: <CAOSf1CGDPF1G763494hBLW+ok9wQ3rsnu946j32zo4-Crk4yqw@mail.gmail.com>
Subject: Re: [Very RFC 06/46] powerpc/iov: Move VF pdev fixup into
 pcibios_fixup_iov()
To: Christoph Hellwig <hch@infradead.org>
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
Cc: Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 21, 2019 at 6:48 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Nov 20, 2019 at 12:28:19PM +1100, Oliver O'Halloran wrote:
> > Move this out of the PHB's dma_dev_setup() callback and into the
> > ppc_md.pcibios_fixup_iov callback. This ensures that the VF PE's
> > pdev pointer is always valid for the whole time the device is
> > added the bus.
> >
> > This isn't strictly required, but it's slightly a slightly more logical
> > place to do the fixup and it makes dma_dev_setup a bit simpler.
>
> Ok, this removes the code I commented on earlier, so I take my
> comment there back.

It is a bit weird. I'll re-order the two patches so we're not
shovelling around the fixup junk.

> > +     if (pdev->is_virtfn) {
> > +             /* Fix the VF PE's pdev pointer */
> > +             struct pnv_ioda_pe *pe = pnv_ioda_get_pe(pdev);
> > +             pe->pdev = pdev;
>
> Maybe add an empty line after the variable declaration?

ok

> > @@ -3641,20 +3654,6 @@ void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
> >  {
> >       struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> >       struct pnv_phb *phb = hose->private_data;
> >
> >       pnv_pci_ioda_dma_dev_setup(phb, pdev);
> >  }
>
> Can you just merge pnv_pci_dma_dev_setup and pnv_pci_ioda_dma_dev_setup
> now?

Oh cool, looks like we can. I'll do that.
