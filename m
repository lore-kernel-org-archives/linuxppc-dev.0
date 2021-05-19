Return-Path: <SRS0=tyeE=KO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD35C433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 19:20:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12D36108D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 19:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12D36108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FljPf1n2lz3bwX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 05:20:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=rcLYOAKu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e;
 helo=mail-pf1-x42e.google.com; envelope-from=f.fainelli@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=rcLYOAKu; dkim-atps=neutral
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FljP14xzqz2xtn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 05:19:49 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id 10so10607596pfl.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2021 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ghVDOoMvorTJdaMzHQG/RIv5BmHhyL6sw4dTSHsJEnU=;
 b=rcLYOAKu9u/Pk2N2pIINoWg7Qql5CHIaTXPW1rmbbrFNRBJ17e6P88xZ/Yr3+K40Vg
 KFK9I+oMG/IgtitN6mi8iqL0UX94lczwdh7i0nBMb8jue1bBvD+G4ynJruy5PLRKgM8v
 188V9tFxrPE9B0B1aPKzXgftN+LtzT071WIlfZD+1U+hRwMChhgRPMvMzKYVh5Q7yJyY
 X233KhJbv3QXKhh18IR7fU0ZBHQkRzKr/brYbrWfvUGYpz9WfdE1CfhVQ0XA+pTrnR5x
 VWSQyHCExyqYP4xFwbo2E8+nGlIJeknoGezPntMeUW6YyiidoBVXS6cxaKILk/O3+EJK
 3+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ghVDOoMvorTJdaMzHQG/RIv5BmHhyL6sw4dTSHsJEnU=;
 b=sBvDPmjK9Lj27xE5kKZlQrHC040yqAiN2hu2N5YFfWVBl31qZ58xwMMn+RPTxM/Pji
 NA2bEUKRWqtFv21ZiyzKZkmvWFkJ4AT6F4BgZ9xbvinE/GA8wrNA+AVFgUd1JAMGzmfY
 xPK1g4FQit6yc1dqP/kbXlwHCUkPDXuBacu9l0bjB1glBFA+IknzaR78Y1WaWPwbgU2C
 uJ1qvp4WWQlbpT/XHWTw2sdVNi8uKjPB26/BcGK/QVXxEq/v8+OZT6gwQZtf80caqp/a
 OWcdCO1aZfnyT3YYhYBi5dCgQGWBcCOjhURTsbFOwpf+LwrVsj4viN3dCSasqA8mbiJv
 9ExQ==
X-Gm-Message-State: AOAM532odgrcxLxDTrSTI2Mb59mgJdPthtNKGV/ZWLAMtbPex4AlALiY
 Yo54FgklSRnSk1uq4nssyF8=
X-Google-Smtp-Source: ABdhPJwjgDsBVD45dTtfq/CuwPFV8Nn9xvyX5u2jGlIQAuONAFWU5ZnSLNw+gRQXo9RnVxq5dGzq7g==
X-Received: by 2002:a63:4e01:: with SMTP id c1mr645397pgb.265.1621451987803;
 Wed, 19 May 2021 12:19:47 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id y66sm128104pgb.14.2021.05.19.12.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 12:19:47 -0700 (PDT)
Subject: Re: [PATCH v7 06/15] swiotlb: Update is_swiotlb_buffer to add a
 struct device argument
To: Claire Chang <tientzu@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 mpe@ellerman.id.au, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-7-tientzu@chromium.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e825f332-eabe-4a82-1528-8bc9d1e60625@gmail.com>
Date: Wed, 19 May 2021 12:19:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518064215.2856977-7-tientzu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 grant.likely@arm.com, paulus@samba.org, mingo@kernel.org, jxgao@google.com,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 xypron.glpk@gmx.de, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, rodrigo.vivi@intel.com,
 bhelgaas@google.com, Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>, tfiga@chromium.org,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 5/17/2021 11:42 PM, Claire Chang wrote:
> Update is_swiotlb_buffer to add a struct device argument. This will be
> useful later to allow for restricted DMA pool.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
