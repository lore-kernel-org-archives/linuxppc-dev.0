Return-Path: <linuxppc-dev+bounces-28168-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06482C98306
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:22:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrgbD57WVz2y8d;
	Fri, 25 Sep 2026 16:22:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790317320;
	cv=none; b=O09QCBttDWpz5WuMcLMvkUl5EkG/fpXl7rSjOVFj7n7UwWQ56ALM5KpOJxl6OqMhr2JHk2oVp9/wVrU7F2Y3RtN0L07qymSS4cKOq9SEciboKcrcAhC+jcI3jp9YNKITgykYxej2hjbeYxiFkWRTC6s9tL9ymC0bgSl/28UCc23Apwo5u1bluK0U6bPypK21m3xcDZlX/f2ExQdqrZF9MJOz9jiyE9Sx5IyvByvRIAIaFMYF5HQowSEG189pQimjY2/kTC2HJhAV7766AfBoKI0xF90ORdIgIguYuv5zpoLx1kSHKh4oGa4M6vZzygUHU3gDUhqa6B196DzNeTUB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790317320; c=relaxed/relaxed;
	bh=peRJubAzt5CBA3DlGa/amJu9ZBZekocmcGMZ2nqjKzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9WRBaypWbGTDD7pTX84N4nE5j1TtpWgm96U6NhQ4AsQHe+zWgaVASdBhPkLS6Njh338+Ax0bPm/laE/okO0a2913rYs76nu1Ry9qidcNfF0hjRHekkC8/Qrz6XVCZ1jhTPAjNLVRFYftfqOFG/P/L8zEtysELdBK0JvPQ7qFLdCkE5B6kSaDdvGieMvJc77zb3ZpZHNONSOPNM6nFy/wwGt2ttRgZtDCTppO7HjGX3J2BptxUpTZDpFpkCZnFOk1mzlER8aeCEd5h0jpjguHViy3G9tQlY2MqyRxWVLjlwv2dmklyc3Y2gjU6w8U8TfegL04++bMPyRSgokZwf0Ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qsCLgeAQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qsCLgeAQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com [IPv6:2607:f8b0:4864:36::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrgbB6ZKTz2y21
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 16:21:58 +1000 (AEST)
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-341fe27b718so105798eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 23:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790317315; x=1790922115; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=peRJubAzt5CBA3DlGa/amJu9ZBZekocmcGMZ2nqjKzw=;
        b=qsCLgeAQd/5GNP6d8uQte1X5diKr0yumDBmLEIDRyh7HHf6+CUBfaiTUw9QmwVYqKc
         s/SpYS98srWa8AhPGbkgNVstihJ312WAGkh9XeKVMlqZUZhEvOXQIXXxcjmpuEMhedJL
         fLabXEiPljXTYyB5fkIYpJQV9db2HRJ9lmJZH1zh03/60QQ/PphRtp8SMMCTDE+vBPXh
         wvnLzzAAnS3hkPw7Vh3mUAM6G9Kk+co3zpk2F1xRvDqb5G6sTKY6K7LTqPQ/RThhC/BD
         RLNysF2RMssqAMaihVyZb6C7hnRhT60VNsYmDey+g+O0BAjh2THbl1JeSUHPcYRg6Wfm
         K+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790317315; x=1790922115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=peRJubAzt5CBA3DlGa/amJu9ZBZekocmcGMZ2nqjKzw=;
        b=BjQITv4DCj+GR9herOZXuKbQ8Ul08LBz9xVdqgHTQzDaZhl6kjP9rhBRXoo3xdyPzP
         3owwUmeAX88LknBL26yJKuNH1BrehFana/mRFYNgwh227domq+lEnTefs6OQgjzc72D8
         hBbdW6F7GWD1io64fmJsDrct3t/cJsuBXCWAAI2FBkOZFHkJkdSwvw8GfT9+fQCEQ+2A
         rblzLqkIZWSgZ/Zx56HOs4LV7kMUONf6isPMeqRj9DB1BIW9Dub66CwcQx3XxbNlgz1U
         D6sXttyVWnMuk2Fd52iI/5kzJ2bJSwRptBYpk36O2pMLkSnvDMO53UJXzNS/NsV96YZo
         bxaw==
X-Forwarded-Encrypted: i=1; AKwUvByl+v8ak6O7vOk2ESjRM6638WP5EXElUsKIQfMMNyxapN8Mgs5MC+lbJ6e8mkmfItfVTaIccW6T+JI3azw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nmJPM6Pe94BG7RiLWfyZnlaius8oyaoyeix7gS4qf0ntg3P5xJ
	VEaMIZQmFT4rvQ7mjuuO93g9L/jJFoD3NTVwddmo8RbT352YjZpk3Z1w
X-Gm-Gg: AYBFou2VRh91AbHQhdvYEjvbxhuvUAM2wlP8U4/P5fLqusePWP1XhBQpdVcluPL8/CE
	a19bjXXwty9uU7c/nSbIOcSH+50V2YoTH2vj+JFw37qaPTsI8EOuL02BKBwwWpWGLr/U1y1xQra
	kCWExyTKVZUzUIp8quw/1Er9ewMcWHvPp9ovpbR2VV18lXNw0ohkA+7h/oN7A41ckRq/i98uqn6
	1S66bWzeB6WUD8EKH//mAl1Wk/2fZqKHavW+ngdUHuQU9vzk6Z+2TMMC8HaKbtHWCMz6xGvjF62
	rvjK7sGPJGK2xox35/0U4XyzIhhoT7bTma21mH4Bfo6h8b0LQgaLdNBusVlL5OjGhwzFn5oZI5v
	g5OlXbSenJzMSoj17GSW2BelDpW2lQISi/W3LYD2qPUyKvS8MQveTW/cotnI6m4FMxEan+59b2o
	PWo/ie0enva5MVUCrRjtywjJhwYCEMEOynye2k4MDERGuUIwQ4mYpb+61srHcmkTBIQ3thPB263
	Nx9wG3MCewLGy5Fyz5O4lsK34Rsg87hFcZ9RNviStLJ
X-Received: by 2002:a05:7300:dd47:b0:342:94b:aa28 with SMTP id 5a478bee46e88-342095b08cemr188044eec.27.1790317315073;
        Thu, 24 Sep 2026 23:21:55 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144172de6sm5598126eec.9.2026.09.24.23.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:21:54 -0700 (PDT)
Date: Fri, 25 Sep 2026 11:51:33 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, 
	sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, nathan@kernel.org, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, jszhang@kernel.org, japo@linux.ibm.com, 
	peterz@infradead.org, jpoimboe@kernel.org, seanjc@google.com, pmladek@suse.com, 
	thuth@redhat.com, ynorov@nvidia.com, joelagnelf@nvidia.com, david@davidgow.net, 
	fujita.tomonori@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <arYR4GrzNnFko7XO@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <arUYLsJJewE--wqo@J2N7QTR9R3>
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
In-Reply-To: <arUYLsJJewE--wqo@J2N7QTR9R3>

On Thu, Sep 24, 2026 at 01:31:42PM +0100, Mark Rutland wrote:
> On Tue, Sep 22, 2026 at 11:20:00AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
> > bug_addr displacement — i.e. the arch's trap label reference resolves to
> > the trap instruction — by calling find_bug() with the exact virtual address
> > of the trap, mirroring what the real trap handler does.
> > 
> > To support all architectures, each arch that implements ARCH_WARN_ASM now
> > defines ARCH_WARN_ASM_TRAP_LABEL, a string constant naming the local label
> > at which the trap instruction is placed:
> > 
> >   x86       "1"     (ud2 at label 1:)
> >   powerpc   "1"     (twi at label 1:)
> >   riscv     "1"     (ebreak at label 1:)
> >   arm64     "14471" (brk placed at 14471: by __BUG_ENTRY_END)
> >   s390      "0"     (mc at label 0:)
> 
> I'm not a fan of exposing such a low-level implementation detail out of
> the architecture code, and I don't think we should expose this.
> 
> What exactly are you trying to verify here, and why? Has there been
> some _specific_ issue on powerpc that caused you to look at this?
> 
> Mark.

Hey Mark,

During implementing ARCH_WARN_ASM for rust I broke the bug entry for
powerpc so I wrote this to verify. I sent it out mainly for ppc but
few people wanted that if it needed it should be done for all archs.
So separated this thing and sent it out as an RFC to check whether
other archs want this or not.

Regards,
Mukesh

