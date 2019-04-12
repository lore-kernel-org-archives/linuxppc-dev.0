Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C23C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 19:39:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB0E20869
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 19:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="jwIaWv78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB0E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gp9h3mjwzDqW1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 05:39:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="jwIaWv78"; 
 dkim-atps=neutral
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gp831qb2zDqSq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 05:37:31 +1000 (AEST)
Received: by mail-ot1-x342.google.com with SMTP id 103so9386331otd.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tZfBY8D1WgXooJQRUiHKhSamR6kz9YpYQFKQ9Eq/1hU=;
 b=jwIaWv78fvkEa5rZbx+eP0fzYbqceSlvTJoR1XduCWAb2gsh8C3klYYgy/UEWlbg3W
 e1k5DE58xsWFRpnox+gDv2pxsyPeGd1VliXQdTqN/wjEe39t7A1LfOBY1Xw2oNp4IQFa
 izdMri970aizgvHVP7AGfoEDXy7apK6am+qaX0cHHnfXzrXeGMBd7PM/5URUlSE3Tjvv
 MU4YS4qovjxjhFGDBxrgmeU0ePJ2LKUa0pGMb+O0e+GfIn77BxF9oo+BRyxvHhW9LjqB
 xR/YJIrdWsl3PIAR/xzmCiHnNkkJXfmydSV2tKK7P3Oie3UkqJ0LeJfKW/5ZfXPUrnvS
 /+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tZfBY8D1WgXooJQRUiHKhSamR6kz9YpYQFKQ9Eq/1hU=;
 b=s+tcAy7w3y2qmUlY8lj1oHJUB3g2lx/xRR3SDqbcjYidFLYxIGJLWQ3j3r6/VY7Iyk
 ChnKkoVCNz9E5K+WVKQohAdmHbikocWX/MmsRzFzuWhxekE7LrrnHbWF/wMr9oPHhAzu
 oYxUQSVJW73/uI4n7Ec6UXj9QkhSzUxxT9jsRMITmtNbTAKVCzoOUJrXZqEN2P3FdG17
 IZaZgJuxWk/TlszxktCwkMw7WCPpWliNqkXsIfvepU244OrcBOjK1stLIq2pSccvm9d9
 xUZ8wn++ouxylIogwYeADI+1MhW+zqQWtZIBt0LuJHPWkT6E8VHN7MGMNQz2LEB/agWU
 t5xQ==
X-Gm-Message-State: APjAAAUDYhhWRYlDe2t5Wun7k5qtLIFy9YbzgXJeZw8KRhKfVJJ/5Ye+
 7VmKcav3wEamPOaXWlhYI9HZaaoh2BzmhBS+BKO3PA==
X-Google-Smtp-Source: APXvYqzhThKbq5GHetTkjSO5HdGMCT2FjO95YYhE57pp/4fhw00RFxMp33Lhq/TjtVDDMqbk9Vdgq3NV9eBZbTTkHEY=
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr37976108otc.246.1555097847859; 
 Fri, 12 Apr 2019 12:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555093412.git.robin.murphy@arm.com>
 <25525e4dab6ebc49e233f21f7c29821223431647.1555093412.git.robin.murphy@arm.com>
In-Reply-To: <25525e4dab6ebc49e233f21f7c29821223431647.1555093412.git.robin.murphy@arm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 12 Apr 2019 12:37:16 -0700
Message-ID: <CAPcyv4heZ7+2QuS2YXYsZcU9EOb87MDymfO8-+bLhbPgYQAYJw@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/3] mm: introduce ARCH_HAS_PTE_DEVMAP
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
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Oliver O'Halloran <oohall@gmail.com>, "Weiny, Ira" <ira.weiny@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 12, 2019 at 12:02 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> ARCH_HAS_ZONE_DEVICE is somewhat meaningless in itself, and combined
> with the long-out-of-date comment can lead to the impression than an
> architecture may just enable it (since __add_pages() now "comprehends
> device memory" for itself) and expect things to work.
>
> In practice, however, ZONE_DEVICE users have little chance of
> functioning correctly without __HAVE_ARCH_PTE_DEVMAP, so let's clean
> that up the same way as ARCH_HAS_PTE_SPECIAL and make it the proper
> dependency so the real situation is clearer.

Looks good to me.

Acked-by: Dan Williams <dan.j.williams@intel.com>
