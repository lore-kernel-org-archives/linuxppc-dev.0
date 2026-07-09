Return-Path: <linuxppc-dev+bounces-23916-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3298CC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 08:32:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwpB13N8zz3c9x;
	Thu, 09 Jul 2026 18:32:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783585961;
	cv=none; b=bAxlHB0CSLE79tvTpUQvQNH3i+dO7bShn5hPZQDIprd6sqsXX1Efi203iq+T2ueQL9r8h8iPURjPJCnMuQJwwqmW0DhDuzb0tXggQ2yx7/ossBBWGKkQGDUuQYpPkZsgeTR9sxGg+KlQxb477TrARCv5JxOOOO8wfFT/pOXKyZ53by+56KCEIx0LjqWgZ6/TIX0e5V14Sx+Tf7cYr/rzs96TaIVTrzzXT9eMHdKtUVzrjirJF+h/yz5FhFAo1zhcM9Gth2UpJSk04FGRm4Ikd0mFTL7EKp6inRVIrJCwsfAUjPOW7RdqXB6fWCBFDrDGxXWBDwatZhtjfmkMQyX4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783585961; c=relaxed/relaxed;
	bh=QWRLiKyUtvYS55x6GhZo8UweZLAkX6ftWW/mKLT4Bjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlRKPNSy5l3ENKBMXv24KgwK3QZ4Kqa+buDqZdWM2b5Qf+cj386LuZmIvELyK5/SAjhk8SSnD3dRDQFMHad7RSffmZGaXRS5+mDYAzsj32BYuaKYegxuCkZtBDIuAsJKFVxhVAUA+vX6T624lu6yeTYTiD9c81wWuoH2qIpuvnpVHAmXNTP5HkuYM4RHGBpAq0FvD1c7wec6eZGClYu2VjiLYit7fcSWyE7ACxQa+LwUBHWbEwbGwu7pbWQwDoxU8d3vgvvSvSqgq0aMjG7oahIHOCXzt/qCJDulRXOu2kxtphpLZKNCoU+KLGffHjXoi8VgVm0UNMeyY3n0wIZ0JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PrOZPle4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PrOZPle4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwp9z5bZ9z3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 18:32:39 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so1843686a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783585957; x=1784190757; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QWRLiKyUtvYS55x6GhZo8UweZLAkX6ftWW/mKLT4Bjk=;
        b=PrOZPle4syepBJPHQmSBfopzJprTxTYdydFsUgaQ+XsbiDwTeTwqEL3sHZR7El4UIL
         QPQUL2u9SfHvuJp/E2orFaMVVQeT1kuLKr80g1x+UKBOKNTPnsZMgq/tGOrE9qP8N/3s
         Z5AZu3dAjxO8IskYWQjsKRvP89vA6F4a4uqgvVsYXnOK99NfZJEELWac19nam/6stU7X
         Hc07cC5qZmhknXu87OL1DM22oCLhRisaMeTmchzJ+O6g4jJLEmFjfTamh8Qry4+owe8c
         gtgOWsxJVMXgbp5610yjVUf5RpJDq+80I3r5ht+SnBIVcWd1pytLZlEyzax8bZre2vW1
         iu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783585957; x=1784190757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QWRLiKyUtvYS55x6GhZo8UweZLAkX6ftWW/mKLT4Bjk=;
        b=TZ7KnowObI/lMeZevBr7560HLu1B/lgScqBnBh1iHnWhUe7JmiuRwCYzMnCrzybVdv
         NeZn7QtjWLuKHyjf1j9LHagLKOSwveQmb5wKHVf0UeuC4UbDLBptGBI55lurWQD4/Dus
         dvTWLCWNTsMvbEwwIL8L/+aXrfL1x7Y48s2NizVcslCePVAVU5rtwRHnyKaMumvyedG+
         WcBvFsHE3el7ETmOYTKyXfcaoOOz4AkNLYwW0Wjv+COln6Q7urccxAAAMLefHzk6LurL
         s+wiPEjs9pVcxKQ7mjpwYMUfOuXKyc7r75gLW5fUJOAO3h+b0lvqJX7INjL0gG03HwjJ
         Wi9w==
X-Gm-Message-State: AOJu0YzRXiE0UxvWJDFIV8T68WTD0uKkPylPnFD0QPxQRYLcCvZNSqjM
	I6tvfLWn0Xj/YorkK9oeZMx/sCBa0vDOPY8MFbQQYZKnrxytJlCBk3hC
X-Gm-Gg: AfdE7ckWQTwOxkR3EYVYOfgt3WV6BuRlyr10EGocXwqU1gwYGKFOjz+c8FjCI52pNts
	HY0YM55As6k2CgXqf9cPTJ7x3fgdqMUGpqd0BllZiTyikrXVQKjcwgCeIbqj9Eae/4oyxwZ3Snp
	6yQLuQBI71YhrLNToIWacizJMwrVMbaPbvXSHfCI+EHmOdnk19bDhOvHE1ZoPDnp9Rd+XZGbFGO
	90Pud+AP+WMsQaLezjzAoR65ykipaN9qQIJ9cFNOkKLi20br4NvEIfBYellZKHCCW9kB4d7qvji
	TzUJSYyXMgyKFWJHKbybtrKBLXnRi4F9Twk7TS4r08wZriPMTINjRMeJuTpBG8+UpfahHPt2H57
	qfLl7uYnqLoikvJPROTFghqH7kI38fXvivWQuWMpi5RevFtNSZaPaECTGa8bbKIqP5x7DpfCEcb
	7l80p2gSigt/Aif0NUiY/5CU9MDfNj1OseZZIhUzW7iGPDbIReOHSEF/5G
X-Received: by 2002:a17:90b:5384:b0:381:c500:b0d1 with SMTP id 98e67ed59e1d1-389421ae13emr6738214a91.20.1783585956923;
        Thu, 09 Jul 2026 01:32:36 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506dee6sm801058a91.4.2026.07.09.01.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:32:36 -0700 (PDT)
Date: Thu, 9 Jul 2026 14:02:29 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	adityag@linux.ibm.com, mahesh@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/64s: Clarify copy_and_flush() cache sync loop
 comment
Message-ID: <ak9bbVrbjtXq0eUp@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
 <20260706082708.43918-1-nikhilks@linux.ibm.com>
 <akyQQAiLHI3sVmTz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <86bee101-6bd4-45a6-a633-34f2a52d5ace@linux.ibm.com>
 <b5f97f5b-4a17-46f7-8830-a9c4c121f0c4@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5f97f5b-4a17-46f7-8830-a9c4c121f0c4@linux.ibm.com>

On Thu, Jul 09, 2026 at 11:40:44AM +0530, Nikhil Kumar Singh wrote:
> Hi Mukesh,
> 
> Ideally, checkpatch should take care of this, I see no checkpatch errors.
> 
> ```
> ./scripts/checkpatch.pl
> v2-0001-powerpc-64s-Clarify-copy_and_flush-cache-sync-loo.patch
> total: 0 errors, 0 warnings, 26 lines checked
> 
> v2-0001-powerpc-64s-Clarify-copy_and_flush-cache-sync-loo.patch has no
> obvious style problems and is ready for submission.
> ```
> 
> Thanks
> ~ Nikhil
> 
I am saying it looks nicer and easy to read for everyone if they are
aligned. If you think it's not readable with the 80 char limit, put the
whole comment before the function start. That will also makes it a
little nicer. Right now it's getting wrapped around and it's difficult
to read.

Regards,
Mukesh
> On 07/07/26 12:48, Nikhil Kumar Singh wrote:
> > Hi Mukesh,
> > 
> > Thanks for reviewing the patch and for the suggestion.
> > I'd prefer to keep the current alignment as I find it a bit more
> > readable.
> > 
> > Thanks,
> > ~ Nikhil
> > 
> > On 07/07/26 11:08, Mukesh Kumar Chaurasiya wrote:
> > > On Mon, Jul 06, 2026 at 01:57:08PM +0530, Nikhil Kumar Singh wrote:
> > > > The value loaded into r0 in copy_and_flush() represents the number of
> > > > 8-byte words processed between cache synchronization operations.
> > > > 
> > > > The existing comment refers to cache line size, which can make
> > > > it appear
> > > > that the value is a cache line size in bytes rather than a loop count.
> > > > Clarify the comment to explain that the loop processes 8 words
> > > > (64 bytes)
> > > > per cache synchronization iteration, and that increasing the
> > > > value would
> > > > skip cache maintenance for intermediate cache lines.
> > > > 
> > > > This is a comment-only change with no functional impact.
> > > > 
> > > > Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> > > > ---
> > > >   arch/powerpc/kernel/head_64.S | 20 ++++++++++++--------
> > > >   1 file changed, 12 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/kernel/head_64.S
> > > > b/arch/powerpc/kernel/head_64.S
> > > > index 63432a33ec49..a54f6f979173 100644
> > > > --- a/arch/powerpc/kernel/head_64.S
> > > > +++ b/arch/powerpc/kernel/head_64.S
> > > > @@ -713,14 +713,18 @@ p_end: .8byte _end - copy_to_here
> > > >   _GLOBAL(copy_and_flush)
> > > >       addi    r5,r5,-8
> > > >       addi    r6,r6,-8
> > > > -4:    li    r0,8            /* Use the smallest common    */
> > > > -                    /* denominator cache line    */
> > > > -                    /* size.  This results in    */
> > > > -                    /* extra cache line flushes    */
> > > > -                    /* but operation is correct.    */
> > > > -                    /* Can't get cache line size    */
> > > > -                    /* from NACA as it is being    */
> > > > -                    /* moved too.            */
> > > > +4:    li    r0,8            /* r0 is the number of 8-byte words    */
> > > > +                    /* to copy per cache sync iteration. */
> > > > +                    /* 8 words * 8 bytes = 64 bytes. 64B is    */
> > > > +                    /* the current default cache line size.    */
> > > > +                    /* This is a loop count, not a byte    */
> > > > +                    /* count. Increasing it may skip    */
> > > > +                    /* dcbst/icbi for lines in between and */
> > > > +                    /* leave stale instructions in icache. */
> > > > +                    /* This results in extra cache line    */
> > > > +                    /* flushes but operation is correct. */
> > > > +                    /* Can't get cache line size from NACA */
> > > > +                    /* as it is being moved too.        */
> > > The comment looks fine. But the alignement of the comment is still
> > > different from earlier. Keep the alignment same as earlier, it looks a
> > > little nicer.
> > > 
> > > Regards,
> > > Mukesh
> > > >         mtctr    r0            /* put # words/line in ctr    */
> > > >   3:    addi    r6,r6,8            /* copy a cache line */
> > > > -- 
> > > > 2.43.5
> > > > 

