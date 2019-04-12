Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1646EC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 19:14:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40ADF20663
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 19:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qOPiNtjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40ADF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gndW1n2QzDqT7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 05:14:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="qOPiNtjh"; 
 dkim-atps=neutral
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gnbq0J7YzDqST
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 05:13:04 +1000 (AEST)
Received: by mail-oi1-x242.google.com with SMTP id t81so8863345oig.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cjb/Jw1kYT3CwdkCeHpw/B4B9pOzyujTUh9p8dSWf7g=;
 b=qOPiNtjhfsHHrcivyLQFuR8OxLUM441a/pqFDJ7Ihm23VNLXYRnNEf5ZCadtXfy1Bb
 bH/+WtbDeAv1BI5bE2bCLzjj6MAW7Lz9sN0irIl+eFKNM/AireWatNsg9DoUgJDe97AH
 x50W6yKuoX4s6Z/mmGcke/PvP+TGPwFvXhujik17ueQj3kGTVkrsqO0h0CCfZWpXDG1L
 VCJnD5jSlG00/ERDeLIJaK7KW/12x8qrzv3rxm3B1Upq9Dty1k30Zoil2MhCZzsziSLX
 Rdlygg4wxhOGAXpvC7j3dNN96kNtrI8bfA1b99bLzW6Q7EwqIABx3SYH/3W7XCF3/Bbp
 Nrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cjb/Jw1kYT3CwdkCeHpw/B4B9pOzyujTUh9p8dSWf7g=;
 b=ddwi13O057zKHTd6e+YgWsuYMk3Mr4UotI7CXlSrDFID9c///jGXzSSAJFxlK8IwlE
 rwpFpqbB1D4r/rlUk65as+ZWD/PaLPu3dQ3LzimRZ+K3VNBnEtXE9iSe31Nx6hOCJGTO
 VHK6tPlJT4wayIXIInGvvJ4a5ijYYTBWNYn85jMK7oVmQgkj+ZUiRxnZ8XYUqvH6EMtC
 giUBswA1BpKNZwwuXTUA6yxIPElgStTbkppjrhpnoFZKkSF1MHblFpijNrU1Ap5i0cJa
 vpi9wA980sXhjlKvSM7ir+T8u6BKISafMIFLvldYnJJfEEwries5kmwJ3AOlTVIx3+nQ
 iFYA==
X-Gm-Message-State: APjAAAWscP16Cq5amzz5G4XA1gaRjxi5wkgSU5n/fvoAWquNhC/QPl3Y
 udfPfV/SGe+uUe83bv6kjYlADJtNYrG3tkjyPJ2dvA==
X-Google-Smtp-Source: APXvYqyTMfUJpFFuq8fWP7BFdKu7wN/l6+qXM5aSFSP3dYO5Xa1B6man/nth6r/rgs3JIUo7K4mVyjLLDGZmpOQzsOM=
X-Received: by 2002:aca:f581:: with SMTP id t123mr11899459oih.0.1555096381187; 
 Fri, 12 Apr 2019 12:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555093412.git.robin.murphy@arm.com>
 <029d4af64642019a6d73c804d362d840f4eb0941.1555093412.git.robin.murphy@arm.com>
In-Reply-To: <029d4af64642019a6d73c804d362d840f4eb0941.1555093412.git.robin.murphy@arm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 12 Apr 2019 12:12:49 -0700
Message-ID: <CAPcyv4iYgwPJZpwUzM-ehc5F3gjO5TJ4AOz3f21ou8NrRCsEKA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/memremap: Rename and consolidate SECTION_SIZE
To: Robin Murphy <robin.murphy@arm.com>
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
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, ohall@gmail.com,
 X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, "Weiny,
 Ira" <ira.weiny@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 12, 2019 at 11:57 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Trying to activatee ZONE_DEVICE for arm64 reveals that memremap's

s/activatee/activate/

> internal helpers for sparsemem sections conflict with and arm64's
> definitions for hugepages, which inherit the name of "sections" from
> earlier versions of the ARM architecture.
>
> Disambiguate memremap (and now HMM too) by propagating sparsemem's PA_
> prefix, to clarify that these values are in terms of addresses rather
> than PFNs (and because it's a heck of a lot easier than changing all the
> arch code). SECTION_MASK is unused, so it can just go.

Looks good to me. So good that it collides with a similar change in
the "sub-section" support series.

Acked-by: Dan Williams <dan.j.williams@intel.com>
