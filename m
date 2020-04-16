Return-Path: <SRS0=XoDJ=6A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE7C2BA19
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 02:55:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D365D206F9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 02:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llwmz87t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D365D206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492kP649yNzDrGp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 12:55:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d41;
 helo=mail-io1-xd41.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=llwmz87t; dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492kM65pg1zDqr5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2020 12:53:54 +1000 (AEST)
Received: by mail-io1-xd41.google.com with SMTP id e127so4194666iof.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2020 19:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ngCJzKY2ZnK49mg2jGGljIlU1JbhJIlV2lpEN9jKoEY=;
 b=llwmz87toXGIOJuYxhv2PIFwORKPaThTINL2NoVuCVqGaUmUA7pHFbF1rmjk9A1JXB
 AI0YubGcI81uNFct+Yp0Gb3pda/Bf3jclSTgLX22rnpeFyXAKZCpPLYs0POU986neGo4
 3N6qqN1MfvpfobDHU79UymqFKqj8xgcZMP/KMP36Zf5U/aCYN2bLkVSzIq2dN/1qjmH3
 B0MIbEZE8i/0s239U34M4Dz5ifPdCbbbK635AsDenm+h0D/Or/K2SnCCnwKfCKgWkAmJ
 DwRM+kxpaQTTmkBvlsGhbF0eQvqq16B8bUlHTJFCIO3YuVDQ1X1SJpbF/b+ox/nSnQGg
 RzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ngCJzKY2ZnK49mg2jGGljIlU1JbhJIlV2lpEN9jKoEY=;
 b=aVaZ1BaSr88r81i12G+rKsaDIs8nvHZLLOBUShamxIwsCp2s5bswwGak8ZSf17xGNy
 EJPCZ2rZHz9ilBOIUTA5FexjbY9E3zOwVQKLphvHHt1wsK/96aV8rEqa+sQJQSnvOfwY
 PuGrzKzbb6IoOo6egbW3Q4J58tcjylRCQlQRZSsIwh1mb9xEt0FpK7xU50ywHzYb/Tmj
 n+Rr/+2/db/VY6ZvKaFyfN8HUG9R/sIMbdlIp9o8y+kP0yI9a7aJgwpFNYm4l08ynWln
 it/6WjkH9b2W1aXkVzUvxQzNugJYWKsYXFuYZaWcNus5USvS6wZm0X94r3oyw73DrYkL
 gaOw==
X-Gm-Message-State: AGi0PubHAzYYemHgfDTLzWi0SzdomYQIe/YJ8ZgxKrcZ3UOqI1pZNetI
 6t6FHPCtou3JXK8aEB3f1N+sYcbH+iUuuvlIgf0=
X-Google-Smtp-Source: APiQypKEW4cirP40WWh9h1+FSf8l8r3Na2muRxXULAy1/Sjlj4eHqzxNeFysW4pqxEPNPnQTWbu3Zrsw8Id3VqS3cjY=
X-Received: by 2002:a6b:7903:: with SMTP id i3mr30104932iop.66.1587005632207; 
 Wed, 15 Apr 2020 19:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200323075354.93825-1-aik@ozlabs.ru>
 <b512ac5e-dca5-4c08-8ea1-a636b887c0d0@ozlabs.ru>
 <d5cac37a-8b32-cabf-e247-10e64f0110ab@ozlabs.ru>
 <CAOSf1CGfjX9LGQ1GDSmxrzjnaWOM3mUvBu9_xe-L2umin9n66w@mail.gmail.com>
In-Reply-To: <CAOSf1CGfjX9LGQ1GDSmxrzjnaWOM3mUvBu9_xe-L2umin9n66w@mail.gmail.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 16 Apr 2020 12:53:41 +1000
Message-ID: <CAOSf1CHgUsJ7jGokg6QD6cEDr4-o5hnyyyjRZ=YijsRY3T1sYA@mail.gmail.com>
Subject: Re: [PATCH kernel v2 0/7] powerpc/powenv/ioda: Allow huge DMA window
 at 4GB
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
Cc: KVM list <kvm@vger.kernel.org>, Fabiano Rosas <farosas@linux.ibm.com>,
 Alistair Popple <alistair@popple.id.au>, kvm-ppc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 16, 2020 at 12:34 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>
> On Thu, Apr 16, 2020 at 11:27 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >
> > Anyone? Is it totally useless or wrong approach? Thanks,
>
> I wouldn't say it's either, but I still hate it.
>
> The 4GB mode being per-PHB makes it difficult to use unless we force
> that mode on 100% of the time which I'd prefer not to do. Ideally
> devices that actually support 64bit addressing (which is most of them)
> should be able to use no-translate mode when possible since a) It's
> faster, and b) It frees up room in the TCE cache devices that actually
> need them. I know you've done some testing with 100G NICs and found
> the overhead was fine, but IMO that's a bad test since it's pretty
> much the best-case scenario since all the devices on the PHB are in
> the same PE. The PHB's TCE cache only hits when the TCE matches the
> DMA bus address and the PE number for the device so in a multi-PE
> environment there's a lot of potential for TCE cache trashing. If
> there was one or two PEs under that PHB it's probably not going to
> matter, but if you have an NVMe rack with 20 drives it starts to look
> a bit ugly.
>
> That all said, it might be worth doing this anyway since we probably
> want the software infrastructure in place to take advantage of it.
> Maybe expand the command line parameters to allow it to be enabled on
> a per-PHB basis rather than globally.

Since we're on the topic

I've been thinking the real issue we have is that we're trying to pick
an "optimal" IOMMU config at a point where we don't have enough
information to work out what's actually optimal. The IOMMU config is
done on a per-PE basis, but since PEs may contain devices with
different DMA masks (looking at you wierd AMD audio function) we're
always going to have to pick something conservative as the default
config for TVE#0 (64k, no bypass mapping) since the driver will tell
us what the device actually supports long after the IOMMU configuation
is done. What we really want is to be able to have separate IOMMU
contexts for each device, or at the very least a separate context for
the crippled devices.

We could allow a per-device IOMMU context by extending the Master /
Slave PE thing to cover DMA in addition to MMIO. Right now we only use
slave PEs when a device's MMIO BARs extend over multiple m64 segments.
When that happens an MMIO error causes the PHB to freezes the PE
corresponding to one of those segments, but not any of the others. To
present a single "PE" to the EEH core we check the freeze status of
each of the slave PEs when the EEH core does a PE status check and if
any of them are frozen, we freeze the rest of them too. When a driver
sets a limited DMA mask we could move that device to a seperate slave
PE so that it has it's own IOMMU context taylored to its DMA
addressing limits.

Thoughts?

Oliver
