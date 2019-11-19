Return-Path: <SRS0=BgZL=ZL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F7FC432C0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 13:25:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E10222C7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 13:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs6DiB6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E10222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HRQc44t5zDqgV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 00:25:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d44;
 helo=mail-io1-xd44.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vs6DiB6f"; 
 dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HRMF6MP7zDqZG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2019 00:22:32 +1100 (AEDT)
Received: by mail-io1-xd44.google.com with SMTP id i11so12164572iol.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2019 05:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QWs+vZ9aE528wO9EG5Wr9V9AoHUEL8WTxMCms8MVv1Q=;
 b=Vs6DiB6f8mrjTDil94oYUia5e4V3cEkGpwI9D6bRmDn7JxW5BCyL89dYO2UI1vxaKC
 0qgiQuNKeJUJfF9bHh2OKOIRJQm6JSbEeXZkMJOkN//kEOEqDdTuQd7QZZoBn2L3gYHl
 wGWomn7Yd6/1xmLZ/uFDIwlYYAm32urjuPQdJpDXdczkJoKWoUm78joUC9DeTRYjkr+Y
 PDTs78mlgnvkGKiBoZ0MrSLb/Qc8StdOCGOse/FeBuH3pssr4rGv75dQQDT7RPoZCOe1
 tKyUBTi7PayngH9ZYuVyyoHaLngvWtkgSYG6wdjsAaD4AYNc7uMW3zWrEf72VobaQdeo
 cpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QWs+vZ9aE528wO9EG5Wr9V9AoHUEL8WTxMCms8MVv1Q=;
 b=qZuREod9UNegGxBCJGjnl7RUAtGzMCm4i7AannqiBnciEbniP6WblMXUPeAQz+XJuF
 hLVjvnYTzUyPn3U0d2io+Lp26cQ5Fnm5mH4+45It0t0iPCu74DTzioiVzbs6BHb6jnN3
 jx53Q5LVI2pLbMTOGNtXTWOtwhMmV71zIrNGFd5LQCDTh9xFkCcYaug9Hv2AO2JW3+nI
 eQaViL8m1fBUrcRR5jDz6wbfnX7LjDwYmH4PeJEUCHqHWzLO7oWCWugXtoE+FkAO/Hwb
 JgbM3me9JG1um0Qy4JLMls91PY05w1Wl3rkfXRmM5l0obzQDEkMe7k1LDdgQXyX+qfbU
 4YrQ==
X-Gm-Message-State: APjAAAWEYKesPKo+dGKLy8jvOxAEhK7Fgb+FFjttsT+U+cQMQjK4iN5O
 54jplDTmXxW9JeZrAKG4tP/cwzF7BT5hfqBVtLc=
X-Google-Smtp-Source: APXvYqxGz7cgVcCbkskVmzW4i4LrP+myVRVurUQIA/jnzyoCZQMzhcQAB/aM1eJwdkxZL3QJcL9CWHJxWYXmvCJFAKw=
X-Received: by 2002:a02:730d:: with SMTP id y13mr18081798jab.124.1574169749754; 
 Tue, 19 Nov 2019 05:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20190909154600.19917-1-fbarrat@linux.ibm.com>
 <20190909154600.19917-3-fbarrat@linux.ibm.com>
 <8f5d581d8f1e8defaf8622cd79c40c98f18d3507.camel@au1.ibm.com>
 <882c0d26-7931-a2e9-c99a-7732d32a6a2f@linux.ibm.com>
In-Reply-To: <882c0d26-7931-a2e9-c99a-7732d32a6a2f@linux.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 20 Nov 2019 00:22:18 +1100
Message-ID: <CAOSf1CHstMRhC9dqsuvZnQuRyLwMrQkcuMYFDobq59KvYG1hEQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] powerpc/powernv/ioda: Protect PE list
To: Frederic Barrat <fbarrat@linux.ibm.com>
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
Cc: Christophe Lombard <clombard@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Alastair D'Silva <alastair@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Greg Kurz <groug@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 19, 2019 at 11:57 PM Frederic Barrat <fbarrat@linux.ibm.com> wrote:
>
> > Do the other accessors of ioda.pe_list also need mutex protection?
> > pnv_ioda_setup_bus_PE()
> > pnv_pci_dma_bus_setup()
> > pnv_pci_init_ioda_phb()
> > pnv_pci_ioda_setup_PEs()
>
>
> I think we could also use it there, it wouldn't hurt. Those functions
> are called when the kernel is building part of the PCI topology, and
> devices are not really active yet, so I don't think it's absolutely
> required.
>
> I'm actually not sure my patch is needed either. With hotplug, the
> devices can come and go, whereas the PHB remains. So it feels right to
> start protecting the list when adding/removing a device. But I don't
> think we can really have concurrency and have 2 different operations
> adding/removing devices at the same time under the same PHB, at least
> for opencapi. Maybe for PCI, if we have multiple slots under the same
> PHB. Not sure.

Creation of new pci_dev's is serialised by the global pci rescan and
remove lock so on the creation side it's not an issue. However, we can
release IODA PEs in the pci_dev's release function which might be
called without that lock held. It's pretty hard to hit that case
though since it require something to be holding a ref to the pci_dev
even after the driver's ->remove() function has been called.
