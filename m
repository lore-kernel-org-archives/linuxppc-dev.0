Return-Path: <linuxppc-dev+bounces-23679-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075D6C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 07:24:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvXm94WmXz3brt;
	Tue, 07 Jul 2026 17:24:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783409065;
	cv=none; b=XB6G/0rKuVDLhbR6cEPveNBxz/9M1ZBCZcM+N9pxyEAGUl7t0HcElrdO0pqa783/SdBdczFHvhLguvecXnR/84/GGUGDvSJ2pXY6Vknb1xuuRTz7EaGMZKmOT61uVSr5cv8wjASI0b6ETT65UL0oftup74QkVljxxAmxEdDIsebT1dLMICLGbmW60J4IziG5srZn95X3Sd2cSRxyiDbSW3gDrHw0MxwsypNQ1/2oWO1JIfUidJ0j63cTfEKuEG4uOt6HCAl5JYsFo2vYWhh0uAxKyM1uUGYDHIkn66QkaXgYPW241WuPFVjsd9QmjoLRStIUDTNV6Zsr7N+nbVkmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783409065; c=relaxed/relaxed;
	bh=OdGDfYNlxsQeNI88N9N+orgbq/CI/BwGRgRDiSbrzTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfAHwULafhe67wjVmipvKEqM80Ua59zxZLrE9w5vXdmLUkbLB9XkUOZ2nXbCriCo+8Q6dzdDKSUxAhTQwEemrhBBWeXrR4KqkXmo6Bk3/ItCRrPIBdl3UKgZ+Cu4ltzuD5jCu6zxD1eNdxSi/XhsKqE3z+96myYwxWifoYgkoulYuy9kY79LMboI/eoixPqJ7KzXt+MRh810Rn0Jwc/FMZ0tevk9IJltjztsdNtOL6MsldycB1hrv6uL95CsFL88llHdwktIo8829OmjbdkFCWOX0TToW2MLOdo5cFMP42aVObH2exdTItnn95nUveXOg6mDSd8eXhYZcTaRf0xorA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oW2HgF9T; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oW2HgF9T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvXm838tCz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 17:24:24 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-847a483e344so387682b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 00:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783409062; x=1784013862; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OdGDfYNlxsQeNI88N9N+orgbq/CI/BwGRgRDiSbrzTc=;
        b=oW2HgF9TWBDpvodrCoh0Dw0E/tbYVq2YRpYrcfdFizBN+yOvFBuwh4WebYWD6VQYYo
         yQzBQMqs+dIs3NJrxkCdmB3yyzYh6gux0fMCg/wQwm4p5zOaSPsM66JS0UXkoge0NXNl
         PaRlH+NtxM4wGUXp96jpdcqyUTWNXgl+fDFVdc0pEmFHuUKd6uqrwzulINmQg3ag92ia
         AfEGOuOo4DYrCmD2FAq0FXmrRgj+TOkcFc8nq9dNeGZuy0IXG4B4RrGjuFcDQ/ia2u+X
         OK7xvhRSwRyh81NrCoh+zXyBAuaPItybeoa94QArODJumrHKpUC9JClvb+vmhYj7xZbY
         AF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783409062; x=1784013862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdGDfYNlxsQeNI88N9N+orgbq/CI/BwGRgRDiSbrzTc=;
        b=q5rpP1kO/M8KkDDGbgy6NJFVeBkG8pEadgkkPQGlLO5YzisgYg3pdQQ17C2u/yQ2bb
         W9xLjPyPshho6FHFXWAmSjkg2EQjAAS2qvGUmwptsSYtrGNQoaNustyc0ZklrkVzIEs0
         sKI6JU7LuhDtGSXYgrx7+BxNO6oneS6d3op2hQ4wLCQ9VPKSBifQ6fZYagIeTSQt0SJr
         DjuoNXirIciBIQ3fXfiQk8LL8puK+qfXoBr/qtkkXMWf+6fJ0bmjG7zRlAtP2e+iUkST
         7bSl6zZx+l3Mh0TVLfR83M+FPcwqIfNpYhcWjWHu4oty1fZE2SR1Xr+JB10qviJlI9mE
         4RAg==
X-Gm-Message-State: AOJu0Yw7xxrR1gmax16dLaYrBe88bwiliB/4lGVDXX5XJmp1Q+6Un5hn
	xt10UOGHuTQGDfF7Icdj4Yl9GjbuQ/LA8ywe/xkaHLu9dFG5UxFHkLb2
X-Gm-Gg: AfdE7cljbp+gPQvBIL4suxYed8wnNP7CiVCHE9ve8XdD/Yjmv8dQO9em4t7jiC1Jf61
	8VAox7MKHkO9EtwJ8C6VW2EL0b7VlWyu1nJKTSYD83ZtMxCqcCxZXNnfnZrtZmfP/Escf/EXeJr
	l9XjljP2ZmeheyX3+pRVVwVc+7WkIGDZKihkPTSK3yXd++GL3/Xe/XBTwPJ+75RQ7JBdNHO3zks
	8xS4+jMWghw+6I7OR/tFW77ovRc3E1Lyy3K134JDZ55qtylfsm3+jSB5/zP4z/aoy84vaOGnz71
	Gs6S5NvEs++WT0sMSSuoIQFH9NplC+eDBy+WI453x1R4z7p2GXTNEiAXcZW+v9rj1YxMnLZQ4R2
	QRaSOWAGOjO/4PeQwZAB5wCk7VjgjUwYZuup+KMEeaNNameTZN4QXSk4Hb5+bVtudw9musOerOv
	aRpSx490BVryB5jgilNoyNlaNQZAX3mTrj1a90jzHDw44vAL4rVzInDHV11uGc
X-Received: by 2002:a05:6a00:ab87:b0:847:9301:48e9 with SMTP id d2e1a72fcca58-8482f20bc4amr1442690b3a.15.1783409061418;
        Tue, 07 Jul 2026 00:24:21 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dddf8bsm4952166b3a.61.2026.07.07.00.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:24:21 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:54:15 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	adityag@linux.ibm.com, mahesh@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/64s: Clarify copy_and_flush() cache sync loop
 comment
Message-ID: <akypcnslC8r_XG6D@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
 <20260706082708.43918-1-nikhilks@linux.ibm.com>
 <akyQQAiLHI3sVmTz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <86bee101-6bd4-45a6-a633-34f2a52d5ace@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bee101-6bd4-45a6-a633-34f2a52d5ace@linux.ibm.com>

On Tue, Jul 07, 2026 at 12:48:57PM +0530, Nikhil Kumar Singh wrote:
> Hi Mukesh,
> 
> Thanks for reviewing the patch and for the suggestion.
> I'd prefer to keep the current alignment as I find it a bit more readable.
> 
> Thanks,
> ~ Nikhil
> 
There is a reason we keep the character limit to 80 chars. Please go
through these coding guidelines.

https://docs.kernel.org/process/coding-style.html

Regards,
Mukesh

> On 07/07/26 11:08, Mukesh Kumar Chaurasiya wrote:
> > On Mon, Jul 06, 2026 at 01:57:08PM +0530, Nikhil Kumar Singh wrote:
> > > The value loaded into r0 in copy_and_flush() represents the number of
> > > 8-byte words processed between cache synchronization operations.
> > > 
> > > The existing comment refers to cache line size, which can make it appear
> > > that the value is a cache line size in bytes rather than a loop count.
> > > Clarify the comment to explain that the loop processes 8 words (64 bytes)
> > > per cache synchronization iteration, and that increasing the value would
> > > skip cache maintenance for intermediate cache lines.
> > > 
> > > This is a comment-only change with no functional impact.
> > > 
> > > Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> > > ---
> > >   arch/powerpc/kernel/head_64.S | 20 ++++++++++++--------
> > >   1 file changed, 12 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> > > index 63432a33ec49..a54f6f979173 100644
> > > --- a/arch/powerpc/kernel/head_64.S
> > > +++ b/arch/powerpc/kernel/head_64.S
> > > @@ -713,14 +713,18 @@ p_end: .8byte _end - copy_to_here
> > >   _GLOBAL(copy_and_flush)
> > >   	addi	r5,r5,-8
> > >   	addi	r6,r6,-8
> > > -4:	li	r0,8			/* Use the smallest common	*/
> > > -					/* denominator cache line	*/
> > > -					/* size.  This results in	*/
> > > -					/* extra cache line flushes	*/
> > > -					/* but operation is correct.	*/
> > > -					/* Can't get cache line size	*/
> > > -					/* from NACA as it is being	*/
> > > -					/* moved too.			*/
> > > +4:	li	r0,8			/* r0 is the number of 8-byte words	*/
> > > +					/* to copy per cache sync iteration.	*/
> > > +					/* 8 words * 8 bytes = 64 bytes. 64B is	*/
> > > +					/* the current default cache line size.	*/
> > > +					/* This is a loop count, not a byte	*/
> > > +					/* count. Increasing it may skip	*/
> > > +					/* dcbst/icbi for lines in between and	*/
> > > +					/* leave stale instructions in icache.	*/
> > > +					/* This results in extra cache line	*/
> > > +					/* flushes but operation is correct.	*/
> > > +					/* Can't get cache line size from NACA	*/
> > > +					/* as it is being moved too.		*/
> > The comment looks fine. But the alignement of the comment is still
> > different from earlier. Keep the alignment same as earlier, it looks a
> > little nicer.
> > 
> > Regards,
> > Mukesh
> > >   	mtctr	r0			/* put # words/line in ctr	*/
> > >   3:	addi	r6,r6,8			/* copy a cache line		*/
> > > -- 
> > > 2.43.5
> > > 
> 

