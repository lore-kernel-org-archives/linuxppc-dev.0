Return-Path: <SRS0=hR0M=QY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19288C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 06:25:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C8D2196F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 06:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifcnmcwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C8D2196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442H6k3dnlzDqRZ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 17:25:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442H4s5fJ5zDqQk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 17:23:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ifcnmcwM"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 442H4s4VQzz8svx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 17:23:41 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 442H4s44Tpz9sD4; Sun, 17 Feb 2019 17:23:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ifcnmcwM"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 442H4s0l5rz9s3x
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2019 17:23:41 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id v21so3936456pfm.12
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2019 22:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nm7Mpr2bFzDsTZtDgyvgfnqAVAhEse/hD66HPwpevYI=;
 b=ifcnmcwMlqknwcmblNlaOdEKIdi2A7JylegsmM4qPX6LKXhT0ZDMyL5XKSNZUgZ1ol
 mbTn8MatZvfW5RlESuur/dZZzaVRaepLswtWfvSL93RWTQhoKtUMHJWKOU/QNCNchpSq
 Lu/svA4tSsxsI85nS1x9uShfXffajFxM2Df+Mdl4vi3qRz8X6Aqpo0XR/+GbJkZzCj3o
 NrvzGzrRqu5fKqZmH5Bo49rKdOqKBSjfMxBPMNGzaNhsrFFesFV6le1PgjnnT6AA94Jy
 T015qKwtZu05dS2Hm8uFvn5dZTIBkwQrJe1YESNzYmnhfz/SujlmJTpbMmLCkpdxS5A1
 LbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nm7Mpr2bFzDsTZtDgyvgfnqAVAhEse/hD66HPwpevYI=;
 b=crmflvDAA49kgwkCOezTUhW5QJDCBYDXCqRIsC9nJxRSjY4FccGN9AIRkr15Dwloyt
 8ll+TwSNGMf7r5aj+mh8QyX5bkj4lcgKo/7MqN7C6yICuIoyeEGA7kPt9qDzM9L1l2/V
 ptVnzz4uEfqKMW+3hNQCqu+ii0IMPZihon1eLGl/d4wS4wNxbA0jW44iZVwl9P+uuaeW
 BACE319XclJj/aNNHEuj/GsUUft0lMybRGuxFbLAZbQdadGj2wRDgIiEOKbBxqva8t7V
 j0aSKeBJe/09izsP0Byvz/QYyGOBfHWXyi8JtBFMC8fESA6RuCnOHUi29ZQnh5d8ngme
 w8wg==
X-Gm-Message-State: AHQUAuZn9UHCMgK2dj8JvlMzWrVsYZMjecwwhBs7KitgN5Tntz42TBcb
 WyT6nh7mdfIzl3riTYuG40U=
X-Google-Smtp-Source: AHgI3IbaL+qoncpcwlKwPaLrZSlwDbREXbJesWUb4jxQUmO9VmgguFlB3LYaCIFe0NomUSbpOkUzig==
X-Received: by 2002:a62:b40b:: with SMTP id h11mr313568pfn.108.1550384618640; 
 Sat, 16 Feb 2019 22:23:38 -0800 (PST)
Received: from localhost (220-245-128-230.tpgi.com.au. [220.245.128.230])
 by smtp.gmail.com with ESMTPSA id f13sm13736786pfa.132.2019.02.16.22.23.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 16 Feb 2019 22:23:37 -0800 (PST)
Date: Sun, 17 Feb 2019 17:23:33 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due
 to pgd/pud_present()
Message-ID: <20190217062333.GC31125@350D>
References: <20190214062339.7139-1-mpe@ellerman.id.au>
 <20190216105511.GA31125@350D>
 <20190216142206.GE14180@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216142206.GE14180@gate.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: erhard_f@mailbox.org, jack@suse.cz, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Feb 16, 2019 at 08:22:12AM -0600, Segher Boessenkool wrote:
> Hi all,
> 
> On Sat, Feb 16, 2019 at 09:55:11PM +1100, Balbir Singh wrote:
> > On Thu, Feb 14, 2019 at 05:23:39PM +1100, Michael Ellerman wrote:
> > > In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
> > > rather than just checking that the value is non-zero, e.g.:
> > > 
> > >   static inline int pgd_present(pgd_t pgd)
> > >   {
> > >  -       return !pgd_none(pgd);
> > >  +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
> > >   }
> > > 
> > > Unfortunately this is broken on big endian, as the result of the
> > > bitwise && is truncated to int, which is always zero because
> 
> (Bitwise "&" of course).
> 
> > Not sure why that should happen, why is the result an int? What
> > causes the casting of pgd_t & be64 to be truncated to an int.
> 
> Yes, it's not obvious as written...  It's simply that the return type of
> pgd_present is int.  So it is truncated _after_ the bitwise and.
>

Thanks, I am surprised the compiler does not complain about the truncation
of bits. I wonder if we are missing -Wconversion

Balbir
