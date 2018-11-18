Return-Path: <SRS0=mwa9=N5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F84AC43441
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 08:29:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670162075B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 08:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXcjdWvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670162075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42yQ9d69hVzF3Rp
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 19:29:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OXcjdWvf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=amodra@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OXcjdWvf"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yQ79101nzF3gX
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 19:27:00 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id z11so9825125pgu.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 00:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=E59FCu3OIJpiBud/83uRBkaJHOiO/JShj9PTZGvSjaY=;
 b=OXcjdWvfHDLUHS34qF34Qj7UsTJTrLqMuMQ+8pmFIcr2tdr9WdCcv/M3AQ59OfsYYF
 aZ8UunlwFJiX+mBW4RDPeinv4ci8dey61vU0+UhKI5fU999MQkk8RtWpw+8III2/AbZJ
 cwhshcNYKqehK6Q4u5pLAWO/oEia5RcocY+A/REv9LgE9suItUrFJBv7kG6WYd3SAE5u
 luC7Zavz7ooZu3dxMg/O1M/KmUwnGZpEBcmT2awqAgI1Ub2TWI56SYVgT5ivJW9qu+qU
 DaovBaz/u8dPAwvu9L39GI8+/NDMhovU5819L3VyF7AolF1Fo7peKZnYsPbs2lnUP4Vg
 2+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=E59FCu3OIJpiBud/83uRBkaJHOiO/JShj9PTZGvSjaY=;
 b=Z0PJP8B7PcETC3B+8gZ4Q+6oMTT6WklG5HKRFGEbTU+IQdojl/kLwkp+jF1TZE8zEN
 hZVlMBG4uLBEJp53ks34Yl8lbcb5VlcV/6Pp4yvqcwrph35NiCBflB+dPC43gpR/w1Ez
 5J0ROb5gUgV1YJLSQU8BzNi4AmmVf4YfK3ayL32EpFsLia/YgbnZJhOhOKDtKXRW7jN3
 s4ZERtS6s8jyqR4fHxKyNgsjFdqLZJYJ04lUxuap0kOOTYwT7d+1P2Lzgt+XwfO9pNH6
 Lam0u7yGhbs7ctjB2xV63UlYRgtZXz/draQZEgB0JIk7vFO8B5DWm9klLPzJqoHW1R9G
 GWRA==
X-Gm-Message-State: AGRZ1gIFrT1r91uuH6kOdONVuDr7opxTEKWlkxyHlaOz9FPr0VvduKW+
 fO4hsd3+vN0S2A8qvlNqqP8=
X-Google-Smtp-Source: AJdET5ec7gju8O6Hgn6K5fhMOsO0qw8iGsDymnNTNebmIaakhrMS6/6hVTggSxNyME0ECqa8AbBYOg==
X-Received: by 2002:a63:d513:: with SMTP id c19mr16006439pgg.287.1542529618207; 
 Sun, 18 Nov 2018 00:26:58 -0800 (PST)
Received: from bubble.grove.modra.org ([58.175.241.133])
 by smtp.gmail.com with ESMTPSA id m1sm17142619pgn.9.2018.11.18.00.26.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 18 Nov 2018 00:26:56 -0800 (PST)
Received: by bubble.grove.modra.org (Postfix, from userid 1000)
 id 9DCA9805FD; Sun, 18 Nov 2018 18:56:52 +1030 (ACDT)
Date: Sun, 18 Nov 2018 18:56:52 +1030
From: Alan Modra <amodra@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/32: Include .branch_lt in data section
Message-ID: <20181118082652.GA21617@bubble.grove.modra.org>
References: <20181114030218.25508-1-joel@jms.id.au>
 <20181114040045.GX29784@bubble.grove.modra.org>
 <87wopetslj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wopetslj.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 15, 2018 at 11:47:52PM +1100, Michael Ellerman wrote:
> Alan Modra <amodra@gmail.com> writes:
> 
> > On Wed, Nov 14, 2018 at 01:32:18PM +1030, Joel Stanley wrote:
> >> I wasn't sure where this should go or if the ordering matters.
> >
> > The usual answer is: "Look at where the section goes in the standard
> > linker scripts."   But that doesn't apply here.  The section will be
> > empty for a kernel build so it doesn't matter where it goes.
> 
> If it's empty why don't we just discard it?

That can be a recipe for finding linker bugs.  Not that I'm against
you finding linker bugs.  ;-)

-- 
Alan Modra
Australia Development Lab, IBM
