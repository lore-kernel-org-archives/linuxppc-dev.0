Return-Path: <SRS0=pFgb=LF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F702C48BD1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 15:41:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB0F613E9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 15:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB0F613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G1lSV0mLyz3clB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jun 2021 01:41:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IRqkW7ak;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::72b;
 helo=mail-qk1-x72b.google.com; envelope-from=tientzu@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IRqkW7ak; dkim-atps=neutral
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G1lS01hjLz3bsf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jun 2021 01:41:03 +1000 (AEST)
Received: by mail-qk1-x72b.google.com with SMTP id q16so5402713qkm.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AzuwWZVb0hvYDmhYzyjXOdcnRd7gmJwLqOExosCeDwM=;
 b=IRqkW7akj902Qmh2dpTJs35MbbbyYdNh845FqGa90ZgwGlX/fY4AEM0E2Tq/OkUGrx
 VVpf/9sUsDrF+Qmi4N27tWzf7jckOIK7UvGuS34GnQEYg0G4BU1Idcj7Q7ryrjHTdpBh
 ql1llzJVDf1YUXhBMlreUDeIOuUDsqa6G9X1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AzuwWZVb0hvYDmhYzyjXOdcnRd7gmJwLqOExosCeDwM=;
 b=oEGv+YgaZaf+tE7AuDMtsRrCZebChE0mLkjnDfqe/KPzyb2a5fyCQm2lE5aMVgmrbI
 C7jI1fS5wd9Wnx6n3rG8j4nduoqISqie29Q6XfymPR1RVid9rQuwAwF+Mh0hZUTKjgkC
 iL8/PyKWDaUp3K1jXsp7ebpGJaGJElT3UFIlgbK9YJIlYL5+eXHxPBOsNdIAVLtPC9Oe
 mVfxyiCII5m5OEdy5lU8qokksvG6E8W/Opme+9ROMBp3y+c0qQhohYy4mVSR4f1eKXLH
 Lw0k35FV4nWiqzv0nt+tY0aLitnTZQLBcpoy70yYZCtchFTwOKefkX1SC9boueTUwQkB
 PyjQ==
X-Gm-Message-State: AOAM530pb4bGH/3YtAhIPC6cUEAeUPBtslCbD+Z8/t4zXaLgU/D43Ld5
 7PePs5thEehMzb2N4BcZ5Xe/AjwX1wJb9Q==
X-Google-Smtp-Source: ABdhPJw+8FfVOgW7cGSfcBxZ6MD6kMu5Tlj6gwMvhGShwI86JQtHdM6m6Kn/uU8gnBboziN6a6b2qw==
X-Received: by 2002:a37:a393:: with SMTP id m141mr4463094qke.164.1623426059854; 
 Fri, 11 Jun 2021 08:40:59 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com.
 [209.85.160.177])
 by smtp.gmail.com with ESMTPSA id 137sm4651552qko.29.2021.06.11.08.40.59
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jun 2021 08:40:59 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id z4so2899650qts.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 08:40:59 -0700 (PDT)
X-Received: by 2002:a05:6638:e81:: with SMTP id
 p1mr4464281jas.84.1623425710461; 
 Fri, 11 Jun 2021 08:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210611152659.2142983-1-tientzu@chromium.org>
 <20210611152659.2142983-7-tientzu@chromium.org>
In-Reply-To: <20210611152659.2142983-7-tientzu@chromium.org>
From: Claire Chang <tientzu@chromium.org>
Date: Fri, 11 Jun 2021 23:34:59 +0800
X-Gmail-Original-Message-ID: <CALiNf28OT2L1qcH4dKK8mb0=uCyaKDHW7r=LrC9MTJw0PSzSbw@mail.gmail.com>
Message-ID: <CALiNf28OT2L1qcH4dKK8mb0=uCyaKDHW7r=LrC9MTJw0PSzSbw@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] swiotlb: Update is_swiotlb_active to add a
 struct device argument
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, 
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
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
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 grant.likely@arm.com, paulus@samba.org, mingo@kernel.org,
 Jianxiong Gao <jxgao@google.com>, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
 maarten.lankhorst@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Nicolas Boichat <drinkcat@chromium.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@chromium.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I don't have the HW to verify the change. Hopefully I use the right
device struct for is_swiotlb_active.
