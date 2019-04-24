Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F51AC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:50:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ABB320878
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODqw1SW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABB320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q4Ww75hgzDqXb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 01:50:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ODqw1SW1"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q4Rs3hdhzDqSZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 01:46:33 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id o7so7250118pll.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Y0LsCVSrGvoNOIOBTy+0pPOtleaTZYJy2+61/AagOVw=;
 b=ODqw1SW1096t2F8vFyk3P59wHCbJ7qXOaM37DdDe05X6EwQoskcUPWaGbz/hs76P7U
 TUOFwLI/hsCU6afQjXPkZrTkYmmGaETeod6xT4ulHGWIorpiTGcQk2kmBGw9maDWahiT
 k+Y2en03bXv7vbD8TMOBwxPPgKe2qWwF4NfuJlm5XmLGDXXL2cwheDNOFD9dJ5pKl9jL
 z0FNIw0S4bDJzuc7RBZsgk3/25xY+Yt2Ztv/RZeLFIJ388Y2HSg7ikZUxZhu89RDq3lU
 4gjuaUFHN0zyIcVK9YDrbRRWTnIjVgh5dQnZAYsmIIKfqDnmKNcrPOntbOssobcZalcx
 idyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Y0LsCVSrGvoNOIOBTy+0pPOtleaTZYJy2+61/AagOVw=;
 b=O3QDgBgCUFxzuC+tv41Su9uuPIlFnvw4m+ELYW6v+INo3KPx1i2o/olsF9k9bga8cH
 swZwT9giFy1SELwitc84oymvhUgIVjoIHDhCHpzllrsviN/ocxmZghkZEOKp4FA5EGN0
 54rTLtTCyKnh6fYi+WWhV9jvbRwOuNa/rrPWDYAdUYabkiMoSkqIeF8ze82LohQ4WfKs
 doZqYx5Hxk8Il2h1ajpYODsMebHU2/O9rLdp1E+Ot11LNh0HzzGj1gmGYPEzSJIwcECr
 jxeb1qfBIgxVnZIfpdSc3BwXIRhoc1dONoDygzAjLvf3Q/k5cmIgW2B0a1xYKI8qCT06
 A13Q==
X-Gm-Message-State: APjAAAXxvvhHAK7Kc2vTIfVLTx0QVWZhIx42YWbs+Ha6wYkdCIrSponD
 wqxZYI+OoT009B+bcnYOxeM=
X-Google-Smtp-Source: APXvYqx1LVJqHOnpDOTUG9ydbgXkCgWczr574IlkzKmuvt4hX8i46bC8skY8tJxknOZWxaizOzpQyQ==
X-Received: by 2002:a17:902:868e:: with SMTP id
 g14mr15575836plo.183.1556120789376; 
 Wed, 24 Apr 2019 08:46:29 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id d67sm7320974pfa.35.2019.04.24.08.46.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Apr 2019 08:46:28 -0700 (PDT)
Date: Wed, 24 Apr 2019 23:46:18 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx TOC
 tree
Message-ID: <20190424154617.kowr5aamjkeceltr@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <CAJZ5v0jPyaGQcDfpW5b7A-_3bvkfL78MxFmPtjwCGZ4-=KwUwg@mail.gmail.com>
 <20190423173644.GA14616@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423173644.GA14616@google.com>
User-Agent: NeoMutt/20180716
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
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Linux PCI <linux-pci@vger.kernel.org>,
 linux-gpio@vger.kernel.org,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 23, 2019 at 12:36:44PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 23, 2019 at 06:39:47PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 23, 2019 at 6:30 PM Changbin Du <changbin.du@gmail.com> wrote:
> > > Hi Corbet and All,
> > > The kernel now uses Sphinx to generate intelligent and beautiful
> > > documentation from reStructuredText files. I converted all of the Linux
> > > ACPI/PCI/X86 docs to reST format in this serias.
> > >
> > > In this version I combined ACPI and PCI docs, and added new x86 docs
> > > conversion.
> > 
> > I'm not sure if combining all three into one big patch series has been
> > a good idea, honestly.
> 
> Yeah, if you post this again, I would find it easier to deal with if
> linux-pci only got the PCI-related things.  63 patches is a little too
> much for one series.
>
sure, so I will resend them respectively.

> Bjorn

-- 
Cheers,
Changbin Du
