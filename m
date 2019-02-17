Return-Path: <SRS0=hR0M=QY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF224C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 21:57:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC225217F9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 21:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXiPb+jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC225217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442gpM75Y1zDqMH
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 08:57:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442gmg1Bk7zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 08:56:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bXiPb+jj"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 442gmf6cT7z8t4q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 08:56:02 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 442gmf67CXz9sMl; Mon, 18 Feb 2019 08:56:02 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bXiPb+jj"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 442gmf1S6dz9s5c
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2019 08:56:01 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id f90so7696225plb.10
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2019 13:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0wmxiqqk7vAqmoD3PZT4D63Pg1Meu3+th20mrox0DOk=;
 b=bXiPb+jjfszHalIcoiGQpr79ma8nHUzFESYIQEBjgvau7dlK3K1YyqqgkSGMsyuTAN
 oi91PYriZRkfrrF/V8hoEH4ml69BOQMHy86EvXVDzpK9wlww8T5kstXI0AMa8MqsFZ8z
 3fG41To4sZ5ucp8bstPbknWBHxLatVJjmDIUOxEoyMVB0DeNxDf6UGbs1vZoXgD8zalt
 e3smdskO9nQgH11fmjyY+g0kVftd5WfwBF4+keK2y5lFUDra1xiQJRWIFzHKCkLDIkDh
 lSKxg/2+KIrGF33aPuTrHYpSBVlfKgeEfJ0cPEw/EYfT2hvYkkv1+NJtoq8qq+rwXG8Y
 Se8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0wmxiqqk7vAqmoD3PZT4D63Pg1Meu3+th20mrox0DOk=;
 b=ot+wBSyDhaPc1xmxQdUZpI9+ywTzdCzb0IeJZOZ6TsowvLRExezdSEVmP445mrHPXG
 aBaO1fxJrXU3val/qsEdKd33nnMeUcWJm0KJmjAzgvadcexiQaTyHkXIDD6L1t7XCUVN
 VQ33KSVxR7dHBEAiMut6wT1R0lnqQbw/GgB/8Wl/XwldxpnDsjldsJVis3wKw3/pIukG
 qlZa+Ax9DC5WdG8a8/D1zEsiyKPbxTh8cozJO/AEFzuiygqKCTSSvQ4yoJLPYYWW5KcN
 fW6Q1UPSv0eWNEMPIFw1oHDHht/uoCFpT2jGsNdluKBGMdhwKGsfNrXjQgiDiHD1GwrK
 /CKA==
X-Gm-Message-State: AHQUAuaTV+cQIwttB9dLvIR6TtbZycJdv2vxXC+IGzDXYPcNX1c6Eep9
 83AgQTtcZqUwfk1726UngBU=
X-Google-Smtp-Source: AHgI3IbqXw5YEK0XINbUyF5eYSMqG3seFTkN2WP0zeb+/N+xaXLutf2s82q5LgbDabqLwxuFqUbxag==
X-Received: by 2002:a17:902:28e9:: with SMTP id
 f96mr21903651plb.169.1550440559472; 
 Sun, 17 Feb 2019 13:55:59 -0800 (PST)
Received: from localhost ([203.219.252.113])
 by smtp.gmail.com with ESMTPSA id k74sm5381900pfb.172.2019.02.17.13.55.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 Feb 2019 13:55:58 -0800 (PST)
Date: Mon, 18 Feb 2019 08:55:56 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due
 to pgd/pud_present()
Message-ID: <20190217215556.GH31125@350D>
References: <20190214062339.7139-1-mpe@ellerman.id.au>
 <20190216105511.GA31125@350D>
 <20190216142206.GE14180@gate.crashing.org>
 <20190217062333.GC31125@350D>
 <87ef86dd9v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef86dd9v.fsf@concordia.ellerman.id.au>
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
Cc: erhard_f@mailbox.org, jack@suse.cz, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Feb 17, 2019 at 07:34:20PM +1100, Michael Ellerman wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> > On Sat, Feb 16, 2019 at 08:22:12AM -0600, Segher Boessenkool wrote:
> >> Hi all,
> >> 
> >> On Sat, Feb 16, 2019 at 09:55:11PM +1100, Balbir Singh wrote:
> >> > On Thu, Feb 14, 2019 at 05:23:39PM +1100, Michael Ellerman wrote:
> >> > > In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
> >> > > rather than just checking that the value is non-zero, e.g.:
> >> > > 
> >> > >   static inline int pgd_present(pgd_t pgd)
> >> > >   {
> >> > >  -       return !pgd_none(pgd);
> >> > >  +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
> >> > >   }
> >> > > 
> >> > > Unfortunately this is broken on big endian, as the result of the
> >> > > bitwise && is truncated to int, which is always zero because
> >> 
> >> (Bitwise "&" of course).
> >> 
> >> > Not sure why that should happen, why is the result an int? What
> >> > causes the casting of pgd_t & be64 to be truncated to an int.
> >> 
> >> Yes, it's not obvious as written...  It's simply that the return type of
> >> pgd_present is int.  So it is truncated _after_ the bitwise and.
> >>
> >
> > Thanks, I am surprised the compiler does not complain about the truncation
> > of bits. I wonder if we are missing -Wconversion
> 
> Good luck with that :)
> 
> What I should start doing is building with it enabled and then comparing
> the output before and after commits to make sure we're not introducing
> new cases.
>

Fair enough, my point was that the compiler can help out. I'll see what
-Wconversion finds on my local build :)

Balbir Singh. 
