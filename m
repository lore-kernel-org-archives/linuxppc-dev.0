Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A8CC5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 21:53:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DA72081F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 21:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="LZ4um475"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DA72081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DGzj2366zDqZp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 08:53:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="LZ4um475";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::843; helo=mail-qt1-x843.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="LZ4um475"; 
 dkim-atps=neutral
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DGwZ5yYdzDqbx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 08:50:54 +1100 (AEDT)
Received: by mail-qt1-x843.google.com with SMTP id n32so14139533qte.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 13:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3bs5ZL7/SQT+ZpG7+URPlbhsekJSjOkjzb7pgrvFGi0=;
 b=LZ4um475rHJM+zEDON8e+Ke6KgsnVwDumzeun5ukHXxvIvm8vb6WV+ZMLxmZrzL6ij
 T/npuTeiWFjzpPczbVwPPuKL5rX7zsQ1GP699SXJOY+ZDot6DgZbb3RVuMimZ5MJ3ZZG
 Cp90FDW/tUEvif3FBfyFFGYOONTfKPqtA8Eys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3bs5ZL7/SQT+ZpG7+URPlbhsekJSjOkjzb7pgrvFGi0=;
 b=EB3LlIw4vm7wdGdpbUJCtL/EwfQhn1alOUTls4q69kreTMa/zi4eWDIDzfxym22Sru
 Kjr+wy8aD3Qg0iKMmJnYsW9qmzC5uv4p0yRX3m5Y9QWrHrSYXdG+psQNUSpYJvknaee8
 T9u0nIF4HchU0MDDyxiltIT/PAuA8cHyzrc7s8BDecD3ciFizitK31Y0wfsdOBHh1DcZ
 OiX/RdmpCFJaG1caN6UtfgaUGlVefVR8lbEqXPbvkEeakyrJQD6N4C8D1ggcqoh0ZdTv
 bSIDtW1XAOB6/gpBb2CzH6iD8yIt/1Y5WY65YJ/ukf6NRp5MupQDDz2b/eVg3e3x6kPa
 M7Yw==
X-Gm-Message-State: AA+aEWahs+h0I9RmoXdO+SjVu2X4ZVVMzAWFDPtLlvYaURKt8jOLgH4a
 LqAlj4OKRrYt87jdnLxKYZNsBRnwNxtHdcrzzo4=
X-Google-Smtp-Source: AFSGD/Vx4moyDIXovQJmXPGPRrfNGEFCn71YJbDcBvR1BXIoUb0CS8pwtKa9bIpwPeGZCK7aYydyX1ySRZfalMONkbM=
X-Received: by 2002:aed:2764:: with SMTP id n91mr13864635qtd.37.1544478651845; 
 Mon, 10 Dec 2018 13:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20181204005429.32681-1-joel@jms.id.au>
 <20181204005429.32681-3-joel@jms.id.au>
 <20181204174032.GG3803@gate.crashing.org>
In-Reply-To: <20181204174032.GG3803@gate.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 11 Dec 2018 08:20:40 +1030
Message-ID: <CACPK8Xcfy1YcK5f6AeBCRqp8yuq-ofrBRKW9AKz5L7hvfRmFjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc: Discard dynsym section for !PPC32
To: Segher Boessenkool <segher@kernel.crashing.org>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org,
 Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 5 Dec 2018 at 04:11, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Tue, Dec 04, 2018 at 11:24:28AM +1030, Joel Stanley wrote:
> > Alan Modra <amodra@gmail.com> explains:
> >
> >  > Likely you could discard .interp > and .dynstr too, and .dynsym when
> >  > !CONFIG_PPC32.
> >
> > Discarding of interp and dynstr happened in a previous patch. The dynsym
> > cleanup was a bit less straightforward, so it gets it's own patch.
>
> > diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> > index 6570209b0671..2c93a420f456 100644
> > --- a/arch/powerpc/kernel/vmlinux.lds.S
> > +++ b/arch/powerpc/kernel/vmlinux.lds.S
> > @@ -266,14 +266,13 @@ SECTIONS
> >       }
> >  #ifdef CONFIG_RELOCATABLE
> >       . = ALIGN(8);
> > +#ifdef CONFIG_PPC32
> >       .dynsym : AT(ADDR(.dynsym) - LOAD_OFFSET)
> >       {
> > -#ifdef CONFIG_PPC32
> >               __dynamic_symtab = .;
> > -#endif
> >               *(.dynsym)
> >       }
> > -     .dynstr : AT(ADDR(.dynstr) - LOAD_OFFSET) { *(.dynstr) }
>
> So this last line belongs in the previous patch then, right?

Correct. Good catch.
