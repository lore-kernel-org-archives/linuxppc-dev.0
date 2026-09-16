Return-Path: <linuxppc-dev+bounces-27488-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB79C982C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 14:46:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlMD05KF7z2yGT;
	Thu, 17 Sep 2026 00:46:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789570016;
	cv=none; b=AqsplJL8PXramOIgGdMfiGQ8iqleEfWwoFVY5R31V9w6QDC8MXx0LyPdXB1JCOWWeVGPLwc2R21Bm/Esx6s43OSPC+ghO0ZQUHcBcAp2Z90r6UitcOC0jd8IqU34sfr+BP7aVJ7ULJKmwi45ovjz8N5p2yBYChKt9LgUKB0U3b0wtXgJK2F1Up2UAd+gkemZKQCeIugrdgUYDlJoo78/B8tXos5nJuD7aQzDeyV7oMDcQnZ61S4Tyl+koAEcS1fdKB5MNWWnTOXlW8MyXkqnV6my37iQfo2bSsrWQ/vGTMx5QRbB1LcvBXcbXic033MR4gqLcS8/Dbc94rN3jHNCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789570016; c=relaxed/relaxed;
	bh=Leygo7+6aTim/GwiqbwE1kTpWGv4lEshT5ezDgEePDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QehQAF52jiKMOS7vl2vcvAV2JQL+ftsHFsd6oUqZTCeAgcG/vXA8KJMQyHAbvS8eAboXK6YCda+LiIzod2vMtDPfMuEo7Ctbe0MbOLWkyWgU1S3PoqQrNSH9aJENZ8z7Y6QdH7xtB28WBfRalRY2rz9BLwKgprQgL6QcwoTzOm1xJL7ddhymf1fVvpT94eQGSbe659Btp/7FeDr0Nd0dabdccdi9P8Ykvb+w4MZ9PI81wMeqHKnwiEMOcGh6rHhbvr3Nr/26Pmx3dWPQV0AlZDqwfNfH4w6BFSrL0vYR6ZwfhvJN6c2KCoOGBsxmzlwoVhkptHHEKQUzieHkaPSwBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l6egouwb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l6egouwb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlMCz4GNwz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 00:46:55 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2db18fe433fso8544175ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789570012; x=1790174812; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Leygo7+6aTim/GwiqbwE1kTpWGv4lEshT5ezDgEePDE=;
        b=l6egouwbfTcvTb74V8s/UbUzJYUxjyxqioL2ElK24EUU/bQ0uIv5v3mMRdplsy8XDG
         lQ2FdozpbYllnFGg72CRvieIZrR0OJimygfeGlNaSWPnCjyJenlUhoDv/QSxfTOqJuS4
         tHKLVS8Xw8iHiAJ1EMfx4tUCIoKQtbl55EGhfKyUgV76rzurVB+mx2kzTbAI18TX2SJl
         //pZH7SPzYNtUBqiPfAanKLBU9BA+niUXxJyaNqY0lbYebGbL2V00z9imgbbk+fUiuRc
         Apd4/uVPWvQ1rc7oZW7dzuNXxlVHnyRqkqllvlWr9fVHSEy+TwzTMMptu1D2mYkrd8yv
         njBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789570012; x=1790174812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Leygo7+6aTim/GwiqbwE1kTpWGv4lEshT5ezDgEePDE=;
        b=t++JcXI6+2l35uu356COLO7PskCzGVfFD1G7qLQYV36xYsuCCJMxxSsq4GiBHd2siV
         dI0cE+bmLMG4VMGOR2X+4qn83CXSZieX2uC2PSe/Rq14ogQdc3W4PlCxrKd/v9wHJ7Q2
         WWetBdR2sxDxpcLkm16dBHd3c+ZIgMGpCtfDSrnKaZW2/LdhpKoqJLnvggysVKCIozio
         3PTC88kwVUaLvtD2TbSbk/A8yeMQB2ttJDbKXj9Ez8qKMoAnmNu5bHrHQZ1WYP7JhDMp
         oXFt3RzmFQ7RYLp3bEaOAFbUGJWVhtDfGKII6FZWO6wJ4eWEVUie63o2Ll9270tRA5n6
         k2dg==
X-Forwarded-Encrypted: i=1; AKwUvBzdWlgJNN9I8lpCNLM40k0L480lrHpWbbOQXSB7SJOFU725O3ilCywub9Lewkd+e6Go7ypiyZjsdTLhSCk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l3Ze+e8fyRDLlKeyWPS7hJiKy2BbRB/tcfmHxudc1MxaEbfVJp
	umZoxmeR3pV67fgLqIknoMmcddqxmYGOSyf3/rcPnPNUc8f0YuiOy88E
X-Gm-Gg: AYBFou0bpWwVl608hbk6OgBgknI0x6yIIy1I61wjOkoezP9x7KDmRCI9UujpCRK6yd7
	w9r/cBYnAE/x7I7GHKNai8IIhycZlnKf4f9nNCEO1BbQF0W7Gui6IZiTzrFGQmiFkuwlyHay/ST
	qgPM/pLD3zSen+ZXKCC1EDALvnZRUHaOXbFL/B3ZA0mtquEe6PFaVXFrtYYSx+RnQfvgROO4bdz
	vxHzIqgLSK//6lyip2fygG2yi/xzyTluAX5UOPIkRPnQdh0bVqe/OajAIrabe3O382TlTDrReuZ
	tkim7aic272XkOX0dKBe0lnPdaYUQvneuWqk7IP1Px6kKOTPnPSmS7YZnOM/KiJ5RtevHM4Vve1
	NllKzFibGPu8yTGD12XmhPtGw7uSDIzYbYX8k/mVv/CcmWBaHWR5byDPwoFQU3vVi242WKAppG4
	ufIinKsxSy/Ogk/qDAug5zxtvpvyqZSxuRNYDL1na5L/WN82K9AuC6laA5VEDcOtmJhhiUMdqHk
	vG8/ni7RaJznAZo8GLHl2aWoxHq5Ypr9wRFODHNM0xnqA==
X-Received: by 2002:a17:903:2f10:b0:2d8:d4d0:7930 with SMTP id d9443c01a7336-2dd8e7aa5afmr63174535ad.20.1789570012227;
        Wed, 16 Sep 2026 07:46:52 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8fe00sm13298065ad.12.2026.09.16.07.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:46:51 -0700 (PDT)
Date: Wed, 16 Sep 2026 20:16:39 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: David Gow <david@davidgow.net>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, nathan@kernel.org, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, ynorov@nvidia.com, joelagnelf@nvidia.com, 
	fujita.tomonori@gmail.com, linkmauve@linkmauve.fr, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH V5 2/2] rust: kernel: Add KUnit tests for powerpc
 ARCH_WARN_ASM bug table emission
Message-ID: <aqqqKyquDoisxvZL@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260915090453.1227034-1-mkchauras@gmail.com>
 <20260915090453.1227034-3-mkchauras@gmail.com>
 <236f1c15-9532-405a-818d-9bf52349f25a@davidgow.net>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <236f1c15-9532-405a-818d-9bf52349f25a@davidgow.net>

[...]
> This works for me under QEMU, but I have a couple of small suggestions.
> 
> 1. You should use the kernel CStr and kernel::ffi::c_* types, not the ones
> from core. This properly matches the way the kernel uses -funsigned-char.
> For any architectures where char is normally signed, this would fail to
> build. Which brings me to…
> 
Thanks for pointing it out, i missed this.
> 2. Why is this specific to powerpc? Shouldn't it be possible to do this in a
> way that works across more architectures? (Indeed, the current
> implementation happens to pass on x86_64 with the above fix, though more
> would be needed for other architectures, and there's probably a better
> solution overall which doesn't hardcode a special bug address.)
> 
> So this still seems like it's something worth having, but I'd much prefer it
> to not be architecture-specific if we can avoid it.
> 
> Cheers,
> -- David
> 
The dependency to support these on all archs as it is would be to probe
the implementation and figure out which will again cause it to have some
arch specific stuff. I couldn't find a clean way of having all that at
the same place without a lot of #cfg's so i just made it powerpc
specific.

Tomonori sent out a patch with a single test that's arch agnostic, but
for ppc I would still like to keep these if the maintainer agrees.

[...]
> 
> It'd be really nice to use the warn_flags!() macro here (or even all of
> warn_on!() instead of hardcoding a separate implementation here. But even if
> we can't (due, e.g., to the need for global_asm! vs asm!), it'd be nice if
> this were more similar to the warn_flags!() implementation. Not only would
> that reduce the likelihood of these deviating needlessly, but it'd better
> support more architectures, too.
> 
> For example, the commented "{size}" would help on architectures where size
> isn't needed.
> 
Let me try this.
[...]
> > +    /// With `CONFIG_DEBUG_BUGVERBOSE` the entry must record a non-null file
> > +    /// pointer pointing back into this source file.
> > +    #[test]
> > +    #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
> > +    fn bug_entry_file() {
> > +        use core::ffi::CStr;
> 
> Please don't use core::ffi::* in the kernel. The kernel provides its own
> CStr and c_char implementations. Otherwise, this can lead to issues as the
> kernel builds with -funsigned-char, but core::ffi will use the architecture
> default.
> 
Sure.

> > +
> > +        assert!(trap_addr() != 0);
> > +        let entry = unsafe { bindings::find_bug(trap_addr()) };
> > +        assert!(!entry.is_null());
> > +
> > +        let mut file_ptr: *const core::ffi::c_char = core::ptr::null();
> 
> Again, core::ffi::c_char should be avoided in kernel code. Use
> [kernel::]ffi:c_char
> 
Sure.
[...]
> > +    /// With `CONFIG_DEBUG_BUGVERBOSE` the recorded line number must be
> > +    /// non-zero (a zero line would mean the asm operand was not substituted).
> > +    #[test]
> > +    #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
> > +    fn bug_entry_line() {
> > +        assert!(trap_addr() != 0);
> > +        let entry = unsafe { bindings::find_bug(trap_addr()) };
> > +        assert!(!entry.is_null());
> > +
> > +        let mut file_ptr: *const core::ffi::c_char = core::ptr::null();
> 
> And again.
> 
Sure 

Regards,
Mukesh
[...]

