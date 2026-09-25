Return-Path: <linuxppc-dev+bounces-28171-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F63CC98306
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:32:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrgqk63b1z2yqq;
	Fri, 25 Sep 2026 16:32:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790317970;
	cv=none; b=hrL5FsF9KvehPx0QWMBg5/l/gvv8afonLnMIas3nMW4haIoXM1QZU7l23TQcvWlfI0dI/A/C1nTRSucIXimueead96W8RKNqJna4oL26wxVtD4X5FZQxMQ/bjeZsZJS/e62j2I35Zp/YSs6eFspIku2ZIcLWX9t4oioEswQBD89nyO9KIBVgA2eclbwdGvMndesdeu3vS0M6c17ZaagCPTLRw0v42tQTUYPp+idlN0O1KkO2xMNElD93ldtbT2q7RzhOXuztoTvk52/ISFZ+Ol9TqdLzFptpCX+fVDxJai03EFWOn36dFlRy6NcWanRE8J2wcquFkHLD3DJP9Habbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790317970; c=relaxed/relaxed;
	bh=ff013h9UPO5JfvQ6KOoQNBZOiCtGEKIOGbWYKhP5c+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXg9Qi2DVRynQMFrwtEIYH32rYwJOVUp1ObNzGhKqdP9KMswY+eWI3SaYncH+VF1CMwMsavmU8JeChNaPvLARl/sPnXEP6oy92mqZvxj5Wzf3Gqz+wrk15G0+rqN0P+QvnNKQXpb5eFCMEhBmaEzb9kWZ3LkeMroXt5oL05ePSxBSxBmzMvQg5ExXE6MgMKyAsfIB8FzKTQJHbQV5JMNm23nYLcGz5uzG0cP9vnfUvT2y/GtvnpMPOW7cZCkZUVWqYLOriou0gtkHEHpM21Ts6gl1kZMsNBHKbau5tbjQjXs1FUlEW1Vqwg9Ktwkor6CPF3aj6tMXBrtOW6t1L+dgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SZvSQ7Re; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SZvSQ7Re;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com [IPv6:2607:f8b0:4864:36::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrgqj66w6z2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 16:32:49 +1000 (AEST)
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-34213ed0b18so27068eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 23:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790317966; x=1790922766; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ff013h9UPO5JfvQ6KOoQNBZOiCtGEKIOGbWYKhP5c+0=;
        b=SZvSQ7RelOzTCyRnMRxPIOjH9HlI4TL2cEAan1Tt9l0kL7X2SLikDi36jfkIOiAdCi
         1Xmqo4YK6c9inIxBF386ojAqzQVzuYdERq2zf267O1FxKaf2xqDJFaROoESa/Mfs3weS
         zwkIYVEYzFHfsW46pg9DamUFbXYRXrN4wiHKAq2hGZ5dIL8jkSz0XQ3KZZTYKziygMXl
         bWZfyqWTnPs+v8V4AzuP+WCG/08ihxvfwa1zXjUhwA5EMAFkAwvLxJZHExxIxqikL7W/
         PvCcmOvOK6hV7v73p97HNR0ZG8nu4nT9jPTG9+sRMWxf2XWzW+6vnMBrIl+gbg8VIJj9
         4Qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790317966; x=1790922766;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ff013h9UPO5JfvQ6KOoQNBZOiCtGEKIOGbWYKhP5c+0=;
        b=RK7YPWGcwdaaS86ynKszB22imFXcKYSHf8cxL2o3ZTDf8VidiQyfH3zSEOWj9jjKY3
         dFovg+k6U12pEacwqTr7D8bxk7I/jn9XtgiySRP2oOl3e7ANhoMGdYb57i8TBcnMcq92
         e41AoQOcgCrtK8JVfF6DKVPV5moUKITkS8D+6XG0pkvs4/bRZZ16YHEs5gknJ/Sc0muD
         4tfapVvLmMtRYkm08mI5027OfCllpsOfa1zriENF4xOkatfL0H31K4eqJo9qEwk0/Q1C
         5Pf00CaLnd+GT0c0mDozPbd1X/A/3Dsye2FLKLeVGL1du6e+GM5ptFMerdTI5Q2R+2H+
         g3Hg==
X-Forwarded-Encrypted: i=1; AKwUvBzyvSY0fPNaF3HIf9fvdcU+XhBzypu1HvZOQHR5iKeBYd9LFgX3sx1AmSN0epQYr1ZkFIMTQUPai4+Qqno=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k9Utehy3DFB9tu+2+w/LKgggcOhoF/oapVcLh5LUs+9goFk7t3
	HF37i8IT5lkISeV42mxQcbymUcTkBqHYZjoqkS4ZEez33H66h0WchfIw
X-Gm-Gg: AYBFou0mYMhRcqX5xNUizTyLxVxAw5u8LmLsOj9LeAXuZuMdrqvTUMvfbs/YQkP3hmw
	B/BYdWhjDcr1ZPWGVBp3SMOp498axSv55USrDWyz8wX61e9SVGvOyQCG0/SOsREmdH7/hs6DVwc
	OTqvDeKKQ6Wekh66SzVhkrSc12i4gVVGEO+crwMCA3bpyS4BxWONMXnXJunnZ4sz6zBuMNOkNWV
	mpVOSGp9GQ60lJYxcMrhe/UbkW19SjKjtLUpyd6yEpDg9LbX4Q6C8vHxCImEyRdNP5GZfoG73QF
	EfehoPUVd0NfUe+qXOFCeyJ3t7FflKrTAt+SSP16Sc8LNcUnXS3iymg17/fbb0ETndbbvP7X95/
	Z41nu3Oe/kpRi36zDtXaMUjGNdgoXpCvn2nPUcEjO8sMlZ4L+hVdpw0qBU1ppOBeAi5fz1ZTOJY
	rrN3ND1b15Qh8d2M0qnpkpyuekiZjRIku3e46E2kiStl3gNy51Lcn7q74qYIc8pF/tm0ETcHQfU
	wUnkxvY3JvTvl1u2hWuAYCuPfDCMbsxSRmf/5eFvhte
X-Received: by 2002:a05:693c:87c3:10b0:33b:c478:a545 with SMTP id 5a478bee46e88-34002be4604mr3482720eec.8.1790317965974;
        Thu, 24 Sep 2026 23:32:45 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144172de6sm5786357eec.9.2026.09.24.23.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:32:45 -0700 (PDT)
Date: Fri, 25 Sep 2026 12:02:24 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, catalin.marinas@arm.com, 
	will@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, jszhang@kernel.org, japo@linux.ibm.com, jpoimboe@kernel.org, 
	seanjc@google.com, pmladek@suse.com, thuth@redhat.com, ynorov@nvidia.com, 
	joelagnelf@nvidia.com, david@davidgow.net, fujita.tomonori@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <arYUiddxIDeLYj8v@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
 <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <20260924111557.GP1837346@noisy.programming.kicks-ass.net>
 <arUbw_TIA0Uj7oXT@J2N7QTR9R3>
 <20260924125253.GY776954@noisy.programming.kicks-ass.net>
 <arUgNdqpA5U8EjjP@J2N7QTR9R3>
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
In-Reply-To: <arUgNdqpA5U8EjjP@J2N7QTR9R3>

On Thu, Sep 24, 2026 at 02:05:57PM +0100, Mark Rutland wrote:
> On Thu, Sep 24, 2026 at 02:52:53PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 24, 2026 at 01:46:59PM +0100, Mark Rutland wrote:
> > > What problem is this trying to solve?
> > > 
> > > Mukesh's original patch seems to be trying to check whether we compiled
> > > things correctly (such that the bug_table entry points at the expected
> > > insturction), and I don't think that warrants a runtime check, but (as
> > > per my reply to him) I don't understand why that's a thing to check in
> > > the first place.
> > > 
> > > On arm64 we only call is_valid_bugaddr() under do_el1_brk64() ->
> > > call_el1_break_hook() -> bug_brk_handler(). We only call
> > > bug_brk_handler() when HW has taken a BRK exception with the BUG_BRK_IMM
> > > immediate, and that can only be triggered by executing the right
> > > instruction (BRK #BUG_BRK_IMM), which we ONLY use for BUG(). and WARN().
> > > 
> > > So I don't see why any change is necessary here.
> > > 
> > > If the HW has somehow taken a BRK exception from any other instruction
> > > (which would presumably be a HW bug), there won't be a bug_table entry,
> > > and so __report_bug() will fail to find an entry, and will return
> > > BUG_TRAP_TYPE_NONE, same as for the !is_valid_bugaddr() case.
> > 
> > Right, so I wasn't at all sure what he was doing, Rust is still mostly
> > unreadable garbage to me.
> > 
> > But I figured I'd much rather see him use is_valid_bugaddr() to do
> > runtime checks than whatever dodgy games he was playing with that label.
> > 
> > So *if* doing runtime checks is what is wanted, then is_valid_bugaddr()
> > needs to actually work, because then it grows a user outside of the BRK
> > handler.
> 
> Thanks; I think we're aligned. :)
> 
> Before we delve into implementation details, I'd like to understand the
> problem Mukesh is trying to solve.
> 
> Mark.

Hey Peter and Mark,

It's not as a problem, it's something i faced while implementing the
ARCH_WARN_ASM, the generated assembly was not correct so i wrote a test
for it, I sent it out along with the same patch[1] but then the
discussion led to it being for all archs so I sent it out as an RFC to
know others opinion.

After Peter's last comment i found is_valid_bugaddr can use a bit more
work(atleast on ppc) so i think i am going to drop this and go ahead
with improving is_valid_bugaddr.

Regards,
Mukesh

[1]https://lore.kernel.org/all/20260915090453.1227034-1-mkchauras@gmail.com/

