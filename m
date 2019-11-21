Return-Path: <SRS0=V+RV=ZN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6720EC432C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 04:35:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7371206CC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 04:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCP4zdJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7371206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47JRYk4VL6zDqvY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 15:35:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d32;
 helo=mail-io1-xd32.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WCP4zdJP"; 
 dkim-atps=neutral
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47JRWm0JqxzDqs8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2019 15:33:23 +1100 (AEDT)
Received: by mail-io1-xd32.google.com with SMTP id i11so1791015iol.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2019 20:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LDFhZr4xlv9N0Psa36tJ4PxQavrmQWdPfnjAewTWIiU=;
 b=WCP4zdJPcvY/xNzb+Uy5GXJJEUcV3K3MPp00+wksvYABhj6uLx97opgcS6ymFbW9V+
 UBW+1iLjMPgOlS2J1lj0zGkjZ4HcG35R8RD4Y5/7AzdHbypyYnk6YBpKqDr5jxFYJtrA
 sh7O7b4Z70U3uH+Rgn6oYuDWGBY36hARn6xd3BrWltXpm7/3YWJYdDd9Ptzx/gpm/COY
 SY2uuyu/HZUzCIA8OliEB5tGxnkpLpa0UwQX6sangj7rvMmi9QduK5FPWkLeJipnJLKD
 Ubim+317dJx/WVjEJwUtIiDGQNpLRQMQoTqRuZGVgEXg/j4JZ0qUjgG/5+qIk0QvykF8
 N9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LDFhZr4xlv9N0Psa36tJ4PxQavrmQWdPfnjAewTWIiU=;
 b=FFVaq/IwArFRCY4MTiAPDfrimEZEtGN1vUWJuKr4zWbzQgZod+tED1DxsCVGCaFnGz
 LvM5QcdLEWcPWKnSpFpBEddwv3czo0QlO4rttc5UC9dCawtEYJ4cI3vHnnIkB/AsVvbW
 ZA47QjWE6RoPvJO6K7C9EkCxxUpGrYpwWF2xnQpwC0LwnUQpLAbQ3UANywqmyt61BIx0
 EjwhcXG9+rX4cKauvOwn9viq8UcW9wH8kdcrc82+adhGlg8r8RJWqUqfhD696ml6h1hh
 bkD+7xlfk2A2Umvn+lDacsRpHNGBL+zDKmImr6WC1isvLh0RXmfF42CEXGxxqqW2cCb3
 ut4Q==
X-Gm-Message-State: APjAAAVDl/w8RBJ3tTSGY/jv0O6JWDaW4hA04g0rLpY3YeG6buCG+Vmq
 HcxiX7lp+HO9fQW6Jm/y9b1iLJQYaVnA1qvAwOGUdQ==
X-Google-Smtp-Source: APXvYqyHy7s9CjKzfLcMMTiXtdUEGzde54r+q2hSJSeAoRTNG/jWW15rwx+jZye+YojojpqZSiSpzXD1O6WpysnnXDg=
X-Received: by 2002:a6b:e315:: with SMTP id u21mr6140417ioc.192.1574310800131; 
 Wed, 20 Nov 2019 20:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20191120012859.23300-1-oohall@gmail.com>
 <20191120012859.23300-5-oohall@gmail.com>
 <051dac75-af97-04a5-07db-462629614698@ozlabs.ru>
In-Reply-To: <051dac75-af97-04a5-07db-462629614698@ozlabs.ru>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 21 Nov 2019 15:33:09 +1100
Message-ID: <CAOSf1CF0AO1TOh_R9k3vrhodjnS-Wwu=OLCbF63EDy_42zqc6A@mail.gmail.com>
Subject: Re: [Very RFC 04/46] powernv/pci: Move dma_{dev|bus}_setup into
 pci-ioda.c
To: Alexey Kardashevskiy <aik@ozlabs.ru>
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

On Thu, Nov 21, 2019 at 3:02 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>
>
> On 20/11/2019 12:28, Oliver O'Halloran wrote:
> > These functions are only used from pci-ioda.c. Move them in there and remove
> > the prototypes from the header files.
>
>
> Make them static then, or am I missing the point?

I forgot.

>
> With that fixed,
>
>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
>
>
> Also, pci-ioda.c is around 4000 lines long, if anything I'd rather be
> moving things to a separate new file (pci-ioda-dma.c or whatever). OTOH
> after everything you've done, pci-ioda.c is 77 lines shorter so I'll
> shut up now :)

IMO pci-ioda and pci.c should probably be folded together since
there's no clear distinction between the two. We might be able to
split off the PCI/NPU/OpenCAPI PHB specific functions into separate
files to slim things down a bit, but I still need to re-work some of
PHB init code and to make that possible.

Oliver
